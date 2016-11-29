package cloud.shop.system.dao;

import cloud.shop.system.po.SysUser;
import cloud.shop.system.vo.SysUserVO;




public interface LoginDAO {
	public SysUser getUser(SysUserVO user)throws Exception;
	public void updateUser(SysUser user)throws Exception;
	public void updateUserForLogin(SysUser sysUser)throws Exception;
}
