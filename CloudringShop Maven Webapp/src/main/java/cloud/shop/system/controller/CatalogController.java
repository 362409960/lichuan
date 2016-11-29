package cloud.shop.system.controller;



import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;



import cloud.shop.common.Constants;
import cloud.shop.system.po.Catalog;
import cloud.shop.system.service.CatalogService;
import cloud.shop.system.vo.SysUserVO;

import com.fasterxml.jackson.databind.ObjectMapper;

/**
 * 验证码Controller
 * 
 *
 */
@Controller
@RequestMapping("/admin/catalog")
public class CatalogController {
	@Autowired
	private CatalogService catalogService;
	
	public CatalogService getCatalogService() {
		return catalogService;
	}

	public void setCatalogService(CatalogService catalogService) {
		this.catalogService = catalogService;
	}
	
	@RequestMapping(value = "/list")
	public String showForm(ModelMap model) {
		return "page/sys/catalog/list";
	}
	
	@RequestMapping(value = "/dictionaryData")
	public String dictionaryData(HttpServletRequest request,HttpServletResponse response,ModelMap model) {
		model.addAttribute("catalog_id", request.getParameter("pkid"));
		return "page/sys/catalog/dictionary/list";
	}
	
	/**
	 * 分页返回用户列表
	 */
	@RequestMapping(value = "/listCatalog")
	public void listCatalog(HttpServletRequest request,HttpServletResponse response,@RequestParam(required = false, defaultValue = "1") Integer page,@RequestParam(required = false, defaultValue = "10") Integer rows,Catalog catalog){
		response.setContentType("text/html;charset=utf-8"); //指定输出内容类型和编码
        try{
        	PrintWriter out = response.getWriter();//获取输出口
        	//JSONObject jsonObjectMap = new JSONObject();
        	catalog.setPageIndex((page-1)*rows);
        	catalog.setPageSize(rows);
        	List<Catalog> list = catalogService.getCatalogList(catalog);
        	int total = catalogService.catalogCount(catalog);
        	catalog.setTotal(total);
        	catalog.setRows(list);
			//获取分页返回的数据,格式化数据并返回JSON
        	ObjectMapper mapper = new ObjectMapper();
        	out.write(mapper.writeValueAsString(catalog));
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
	 * @param catalog
	 */
	@RequestMapping(value = "/insertCatalog")
	public void insertCatalog(HttpServletRequest request,HttpServletResponse response,Catalog catalog){
		response.setContentType("text/html;charset=utf-8"); //指定输出内容类型和编码
        try{
        	boolean isValid = false;
        	SysUserVO user = (SysUserVO)request.getSession().getAttribute(Constants.SESSION_LOGIN_USER);//将用户信息放入session
        	catalog.setCreateUser(user.getUserCode());
        	catalog.setState("0");
        	catalogService.insertCatalog(catalog);
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
	 * @param Catalog
	 */
	@RequestMapping(value = "/updateCatalog")
	public void updateCatalog(HttpServletRequest request,HttpServletResponse response,Catalog catalog){
		response.setContentType("text/html;charset=utf-8"); //指定输出内容类型和编码
        try{
        	boolean isValid = false;
        	catalog.setPkid(request.getParameter("id"));
        	SysUserVO user = (SysUserVO)request.getSession().getAttribute(Constants.SESSION_LOGIN_USER);//将用户信息放入session
        	catalog.setUpdateUser(user.getUserCode());
        	catalogService.updateCatalog(catalog);
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
	 * @param catalog
	 */
	@RequestMapping(value = "/deleteCatalog")
	public void deleteCatalog(HttpServletRequest request,HttpServletResponse response,Catalog catalog){
		response.setContentType("text/html;charset=utf-8"); //指定输出内容类型和编码
        try{
        	boolean isValid = false;
        	catalogService.deleteCatalog(catalog.getPkid());
        	isValid = true;
        	response.getWriter().print(JSONArray.fromObject(isValid));
        }catch(Exception ex){
            ex.printStackTrace();
        }
	}
}