package cloud.app.system.controller;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import cloud.app.common.Constants;
import cloud.app.common.MD5;
import cloud.app.system.po.City;
import cloud.app.system.po.Department;
import cloud.app.system.po.District;
import cloud.app.system.po.Province;
import cloud.app.system.po.STRoleMenu;
import cloud.app.system.po.STUserMenu;
import cloud.app.system.po.STUserRole;
import cloud.app.system.service.DepartmentService;
import cloud.app.system.service.MenuService;
import cloud.app.system.service.RoleService;
import cloud.app.system.service.SysUserService;
import cloud.app.system.vo.RoleVO;
import cloud.app.system.vo.SysUserVO;

@Controller
@RequestMapping("/admin/user")
public class SysUserController {
	
	Logger logger = Logger.getLogger(this.getClass());
	
	@Autowired
	private SysUserService sysUserService;
	@Autowired
	private MenuService menuService;
	@Autowired
	private RoleService roleService;
	@Autowired
	private DepartmentService departmentService;
	
	//http://localhost:8080/CloudringAD/admin/user/listSysUser.do
	@RequestMapping(value = "/listSysUser")
	public String listSysUser(HttpServletRequest request,HttpServletResponse response,ModelMap model,String page){
		logger.info("--------------->用户列表");
		SysUserVO userVO = (SysUserVO)request.getSession().getAttribute(Constants.SESSION_LOGIN_USER);//将用户信息放入session
        try{
        	SysUserVO sysUser = new SysUserVO();
        	String userName = request.getParameter("userName");
        	if(userName != null){
        		userName = userName.trim();
        	}
        	String departmentid = request.getParameter("departmentid");
        	String departmentname = request.getParameter("departmentname");
        	String ps = request.getParameter("pageSize");
        	
        	if(ps==null){
        		ps = "10";
        	}
        	int pageSize = Integer.parseInt(ps);//每页显示的条数
        	if("page".equals(page)){
        		userName = null;
        		departmentid = null;
        		page = null;
        	}
        	sysUser.setUserName(userName);
        	sysUser.setDepartmentid(departmentid);
        	sysUser.setCreateUser(userVO.getUserCode());
        	sysUser.setUserCode(userVO.getUserCode());
        	int total = sysUserService.SysUserCount(sysUser);
        	//查到的总用户数
        	model.addAttribute("total", total);
			
			//int pageSize = 9;
			//总页数
			int pageTimes;
			if(total%pageSize == 0){
				pageTimes = total/pageSize;
			}else{
				pageTimes = total/pageSize + 1;
			}
			model.addAttribute("pageTimes", pageTimes);
			
			//页面初始的时候page没有值
			if(null == page){
				page = "1";
			}
			//每页开始的第几条记录            
			int startRow = (Integer.parseInt(page)-1) * pageSize;
			sysUser.setPageIndex(startRow);
			sysUser.setPageSize(pageSize);
			
			List<SysUserVO> list = sysUserService.getSysUserList(sysUser);
			
			for (SysUserVO sysUserVO : list) {
				Department department = departmentService.getDepartmentById(sysUserVO.getDepartmentid());
				if(department!=null){
					sysUserVO.setDepartmentid(department.getId());
					sysUserVO.setDepartmentname(department.getName());
				}
			}
			
//			for (SysUserVO sysUserVO : list) {
//				String role = "";
//				String roleName = "";
//				List<STUserRole> roles = sysUserService.selectUserByRoleId(sysUserVO.getId());
//				for (STUserRole stUserRole : roles) {
//					role+=stUserRole.getRole_id()+",";
//				}
//				String[] role_id = role.split(",");
//        		for(int i = 0;i<role_id.length;i++){//批量添加
//        			RoleVO roleVO = roleService.getInfoById(role_id[i]);
//        			if(roleVO!=null){
//        				roleName += roleVO.getRole_name()+",";
//        			}
//        		}
//				sysUserVO.setRole(StringUtils.isNotEmpty(roleName)?roleName.substring(0, roleName.length()-1):"");
//			}
			
			model.addAttribute("currentPage", Integer.parseInt(page));
			model.addAttribute("list", list);
			model.addAttribute("userName", userName);
			model.addAttribute("departmentname", departmentname);
			model.addAttribute("departmentid", departmentid);
			model.addAttribute("pageSize", pageSize);
			model.addAttribute("page", page);
        }catch(Exception ex){
            ex.printStackTrace();
        }
        return "page/sys/user/list";
	}
	
