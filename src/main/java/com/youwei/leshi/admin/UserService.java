package com.youwei.leshi.admin;

import java.util.List;

import org.bc.sdak.CommonDaoService;
import org.bc.sdak.GException;
import org.bc.sdak.TransactionalServiceHelper;

import com.youwei.PlatformExceptionType;
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
		List<User> list = dao.listByParams(User.class, new String[]{"name" , "pwd"}, new Object[]{user.name  , pwd});
		if(list==null || list.isEmpty()){
			throw new GException(PlatformExceptionType.BusinessException,"用户名或密码不正确。");
		}
		return mv;
	}
}
