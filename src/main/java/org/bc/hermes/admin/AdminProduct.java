package org.bc.hermes.admin;

import java.util.Map;

import org.bc.hermes.util.JSONHelper;
import org.bc.sdak.Page;
import org.bc.web.ModelAndView;
import org.bc.web.Module;
import org.bc.web.WebMethod;

@Module(name="/admin/product")
public class AdminProduct {

	@WebMethod
	public ModelAndView list(Page<Map> page){
		ModelAndView mv = new ModelAndView();
		mv.jsp="list";
		page.totalCount=8;
		mv.data.put("page", JSONHelper.toJSON(page));
		return mv;
	}
}