	/**
	 * 详情
	 * @param request
	 * @param response
	 */
	//http://localhost:8080/CloudringAD/admin/user/detailsUser.do
	@RequestMapping(value = "/detailsUser")
	public String detailsUser(HttpServletRequest request,HttpServletResponse response,ModelMap model,SysUserVO user){
		String action = request.getParameter("action");
        try{
        	SysUserVO sysUser = null;
        	List<RoleVO> listRoleVO = null;
        	
        	if(user.getId() == null){
        		RoleVO role = new RoleVO();
            	listRoleVO = roleService.getRoleList(role);
        	}else{
        		List<String> listRoleId = new ArrayList<String>();
    			sysUser = sysUserService.getUserInfoById(user.getId());
    			
    			//查看用户权限
    			List<STUserRole> userRoleList = sysUserService.selectUserByRoleId(user.getId());
    			for (STUserRole stUserRole : userRoleList) {
    				listRoleId.add(stUserRole.getRole_id());
    			}
    			
    			RoleVO role = new RoleVO();
            	listRoleVO = roleService.getRoleList(role);
            	for (RoleVO roleVO : listRoleVO) {//判断有哪些权限
            		roleVO.setIs_checked(listRoleId.contains(roleVO.getId()));
    			}
        	}
        	
        	model.addAttribute("password", Constants.C_INIT_PASSWORD);//初始化密码
			model.addAttribute("user", sysUser);
			model.addAttribute("allRoles", listRoleVO);
			
        }catch(Exception ex){
            ex.printStackTrace();
        }
        if(StringUtils.isEmpty(action)){
        	return "page/sys/user/details";
        }else{
            return "page/sys/user/edit";
        }
	}
	
	//判断字符串是否为数字
	public static boolean isNumeric(String str){
		for (int i = str.length();--i>=0;){   
			if (!Character.isDigit(str.charAt(i))){
				return false;
			}
		}
		
		return true;
	}

