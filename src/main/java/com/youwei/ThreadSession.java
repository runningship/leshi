package com.youwei;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.youwei.leshi.user.entity.User;
import org.bc.sdak.GException;
public class ThreadSession {

//	private static final ThreadLocal<HttpSession> HttpSession = new ThreadLocal<HttpSession>();
	private static final ThreadLocal<HttpServletRequest> HttpRequest = new ThreadLocal<HttpServletRequest>();
	private static final ThreadLocal<HttpServletResponse> HttpResponse = new ThreadLocal<HttpServletResponse>();
	private static final ThreadLocal<Boolean> superAdmin = new ThreadLocal<Boolean>();
    private ThreadSession() {  
    }  
  
    public static boolean isSuperAdmin() {  
        return superAdmin.get(); 
    }  
  
    public static void setSuperAdminr(boolean sup) {  
    	superAdmin.set(sup);
    }
    
//    public static HttpSession getHttpSession(){
//    	return HttpSession.get();
//    }
//    public static void setHttpSession(HttpSession session){
//    	HttpSession.set(session);
//    }
    public static void setHttpServletRequest(HttpServletRequest reqeust){
    	HttpRequest.set(reqeust);
    }
    
    public static HttpServletRequest getHttpServletRequest(){
    	return HttpRequest.get();
    }
    
    public static void setHttpServletResponse(HttpServletResponse response){
    	HttpResponse.set(response);
    }
    
    public static HttpServletResponse getHttpResponse(){
    	return HttpResponse.get();
    }
    
   
    
    public static User getUser(){
    	HttpSession session = HttpRequest.get().getSession();
    	User user = (User)session.getAttribute("user");
    	if(user==null){
    		//
    		throw new GException(PlatformExceptionType.UserOfflineException , "");
//    		try {
//				HttpResponse.get().getWriter().write("<script action='relogin' type='text/javascript'>window.parent.location="+HttpRequest.get().getContextPath()+"'/login/index.html'</script>");
//			} catch (IOException e) {
//				e.printStackTrace();
//			}
    	}
    	return user;
    }
    
    public static String getIp(){
    	HttpSession session = HttpRequest.get().getSession();
    	return (String)session.getAttribute("ip");
    }
}
