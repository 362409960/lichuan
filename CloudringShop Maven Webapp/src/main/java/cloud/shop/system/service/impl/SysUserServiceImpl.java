package cloud.shop.system.service.impl;



import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cloud.shop.system.dao.SysUserDAO;
import cloud.shop.system.po.STUserMenu;
import cloud.shop.system.po.STUserRole;
import cloud.shop.system.po.SysUser;
import cloud.shop.system.service.SysUserService;
import cloud.shop.system.vo.SysUserVO;



@Service
public class SysUserServiceImpl implements SysUserService {
	Logger logger = Logger.getLogger(this.getClass());
	
	@Autowired
	private SysUserDAO sysUserDAO;

	public List<String> selectUserRole(String id) throws Exception {
		return sysUserDAO.selectUserRole(id);
	}

	public SysUserVO getInfoById(String id) throws Exception {
		SysUserVO sysUserVO = null;
		
		SysUser sysUser = sysUserDAO.getInfoById(id);
		if(sysUser != null){
			sysUserVO = new SysUserVO();
			BeanUtils.copyProperties(sysUser, sysUserVO);
		}

		return sysUserVO;
	}

//	public void updateInitPassword(String id) throws Exception {
//		String[] str = id.split(Constants.C_DELIMITER);
//
//		for(String tempId : str){
//			SysUser sysUser = new SysUser();
//
//			sysUser.setId(tempId);
//			sysUser.setUserPassword(MD5.Md5(Constants.C_INIT_PASSWORD));
//			
//			sysUserDAO.update(sysUser);
//		}
//	}

	public void delete(String id) throws Exception {
		sysUserDAO.deleteById(id);
		
		
	}

	public List<String> selectUserMenu(String id) throws Exception {
		
		return sysUserDAO.selectUserMenu(id);
	}

	@Override
	public List<SysUserVO> getSysUserList(SysUserVO sysUserVO) throws Exception {
		// TODO Auto-generated method stub
		return sysUserDAO.getSysUserList(sysUserVO);
	}

	@Override
	public int SysUserCount(SysUserVO sysUserVO) throws Exception {
		// TODO Auto-generated method stub
		return sysUserDAO.sysUserCount(sysUserVO);
	}

	@Override
	public void insertUser(SysUserVO sysUserVO) throws Exception {
		// TODO Auto-generated method stub
		sysUserDAO.insertUser(sysUserVO);
	}

	@Override
	public void updateUser(SysUserVO sysUserVO) throws Exception {
		// TODO Auto-generated method stub
		sysUserDAO.updateUser(sysUserVO);
	}

	@Override
	public void deleteUser(String id) throws Exception {
		// TODO Auto-generated method stub
		sysUserDAO.deleteById(id);
	}

	@Override
	public List<STUserMenu> selectUserByMenuId(String userId) {
		// TODO Auto-generated method stub
		return sysUserDAO.selectUserByMenuId(userId);
	}

	@Override
	public SysUserVO getUserInfoById(String id) throws Exception {
		// TODO Auto-generated method stub
		return sysUserDAO.getUserInfoById(id);
	}

	@Override
	public List<STUserRole> selectUserByRoleId(String userId) {
		// TODO Auto-generated method stub
		return sysUserDAO.selectUserByRoleId(userId);
	}

	@Override
	public void insertUser_Role(STUserRole sTUserRole) throws Exception {
		// TODO Auto-generated method stub
		sysUserDAO.insertUser_Role(sTUserRole);
	}

	@Override
	public void deleteUser_Role(STUserRole sTUserRole) throws Exception {
		// TODO Auto-generated method stub
		sysUserDAO.deleteUser_Role(sTUserRole);
	}

	@Override
	public List<STUserRole> selectUser_Role(STUserRole sTUserRole)
			throws Exception {
		// TODO Auto-generated method stub
		return sysUserDAO.selectUser_Role(sTUserRole);
	}

	@Override
	public void insertUser_Menu(STUserMenu sTUserMenu) throws Exception {
		// TODO Auto-generated method stub
		sysUserDAO.insertUser_Menu(sTUserMenu);
	}

	@Override
	public void deleteUser_Menu(STUserMenu sTUserMenu) throws Exception {
		// TODO Auto-generated method stub
		sysUserDAO.deleteUser_Menu(sTUserMenu);
	}

	@Override
	public List<STUserMenu> selectUser_Menu(STUserMenu sTUserMenu) {
		// TODO Auto-generated method stub
		return sysUserDAO.selectUser_Menu(sTUserMenu);
	}
	
	@Override
	public void deleteUser_MenuById(String id) throws Exception {
		// TODO Auto-generated method stub
		sysUserDAO.deleteUser_MenuById(id);
	}

	@Override
	public void deleteUser_MenuByUserId(STUserMenu sTUserMenu) throws Exception {
		// TODO Auto-generated method stub
		sysUserDAO.deleteUser_MenuByUserId(sTUserMenu);
	}

}
