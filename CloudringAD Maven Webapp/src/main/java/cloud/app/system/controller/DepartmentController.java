package cloud.app.system.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import cloud.app.system.service.SysUserService;
import cloud.app.system.po.Department;
import cloud.app.system.po.STUserMenu;
import cloud.app.system.po.STUserRole;
import cloud.app.common.Constants;
import cloud.app.common.MD5;
import cloud.app.system.po.STRoleMenu;
import cloud.app.system.service.DepartmentService;
import cloud.app.system.service.RoleService;
import cloud.app.system.vo.RoleVO;
import cloud.app.system.vo.SysUserVO;

@Controller
@RequestMapping("/admin/department")
public class DepartmentController {
	
	Logger logger = Logger.getLogger(this.getClass());
	
	boolean isValid=false;
	
	@Autowired
	private RoleService roleService;
	@Autowired
	private SysUserService sysUserService;
	@Autowired
	private DepartmentService departmentService;
	
//	@RequestMapping(value = "/listDepartment")
//	public String listDepartment(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
//		JSONObject jsonObjectMap = new JSONObject();
//		JSONArray jsonArray = new JSONArray();
//		try {
//			List<Department> menuList = departmentService.getDepartmentByPid(Constants.PARENT_ID);
//			for (Department stMenu : menuList) {
//				List<Department> menuParent = departmentService.getDepartmentListNodeById(stMenu.getId());
//				jsonObjectMap.put("id",stMenu.getId());
//				jsonObjectMap.put("name",stMenu.getName());
//				jsonObjectMap.put("pid",stMenu.getPid());
//				jsonObjectMap.put("parentName",stMenu.getParentName());
//				jsonObjectMap.put("create_user",stMenu.getCreate_user());
//				jsonObjectMap.put("update_user",stMenu.getUpdate_user());
//				jsonObjectMap.put("update_time",stMenu.getUpdate_time());
//				
//				//第一个节点不显示复选框
//				if(stMenu.getPid().equals(Constants.PARENT_ID)){
//					jsonObjectMap.put("nocheck",true);
//				}
//				
//				for (Department stMenu2 : menuParent) {
//					stMenu2.setParentName(stMenu.getName());//上级菜单名称
//					List<Department> menuParent1 = departmentService.getDepartmentListNodeById(stMenu2.getId());
//					for (Department stMenu3 : menuParent1) {
//						stMenu3.setParentName(stMenu2.getName());//2级菜单名称
//						List<Department> menuParent2 = departmentService.getDepartmentListNodeById(stMenu3.getId());
//						for (Department stMenu4 : menuParent2) {
//							stMenu4.setParentName(stMenu3.getName());//3级菜单名称
//							List<Department> menuParent3 = departmentService.getDepartmentListNodeById(stMenu4.getId());
//							for (Department stMenu5 : menuParent3) {
//								stMenu5.setParentName(stMenu4.getName());//4级菜单名称
//								List<Department> menuParent4 = departmentService.getDepartmentListNodeById(stMenu5.getId());
//								stMenu5.setSubMenuList(menuParent4);
//							}
//							stMenu4.setSubMenuList(menuParent3);
//						}
//						stMenu3.setSubMenuList(menuParent2);
//					}
//					stMenu2.setSubMenuList(menuParent1);
//				}
//				jsonObjectMap.put("subMenuList",menuParent);
//				
//				jsonArray.add(jsonObjectMap);
//			}
//			isValid = true;
//		} catch (Exception e) {
//			e.printStackTrace();
//			isValid = false;
//		}
//		String json = jsonArray.toString();
//		json = json.replaceAll("subMenuList", "nodes").replaceAll("url", "menuUrl");
//		
//		String jsonNodes = "[{'id':'" + Constants.PARENT_ID + "','name':'" + Constants.PARENT_NAME + "','open':true,'nocheck':true,'nodes':" + json + "}]";//最顶级菜单
//		
//		model.addAttribute("zTreeNodes", json.replaceAll("'", "\""));
//		model.addAttribute("total", departmentService.departmentCount());
//		return "page/sys/department/list";
//	}
	
