package cloud.app.system.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cloud.app.system.dao.DepartmentDAO;
import cloud.app.system.dao.SysUserDAO;
import cloud.app.system.po.City;
import cloud.app.system.po.Department;
import cloud.app.system.po.District;
import cloud.app.system.po.Province;
import cloud.app.system.po.STUserMenu;
import cloud.app.system.po.STUserRole;
import cloud.app.system.po.SysUser;
import cloud.app.system.service.SysUserService;
import cloud.app.system.vo.SysUserVO;

@Service
public class SysUserServiceImpl implements SysUserService {
	Logger logger = Logger.getLogger(this.getClass());
	
	@Autowired
	private SysUserDAO sysUserDAO;
	@Autowired
	private DepartmentDAO departmentDAO;

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
		Map<String, Object> params = setParams(sysUserVO);
		return sysUserDAO.getSysUserList(params);
	}

	@Override
	public int SysUserCount(SysUserVO sysUserVO) throws Exception {
		// TODO Auto-generated method stub
		Map<String, Object> params = setParams(sysUserVO);
		return sysUserDAO.sysUserCount(params);
	}

	public Map<String, Object> setParams(SysUserVO sysUserVO) throws Exception{
		Map<String, Object> params = new HashMap<String, Object>();
		
		List<String> listMenuId = new ArrayList<String>();
		List<Department> departs = departmentDAO.queryChildrenDepartmentInfo(sysUserVO.getDepartmentid());
		for (Department department : departs) {
			listMenuId.add(department.getId());
		}
    	
		String departIds = "";
	 	for(int i=0;i<listMenuId.size();i++){
	 		String id = listMenuId.get(i);
	 		departIds+=id;
            if(listMenuId.size()-1!=i){
            	departIds+=",";
            }
        }
		
		String [] departmentid = null;
		if(StringUtils.isNotEmpty(departIds)){
			departmentid = departIds.split(",");
		}
		
		params.put("departmentid", departmentid);
		params.put("userCode", sysUserVO.getUserCode());
		params.put("state", sysUserVO.getState());
		params.put("userName", sysUserVO.getUserName());
	    params.put("userPassword", sysUserVO.getUserPassword());
	    params.put("createUser", sysUserVO.getCreateUser());
	    params.put("pageIndex", sysUserVO.getPageIndex());
	    params.put("pageSize", sysUserVO.getPageSize());
	    
		return params;
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

	@Override
	public List<Province> queryProvince() {
		// TODO Auto-generated method stub
		return sysUserDAO.queryProvince();
	}

	@Override
	public List<District> queryDistrict(District district) {
		// TODO Auto-generated method stub
		return sysUserDAO.queryDistrict(district);
	}

	@Override
	public List<City> queryCity(City city) {
		// TODO Auto-generated method stub
		return sysUserDAO.queryCity(city);
	}

	@Override
	public void updateUserPwd(SysUserVO sysUserVO) throws Exception {
		// TODO Auto-generated method stub
		sysUserDAO.updateUserPwd(sysUserVO);
	}

	@Override
	public void deleteUser_RoleByUserId(STUserRole sTUserRole) throws Exception {
		// TODO Auto-generated method stub
		sysUserDAO.deleteUser_RoleByUserId(sTUserRole);
	}

	@Override
	public void insertUser_Menu_List(List<STUserMenu> list) throws Exception {
		// TODO Auto-generated method stub
		sysUserDAO.insertUser_Menu_List(list);
	}

	@Override
	public String getCtityNameById(String id) throws Exception {
		// TODO Auto-generated method stub
		return sysUserDAO.getCtityNameById(id);
	}

	@Override
	public List<SysUserVO> getUserByName(String name) throws Exception {
		// TODO Auto-generated method stub
		return sysUserDAO.getUserByName(name);
	}

	@Override
	public List<SysUserVO> getSysUserByDepartmentid(SysUserVO user)
			throws Exception {
		// TODO Auto-generated method stub
		return sysUserDAO.getSysUserByDepartmentid(user);
	}

}
