package cloud.shop.system.service;

import cloud.shop.system.po.SysUser;
import cloud.shop.system.vo.SysUserVO;





public interface LoginService {

	public SysUserVO updateLogin(SysUserVO user, String ip)throws Exception;
	public void update(SysUser sysUser)throws Exception;
}
