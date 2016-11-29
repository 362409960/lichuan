package cloud.app.system.service.impl;

import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cloud.app.common.StringUtil;
import cloud.app.system.dao.RoleDAO;
import cloud.app.system.po.STRoleMenu;
import cloud.app.system.po.STUserRole;
import cloud.app.system.service.RoleService;
import cloud.app.system.vo.RoleVO;

@Service
public class RoleServiceImpl implements RoleService {
	Logger logger = Logger.getLogger(this.getClass());
	
	@Autowired
	RoleDAO roleDAO;

//	public void updateRelateMenu(String roleId, String[] menuIds) throws Exception {
//		roleDAO.deleteRoleMenu(roleId);
//		
//		Map<String, String> map = new HashMap<String, String>();
//		map.put("roleId", roleId);
//		List<String> list = null;
//		for (String menuId : menuIds) {
//			if (list == null)
//				list = menuDAO.getMenuListByMenuId(menuId);
//			else {
//				list.addAll(menuDAO.getMenuListByMenuId(menuId));
//			}
//		}
//		
		//去掉list重复的值
//		SetUniqueList setUniqueList = SetUniqueList.decorate(list);
//		for (Object tempId : setUniqueList) {
//			if(tempId != null){
//				map.put("menuId", tempId.toString());
//				map.put("id", StringUtil.getUUID());
//				roleDAO.addRoleMenu(map);
//			}
//		}
//	}

	public RoleVO getInfoById(String id) throws Exception {
		return roleDAO.getInfoById(id);
	}

	public void insert(RoleVO roleVO) throws Exception {
		roleVO.setId(StringUtil.getUUID());
		roleVO.setIs_del("0");
		
		roleDAO.insert(roleVO);
	}

	public void update(RoleVO roleVO) throws Exception {
		roleDAO.update(roleVO);
	}

	public List<RoleVO> selectCheck(RoleVO roleVO) throws Exception {
		return roleDAO.getRoleList(roleVO);
	}

	@Override
	public List<RoleVO> getRoleList(RoleVO roleVO) throws Exception {
		// TODO Auto-generated method stub
		return roleDAO.getRoleList(roleVO);
	}

	@Override
	public void deleteById(String id) throws Exception {
		// TODO Auto-generated method stub
		roleDAO.deleteById(id);
	}

	@Override
	public int roleCount(RoleVO roleVO) throws Exception {
		// TODO Auto-generated method stub
		return roleDAO.roleCount(roleVO);
	}

	@Override
	public List<STRoleMenu> selectRoleByMenuId(String roleId) throws Exception {
		// TODO Auto-generated method stub
		return roleDAO.selectRoleByMenuId(roleId);
	}

	@Override
	public List<STRoleMenu> selectRole_Menu(STRoleMenu sTRoleMenu) {
		// TODO Auto-generated method stub
		return roleDAO.selectRole_Menu(sTRoleMenu);
	}

	@Override
	public void insertRole_Menu(STRoleMenu sTRoleMenu) {
		// TODO Auto-generated method stub
		roleDAO.insertRole_Menu(sTRoleMenu);
	}

	@Override
	public void deleteRole_Menu(STRoleMenu sTRoleMenu) {
		// TODO Auto-generated method stub
		roleDAO.deleteRole_Menu(sTRoleMenu);
	}

	@Override
	public List<STUserRole> userRoleById(String roleId) {
		// TODO Auto-generated method stub
		return roleDAO.userRoleById(roleId);
	}

	@Override
	public void insertRole_Menu_List(List<STRoleMenu> list) {
		// TODO Auto-generated method stub
		roleDAO.insertRole_Menu_List(list);
	}

	@Override
	public List<RoleVO> getRoleByName(String name) {
		// TODO Auto-generated method stub
		return roleDAO.getRoleByName(name);
	}
	
}
