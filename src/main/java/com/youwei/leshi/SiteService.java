package com.youwei.leshi;

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
import com.youwei.web.ModelAndView;
import com.youwei.web.Module;
import com.youwei.web.WebMethod;

@Module(name="/")
public class SiteService {
	CommonDaoService dao = TransactionalServiceHelper.getTransactionalService(CommonDaoService.class);
	
	@WebMethod
	public ModelAndView newsList(Page<Map> page,Integer topId , Integer bid){
		ModelAndView mv = new ModelAndView();
		List<Object> params = new ArrayList<Object>();
		List<Board> modules = dao.listByParams(Board.class, "from Board where fid is null or fid=0 order by orderx");
//		page.setPageSize(2);
		if(bid!=null){
			Board currentBoard = dao.get(Board.class, bid);
			mv.jspData.put("currentBoard", currentBoard);
			params.add(bid);
			page = dao.findPage(page, "select id as id, title as title , addtime as addtime from Post where bid=? order by addtime desc", true,params.toArray());
		}else{
			params.add(topId);
			page = dao.findPage(page, "select p.id as id, p.title as title , p.addtime as addtime from Post p ,Board b where p.bid=b.id and b.fid=? order by p.addtime desc",true, params.toArray());
		}
		Board topBoard = dao.get(Board.class, topId);
		
		mv.jspData.put("page", page);
		List<Board> list = dao.listByParams(Board.class, "from Board where fid=? order by orderx" ,topId);
		mv.jspData.put("boards", list);
		mv.jspData.put("modules", modules);
		mv.jspData.put("topBoard", topBoard);
		
		return mv;
	}
	
	@WebMethod
	public ModelAndView index(){
		ModelAndView mv = new ModelAndView();
		List<Board> modules = dao.listByParams(Board.class, "from Board where fid is null or fid=0 order by orderx");
		mv.jspData.put("modules", modules);
		return mv;
	}
	
	@WebMethod
	public ModelAndView news(int id){
		Post news = dao.get(Post.class, id);
		Board board = dao.get(Board.class, news.bid);
		ModelAndView mv = new ModelAndView();
		List<Board> modules = dao.listByParams(Board.class, "from Board where fid is null or fid=0 order by orderx");
		List<Board> list = dao.listByParams(Board.class, "from Board where fid=? order by orderx" ,board.fid);
		mv.jspData.put("boards", list);
		mv.jspData.put("modules", modules);
		mv.jspData.put("news", news);
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
