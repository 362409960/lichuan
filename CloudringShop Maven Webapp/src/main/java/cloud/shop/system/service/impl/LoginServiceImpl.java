package cloud.shop.system.service.impl;



import java.util.Calendar;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cloud.shop.system.dao.LoginDAO;
import cloud.shop.system.po.SysUser;
import cloud.shop.system.service.LoginService;
import cloud.shop.system.vo.SysUserVO;





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
