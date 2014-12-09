package com.youwei.leshi.admin;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.bc.sdak.CommonDaoService;
import org.bc.sdak.GException;
import org.bc.sdak.Page;
import org.bc.sdak.TransactionalServiceHelper;

import com.youwei.PlatformExceptionType;
import com.youwei.leshi.admin.entity.Board;
import com.youwei.leshi.admin.entity.Post;
import com.youwei.leshi.util.JSONHelper;
import com.youwei.web.ModelAndView;
import com.youwei.web.Module;
import com.youwei.web.WebMethod;

@Module(name="/admin/post")
public class PostService {
	CommonDaoService dao = TransactionalServiceHelper.getTransactionalService(CommonDaoService.class);
	
	@WebMethod
	public ModelAndView listData(Page<Map> page){
		ModelAndView mv = new ModelAndView();
		List<Object> params = new ArrayList<Object>();
		page.setPageSize(25);
		page = dao.findPage(page, "select b.name as bname, p.id as id , p.title as title , p.orderx as orderx from Post p, Board b  where b.id=p.bid order by p.addtime desc", true, params.toArray());
		mv.data = JSONHelper.toJSON(page);
		return mv;
	}
	
	@WebMethod
	public ModelAndView add(){
		ModelAndView mv = new ModelAndView();
		List<Board> modules = dao.listByParams(Board.class, "from Board where fid is null or fid=0 order by orderx");
		mv.jspData.put("modules", modules);
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
		List<Board> modules = dao.listByParams(Board.class, "from Board where fid is null or fid=0 order by orderx");
		mv.jspData.put("modules", modules);
		Post po = dao.get(Post.class, id);
		Board board = dao.get(Board.class, po.bid);
		mv.jspData.put("moduleId", board.fid);
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
