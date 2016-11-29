package cloud.app.system.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
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

import cloud.app.common.Constants;
import cloud.app.system.po.STMenu;
import cloud.app.system.po.STRoleMenu;
import cloud.app.system.po.STUserMenu;
import cloud.app.system.po.STUserRole;
import cloud.app.system.service.MenuService;
import cloud.app.system.service.RoleService;
import cloud.app.system.service.SysUserService;
import cloud.app.system.vo.RoleVO;
import cloud.app.system.vo.SysUserVO;

/**
 * 验证码Controller
 * 
 *
 */
@Controller
@RequestMapping("/admin/role")
public class RoleController {
	
	Logger logger = Logger.getLogger(this.getClass());
	
	@Autowired
	private RoleService roleService;
	@Autowired
	private MenuService menuService;
	@Autowired
	private SysUserService sysUserService;
	
	public RoleService getRoleService() {
		return roleService;
	}

	public void setRoleService(RoleService roleService) {
		this.roleService = roleService;
	}
	
	@RequestMapping(value = "/list")
	public String showForm(ModelMap model) {
		return "page/sys/role/list";
	}
	
	/**
	 * 分页返回角色列表
	 */
	//http://localhost:8080/CloudringAD/admin/role/listRole.do
	@RequestMapping(value = "/listRole")
	public String listRole(HttpServletRequest request,HttpServletResponse response,ModelMap model,String page){
        logger.info("--------------->角色列表");
        try{
        	RoleVO role = new RoleVO();
        	String role_name = request.getParameter("role_name");
        	if(role_name != null){
        		role_name = role_name.trim();
        	}
        	String ps = request.getParameter("pageSize");
        	if(ps==null){
        		ps = "5";
        	}
        	int pageSize = Integer.parseInt(ps);//每页显示的条数
        	if("page".equals(page)){
        		role_name = null;
        		page = null;
        	}
        	role.setRole_name(role_name);
        	int total = roleService.roleCount(role);
        	//查到的总用户数
        	model.addAttribute("total", total);
			//每页显示的条数
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
			if(null == page||page.equals("")){
				page = "1";
			}
			//每页开始的第几条记录            
			int startRow = (Integer.parseInt(page)-1) * pageSize;
			role.setPageIndex(startRow);
			role.setPageSize(pageSize);
			List<RoleVO> list = roleService.getRoleList(role);
			model.addAttribute("currentPage", Integer.parseInt(page));
			model.addAttribute("list", list);
			model.addAttribute("role_name", role_name);
			model.addAttribute("pageSize", pageSize);
			model.addAttribute("page", page);
        }catch(Exception ex){
            ex.printStackTrace();
        }
        return "page/sys/role/list";
	}
	
