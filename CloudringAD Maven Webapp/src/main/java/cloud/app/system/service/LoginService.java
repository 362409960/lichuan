package cloud.app.system.service;

import cloud.app.system.po.SysUser;
import cloud.app.system.vo.SysUserVO;

public interface LoginService {

	public SysUserVO updateLogin(SysUserVO user, String ip)throws Exception;
	public void update(SysUser sysUser)throws Exception;
}