	@RequestMapping(value = "/listDepartment")
	public String listDepartment(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		String action = request.getParameter("action");
		try {
			List<Department> menus = departmentService.getDepartmentList(null);
			for (Department department : menus) {
				if(Constants.PARENT_ID.equals(department.getPid())){
					department.setParentCheck(true);//最顶级父节点不显示复选框
				}
			}
			model.addAttribute("zTreeNodes", com.alibaba.fastjson.JSONArray.toJSONString(menus).replaceAll("pid","pId").replaceAll("parentCheck", "nocheck"));
			model.addAttribute("total", departmentService.departmentCount());
		} catch (Exception e) {
			e.printStackTrace();
		}
		if(StringUtils.isEmpty(action)){
			return "page/sys/department/list";
        }else{
        	return "page/sys/department/tree";
        }
		
	}
	
	//详情
	@RequestMapping(value = "/detailsDepartment")
	public String detailsDepartment(HttpServletRequest request,HttpServletResponse response,Department department,ModelMap model) {
		String action = request.getParameter("action");
		try {
			String id = request.getParameter("id");
			List<SysUserVO> users = null;
			if(id==null){
				List<Department> menuList = departmentService.getDepartmentByPid(Constants.PARENT_ID);
				if(menuList.size()==0){
					department.setPid("0");
				}
				for (Department department2 : menuList) {
					department.setPid(department2.getId());
					department.setParentName(department2.getName());
				}
			}else{
				department = departmentService.getDepartmentById(id);
				if(department!=null){
					Department depart = departmentService.getDepartmentById(department.getPid());
					if(depart!=null){
						department.setParentName(depart.getName());
					}
				}
				SysUserVO user = new SysUserVO();
				user.setDepartmentid(id);
				users = sysUserService.getSysUserByDepartmentid(user);
			}
			
			model.addAttribute("users", users);
			model.addAttribute("department", department);
		} catch (Exception e) {
			e.printStackTrace();
		}
		if(StringUtils.isEmpty(action)){
        	return "page/sys/department/details";
        }else{
            return "page/sys/department/edit";
        }
	}
	
	/**
	 * 新增或修改
	 * @param request
	 * @param response
	 * @param user
	 * @throws Exception 
	 */
	@RequestMapping(value = "/editDepartment")
	public String editDepartment(HttpServletRequest request,HttpServletResponse response,Department department,ModelMap model) throws Exception{
        try{
        	SysUserVO userVO = (SysUserVO)request.getSession().getAttribute(Constants.SESSION_LOGIN_USER);//将用户信息放入session
        	if(StringUtils.isEmpty(department.getId())){
        		department.setId(UUID.randomUUID().toString().replace("-", ""));//用户编号
        		department.setCreate_user(userVO.getUserCode());
        		departmentService.insertDepartment(department);
        	}else{
        		department.setUpdate_user(userVO.getUserCode());
        		departmentService.updateDepartment(department);
        	}
        	
        }catch(Exception ex){
            ex.printStackTrace();
        }
        
        return listDepartment(request, response, model);
	}
	
	//删除节点
	@RequestMapping(value = "/deleteNode")
	public void deleteNode(HttpServletRequest request,HttpServletResponse response){
		response.setContentType("text/html;charset=utf-8"); //指定输出内容类型和编码
        try{
        	boolean isValid = false;
        	String ids = request.getParameter("ids");
        	if(StringUtils.isNotEmpty(ids)){
        		String[] id = ids.split(",");
        		for(int i = 0;i<id.length;i++){
        			departmentService.deleteDepartment(id[i]);
        		}
        		isValid = true;
        	}
        	response.getWriter().print(JSONArray.fromObject(isValid));
        }catch(Exception ex){
            ex.printStackTrace();
        }
	}
	
	//查询名字是否存在
	@RequestMapping(value = "/queryName")
	public void queryName(HttpServletRequest request,HttpServletResponse response){
		response.setContentType("text/html;charset=utf-8"); //指定输出内容类型和编码
        try{
        	boolean isValid = false;
        	String id = request.getParameter("id");
        	String name = new String(request.getParameter("name").getBytes("ISO-8859-1"),"GBK");
        	if(StringUtils.isEmpty(id)){
        		List<Department> list = departmentService.getDepartmentByName(name);
            	if(list.size()>0){
            		isValid = true;
            	}
        	}
        	response.getWriter().print(JSONArray.fromObject(isValid));
        }catch(Exception ex){
            ex.printStackTrace();
        }
	}
	
