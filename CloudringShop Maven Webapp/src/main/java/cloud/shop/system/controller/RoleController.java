package cloud.shop.system.controller;



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



import cloud.shop.common.Constants;
import cloud.shop.system.po.STMenu;
import cloud.shop.system.po.STRoleMenu;
import cloud.shop.system.po.STUserMenu;
import cloud.shop.system.po.STUserRole;
import cloud.shop.system.service.MenuService;
import cloud.shop.system.service.RoleService;
import cloud.shop.system.service.SysUserService;
import cloud.shop.system.vo.RoleVO;
import cloud.shop.system.vo.SysUserVO;

import com.fasterxml.jackson.databind.ObjectMapper;

/**
 * 验证码Controller
 * 
 *
 */
@Controller
@RequestMapping("/admin/role")
public class RoleController {
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
	
	@RequestMapping(value = "/relevanceRole")
	public String relevanceRole(HttpServletRequest request,HttpServletResponse response,RoleVO role,ModelMap model) {
		JSONObject jsonObjectMap = new JSONObject();
		JSONArray jsonArray = new JSONArray();
		List<String> listMenuId = new ArrayList<String>();
		List<Boolean> listIsSelected = new ArrayList<Boolean>();//父菜单
		List<Boolean> listParentIsSelected = new ArrayList<Boolean>();//最父级菜单
		boolean parentCheck = false;
		try {
			response.setContentType("text/html; charset=UTF-8");
			RoleVO roleVO = roleService.getInfoById(role.getId());
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
			model.addAttribute("roleVO", roleVO);
			model.addAttribute("zTreeNodes", jsonNodes.replaceAll("'", "\""));
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "page/sys/role/relate_menu";
	}
	
	/**
	 * 分页返回列表
	 */
	@RequestMapping(value = "/listRole")
	public void roleList(HttpServletRequest request,HttpServletResponse response,@RequestParam(required = false, defaultValue = "1") Integer page,@RequestParam(required = false, defaultValue = "10") Integer rows,RoleVO role){
		response.setContentType("text/html;charset=utf-8"); //指定输出内容类型和编码
        try{
        	PrintWriter out = response.getWriter();//获取输出口
        	//JSONObject jsonObjectMap = new JSONObject();
        	role.setPageIndex((page-1)*rows);
        	role.setPageSize(rows);
        	List<RoleVO> list = roleService.getRoleList(role);
        	int total = roleService.roleCount(role);
        	role.setTotal(total);
        	role.setRows(list);
			//获取分页返回的数据,格式化数据并返回JSON
        	ObjectMapper mapper = new ObjectMapper();
        	out.write(mapper.writeValueAsString(role));
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
	 * @param role
	 */
	@RequestMapping(value = "/insertRole")
	public void insertRole(HttpServletRequest request,HttpServletResponse response,RoleVO role){
		response.setContentType("text/html;charset=utf-8"); //指定输出内容类型和编码
        try{
        	boolean isValid = false;
        	role.setId(UUID.randomUUID().toString().replace("-", ""));//权限编号
        	SysUserVO user = (SysUserVO)request.getSession().getAttribute(Constants.SESSION_LOGIN_USER);//将用户信息放入session
        	role.setCreate_user(user.getUserCode());
        	role.setIs_del(Constants.C_STATUS_NORMAL);
        	roleService.insert(role);
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
	 * @param role
	 */
	@RequestMapping(value = "/deleteRole")
	public void deleteRole(HttpServletRequest request,HttpServletResponse response,RoleVO role){
		response.setContentType("text/html;charset=utf-8"); //指定输出内容类型和编码
        try{
        	boolean isValid = false;
        	roleService.deleteById(role.getId());
        	isValid = true;
        	response.getWriter().print(JSONArray.fromObject(isValid));
        }catch(Exception ex){
            ex.printStackTrace();
        }
	}
	
	//分配角色及菜单
	@RequestMapping(value = "/grantRole")
	public void grantRole(HttpServletRequest request,HttpServletResponse response,RoleVO role){
		response.setContentType("text/html;charset=utf-8"); //指定输出内容类型和编码
        try{
        	boolean isValid = false;
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
        	
        	STRoleMenu sTRoleMenu = new STRoleMenu();
        	sTRoleMenu.setRole_id(role.getId());
        	
        	//已选中菜单编号
        	if(menuIds!=null&&menuIds!=""){
        		String[] menuId = menuIds.split(",");
        		for(int i =0;i<menuId.length;i++){
        			sTRoleMenu.setMenu_id(menuId[i]);
        			List<STRoleMenu> selectRoleMenu = roleService.selectRole_Menu(sTRoleMenu);//查询权限菜单
        			if(selectRoleMenu.size()==0){
        				//if(!listNotMenuPid.contains(menuId[i])){
    					sTRoleMenu.setId(UUID.randomUUID().toString().replace("-", ""));
    					roleService.insertRole_Menu(sTRoleMenu);//增加权限菜单
    					
    					STUserMenu sTUserMenu = new STUserMenu();
    					List<STUserRole> sTUserRoles = roleService.userRoleById(sTRoleMenu.getRole_id());//权限编号查询用户权限
    					for (STUserRole stUserRole2 : sTUserRoles) {
    						sTUserMenu.setId(sTRoleMenu.getId());
    						sTUserMenu.setMenu_id(sTRoleMenu.getMenu_id());
    						sTUserMenu.setUser_id(stUserRole2.getUser_id());
        					sysUserService.insertUser_Menu(sTUserMenu);//增加用户菜单
						}
        				
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
    			sTRoleMenu.setMenu_id(select[i]);
    			List<STRoleMenu> stRoleMenus = roleService.selectRole_Menu(sTRoleMenu);//查询权限菜单
    			for (STRoleMenu stRoleMenu2 : stRoleMenus) {
    				sysUserService.deleteUser_MenuById(stRoleMenu2.getId());//删除关联的菜单
				}
    			roleService.deleteRole_Menu(sTRoleMenu);//删除权限菜单
	        }
	        
        	isValid = true;
        	response.getWriter().print(JSONArray.fromObject(isValid));
        }catch(Exception ex){
            ex.printStackTrace();
        }
	}
	
}