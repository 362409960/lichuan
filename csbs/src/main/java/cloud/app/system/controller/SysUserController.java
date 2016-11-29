package cloud.app.system.controller;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import cloud.app.common.Constants;
import cloud.app.common.MD5;
import cloud.app.system.po.STMenu;
import cloud.app.system.po.STRoleMenu;
import cloud.app.system.po.STUserMenu;
import cloud.app.system.po.STUserRole;
import cloud.app.system.service.MenuService;
import cloud.app.system.service.RoleService;
import cloud.app.system.service.SysUserService;
import cloud.app.system.vo.RoleVO;
import cloud.app.system.vo.SysUserVO;

import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
@RequestMapping("/admin/user")
public class SysUserController {
	@Autowired
	private SysUserService sysUserService;
	@Autowired
	private MenuService menuService;
	@Autowired
	private RoleService roleService;
	
	public SysUserService getSysUserService() {
		return sysUserService;
	}

	public void setSysUserService(SysUserService sysUserService) {
		this.sysUserService = sysUserService;
	}

	@RequestMapping(value = "/list")
	public String showForm(ModelMap model) {
		return "page/sys/user/list";
	}
	
	/**
	 * 
	 * @param request
	 * @param response
	 * @param user
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/relevanceUser")
	public String relevanceUser(HttpServletRequest request,HttpServletResponse response,SysUserVO user,ModelMap model) {
		JSONObject jsonObjectMap = new JSONObject();
		JSONArray jsonArray = new JSONArray();
		List<String> listMenuId = new ArrayList<String>();
		List<String> listRoleId = new ArrayList<String>();
		List<Boolean> listIsSelected = new ArrayList<Boolean>();//父菜单
		List<Boolean> listParentIsSelected = new ArrayList<Boolean>();//最父级菜单
		boolean parentCheck = false;
		try {
			response.setContentType("text/html; charset=UTF-8");
			SysUserVO sysUser = sysUserService.getUserInfoById(user.getId());
			STMenu m = new STMenu();
			m.setPid(Constants.PARENT_ID);
			List<STMenu> menuList = menuService.getMenuListParentNode(m);//查询父级菜单
			
			//查看用户菜单
			List<STUserMenu> userMenuList = sysUserService.selectUserByMenuId(user.getId());
			for (STUserMenu sTUserMenu : userMenuList) {//集合保存所有用户菜单里面的菜单编号
				listMenuId.add(sTUserMenu.getMenu_id());
			}
			
			//查看用户权限
			List<STUserRole> userRoleList = sysUserService.selectUserByRoleId(user.getId());
			for (STUserRole stUserRole : userRoleList) {
				listRoleId.add(stUserRole.getRole_id());
			}
			
			RoleVO role = new RoleVO();
			role.setPageIndex(0);
        	role.setPageSize(100000000);
        	List<RoleVO> listRoleVO = roleService.getRoleList(role);
        	for (RoleVO roleVO : listRoleVO) {//判断有哪些权限
        		roleVO.setIs_checked(listRoleId.contains(roleVO.getId()));
			}
			
			for (STMenu stMenu : menuList) {
				List<STMenu> menuParent = menuService.getMenuListNodeById(stMenu.getId());
				jsonObjectMap.put("id",stMenu.getId());
				jsonObjectMap.put("name",stMenu.getName());
				jsonObjectMap.put("pid",stMenu.getPid());
				jsonObjectMap.put("parentName",stMenu.getParentName());
				jsonObjectMap.put("url",stMenu.getUrl());
				jsonObjectMap.put("show_index",stMenu.getShow_index());
				jsonObjectMap.put("note",stMenu.getNote());
				jsonObjectMap.put("create_user",stMenu.getCreate_user());
				jsonObjectMap.put("update_user",stMenu.getUpdate_user());
				jsonObjectMap.put("update_time",stMenu.getUpdate_time());
				jsonObjectMap.put("menuImgUrl",stMenu.getMenuImgUrl());
				
				listIsSelected.removeAll(listIsSelected);//清空前一次保存的值
				
				if(menuParent.size()>0){
					for (STMenu menu : menuParent) {
						menu.setUrl("");
						menu.setIsChecked(listMenuId.contains(menu.getId()));//对比用户菜单里面的所有此用户的菜单
						listIsSelected.add(menu.getIsChecked());
					}
				}else{//只有父菜单，不选中
					listIsSelected.add(listMenuId.contains(stMenu.getId()));
				}
				
				if(listIsSelected.contains(false)){
					jsonObjectMap.put("isChecked",false);//是否选中
					listParentIsSelected.add(false);
				}else{
					jsonObjectMap.put("isChecked",true);//是否选中
					listParentIsSelected.add(true);
				}
				
				jsonObjectMap.put("subMenuList",menuParent);
				jsonArray.add(jsonObjectMap);
			}
			
			//最父级
			if(listParentIsSelected.contains(false)){
				parentCheck = false;
			}else{
				parentCheck = true;
			}
			
			String json = jsonArray.toString();
			json = json.replaceAll("subMenuList", "nodes").replaceAll("isChecked", "checked");
			
			String jsonNodes = "[{'id':'" + Constants.PARENT_ID + "','name':'" + Constants.PARENT_NAME + "','open':true,'checked':" + parentCheck + ",'nodes':" + json + "}]";//最顶级菜单
			
			System.out.println(jsonNodes);
			model.addAttribute("sysUser", sysUser);
			model.addAttribute("zTreeNodes", jsonNodes.replaceAll("'", "\""));
			model.addAttribute("allRoles", listRoleVO);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "page/sys/user/relate_role";
	}
	
	/**
	 * 分页返回用户列表
	 * @param request
	 * @param response
	 * @param page
	 * @param rows
	 * @param sysUser
	 */
	@RequestMapping(value = "/listSysUser")
	public void listSysUser(HttpServletRequest request,HttpServletResponse response,@RequestParam(required = false, defaultValue = "1") Integer page,@RequestParam(required = false, defaultValue = "10") Integer rows,SysUserVO sysUser){
		response.setContentType("text/html;charset=utf-8"); //指定输出内容类型和编码
        try{
        	PrintWriter out = response.getWriter();//获取输出口
        	//JSONObject jsonObjectMap = new JSONObject();
        	sysUser.setPageIndex((page-1)*rows);
        	sysUser.setPageSize(rows);
        	List<SysUserVO> list = sysUserService.getSysUserList(sysUser);
        	int total = sysUserService.SysUserCount(sysUser);
        	sysUser.setTotal(total);
        	sysUser.setRows(list);
			//获取分页返回的数据,格式化数据并返回JSON
        	ObjectMapper mapper = new ObjectMapper();
        	out.write(mapper.writeValueAsString(sysUser));
    		out.flush();
    		out.close();
        }catch(Exception ex){
            ex.printStackTrace();
        }      
	}
	
