package cloud.app.system.dao;

import cloud.app.system.po.SysUser;
import cloud.app.system.vo.SysUserVO;

public interface LoginDAO {
	public SysUser getUser(SysUserVO user)throws Exception;
	public void updateUser(SysUser user)throws Exception;
	public void updateUserForLogin(SysUser sysUser)throws Exception;
}
