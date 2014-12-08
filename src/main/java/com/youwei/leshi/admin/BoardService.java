package com.youwei.leshi.admin;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletContext;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.bc.sdak.CommonDaoService;
import org.bc.sdak.GException;
import org.bc.sdak.TransactionalServiceHelper;

import com.youwei.PlatformExceptionType;
import com.youwei.ThreadSession;
import com.youwei.leshi.admin.entity.Board;
import com.youwei.leshi.admin.entity.Post;
import com.youwei.web.ModelAndView;
import com.youwei.web.Module;
import com.youwei.web.WebMethod;

@Module(name="/admin/board")
public class BoardService {
	CommonDaoService dao = TransactionalServiceHelper.getTransactionalService(CommonDaoService.class);
	
	@WebMethod
	public ModelAndView topBoard(){
		ModelAndView mv = new ModelAndView();
		List<Board> list = dao.listByParams(Board.class, "from Board where fid is null order by orderx");
		mv.jspData.put("boards", list);
		return mv;
	}
	
	@WebMethod
	public ModelAndView subBoard(Integer fid){
		ModelAndView mv = new ModelAndView();
		List<Board> list = new ArrayList<Board>();
		if(fid!=null){
			list = dao.listByParams(Board.class, "from Board where fid="+fid+" order by orderx");
		}
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
		dao.saveOrUpdate(board);
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
