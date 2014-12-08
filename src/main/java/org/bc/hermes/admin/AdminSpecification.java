package org.bc.hermes.admin;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.apache.commons.lang.StringUtils;
import org.bc.hermes.admin.entity.Spec;
import org.bc.hermes.admin.entity.SpecVal;
import org.bc.hermes.util.JSONHelper;
import org.bc.sdak.CommonDaoService;
import org.bc.sdak.GException;
import org.bc.sdak.Page;
import org.bc.sdak.TransactionalServiceHelper;
import org.bc.web.ModelAndView;
import org.bc.web.Module;
import org.bc.web.WebMethod;

@Module(name="/admin/specification")
public class AdminSpecification {

	CommonDaoService dao = TransactionalServiceHelper.getTransactionalService(CommonDaoService.class);
	
	@WebMethod
	public ModelAndView list(Page<Spec> page){
		ModelAndView mv = new ModelAndView();
		List<Object> params = new ArrayList<Object>();
//		page = dao.findPage(page, "select sp.name as name,sp.strDesc as strDesc, sv.txt as txt from Spec sp left join sp.vals sv " , true , params.toArray());
		page = dao.findPage(page, "from Spec");
		mv.data = JSONHelper.toJSON(page);
		return mv;
	}
	
	@WebMethod
	public ModelAndView svList(Page<SpecVal> page , String specId){
		ModelAndView mv = new ModelAndView();
		List<Object> params = new ArrayList<Object>();
		params.add(specId);
		page = dao.findPage(page, "from SpecVal where specId=?" , params.toArray());
		mv.data = JSONHelper.toJSON(page);
		return mv;
	}
	
	@WebMethod
	public ModelAndView edit(String id){
		ModelAndView mv = new ModelAndView();
		Spec po = dao.get(Spec.class, id);
		if(po!=null){
			mv.jspData.put("spec", po);
		}
		
		return mv;
	}
	
	@WebMethod
	public ModelAndView save(Spec spec){
		ModelAndView mv = new ModelAndView();
		if(StringUtils.isEmpty(spec.name)){
			throw new GException(org.bc.PlatformExceptionType.ParameterMissingError,"name","请先填写名称");
		}
		Spec po = dao.getUniqueByKeyValue(Spec.class, "name", spec.name);
		if(po!=null){
			throw new GException(org.bc.PlatformExceptionType.BusinessException,"存在相同名称的规格");
		}
		spec.id = UUID.randomUUID().toString();
		dao.saveOrUpdate(spec);
		return mv;
	}
	
	@WebMethod
	public ModelAndView saveSpecVal(SpecVal sv){
		ModelAndView mv = new ModelAndView();
		if(StringUtils.isEmpty(sv.name)){
			throw new GException(org.bc.PlatformExceptionType.ParameterMissingError,"name","请先填写名称");
		}
		SpecVal po = dao.getUniqueByKeyValue(SpecVal.class, "name", sv.name);
		if(po!=null){
			throw new GException(org.bc.PlatformExceptionType.BusinessException,"存在相同的规格值名称");
		}
		sv.id = UUID.randomUUID().toString();
		dao.saveOrUpdate(sv);
		return mv;
	}
	
	@WebMethod
	public ModelAndView update(Spec spec){
		ModelAndView mv = new ModelAndView();
		if(StringUtils.isEmpty(spec.name)){
			throw new GException(org.bc.PlatformExceptionType.ParameterMissingError,"name","请先填写名称");
		}
		Spec other = dao.getUniqueByKeyValue(Spec.class, "name", spec.name);
		if(other!=null){
			throw new GException(org.bc.PlatformExceptionType.BusinessException,"存在相同名称的规格");
		}
		Spec po = dao.get(Spec.class, spec.id);
		po.name = spec.name;
		po.orderx = spec.orderx;
		po.strDesc = spec.strDesc;
		dao.saveOrUpdate(po);
		return mv;
	}
	
	@WebMethod
	public ModelAndView delete(String ids){
		List<String> params = new ArrayList<String>();
		ModelAndView mv = new ModelAndView();
		String[] idArr = ids.split(",");
		StringBuilder hql = new StringBuilder("delete from Spec where id in (''");
		for(String id : idArr){
			hql.append(",").append("?");
			params.add(id);
		}
		hql.append(")");
		dao.execute(hql.toString(), params.toArray());
		return mv;
	}
	
	@WebMethod
	public ModelAndView deleteSpecVal(String id){
		ModelAndView mv = new ModelAndView();
		SpecVal po = dao.get(SpecVal.class, id);
		if(po!=null){
			dao.delete(po);
		}
		return mv;
	}
}