	/**
	 * 新增
	 * @param request
	 * @param response
	 * @param sysUser
	 */
	@RequestMapping(value = "/insertSysUser")
	public void insertSysUser(HttpServletRequest request,HttpServletResponse response,SysUserVO sysUser){
		response.setContentType("text/html;charset=utf-8"); //指定输出内容类型和编码
        try{
        	boolean isValid = false;
        	sysUser.setId(UUID.randomUUID().toString().replace("-", ""));//权限编号
        	SysUserVO user = (SysUserVO)request.getSession().getAttribute(Constants.SESSION_LOGIN_USER);//将用户信息放入session
        	sysUser.setUserPassword(MD5.Md5(Constants.C_INIT_PASSWORD));//初始化密码
        	sysUser.setCreateUser(user.getUserCode());
        	if(sysUser.getState()==null){
        		sysUser.setState(Constants.C_USER_STATE_COMMON);//初始化用户正常
        	}
        	sysUserService.insertUser(sysUser);
        	isValid = true;
        	response.getWriter().print(JSONArray.fromObject(isValid));
        }catch(Exception ex){
            ex.printStackTrace();
        }
	}
	
	/**
	 * 修改
	 * @param request
	 * @param response
	 * @param sysUser
	 */
	@RequestMapping(value = "/updateSysUser")
	public void updateSysUser(HttpServletRequest request,HttpServletResponse response,SysUserVO sysUser){
		response.setContentType("text/html;charset=utf-8"); //指定输出内容类型和编码
        try{
        	boolean isValid = false;
        	SysUserVO user = (SysUserVO)request.getSession().getAttribute(Constants.SESSION_LOGIN_USER);//将用户信息放入session
        	sysUser.setUpdateUser(user.getUserCode());
        	sysUserService.updateUser(sysUser);
        	isValid = true;
        	response.getWriter().print(JSONArray.fromObject(isValid));
        }catch(Exception ex){
            ex.printStackTrace();
        }
	}
	