	/**
	 * 新增或修改
	 * @param request
	 * @param response
	 * @param user
	 */
	@RequestMapping(value = "/sysUserEdit")
	public String sysUserEdit(HttpServletRequest request,HttpServletResponse response,SysUserVO sysUser,ModelMap model){
        try{
        	SysUserVO userVO = (SysUserVO)request.getSession().getAttribute(Constants.SESSION_LOGIN_USER);//将用户信息放入session
        	
        	String province = request.getParameter("province");
	    	String city = request.getParameter("city");
	    	String district = request.getParameter("district");
	    	
	    	String location = "";
	    	if(StringUtils.isNotEmpty(province)&&!isNumeric(province))
	    		location = province;
	    	if(StringUtils.isNotEmpty(province)&&!isNumeric(province)&&StringUtils.isNotEmpty(city)&&!isNumeric(city))
	    		location = province + " | " + city;
	    	if(StringUtils.isNotEmpty(province)&&!isNumeric(province)&&StringUtils.isNotEmpty(city)&&!isNumeric(city)&&StringUtils.isNotEmpty(district)&&!isNumeric(district))
	    		location = province + " | " + city + " | " + district;
	    	
	    	sysUser.setAddress(location);//地址
	    	if(null != sysUser.getUserCode()){
	    		sysUser.setUserCode(sysUser.getUserCode().trim());
	    	}
	    	if(null != sysUser.getUserName()){
	    		sysUser.setUserName(sysUser.getUserName().trim());
	    	}
        	if(StringUtils.isEmpty(sysUser.getId())){
        		sysUser.setId(UUID.randomUUID().toString().replace("-", ""));//用户编号
            	sysUser.setUserPassword(MD5.Md5(Constants.C_INIT_PASSWORD));//初始化密码
            	sysUser.setCreateUser(userVO.getUserCode());
            	//sysUser.setCreateTime(new Date());
            	sysUserService.insertUser(sysUser);
        	}else{
        		sysUser.setUpdateUser(userVO.getUserCode());
            	sysUserService.updateUser(sysUser);
        	}
        	
        	String selectedArr = request.getParameter("selectedArr");//已选中角色（添加）
        	String notSelectArr = request.getParameter("notSelectArr");//未选中角色（删除）
    		//用户角色
        	STUserRole sTUserRole = new STUserRole();
        	sTUserRole.setUser_id(sysUser.getId());
        	//用户菜单
        	STUserMenu stUserMenu = new STUserMenu();
        	stUserMenu.setUser_id(sysUser.getId());
        	//删除
//        	if(StringUtils.isNotEmpty(notSelectArr)){
//        		String[] notSelect = notSelectArr.split(",");
//        		for(int i =0;i<notSelect.length;i++){//批量删除
//        			sTUserRole.setRole_id(notSelect[i]);
//        			
//        			List<STRoleMenu> roleMenuList = roleService.selectRoleByMenuId(sTUserRole.getRole_id());
//        			for (STRoleMenu stRoleMenu : roleMenuList) {
//        				
//    					List<STUserRole> sTUserRoles = roleService.userRoleById(sTUserRole.getRole_id());
//    					for (STUserRole stUserRole2 : sTUserRoles) {
//    						if(stUserRole2.getUser_id().equals(sysUser.getId())){
//    							//sTUserMenu.setUser_id(stUserRole2.getUser_id());
//    							STUserMenu um = new STUserMenu();
//    							um.setId(stRoleMenu.getId());
//    							um.setUser_id(sysUser.getId());
//    							sysUserService.deleteUser_MenuByUserId(um);//删除用户菜单
//        					}
//						}
//					}
//    	            sysUserService.deleteUser_RoleByUserId(sTUserRole);//删除用户权限
//    	        }
//        	}
    	    
	        sysUserService.deleteUser_MenuByUserId(stUserMenu);//删除用户菜单
	        sysUserService.deleteUser_RoleByUserId(sTUserRole);//删除用户权限
	        List<STUserMenu> list = new ArrayList<STUserMenu>();
        	//添加
        	if(StringUtils.isNotEmpty(selectedArr)){
        		String[] selected = selectedArr.split(",");
        		for(int i =0;i<selected.length;i++){//批量添加
        			sTUserRole.setRole_id(selected[i]);//设置权限编号
        			
        			List<STUserRole> selectUserRole = sysUserService.selectUser_Role(sTUserRole);//查询是否有此数据
        			if(selectUserRole.size()==0){//说明没得此条数据
        				sTUserRole.setId(UUID.randomUUID().toString().replace("-", ""));
        	            sysUserService.insertUser_Role(sTUserRole);//添加用户权限
        	            logger.info("-------------------->添加用户权限");
        			}
        			
        			//查询角色的所有菜单权限
        			List<STRoleMenu> roleMenuList = roleService.selectRoleByMenuId(sTUserRole.getRole_id());
        			for (STRoleMenu stRoleMenu : roleMenuList) {
        				stUserMenu = new STUserMenu();
        	        	stUserMenu.setUser_id(sysUser.getId());
        				stUserMenu.setMenu_id(stRoleMenu.getMenu_id());//设置权限编号
            			stUserMenu.setId(stRoleMenu.getId());
            			//stUserMenu.setId(UUID.randomUUID().toString().replace("-", ""));
           				list.add(stUserMenu);
					}
    	        }
        		
        		if(list.size()>0){
        			sysUserService.insertUser_Menu_List(list);
            		logger.info("-------------------->添加用户菜单");
        		}
        		
        	}
	        
//        	if(StringUtils.isNotEmpty(selectedArr)){
//	    		String[] selected = selectedArr.split(",");
//	    		for(int i =0;i<selected.length;i++){//批量添加
//	    			sTUserRole.setRole_id(selected[i]);//设置权限编号
//	    			
//	    			List<STUserRole> selectUserRole = sysUserService.selectUser_Role(sTUserRole);//查询是否有此数据
//	    			if(selectUserRole.size()==0){//说明没得此条数据
//	    				sTUserRole.setId(UUID.randomUUID().toString().replace("-", ""));
//	    	            sysUserService.insertUser_Role(sTUserRole);//添加用户权限
//	    	            logger.info("-------------------->添加用户权限");
//	    			}
//	    			
//	    			//查询角色的所有菜单权限
//	    			List<STRoleMenu> roleMenuList = roleService.selectRoleByMenuId(sTUserRole.getRole_id());
//	    			for (STRoleMenu stRoleMenu : roleMenuList) {
//	    				stUserMenu.setMenu_id(stRoleMenu.getMenu_id());//设置权限编号
//	    				List<STUserMenu> selectUserMenu = sysUserService.selectUser_Menu(stUserMenu);
//	        			if(selectUserMenu.size()==0){
//	        				//stUserMenu.setId(UUID.randomUUID().toString().replace("-", ""));
//	        				stUserMenu.setId(stRoleMenu.getId());
//	        				sysUserService.insertUser_Menu(stUserMenu);
//	        				logger.info("-------------------->添加用户菜单");
//	        			}
//	    			}
//		        }
//	    	}
        	
        }catch(Exception ex){
            ex.printStackTrace();
        }
        
        String page = "page";
        return listSysUser(request, response, model, page);
	}
	