	@RequestMapping(value = "/detailsRole")
	public String detailsRole(HttpServletRequest request,HttpServletResponse response,RoleVO role,ModelMap model) {
		String action = request.getParameter("action");
		List<String> listMenuId = new ArrayList<String>();
		Map<String, Object> map = new HashMap<String, Object>();
		
		RoleVO roleVO = null;
		
		try {
    		roleVO = roleService.getInfoById(role.getId());
			List<STMenu> allMenuList = menuService.getMenuList();
			
			List<STRoleMenu> roleMenuList = roleService.selectRoleByMenuId(role.getId());//根据角色编号查询
			for (STRoleMenu stRoleMenu : roleMenuList) {//集合保存所有角色菜单里面的菜单编号
				listMenuId.add(stRoleMenu.getMenu_id());
			}
			
			String ids = "";
		 	for(int i=0;i<listMenuId.size();i++){
		 		String id = listMenuId.get(i);
		 		ids+=id;
	            if(listMenuId.size()-1!=i){
	            	ids+=",";
	            }
	        }
			
			String [] rigth_ids = null;
			if(StringUtils.isNotEmpty(ids)){
				rigth_ids = ids.split(",");
			}
			
			map.put("ids", rigth_ids);
			
			for (STMenu stMenu : allMenuList) {
				if(listMenuId.contains(stMenu.getId()))//是否包含角色菜单
					stMenu.setIsChecked(true);
			}
			
			String jsonTree = null;
			
			if(StringUtils.isEmpty(action)){
				List<STMenu> rigthList = menuService.getListByIds(map);
				jsonTree = com.alibaba.fastjson.JSONArray.toJSONString(rigthList).replaceAll("pid","pId").replaceAll("isChecked", "checked").replace("[", "").replace("]", "");
	        }else{
	        	jsonTree = com.alibaba.fastjson.JSONArray.toJSONString(allMenuList).replaceAll("pid","pId").replaceAll("isChecked", "checked").replace("[", "").replace("]", "");
	        }
			
		 	String jsonNodes = "[{'id':'" + Constants.PARENT_ID + "','name':'所有权限','open':true,'nocheck':true},"+jsonTree+"]";//最顶级菜单
		 	
			System.out.println(jsonNodes.replaceAll("'", "\""));
			model.addAttribute("roleVO", roleVO);
			model.addAttribute("zTreeNodes", jsonNodes.replaceAll("'", "\""));
		} catch (Exception e) {
			e.printStackTrace();
		}
		if(StringUtils.isEmpty(action)){
        	return "page/sys/role/details";
        }else{
            return "page/sys/role/edit";
        }
	}
	
