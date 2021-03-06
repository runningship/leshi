package com.youwei.web;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.util.HashMap;
import java.util.Map;

import javassist.ClassClassPath;
import javassist.ClassPool;
import javassist.CtClass;
import javassist.CtMethod;
import javassist.NotFoundException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Level;
import org.bc.sdak.GException;
import org.bc.sdak.TransactionalServiceHelper;
import org.bc.sdak.utils.LogUtil;

import com.youwei.Escape;
import com.youwei.PlatformExceptionType;
import com.youwei.ThreadSession;


public class GrandServlet extends HttpServlet{

	private static final long serialVersionUID = 1L;

	private static Map<String , CtClass>ctMap = new HashMap<String , CtClass>();
	
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		long start = System.currentTimeMillis();
		resp.setCharacterEncoding("utf8");
//		resp.setContentType("text/html");
		String path = req.getPathInfo();
		LogUtil.info(path);
		if("/".equals(path)){
			processRootRequest(req, resp);
			return;
		}
		if(path.endsWith(".jsp")){
//			super.service(req, resp);
			path = path.replace(".jsp", "");
		}else{
			super.service(req, resp);
			return;
		}
		ThreadSession.setHttpServletRequest(req);
		ThreadSession.setHttpServletResponse(resp);
		Handler handler = ModuleManager.getHandler(path);
		if(handler==null){
//			super.service(req, resp);
//			resp.setStatus(404);
//			resp.getWriter().println("404 : page not found");
			RequestDispatcher rd = req.getRequestDispatcher(req.getPathInfo());
			rd.forward(req, resp);
			return;
		}
		Object manager =null;
		try {
			manager = TransactionalServiceHelper.getTransactionalService(handler.getModuleClass());
//			manager = handler.getModuleClass().newInstance();
		}catch (Exception e) {
			e.printStackTrace();
		}
		if(manager==null){
			resp.setStatus(404);
			resp.getWriter().println("404 : page not found");
			return;
		}
        if(StringUtils.isEmpty(handler.getMethod())){
        	resp.getWriter().println("method not found");
        	return;
        }
		try{
			Object[] params = buildParamForMethod(manager,handler.getMethod(),req);
			ModelAndView mv = ServletHelper.call(manager,handler.getMethod(),params);
			mv.jsp = path+".jsp";
			if(mv.redirect!=null){
				resp.sendRedirect(mv.redirect);
			}else if(mv.jsp==null){
				if(StringUtils.isNotEmpty(mv.contentType)){
					resp.setContentType(mv.contentType);
				}
				if(StringUtils.isNotEmpty(mv.returnText)){
					if(mv.encodeReturnText){
						resp.getWriter().write(Escape.escape(mv.returnText));
					}else{
						resp.getWriter().write(mv.returnText);
					}
				}else{
					resp.getWriter().write(mv.data.toString());
				}
			}else{
				ServletHelper.fillMV(req,mv);
				RequestDispatcher rd = req.getRequestDispatcher(mv.jsp);
				if(rd==null){
					resp.setStatus(404);
					resp.getWriter().println("404 : page not found");
				}else{
					rd.forward(req, resp);
				}
			}
		}catch(Exception ex){
			resp.setStatus(500);
			//go to error page 
			if(ex instanceof GException){
				processGException(resp, (GException)ex);
			}else if (ex instanceof InvocationTargetException ){
				InvocationTargetException iex = (InvocationTargetException)ex;
				if(iex.getTargetException() instanceof GException ){
					processGException(resp, (GException)iex.getTargetException());
				}else{
					LogUtil.log(Level.ERROR,"internal server error",iex.getTargetException());
					iex.getTargetException().printStackTrace(resp.getWriter());
				}
			}else{
				LogUtil.log(Level.ERROR,"internal server error",ex);
				ex.printStackTrace(resp.getWriter());
			}
		}
		long end = System.currentTimeMillis();
		LogUtil.info(path+":"+(end-start)+"毫秒");
	}

	private void processGException(HttpServletResponse resp ,GException ex){
		
		resp.setStatus(400);
		JSONObject jobj = new JSONObject();
		if(ex.getType()==PlatformExceptionType.ParameterMissingError){
			jobj.put("type",PlatformExceptionType.ParameterMissingError.toString());
			jobj.put("field", ex.getField());
		}else if(ex.getType()==PlatformExceptionType.ParameterTypeError){
			jobj.put("type",PlatformExceptionType.ParameterTypeError.toString());
			jobj.put("field", ex.getField());
			jobj.put("msg", ex.getMessage());
		}else if(ex.getType()==PlatformExceptionType.UserOfflineException){
			try {
				resp.getWriter().write("<script action='relogin' type='text/javascript'>window.parent.location='"+ThreadSession.getHttpServletRequest().getContextPath()+"/login/index.html'</script>");
				return;
			} catch (IOException e) {
				e.printStackTrace();
			}
		}else{
			jobj.put("msg", ex.getMessage());
		}
		LogUtil.log(Level.WARN, "警告", ex);
		try {
			resp.getWriter().println(jobj.toString());
		} catch (IOException e) {
			LogUtil.log(Level.WARN, "输出错误信息到客户端失败", e);;
		}
	}
	private void processRootRequest(HttpServletRequest req,HttpServletResponse resp) throws IOException {
		resp.getWriter().println("you are not allowed to access root url");
	}
	
	private Object[] buildParamForMethod(Object manager,String method, HttpServletRequest req){
		Object[] params = null;
		ClassPool pool = ClassPool.getDefault();
		CtClass cc = ctMap.get(manager.getClass().getName());
		if(cc==null){
			cc = ctMap.get(manager.getClass().getSuperclass().getName());
		}
		if(cc==null){
			String ctcName = manager.getClass().getName();
			try {
				cc = pool.getCtClass(ctcName);
			} catch (NotFoundException e) {
				pool.appendClassPath(new ClassClassPath(manager.getClass()));
			}
			if(cc==null){
				//get again
				try {
					cc = pool.getCtClass(ctcName);
				} catch (NotFoundException ex) {
					try {
						ctcName = manager.getClass().getSuperclass().getName();
						cc = pool.getCtClass(ctcName);
					} catch (NotFoundException e) {
						LogUtil.log(Level.WARN, "class not found", ex);
						return new Object[]{};
					}
				}
			}
			if(cc!=null){
				ctMap.put(ctcName, cc);
			}
		}else{
			LogUtil.info("we get ctc class from cache");
		}
		
		for(CtMethod cm : cc.getDeclaredMethods()){
			if(cm.getName().equals(method)){
//				LogUtil.info("start to build parameters for "+manager.getClass().getName()+"."+method);
				params = ServletHelper.buildParamters(cm , req);
			}
		}
		return params;
	}
}
