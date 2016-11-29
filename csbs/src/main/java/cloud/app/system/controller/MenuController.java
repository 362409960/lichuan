package cloud.app.system.controller;

import java.io.IOException;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import cloud.app.common.Constants;
import cloud.app.system.po.STMenu;
import cloud.app.system.po.STRoleMenu;
import cloud.app.system.po.STUserMenu;
import cloud.app.system.po.STUserRole;
import cloud.app.system.service.MenuService;
import cloud.app.system.service.RoleService;
import cloud.app.system.vo.SysUserVO;
import cloud.app.system.service.SysUserService;

@Controller
@RequestMapping("/menu")
public class MenuController {
	
	private List<STMenu> menuList;
	boolean isValid=false;
	
	@Autowired
	private MenuService menuService;
	@Autowired
	private RoleService roleService;
	@Autowired
	private SysUserService sysUserService;

	@RequestMapping(value = "/insert")
	public String showForm(HttpServletRequest request,HttpServletResponse response,Model model) {
		try {
			String id = request.getParameter("id");//菜单编号
			String pid = request.getParameter("pid");//父ID
			String parent_id = request.getParameter("parent_id");
			if(StringUtils.isNotEmpty(id)){
				STMenu stMenu = menuService.viewMenu(id);
				model.addAttribute("stMenu", stMenu);
			}
			model.addAttribute("pid", pid);
			model.addAttribute("parent_id", parent_id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "page/sys/menu/insert";
	}
	
	@RequestMapping(value = "/leftMenu.do", method = RequestMethod.GET)
	public String leftMenu(HttpServletRequest request,HttpServletResponse response, Model model) throws Exception{
		SysUserVO user = null;
		try{
			HttpSession session = request.getSession();
			Object obj = session.getAttribute(Constants.SESSION_LOGIN_USER);
			if(obj == null){
				throw new Exception("session 失效，请重新登录.");
			}else{
				user = (SysUserVO)obj;
			}
			
			menuList = menuService.getMenuListByUser(user);
			isValid = true;
			
            model.addAttribute("menuList", menuList);
            
			return "left";
		}catch(Exception ex){
			throw new Exception(ex.getMessage());
		}
	}
	
	@RequestMapping(value = "/list")
	public String menuList(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws IOException {
		JSONObject jsonObjectMap = new JSONObject();
		JSONArray jsonArray = new JSONArray();
		try {
			STMenu m = new STMenu();
			m.setPid(Constants.PARENT_ID);
			List<STMenu> menuList = menuService.getMenuListParentNode(m);
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
				for (STMenu stMenu2 : menuParent) {
					stMenu2.setParentName(stMenu.getName());//上级菜单名称
				}
				jsonObjectMap.put("subMenuList",menuParent);
				
				jsonArray.add(jsonObjectMap);
			}
			isValid = true;
		} catch (Exception e) {
			e.printStackTrace();
			isValid = false;
		}
		String json = jsonArray.toString();
		json = json.replaceAll("subMenuList", "nodes").replaceAll("url", "menuUrl");
		
		String jsonNodes = "[{'id':'" + Constants.PARENT_ID + "','name':'" + Constants.PARENT_NAME + "','open':true,'nodes':" + json + "}]";//最顶级菜单
		
		System.out.println(jsonNodes);
		model.addAttribute("zTreeNodes", jsonNodes.replaceAll("'", "\""));
		
		return "page/sys/menu/tree";
	}
	
//	@RequestMapping(value = "/menuList")
//	public void menuList(HttpServletRequest request, HttpServletResponse response) throws IOException {
//		JSONObject jsonObjectMap = new JSONObject();
//		JSONArray jsonArray = new JSONArray();
//		try {
//			response.setContentType("text/html; charset=UTF-8");
//			STMenu m = new STMenu();
//			m.setPid(Constants.PARENT_ID);
//			List<STMenu> menuList = menuService.getMenuListParentNode(m);
//			for (STMenu stMenu : menuList) {
//				List<STMenu> menuParent = menuService.getMenuListNodeById(stMenu.getId());
//				jsonObjectMap.put("id",stMenu.getId());
//				jsonObjectMap.put("name",stMenu.getName());
//				jsonObjectMap.put("pid",stMenu.getPid());
//				jsonObjectMap.put("parentName",stMenu.getParentName());
//				jsonObjectMap.put("url",stMenu.getUrl());
//				jsonObjectMap.put("show_index",stMenu.getShow_index());
//				jsonObjectMap.put("note",stMenu.getNote());
//				jsonObjectMap.put("create_user",stMenu.getCreate_user());
//				jsonObjectMap.put("update_user",stMenu.getUpdate_user());
//				jsonObjectMap.put("update_time",stMenu.getUpdate_time());
//				jsonObjectMap.put("menuImgUrl",stMenu.getMenuImgUrl());
//				for (STMenu stMenu2 : menuParent) {
//					stMenu2.setParentName(stMenu.getName());//上级菜单名称
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
//		System.out.println(json);
//		response.getWriter().print(JSONArray.fromObject(json));
//	}
	
//	@RequestMapping(value = "/insertSTMenu.do")
//	public void insertSTMenu(HttpServletRequest request, HttpServletResponse response,STMenu sTMenu) throws IOException {
//		response.setContentType("text/html;charset=utf-8"); //指定输出内容类型和编码
//		boolean isValid = false;//用户信息是否有效标识
//		try {
//			String parent_id = request.getParameter("parent_id");
//			if(StringUtils.isEmpty(sTMenu.getId())){
//				sTMenu.setId(UUID.randomUUID().toString().replace("-", ""));
//				if(StringUtils.isNotEmpty(parent_id)){//增加子节点
//					sTMenu.setPid(parent_id);
//					menuService.insertSTMenu(sTMenu);
//				}else{
//					menuService.insertSTMenu(sTMenu);
//				}
//			}else{
//				menuService.updateSTMenu(sTMenu);
//			}
//			isValid = true;
//		} catch (Exception e) {
//			e.printStackTrace();
//			isValid = false;
//		}
//		response.getWriter().print(JSONArray.fromObject(isValid));
//	}
	
	@RequestMapping(value = "/insertSTMenu.do")
	public String insertSTMenu(HttpServletRequest request, HttpServletResponse response,ModelMap model,STMenu sTMenu) throws IOException {
		try {
			String parent_id = request.getParameter("parent_id");
			if(StringUtils.isEmpty(sTMenu.getId())){
				sTMenu.setId(UUID.randomUUID().toString().replace("-", ""));
				if(StringUtils.isNotEmpty(parent_id)){//增加子节点
					sTMenu.setPid(parent_id);
					menuService.insertSTMenu(sTMenu);
				}else{
					menuService.insertSTMenu(sTMenu);
				}
				//默认把菜单权限加入到超级管理员中
				STRoleMenu sTRoleMenu = new STRoleMenu();
				sTRoleMenu.setId(UUID.randomUUID().toString().replace("-", ""));
				sTRoleMenu.setMenu_id(sTMenu.getId());
				sTRoleMenu.setRole_id(Constants.ADMINI_ID);//默认把菜单分配给超级管理员
				roleService.insertRole_Menu(sTRoleMenu);//增加权限菜单
				//默认超级管理员关联的用户都增加此菜单
				STUserMenu sTUserMenu = new STUserMenu();
				List<STUserRole> sTUserRoles = roleService.userRoleById(sTRoleMenu.getRole_id());//权限编号查询用户权限
				for (STUserRole stUserRole2 : sTUserRoles) {
					sTUserMenu.setId(sTRoleMenu.getId());
					sTUserMenu.setMenu_id(sTRoleMenu.getMenu_id());
					sTUserMenu.setUser_id(stUserRole2.getUser_id());
					sysUserService.insertUser_Menu(sTUserMenu);//增加用户菜单
				}
			}else{
				menuService.updateSTMenu(sTMenu);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return menuList(request, response, model);//刷新菜单页面
	}
	
	/**
	 * 删除
	 * @param request
	 * @param response
	 * @param sTMenu
	 */
	@RequestMapping(value = "/deleteSTMenu")
	public void deleteRole(HttpServletRequest request,HttpServletResponse response,STMenu sTMenu){
		response.setContentType("text/html;charset=utf-8"); //指定输出内容类型和编码
        try{
        	boolean isValid = false;
        	
        	menuService.deleteRole_MenuByMenuId(sTMenu.getId());//删除菜单关联的角色菜单
			menuService.deleteUser_MenuByMenuId(sTMenu.getId());//删除菜单关联的用户菜单
			
        	if(sTMenu.getPid().equals(Constants.PARENT_ID)){//删除父节点及下面的子节点
        		List<STMenu> menuParent = menuService.getMenuListNodeById(sTMenu.getId());
        		for (STMenu stMenu2 : menuParent) {
        			menuService.deleteRole_MenuByMenuId(stMenu2.getId());//删除菜单关联的角色菜单
        			menuService.deleteUser_MenuByMenuId(stMenu2.getId());//删除菜单关联的用户菜单
        			menuService.deleteSTMenu(stMenu2.getId());//删除父节点下面的子节点
				}
        		menuService.deleteSTMenu(sTMenu.getId());//删除父节点
        	}else{
        		menuService.deleteSTMenu(sTMenu.getId());
        	}
        	
        	isValid = true;
        	response.getWriter().print(JSONArray.fromObject(isValid));
        }catch(Exception ex){
            ex.printStackTrace();
        }
	}
}