	/**
	 * 重置密码
	 * @param request
	 * @param response
	 * @param sysUser
	 */
	@RequestMapping(value = "/initPwd")
	public void initPwd(HttpServletRequest request,HttpServletResponse response,SysUserVO sysUser){
		response.setContentType("text/html;charset=utf-8"); //指定输出内容类型和编码
        try{
        	boolean isValid = false;
        	sysUser.setUserPassword(MD5.Md5(Constants.C_INIT_PASSWORD));//初始化密码
        	sysUserService.updateUser(sysUser);
        	isValid = true;
        	response.getWriter().print(JSONArray.fromObject(isValid));
        }catch(Exception ex){
            ex.printStackTrace();
        }
	}
	
	/**
	 * 删除(状态改变，软删除)
	 * @param request
	 * @param response
	 * @param sysUser
	 */
	@RequestMapping(value = "/deleteSysUser")
	public void deleteSysUser(HttpServletRequest request,HttpServletResponse response,SysUserVO sysUser){
		response.setContentType("text/html;charset=utf-8"); //指定输出内容类型和编码
        try{
        	boolean isValid = false;
        	sysUser.setState(Constants.C_USER_STATE_COMMON);//状态改为注销
        	sysUserService.updateUser(sysUser);
        	isValid = true;
        	response.getWriter().print(JSONArray.fromObject(isValid));
        }catch(Exception ex){
            ex.printStackTrace();
        }
	}
	
