package com.youwei.leshi.admin;

import java.util.Date;
import java.util.List;

import org.bc.sdak.CommonDaoService;
import org.bc.sdak.GException;
import org.bc.sdak.TransactionalServiceHelper;

import com.youwei.PlatformExceptionType;
import com.youwei.leshi.admin.entity.Board;
import com.youwei.leshi.admin.entity.Post;
import com.youwei.web.ModelAndView;
import com.youwei.web.Module;
import com.youwei.web.WebMethod;

@Module(name="/admin/post")
public class PostService {
	CommonDaoService dao = TransactionalServiceHelper.getTransactionalService(CommonDaoService.class);
	
	@WebMethod
	public ModelAndView list(){
		ModelAndView mv = new ModelAndView();
		List<Board> list = dao.listByParams(Board.class, "from Board where fid is null order by orderx");
		mv.jspData.put("boards", list);
		return mv;
	}
	
	@WebMethod
	public ModelAndView save(Post post){
		ModelAndView mv = new ModelAndView();
		if(post.bid==null){
			throw new GException(PlatformExceptionType.BusinessException,"请先选择栏目");
		}
		post.addtime = new Date();
		post.updatetime = new Date();
		dao.saveOrUpdate(post);
		return mv;
	}
	
	@WebMethod
	public ModelAndView update(Post post){
		ModelAndView mv = new ModelAndView();
		Post po = dao.get(Post.class, post.id);
		if(po!=null){
			po.title = post.title;
			po.bid = post.bid;
			po.updatetime = new Date();
			po.conts = post.conts;
			dao.saveOrUpdate(po);
		}
		return mv;
	}
	
	@WebMethod
	public ModelAndView edit(int id){
		ModelAndView mv = new ModelAndView();
		Post po = dao.get(Post.class, id);
		mv.jspData.put("post", po);
		return mv;
	}
	
	@WebMethod
	public ModelAndView view(int id){
		ModelAndView mv = new ModelAndView();
		Post po = dao.get(Post.class, id);
		mv.jspData.put("post", po);
		return mv;
	}
	
	@WebMethod
	public ModelAndView delete(int id){
		ModelAndView mv = new ModelAndView();
		Post po = dao.get(Post.class, id);
		if(po!=null){
			dao.delete(po);
		}
		return mv;
	}
}
