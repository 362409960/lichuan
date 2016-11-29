package cloud.app.system.service.impl;

import java.util.Calendar;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cloud.app.system.dao.LoginDAO;
import cloud.app.system.po.SysUser;
import cloud.app.system.service.LoginService;
import cloud.app.system.vo.SysUserVO;



@Service
public class LoginServiceImpl implements LoginService {
	@Autowired
	private LoginDAO loginDAO;
	
	
	public SysUserVO updateLogin(SysUserVO user, String ip) throws Exception {
		SysUser sysUser = loginDAO.getUser(user);
		if (sysUser == null) {
			return null;
		}

		sysUser.setLastLoginIp(ip);
		sysUser.setLastLoginTime(Calendar.getInstance().getTime());
		update(sysUser);
		
		BeanUtils.copyProperties(sysUser, user);
 
		return user;
	}
	
	public void update(SysUser sysUser) throws Exception {
		loginDAO.updateUserForLogin(sysUser);
    }
	
}
