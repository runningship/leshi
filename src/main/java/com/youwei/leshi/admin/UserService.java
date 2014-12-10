package com.youwei.leshi.admin;

import org.bc.sdak.CommonDaoService;
import org.bc.sdak.GException;
import org.bc.sdak.TransactionalServiceHelper;

import com.youwei.PlatformExceptionType;
import com.youwei.ThreadSession;
import com.youwei.leshi.admin.entity.User;
import com.youwei.leshi.util.SecurityHelper;
import com.youwei.web.ModelAndView;
import com.youwei.web.Module;
import com.youwei.web.WebMethod;

@Module(name="/admin/user")
public class UserService {
	CommonDaoService dao = TransactionalServiceHelper.getTransactionalService(CommonDaoService.class);
	
	@WebMethod
	public ModelAndView login(User user){
		ModelAndView mv = new ModelAndView();
		String pwd = SecurityHelper.Md5(user.pwd);
		User po = dao.getUniqueByParams(User.class, new String[]{"name" , "pwd"}, new Object[]{user.name  , pwd});
		if(po==null){
			throw new GException(PlatformExceptionType.BusinessException,"用户名或密码不正确。");
		}
		ThreadSession.getHttpSession().setAttribute("user", po);
		return mv;
	}
	
	@WebMethod
	public ModelAndView logout(){
		ModelAndView mv = new ModelAndView();
		ThreadSession.getHttpSession().removeAttribute("user");
		mv.redirect="/leshi/admin/public/login.jsp";
		return mv;
	}
}
