package com.youwei.leshi.test;

import java.io.File;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.youwei.web.ModelAndView;
import com.youwei.web.Module;
import com.youwei.web.WebMethod;

@Module(name="/test/")
public class TestService {

	@WebMethod
	public ModelAndView list(){
		ModelAndView mv = new ModelAndView();
		mv.jsp="list";
		return mv;
	}
	
	@WebMethod
	public ModelAndView version(){
		ModelAndView mv = new ModelAndView();
//		String addr = ThreadSession.getUser().address;
		mv.data.put("username", "yexinzhou");
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
