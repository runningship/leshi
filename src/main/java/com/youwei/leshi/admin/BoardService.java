package com.youwei.leshi.admin;

import java.util.List;
import java.util.Map;

import org.bc.sdak.CommonDaoService;
import org.bc.sdak.GException;
import org.bc.sdak.TransactionalServiceHelper;

import com.youwei.PlatformExceptionType;
import com.youwei.leshi.admin.entity.Board;
import com.youwei.web.ModelAndView;
import com.youwei.web.Module;
import com.youwei.web.WebMethod;

@Module(name="/admin/board")
public class BoardService {
	CommonDaoService dao = TransactionalServiceHelper.getTransactionalService(CommonDaoService.class);
	
	@WebMethod
	public ModelAndView list(){
		ModelAndView mv = new ModelAndView();
		List<Map> list = dao.listAsMap("select name as name, fname as fname , orderx as orderx , id as id , fid as fid "
				+ "from Board  order by orderx");
		mv.jspData.put("boards", list);
		return mv;
	}
	
	@WebMethod
	public ModelAndView save(Board board){
		ModelAndView mv = new ModelAndView();
		Board po = dao.getUniqueByKeyValue(Board.class, "name", board.name);
		if(po!=null){
			throw new GException(PlatformExceptionType.BusinessException,"已经存在相同的栏目名称，请修改后再重试。");
		}
		Board parent = dao.get(Board.class,board.fid);
		if(parent!=null){
			board.fname = parent.name;
		}
		
		dao.saveOrUpdate(board);
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
	public ModelAndView edit(int id){
		ModelAndView mv = new ModelAndView();
		Board po = dao.get(Board.class, id);
		mv.jspData.put("board", po);
		return mv;
	}
	
	@WebMethod
	public ModelAndView update(Board board){
		ModelAndView mv = new ModelAndView();
		Board po = dao.get(Board.class, board.id);
		if(po!=null){
			po.name = board.name;
			po.fid = board.fid;
			dao.saveOrUpdate(po);
		}
		return mv;
	}
	
	@WebMethod
	public ModelAndView delete(int id){
		ModelAndView mv = new ModelAndView();
		Board po = dao.get(Board.class, id);
		if(po!=null){
			dao.delete(po);
		}
		return mv;
	}
}
