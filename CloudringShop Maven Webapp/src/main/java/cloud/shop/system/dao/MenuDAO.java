package cloud.shop.system.dao;



import java.util.List;
import java.util.Map;

import cloud.shop.system.po.STMenu;



public interface MenuDAO {
	
	public List<STMenu> getMenuListByUserId(Map<String, String> params)throws Exception;

	public STMenu viewMenu(String id)throws Exception;
	
	public List<STMenu> getMenuListParentNode(STMenu stMenu)throws Exception;
	
	public List<STMenu> getMenuListNodeById(String id)throws Exception;
	
	public List<STMenu> getMenuList()throws Exception;
	
	public void insertSTMenu(STMenu stMenu)throws Exception;
	
	public void updateSTMenu(STMenu stMenu)throws Exception;

	public void deleteSTMenu(String id)throws Exception;
	
	public void deleteUser_MenuByMenuId(String menuId)throws Exception;//删除菜单关联的用户菜单
	
	public void deleteRole_MenuByMenuId(String menuId)throws Exception;//删除菜单关联的角色菜单

}
