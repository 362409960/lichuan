package cloud.app.system.dao;

import java.util.List;
import java.util.Map;

import cloud.app.system.po.City;
import cloud.app.system.po.District;
import cloud.app.system.po.Province;
import cloud.app.system.po.STUserMenu;
import cloud.app.system.po.STUserRole;
import cloud.app.system.po.SysUser;
import cloud.app.system.vo.SysUserVO;


public interface SysUserDAO {

	public void deleteById(String id)throws Exception;

	public SysUser getInfoById(String id)throws Exception;
 
	public List<String> selectUserRole(String id)throws Exception;

	public List<String> selectUserMenu(String id)throws Exception;

	public void deleteUserMenuByUserId(String id)throws Exception;

	public void addUserMenu(STUserMenu stUserMenu)throws Exception;
	
	public List<SysUserVO> getSysUserList(Map<String, Object> map) throws Exception;
	
	public int sysUserCount(Map<String, Object> map) throws Exception;
	
	public void insertUser(SysUserVO sysUserVO) throws Exception;
	
	public void updateUser(SysUserVO sysUserVO) throws Exception;

	public SysUserVO getUserInfoById(String id)throws Exception;
	
	public List<STUserMenu> selectUserByMenuId(String userId);

	public List<STUserRole> selectUserByRoleId(String userId);
	
	public List<STUserRole> selectUser_Role(STUserRole sTUserRole)throws Exception;//查询是否角色关联
	
	public void insertUser_Role(STUserRole sTUserRole)throws Exception;//增加角色关联

	public void deleteUser_Role(STUserRole sTUserRole)throws Exception;//删除角色关联

	public List<STUserMenu> selectUser_Menu(STUserMenu sTUserMenu);//查询是否角色菜单

	public void insertUser_Menu(STUserMenu sTUserMenu)throws Exception;//增加角色菜单
	
	public void insertUser_Menu_List(List<STUserMenu> list)throws Exception;//增加角色菜单

	public void deleteUser_Menu(STUserMenu sTUserMenu)throws Exception;//删除角色菜单

	public void deleteUser_MenuById(String id)throws Exception;//删除角色菜单
	
	public void deleteUser_MenuByUserId(STUserMenu sTUserMenu)throws Exception;//删除角色菜单
	
	public List<Province> queryProvince();
	
	public List<District> queryDistrict(District district);
	
	public List<City> queryCity(City city);
	
	public void updateUserPwd(SysUserVO sysUserVO)throws Exception;
	
	public void deleteUser_RoleByUserId(STUserRole sTUserRole)throws Exception;//删除角色关联
	
	public String getCtityNameById(String id)throws Exception;

	public List<SysUserVO> getUserByName(String name)throws Exception;
	
	public List<SysUserVO> getSysUserByDepartmentid(SysUserVO user)throws Exception;
	
}
