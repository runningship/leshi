package com.youwei.leshi.admin;

import java.io.File;
import java.util.Map;

import javax.servlet.ServletContext;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.bc.sdak.Page;

import com.youwei.ThreadSession;
import com.youwei.leshi.util.JSONHelper;
import com.youwei.web.ModelAndView;
import com.youwei.web.Module;
import com.youwei.web.WebMethod;

@Module(name="/admin/common")
public class AdminCommon {

	@WebMethod
	public ModelAndView list(Page<Map> page){
		ModelAndView mv = new ModelAndView();
//		page.pageSize=5;
		mv.jsp="list";
//		page.currentPageNo;
//		page.pageSize;
//		page.currentPageNo
		mv.data.put("page", JSONHelper.toJSON(page));
		return mv;
	}
	
	@WebMethod
	public ModelAndView main(){
		ModelAndView mv = new ModelAndView();
		mv.data.put("menu", "测试");
		mv.data.put("username", "管理员");
		return mv;
	}
	
	@WebMethod
	public ModelAndView index(){
		ModelAndView mv = new ModelAndView();
		mv.data.put("java_version", System.getProperty("java.version"));
		mv.data.put("java_home", System.getProperty("java.home"));
		mv.data.put("os_name", System.getProperty("os.name"));
		mv.data.put("os_arch", System.getProperty("os.arch"));
		
		ServletContext servletContext = ThreadSession.getHttpServletRequest().getServletContext();
		mv.data.put("servlet_server_info", servletContext.getServerInfo());
		mv.data.put("servlet_version", servletContext.getMajorVersion()+"."+servletContext.getMinorVersion());
		return mv;
	}
	
	@WebMethod
	public ModelAndView listFiles(){
		ModelAndView mv = new ModelAndView();
//		String addr = ThreadSession.getUser().address;
		File d = new File("d:\\");
		JSONArray arr = new JSONArray();
		for(File f : d.listFiles()){
			if(f.isHidden()){
				continue;
			}
			JSONObject j = new JSONObject();
			j.put("name", f.getName());
			j.put("size", f.length());
			j.put("isDir", f.isDirectory());
			arr.add(j);
		}
		mv.data.put("files", arr);
		return mv;
	}
}
