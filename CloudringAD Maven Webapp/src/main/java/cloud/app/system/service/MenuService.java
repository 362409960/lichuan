package cloud.app.system.service;

import java.util.List;
import java.util.Map;

import cloud.app.system.po.STMenu;
import cloud.app.system.vo.SysUserVO;

public interface MenuService {
	
	public List<STMenu> getMenuListByUser(SysUserVO user)throws Exception;

	public STMenu viewMenu(String id)throws Exception;
	
	public List<STMenu> getMenuListParentNode(STMenu stMenu)throws Exception;
	
	public List<STMenu> getMenuListNodeById(String id)throws Exception;
	
	public List<STMenu> getMenuList()throws Exception;
	
	public void insertSTMenu(STMenu stMenu)throws Exception;
	
	public void updateSTMenu(STMenu stMenu)throws Exception;
	
	public void deleteSTMenu(String id)throws Exception;
	
	public void deleteUser_MenuByMenuId(String menuId)throws Exception;//删除菜单关联的用户菜单
	
	public void deleteRole_MenuByMenuId(String menuId)throws Exception;//删除菜单关联的角色菜单

	public List<STMenu> getListByIds(Map<String, Object> map)throws Exception;
}