	/**
	 * 删除
	 * @param request
	 * @param response
	 */
	@RequestMapping(value = "/deleteSysUser")
	public void deleteUser(HttpServletRequest request,HttpServletResponse response){
        response.setContentType("text/html;charset=utf-8"); //指定输出内容类型和编码
        try{
        	boolean isValid = false;
        	String ids = request.getParameter("ids");
        	if(ids!=null&&ids!=""){
        		String[] id = ids.split(",");
        		for(int i =0;i<id.length;i++){
        			sysUserService.deleteUser(id[i]);
        		}
        		isValid = true;
        	}
        	response.getWriter().print(JSONArray.fromObject(isValid));
        }catch(Exception ex){
            ex.printStackTrace();
        }
	}
	
	/**
	 * 获取省份信息
	 * @param request
	 * @param response
	 */
	//http://localhost:8080/CloudringAD/admin/user/queryProvince.do
	@RequestMapping(value = "/queryProvince")
	public void queryProvince(HttpServletRequest request,HttpServletResponse response){
		logger.info("--------------->获取省份信息");
		response.setContentType("text/html;charset=utf-8"); //指定输出内容类型和编码
		PrintWriter out = null;
    	List<Province> provinces = null;
    	try {
    		out = response.getWriter();//获取输出口
            provinces = sysUserService.queryProvince();
            for (Province provinceEntity : provinces) {
            	provinceEntity.setProvinceName(provinceEntity.getProvinceName()+(StringUtils.isNotEmpty(provinceEntity.getProvinceType())?provinceEntity.getProvinceType():""));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		out.println(net.sf.json.JSONArray.fromObject(provinces));//返回结果
        out.flush();
        out.close();
	}
	
	/**
	 * 获取市信息
	 * @param request
	 * @param response
	 * @param jsons
	 */
	@RequestMapping(value = "/queryCity")
	public void queryCity(HttpServletRequest request,HttpServletResponse response){
		logger.info("--------------->获取市信息");
		response.setContentType("text/html;charset=utf-8"); //指定输出内容类型和编码
		PrintWriter out = null;
    	List<City> citys = null;
    	City city = new City();
    	try {
    		out = response.getWriter();//获取输出口
    		String provinceId = request.getParameter("provinceId");
    		city.setCityUpId(provinceId);
    		citys = sysUserService.queryCity(city);
            for (City cityEntity : citys) {
            	cityEntity.setCityName(cityEntity.getCityName()+(StringUtils.isNotEmpty(cityEntity.getCityType())?cityEntity.getCityType():""));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		out.println(net.sf.json.JSONArray.fromObject(citys));//返回结果
        out.flush();
        out.close();
	}
	
	/**
	 * 获取区信息
	 * @param request
	 * @param response
	 * @param jsons
	 */
	@RequestMapping(value = "/queryDistrict")
	public void queryDistrict(HttpServletRequest request,HttpServletResponse response){
		logger.info("--------------->获取区信息");
		response.setContentType("text/html;charset=utf-8"); //指定输出内容类型和编码
		PrintWriter out = null;
    	List<District> districts = null;
    	District district = new District();
    	try {
    		out = response.getWriter();//获取输出口
    		String cityId = request.getParameter("cityId");
    		district.setDistrictUpId(cityId);
    		districts = sysUserService.queryDistrict(district);
    		for (District districtEntity : districts) {
    			districtEntity.setDistrictName(districtEntity.getDistrictName()+(StringUtils.isNotEmpty(districtEntity.getDistrictType())?districtEntity.getDistrictType():""));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		out.println(net.sf.json.JSONArray.fromObject(districts));//返回结果
        out.flush();
        out.close();
	}
	
	/**
	 * 密码
	 * @param request
	 * @param response
	 */
	@RequestMapping(value = "/toPwd")
	public String toPwd(HttpServletRequest request,HttpServletResponse response,ModelMap model){
        String id = request.getParameter("id");
		model.addAttribute("id", id);
        return "page/sys/user/password";
	}
	
	/**
	 * 修改密码
	 * @param request
	 * @param response
	 */
	@RequestMapping(value = "/updatPwd")
	public void updatPwd(HttpServletRequest request,HttpServletResponse response,ModelMap model){
		response.setContentType("text/html;charset=utf-8"); //指定输出内容类型和编码
		PrintWriter out = null;
		boolean isValid = false;
    	try {
    		out = response.getWriter();//获取输出口
    		String id = request.getParameter("id");
        	String password = request.getParameter("newsPwd");
        	String oldPassword = request.getParameter("oldPassword");
        	SysUserVO user = sysUserService.getUserInfoById(id);
        	if(MD5.Md5(oldPassword).equals(user.getUserPassword())){
        		user = new SysUserVO();
        		user.setId(id);
        		user.setUserPassword(MD5.Md5(password));
        		sysUserService.updateUserPwd(user);
        		isValid = true;
        	}
		} catch (Exception e) {
			e.printStackTrace();
			isValid = false;
		}
		out.println(net.sf.json.JSONArray.fromObject(isValid));//返回结果
        out.flush();
        out.close();
	}
	
	//退出
	@RequestMapping(value = "/quitUser")
	public String quitUser(HttpServletRequest request,HttpServletResponse response,ModelMap model) throws Exception{
		request.getSession().removeAttribute(Constants.SESSION_LOGIN_USER);
	    return "/init";
	}
	
	
	//查询用户代码是否存在
	@RequestMapping(value = "/queryName")
	public void queryName(HttpServletRequest request,HttpServletResponse response){
		response.setContentType("text/html;charset=utf-8"); //指定输出内容类型和编码
        try{
        	boolean isValid = false;
        	String id = request.getParameter("id");
        	String name = new String(request.getParameter("name").getBytes("ISO-8859-1"),"GBK");
        	if(StringUtils.isEmpty(id)){//添加做判断
        		List<SysUserVO> list = sysUserService.getUserByName(name);
            	if(list.size()>0){
            		isValid = true;
            	}
        	}
        	response.getWriter().print(JSONArray.fromObject(isValid));
        }catch(Exception ex){
            ex.printStackTrace();
        }
	}
}
