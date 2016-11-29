package cloud.app.system.dao;

import java.util.List;

import cloud.app.system.po.STRoleMenu;
import cloud.app.system.po.STUserRole;
import cloud.app.system.vo.RoleVO;

public interface RoleDAO {

	public void insert(RoleVO roleVO)throws Exception;

	public void update(RoleVO roleVO)throws Exception;

	public void deleteById(String id)throws Exception;

	public RoleVO getInfoById(String id)throws Exception;

	public List<RoleVO> getRoleList(RoleVO roleVO)throws Exception;
	
	public int roleCount(RoleVO roleVO)throws Exception;
	
	public List<STRoleMenu> selectRoleByMenuId(String roleId)throws Exception;

	public List<STRoleMenu> selectRole_Menu(STRoleMenu sTRoleMenu);

	public void insertRole_Menu(STRoleMenu sTRoleMenu);

	public void deleteRole_Menu(STRoleMenu sTRoleMenu);
	
	public List<STUserRole> userRoleById(String roleId);

	public void insertRole_Menu_List(List<STRoleMenu> list);
	
	public List<RoleVO> getRoleByName(String name);

}