	/**
	 * 分配角色及菜单
	 * @param request
	 * @param response
	 * @param sysUser
	 */
	@RequestMapping(value = "/grantRole")
	public void grantRole(HttpServletRequest request,HttpServletResponse response,SysUserVO sysUser){
		response.setContentType("text/html;charset=utf-8"); //指定输出内容类型和编码
        try{
        	boolean isValid = false;
        	String selectedArr = request.getParameter("selectedArr");//已选中角色（添加）
        	String notSelectArr = request.getParameter("notSelectArr");//未选中角色（删除）
        	String menuIds = request.getParameter("menuIds");//已选中编号

        	//用户角色
        	STUserRole sTUserRole = new STUserRole();
        	sTUserRole.setUser_id(sysUser.getId());
        	//用户菜单
        	STUserMenu stUserMenu = new STUserMenu();
        	stUserMenu.setUser_id(sysUser.getId());
        	//删除
        	if(notSelectArr!=null&&notSelectArr!=""){
        		String[] notSelect = notSelectArr.split(",");
        		for(int i =0;i<notSelect.length;i++){//批量删除
        			sTUserRole.setRole_id(notSelect[i]);
        			
        			List<STRoleMenu> roleMenuList = roleService.selectRoleByMenuId(sTUserRole.getRole_id());
        			for (STRoleMenu stRoleMenu : roleMenuList) {
        				
    					List<STUserRole> sTUserRoles = roleService.userRoleById(sTUserRole.getRole_id());
    					for (STUserRole stUserRole2 : sTUserRoles) {
    						if(stUserRole2.getUser_id().equals(sysUser.getId())){
    							//sTUserMenu.setUser_id(stUserRole2.getUser_id());
    							STUserMenu um = new STUserMenu();
    							um.setId(stRoleMenu.getId());
    							um.setUser_id(sysUser.getId());
    							sysUserService.deleteUser_MenuByUserId(um);//删除用户菜单
        					}
						}
					}
    	            sysUserService.deleteUser_Role(sTUserRole);//删除用户权限
    	        }
        	}
        	
        	//添加
        	if(selectedArr!=null&&selectedArr!=""){
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
        			for (STRoleMenu stRoleMenu : roleMenuList) {
        				stUserMenu.setMenu_id(stRoleMenu.getMenu_id());//设置权限编号
        				List<STUserMenu> selectUserMenu = sysUserService.selectUser_Menu(stUserMenu);
            			if(selectUserMenu.size()==0){
            				//stUserMenu.setId(UUID.randomUUID().toString().replace("-", ""));
            				stUserMenu.setId(stRoleMenu.getId());
            				sysUserService.insertUser_Menu(stUserMenu);
            			}
					}
        			
    	        }
        	}
        	
        	
        	
//    		List<String> listMenuId = new ArrayList<String>();
//    		List<String> tempListMenuId = new ArrayList<String>();
//    		List<String> listNotMenuPid = new ArrayList<String>();
//    		
//    		STMenu m = new STMenu();
//    		m.setPid(Constants.PARENT_ID);
//			List<STMenu> menus = menuService.getMenuListParentNode(m);//查询父级菜单
//			for (STMenu stMenu : menus) {
//				listNotMenuPid.add(stMenu.getId());
//			}//
//    		
//        	//查询所有菜单
//        	List<STMenu> menuList = menuService.getMenuList();
//        	for (STMenu stMenu : menuList) {
//        		listMenuId.add(stMenu.getId());//所有菜单编号
//			}
//        	
//        	STUserMenu sTUserMenu = new STUserMenu();
//        	sTUserMenu.setUser_id(sysUser.getId());
        	
        	//已选中菜单编号
//        	if(menuIds!=null&&menuIds!=""){
//        		String[] menuId = menuIds.split(",");
//        		for(int i =0;i<menuId.length;i++){
//        			sTUserMenu.setMenu_id(menuId[i]);
//        			List<STUserMenu> selectUserRole = sysUserService.selectUser_Menu(sTUserMenu);
//        			if(selectUserRole.size()==0){
//        				//if(!listNotMenuPid.contains(menuId[i])){
//        					sTUserMenu.setId(UUID.randomUUID().toString().replace("-", ""));
//            				sysUserService.insertUser_Menu(sTUserMenu);
//        				//}
//        			}
//        			tempListMenuId.add(menuId[i]);
//    	        }
//        	}
        	
//	        String temp2 = tempListMenuId.toString().replaceAll ("[\\[\\]]", ",").replaceAll ("\\s+", "");
//	        String notSelectMenuIds = "";
//	        for ( int i = 0; i < listMenuId.size(); i++ ){
//	            if (temp2.indexOf("," + listMenuId.get(i) + ",") == -1){
//	            	notSelectMenuIds += listMenuId.get(i) + ",";
//	                if(i!=listMenuId.size()-1){
//	                	notSelectMenuIds += listMenuId.get(i) + ",";
//	        		}else{
//	        			notSelectMenuIds += listMenuId.get(i);
//	        		}
//	            }
//	        }
        	
//	        String[] select = notSelectMenuIds.split(",");
//    		for(int i =0;i<select.length;i++){
//    			sTUserMenu.setMenu_id(select[i]);
//	            sysUserService.deleteUser_Menu(sTUserMenu);
//	        }
	        
        	isValid = true;
        	response.getWriter().print(JSONArray.fromObject(isValid));
        }catch(Exception ex){
            ex.printStackTrace();
        }
	}
	
	
	/**
	 * 	//分配角色及菜单
	@RequestMapping(value = "/grantRole")
	public void grantRole(HttpServletRequest request,HttpServletResponse response,SysUserVO sysUser){
		response.setContentType("text/html;charset=utf-8"); //指定输出内容类型和编码
        try{
        	boolean isValid = false;
        	String selectedArr = request.getParameter("selectedArr");//已选中（添加）
        	String notSelectArr = request.getParameter("notSelectArr");//未选中（删除）
        	String menuIds = request.getParameter("menuIds");//已选中编号
        	
    		List<String> listMenuId = new ArrayList<String>();
    		List<String> tempListMenuId = new ArrayList<String>();
    		List<String> listNotMenuPid = new ArrayList<String>();
    		
    		STMenu m = new STMenu();
    		m.setPid(Constants.PARENT_ID);
			List<STMenu> menus = menuService.getMenuListParentNode(m);//查询父级菜单
			for (STMenu stMenu : menus) {
				listNotMenuPid.add(stMenu.getId());
			}//
    		
        	//查询所有菜单
        	List<STMenu> menuList = menuService.getMenuList();
        	for (STMenu stMenu : menuList) {
        		listMenuId.add(stMenu.getId());//所有菜单编号
			}
        	
        	STUserMenu sTUserMenu = new STUserMenu();
        	sTUserMenu.setUser_id(sysUser.getId());
        	
        	//已选中菜单编号
        	if(menuIds!=null&&menuIds!=""){
        		String[] menuId = menuIds.split(",");
        		for(int i =0;i<menuId.length;i++){
        			sTUserMenu.setMenu_id(menuId[i]);
        			List<STUserMenu> selectUserRole = sysUserService.selectUser_Menu(sTUserMenu);
        			if(selectUserRole.size()==0){
        				//if(!listNotMenuPid.contains(menuId[i])){
        					sTUserMenu.setId(UUID.randomUUID().toString().replace("-", ""));
            				sysUserService.insertUser_Menu(sTUserMenu);
        				//}
        			}
        			tempListMenuId.add(menuId[i]);
    	        }
        	}
        	
	        String temp2 = tempListMenuId.toString().replaceAll ("[\\[\\]]", ",").replaceAll ("\\s+", "");
	        String notSelectMenuIds = "";
	        for ( int i = 0; i < listMenuId.size(); i++ ){
	            if (temp2.indexOf("," + listMenuId.get(i) + ",") == -1){
	            	notSelectMenuIds += listMenuId.get(i) + ",";
	                if(i!=listMenuId.size()-1){
	                	notSelectMenuIds += listMenuId.get(i) + ",";
	        		}else{
	        			notSelectMenuIds += listMenuId.get(i);
	        		}
	            }
	        }
        	
	        String[] select = notSelectMenuIds.split(",");
    		for(int i =0;i<select.length;i++){
    			sTUserMenu.setMenu_id(select[i]);
	            sysUserService.deleteUser_Menu(sTUserMenu);
	        }
        	
        	//用户角色
        	STUserRole sTUserRole = new STUserRole();
        	sTUserRole.setUser_id(sysUser.getId());
        	
        	if(selectedArr!=null&&selectedArr!=""){
        		String[] selected = selectedArr.split(",");
        		for(int i =0;i<selected.length;i++){//批量添加
        			sTUserRole.setRole_id(selected[i]);
        			List<STUserRole> selectUserRole = sysUserService.selectUser_Role(sTUserRole);
        			if(selectUserRole.size()==0){
        				sTUserRole.setId(UUID.randomUUID().toString().replace("-", ""));
        	            sysUserService.insertUser_Role(sTUserRole);
        			}
    	        }
        	}
        	
        	if(notSelectArr!=null&&notSelectArr!=""){
        		String[] notSelect = notSelectArr.split(",");
        		for(int i =0;i<notSelect.length;i++){//批量删除
    	            sTUserRole.setRole_id(notSelect[i]);
    	            sysUserService.deleteUser_Role(sTUserRole);
    	        }
        	}
	        
        	isValid = true;
        	response.getWriter().print(JSONArray.fromObject(isValid));
        }catch(Exception ex){
            ex.printStackTrace();
        }
	}
	 */
	
}