	@RequestMapping(value = "/detailsRole1")
	public String detailsRole1(HttpServletRequest request,HttpServletResponse response,RoleVO role,ModelMap model) {
		String action = request.getParameter("action");
		JSONObject jsonObjectMap = new JSONObject();
		JSONArray jsonArray = new JSONArray();
		List<String> listMenuId = new ArrayList<String>();
		List<Boolean> listIsSelected = new ArrayList<Boolean>();//父菜单
		List<Boolean> listParentIsSelected = new ArrayList<Boolean>();//最父级菜单
		
		RoleVO roleVO = null;
		
		boolean parentCheck = false;
		try {
    		roleVO = roleService.getInfoById(role.getId());
    		STMenu m = new STMenu();
			m.setPid(Constants.PARENT_ID);
			List<STMenu> menuList = menuService.getMenuListParentNode(m);//查询父级菜单
			
			List<STRoleMenu> roleMenuList = roleService.selectRoleByMenuId(role.getId());//根据角色编号查询
			for (STRoleMenu stRoleMenu : roleMenuList) {//集合保存所有角色菜单里面的菜单编号
				listMenuId.add(stRoleMenu.getMenu_id());
			}
			
			for (STMenu stMenu : menuList) {
				List<STMenu> menuParent = menuService.getMenuListNodeById(stMenu.getId());
				jsonObjectMap.put("id",stMenu.getId());
				jsonObjectMap.put("name",stMenu.getName());
				jsonObjectMap.put("pid",stMenu.getPid());
				jsonObjectMap.put("parentName",stMenu.getParentName());
				//jsonObjectMap.put("url",stMenu.getUrl());
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
						menu.setIsChecked(listMenuId.contains(menu.getId()));//对比角色菜单里面的所有此角色的菜单
						listIsSelected.add(menu.getIsChecked());
					}
				}else{//只有父菜单，查看是否选中
					listIsSelected.add(listMenuId.contains(stMenu.getId()));
				}
				
				if(listIsSelected.contains(false)){
					jsonObjectMap.put("isChecked",false);//是否选中
					listParentIsSelected.add(false);
				}else{
					jsonObjectMap.put("isChecked",true);//是否选中
					listParentIsSelected.add(true);
				}
//				for (int i = 0; i < menuParent.size(); i++) {
//					STMenu st = menuParent.get(i);
//					if(st.getIsChecked() == false){
//						menuParent.remove(i);
//					}
//				}
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
			
			String jsonNodes = "[{'id':'" + Constants.PARENT_ID + "','name':'所有权限','open':true,'nocheck':true,'checked':" + parentCheck + ",'nodes':" + json + "}]";//最顶级菜单
			
			//System.out.println(jsonNodes);
			model.addAttribute("roleVO", roleVO);
			model.addAttribute("zTreeNodes", jsonNodes.replaceAll("'", "\""));
		} catch (Exception e) {
			e.printStackTrace();
		}
		if(StringUtils.isEmpty(action)){
        	return "page/sys/role/details";
        }else{
            return "page/sys/role/edit";
        }
	}
	
	
	/**
	 * 新增或编辑
	 * @param request
	 * @param response
	 * @param role
	 */
	@RequestMapping(value = "/roleEdit")
	public void roleEdit(HttpServletRequest request,HttpServletResponse response,RoleVO role){
		//response.setContentType("text/html;charset=utf-8"); //指定输出内容类型和编码
		role.setRole_name(role.getRole_name().trim());
    	long index = System.currentTimeMillis();
    	
    	logger.info("开始时间-------------------->"+index);
        try{
        	boolean isValid = false;
        	SysUserVO user = (SysUserVO)request.getSession().getAttribute(Constants.SESSION_LOGIN_USER);//将用户信息放入session
    		
        	if(StringUtils.isEmpty(role.getId())){
        		role.setId(UUID.randomUUID().toString().replace("-", ""));//权限编号
            	role.setCreate_user(user.getUserCode());
            	role.setIs_del(Constants.C_STATUS_NORMAL);
            	roleService.insert(role);
        	}else{
        		role.setUpdate_user(user.getUserCode());
            	roleService.update(role);
        	}
        	
        	String menuIds = request.getParameter("menuIds");//已选中编号
        	
    		List<String> listMenuId = new ArrayList<String>();
    		List<String> tempListMenuId = new ArrayList<String>();
    		List<String> listNotMenuPid = new ArrayList<String>();
    		
    		STMenu m = new STMenu();
    		m.setPid(Constants.PARENT_ID);
			List<STMenu> menus = menuService.getMenuListParentNode(m);//查询父级菜单
			for (STMenu stMenu : menus) {
				listNotMenuPid.add(stMenu.getId());
			}
    		
        	//查询所有菜单
        	List<STMenu> menuList = menuService.getMenuList();
        	for (STMenu stMenu : menuList) {
        		listMenuId.add(stMenu.getId());//所有菜单编号
			}
        	
        	STRoleMenu sTRoleMenu = null;
        	
        	List<STRoleMenu> roleMenus = new ArrayList<STRoleMenu>();
        	List<STUserMenu> list = new ArrayList<STUserMenu>();
        	
        	//已选中菜单编号
        	if(StringUtils.isNotEmpty(menuIds)){
        		String[] menuId = menuIds.split(",");
        		for(int i =0;i<menuId.length;i++){
        			
        			sTRoleMenu = new STRoleMenu();
                	sTRoleMenu.setRole_id(role.getId());
        			
        			sTRoleMenu.setMenu_id(menuId[i]);
        			roleService.deleteRole_Menu(sTRoleMenu);//删除权限菜单
        			//List<STRoleMenu> selectRoleMenu = roleService.selectRole_Menu(sTRoleMenu);//查询权限菜单
        			//if(selectRoleMenu.size()==0){
    					sTRoleMenu.setId(UUID.randomUUID().toString().replace("-", ""));
    					roleMenus.add(sTRoleMenu);
    					//roleService.insertRole_Menu(sTRoleMenu);//增加权限菜单
    					
    					List<STUserRole> sTUserRoles = roleService.userRoleById(sTRoleMenu.getRole_id());//权限编号查询用户权限
//    					for (STUserRole stUserRole2 : sTUserRoles) {
//    						sTUserMenu.setId(sTRoleMenu.getId());
//    						sTUserMenu.setMenu_id(sTRoleMenu.getMenu_id());
//    						sTUserMenu.setUser_id(stUserRole2.getUser_id());
//        					sysUserService.insertUser_Menu(sTUserMenu);//增加用户菜单
//        					logger.info("-------------------->添加用户菜单");
//						}
    					for (STUserRole stUserRole2 : sTUserRoles) {
    						STUserMenu sTUserMenu = new STUserMenu();
    						sTUserMenu.setId(sTRoleMenu.getId());
    						sTUserMenu.setMenu_id(sTRoleMenu.getMenu_id());
    						sTUserMenu.setUser_id(stUserRole2.getUser_id());
    						list.add(sTUserMenu);
						}
        			//}
        			tempListMenuId.add(menuId[i]);
    	        }
        		
        		if(roleMenus.size()>0){
        			roleService.insertRole_Menu_List(roleMenus);//增加权限菜单
        			logger.info("-------------------->添加权限菜单");
        		}
        		
        		if(list.size()>0){
        			sysUserService.insertUser_Menu_List(list);//增加用户菜单
        			logger.info("-------------------->添加用户菜单");
        		}
        		
        	}else{
        		sTRoleMenu = new STRoleMenu();
            	sTRoleMenu.setRole_id(role.getId());
    			roleService.deleteRole_Menu(sTRoleMenu);//删除权限菜单
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
	        if(sTRoleMenu==null){
		        sTRoleMenu = new STRoleMenu();
	        }
	        String[] select = notSelectMenuIds.split(",");
	        int length = 0;
	        if(select[0]!=""){
	        	length = select.length;
	        }
    		for(int i =0;i<length;i++){
    			sTRoleMenu.setMenu_id(select[i]);
    			List<STRoleMenu> stRoleMenus = roleService.selectRole_Menu(sTRoleMenu);//查询权限菜单
    			for (STRoleMenu stRoleMenu2 : stRoleMenus) {
    				sysUserService.deleteUser_MenuById(stRoleMenu2.getId());//删除关联的菜单
				}
    			roleService.deleteRole_Menu(sTRoleMenu);//删除权限菜单
	        }
    		long end = System.currentTimeMillis();
    		logger.info("结束时间-------------------->"+end);
    		
    		logger.info("时间-------------------->"+(end-index)/1000);
    		
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
	 * @param role
	 */
	@RequestMapping(value = "/updateRole")
	public void updateRole(HttpServletRequest request,HttpServletResponse response,RoleVO role){
		response.setContentType("text/html;charset=utf-8"); //指定输出内容类型和编码
        try{
        	boolean isValid = false;
        	SysUserVO user = (SysUserVO)request.getSession().getAttribute(Constants.SESSION_LOGIN_USER);//将用户信息放入session
        	role.setUpdate_user(user.getUserCode());
        	roleService.update(role);
        	isValid = true;
        	response.getWriter().print(JSONArray.fromObject(isValid));
        }catch(Exception ex){
            ex.printStackTrace();
        }
	}
	
	/**
	 * 删除
	 * @param request
	 * @param response
	 */
	@RequestMapping(value = "/deleteRole")
	public void deleteRole(HttpServletRequest request,HttpServletResponse response){
		response.setContentType("text/html;charset=utf-8"); //指定输出内容类型和编码
        try{
        	boolean isValid = false;
        	String ids = request.getParameter("ids");
        	if(ids!=null&&ids!=""){
        		String[] id = ids.split(",");
        		for(int i =0;i<id.length;i++){
        			roleService.deleteById(id[i]);
        		}
        		isValid = true;
        	}
        	response.getWriter().print(JSONArray.fromObject(isValid));
        }catch(Exception ex){
            ex.printStackTrace();
        }
	}
	
	//查询角色名称是否存在
	@RequestMapping(value = "/queryName")
	public void queryName(HttpServletRequest request,HttpServletResponse response,RoleVO role){
		response.setContentType("text/html;charset=utf-8"); //指定输出内容类型和编码
        try{
        	boolean isValid = false;
        	String id = request.getParameter("id");
        	if(StringUtils.isEmpty(id)){//添加做判断
        		List<RoleVO> list = roleService.getRoleByName(role.getRole_name().trim());
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