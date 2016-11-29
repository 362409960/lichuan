package cloud.app.system.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cloud.app.system.dao.MenuDAO;
import cloud.app.system.po.STMenu;
import cloud.app.system.service.MenuService;
import cloud.app.system.vo.SysUserVO;

@Service
public class MenuServiceImpl implements MenuService {
	Logger logger = Logger.getLogger(MenuService.class);
	
	@Autowired
	private MenuDAO menuDAO;

	public STMenu viewMenu(String id) throws Exception {
		return menuDAO.viewMenu(id);
	}

	public List<STMenu> getMenuListByUser(SysUserVO user) throws Exception {
	    Map<String, String> params = new HashMap<String, String>();
	    params.put("userId", user.getId());
	    params.put("pid", "0");
	    
	    List<STMenu> pList = menuDAO.getMenuListByUserId(params);
	    for(STMenu menu : pList){
	    	params.put("pid", menu.getId());
	    	
	    	List<STMenu> subMenuList = menuDAO.getMenuListByUserId(params);
	    	for(STMenu temp : subMenuList){
	    		temp.setParentName(menu.getName());
	    	}
	    	
	    	menu.setSubMenuList(subMenuList);
	    	System.out.println(subMenuList.size());
	    }

		return pList;
	}

	@Override
	public List<STMenu> getMenuListParentNode(STMenu stMenu) throws Exception {
		// TODO Auto-generated method stub
		return menuDAO.getMenuListParentNode(stMenu);
	}

	@Override
	public List<STMenu> getMenuListNodeById(String id) throws Exception {
		// TODO Auto-generated method stub
		return menuDAO.getMenuListNodeById(id);
	}

	@Override
	public List<STMenu> getMenuList() throws Exception {
		// TODO Auto-generated method stub
		return menuDAO.getMenuList();
	}

	@Override
	public void insertSTMenu(STMenu stMenu) throws Exception {
		// TODO Auto-generated method stub
		menuDAO.insertSTMenu(stMenu);
	}

	@Override
	public void updateSTMenu(STMenu stMenu) throws Exception {
		// TODO Auto-generated method stub
		menuDAO.updateSTMenu(stMenu);
	}

	@Override
	public void deleteSTMenu(String id) throws Exception {
		// TODO Auto-generated method stub
		menuDAO.deleteSTMenu(id);
	}

	@Override
	public void deleteUser_MenuByMenuId(String menuId) throws Exception {
		// TODO Auto-generated method stub
		menuDAO.deleteUser_MenuByMenuId(menuId);
	}

	@Override
	public void deleteRole_MenuByMenuId(String menuId) throws Exception {
		// TODO Auto-generated method stub
		menuDAO.deleteRole_MenuByMenuId(menuId);
	}
	
	@Override
	public List<STMenu> getListByIds(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return menuDAO.getListByIds(map);
	}
	
}