	/**
	 * 详情
	 * @param request
	 * @param response
	 */
	//http://localhost:8080/CloudringAD/admin/department/toUserInfo.do
	@RequestMapping(value = "/toUserInfo")
	public String toUserInfo(HttpServletRequest request,HttpServletResponse response,ModelMap model) throws Exception{
        String id = request.getParameter("id");
        try{
    		RoleVO role = new RoleVO();
        	List<RoleVO> listRoleVO = roleService.getRoleList(role);
        	Department department = departmentService.getDepartmentById(id);
        	
        	model.addAttribute("password", Constants.C_INIT_PASSWORD);//初始化密码
        	model.addAttribute("department", department);
			model.addAttribute("allRoles", listRoleVO);
			
        }catch(Exception ex){
            ex.printStackTrace();
        }
        return "page/sys/department/userDetails";
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
	 * 新增用户信息
	 * @param request
	 * @param response
	 * @param user
	 */
	@RequestMapping(value = "/addUserInfo")
	public void addUserInfo(HttpServletRequest request,HttpServletResponse response,SysUserVO sysUser,ModelMap model){
		response.setContentType("text/html;charset=utf-8"); //指定输出内容类型和编码
        try{
        	boolean isValid = false;
        	SysUserVO userVO = (SysUserVO)request.getSession().getAttribute(Constants.SESSION_LOGIN_USER);//将用户信息放入session
    		sysUser.setId(UUID.randomUUID().toString().replace("-", ""));//用户编号
        	sysUser.setUserPassword(MD5.Md5(Constants.C_INIT_PASSWORD));//初始化密码
        	sysUser.setCreateUser(userVO.getUserCode());
        	
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
        	
        	sysUserService.insertUser(sysUser);
        	
        	String selectedArr = request.getParameter("selectedArr");//已选中角色（添加）
        	
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
//    	            sysUserService.deleteUser_Role(sTUserRole);//删除用户权限
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
        			}
        			
        			//查询角色的所有菜单权限
        			List<STRoleMenu> roleMenuList = roleService.selectRoleByMenuId(sTUserRole.getRole_id());
//        			for (STRoleMenu stRoleMenu : roleMenuList) {
//        				stUserMenu.setMenu_id(stRoleMenu.getMenu_id());//设置权限编号
//        				List<STUserMenu> selectUserMenu = sysUserService.selectUser_Menu(stUserMenu);
//            			if(selectUserMenu.size()==0){
//            				//stUserMenu.setId(UUID.randomUUID().toString().replace("-", ""));
//            				stUserMenu.setId(stRoleMenu.getId());
//            				sysUserService.insertUser_Menu(stUserMenu);
//            			}
//					}
        			
        			for (STRoleMenu stRoleMenu : roleMenuList) {
        				stUserMenu = new STUserMenu();
        				stUserMenu.setMenu_id(stRoleMenu.getMenu_id());//设置权限编号
        				List<STUserMenu> selectUserMenu = sysUserService.selectUser_Menu(stUserMenu);
            			if(selectUserMenu.size()==0){
            	        	stUserMenu.setUser_id(sysUser.getId());
            				//stUserMenu.setId(UUID.randomUUID().toString().replace("-", ""));
            				stUserMenu.setId(stRoleMenu.getId());
            				list.add(stUserMenu);
            			}
					}
    	        }
        		
        		if(list.size()>0){
        			sysUserService.insertUser_Menu_List(list);
            		logger.info("-------------------->添加用户菜单");
        		}
        		
        	}
        	isValid = true;
        	
        	JSONObject jsonObject = new JSONObject();
        	jsonObject.accumulate("id", sysUser.getId());
        	jsonObject.accumulate("isValid", isValid);
        	
        	response.getWriter().print(JSONArray.fromObject(jsonObject));
        }catch(Exception ex){
            ex.printStackTrace();
            isValid = false;
        }
        
	}
}
