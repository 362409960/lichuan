package cloud.shop.merchandise.controller;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
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



import cloud.shop.common.TreeNode;
import cloud.shop.merchandise.entity.MerchandiseCategories;
import cloud.shop.merchandise.service.MerchandiseCategoriesService;

import com.fasterxml.jackson.databind.ObjectMapper;





@Controller
@RequestMapping("/admin/categories")
public class MerchandiseCategoriesController {
	@Autowired
	private MerchandiseCategoriesService merchandiseCategoriesService;


	
	@RequestMapping(value = "/list")
	public String showForm(ModelMap model) {
		return "page/shop/merchandise/categories/list";
	}
	/**
	 * 分页返回用户列表
	 */
	@RequestMapping(value = "/listMerchandiseCategories")
	public void listMerchandiseCategories(HttpServletRequest request,
			HttpServletResponse response,
			@RequestParam(required = false, defaultValue = "1") Integer page,
			@RequestParam(required = false, defaultValue = "15") Integer rows,
			MerchandiseCategories merchandiseCategories) {
		response.setContentType("text/html;charset=utf-8"); // 指定输出内容类型和编码
		try {
			PrintWriter out = response.getWriter();// 获取输出口
			// JSONObject jsonObjectMap = new JSONObject();
			merchandiseCategories.setPageIndex((page - 1) * rows);
			merchandiseCategories.setPageSize(rows);
			List<MerchandiseCategories> list = merchandiseCategoriesService.getMerchandiseCategorieList(merchandiseCategories);
			int total = merchandiseCategoriesService.merchandiseCategorieCount(merchandiseCategories);
			merchandiseCategories.setTotal(total);
			merchandiseCategories.setRows(list);
			// 获取分页返回的数据,格式化数据并返回JSON
			ObjectMapper mapper = new ObjectMapper();				
			out.write(mapper.writeValueAsString(merchandiseCategories));
			out.flush();
			out.close();
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}
	/**
	 * 指向add界面。
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "/addMerchandiseCategories")
	public String addMerchandiseCategories(ModelMap model) throws Exception
	{
		return "page/shop/merchandise/categories/add";
	}
	
	
	@RequestMapping(value = "/getJsonData")
	public void getJsonData(HttpServletRequest request,
			HttpServletResponse response,			
			MerchandiseCategories merchandiseCategories) {
		response.setContentType("text/html;charset=utf-8"); // 指定输出内容类型和编码
		try {
			PrintWriter out = response.getWriter();// 获取输出口
			// JSONObject jsonObjectMap = new JSONObject();
			List<MerchandiseCategories> caList=merchandiseCategoriesService.getCategorieConditionList();	
			List<TreeNode> treeList=getJson(caList);
			String json = JSONArray.fromObject(treeList).toString();//转化为JSON		
			out.write(json);
			out.flush();
			out.close();
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}
	
	/**
	 * 递归循环TreeNode类进行json数据组装。
	 * @param treeList
	 * @return
	 * @throws Exception 
	 */
	public List<TreeNode> getJson(List<MerchandiseCategories> treeList) throws Exception
	{
		List<TreeNode> list = new ArrayList<TreeNode>();
		for(MerchandiseCategories tree:treeList)
		{
			TreeNode node=new TreeNode();
			node.setId(tree.getId());
			node.setText(tree.getName());
			node.setChildren(getJson(merchandiseCategoriesService.selectPId(tree.getId())));
			list.add(node);
		}
		return list;
	}
	
	/**
	 *验证分类名称的重复
	 */
	@RequestMapping(value = "/verDataIsEffectivenes")
	public void verDataIsEffectivenes(HttpServletRequest request,
			HttpServletResponse response,
			MerchandiseCategories merchandiseCategories) {
		response.setContentType("text/html;charset=utf-8"); // 指定输出内容类型和编码
		try {
			boolean isValid = false; 
			if(null != merchandiseCategories.getName() && !"".equals(merchandiseCategories.getName()))
			{
				int total = merchandiseCategoriesService.isEffectivenes(merchandiseCategories);	
				if(total!=0)
				{
					isValid=true;
				}
			}
        	response.getWriter().print(JSONArray.fromObject(isValid));
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}
	/**
	 * 新增
	 * @param request
	 * @param response
	 * @param catalog
	 */
	@RequestMapping(value = "/insertMerchandiseCategories")
	public void insertMerchandiseCategories(HttpServletRequest request,HttpServletResponse response,MerchandiseCategories merchandiseCategories){
		response.setContentType("text/html;charset=utf-8"); //指定输出内容类型和编码
        try{
        	boolean isValid = false;         	
        	merchandiseCategories.setId(UUID.randomUUID().toString().replace("-", ""));
        	if("".equals(merchandiseCategories.getPid()))merchandiseCategories.setPid(null);
        	merchandiseCategoriesService.insert(merchandiseCategories);
        	isValid = true;
        	response.getWriter().print(JSONArray.fromObject(isValid));
        }catch(Exception ex){
            ex.printStackTrace();
        }
	}
	/**
	 * 指向编辑页面
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/editMerchandiseCategories")
	public String editMerchandiseCategories(ModelMap model,HttpServletRequest request,HttpServletResponse response)
	{
		try {
			MerchandiseCategories merchandiseCategories=merchandiseCategoriesService.selectCheckId(request.getParameter("id"));
			MerchandiseCategories me=merchandiseCategoriesService.selectCheckId(merchandiseCategories.getPid());
			model.put("merch", merchandiseCategories);	
			model.put("me", me);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "page/shop/merchandise/categories/edit";
	}
	/**
	 * 修改
	 * @param request
	 * @param response
	 * @param Catalog
	 */
	@RequestMapping(value = "/updateMerchandiseCategories")
	public void updateMerchandiseCategories(HttpServletRequest request,HttpServletResponse response,MerchandiseCategories merchandiseCategories){
		response.setContentType("text/html;charset=utf-8"); //指定输出内容类型和编码
        try{
        	boolean isValid = false;
        	merchandiseCategories.setId(merchandiseCategories.getId());
        	if("".equals(merchandiseCategories.getPid()))merchandiseCategories.setPid(null);
        	merchandiseCategoriesService.update(merchandiseCategories);
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
	@RequestMapping(value = "/deleteMerchandiseCategories")
	public void deleteMerchandiseCategories(HttpServletRequest request,HttpServletResponse response,MerchandiseCategories merchandiseCategories){
		response.setContentType("text/html;charset=utf-8"); //指定输出内容类型和编码
        try{
        	boolean isValid = false;
        	merchandiseCategoriesService.deleteByPkId(merchandiseCategories.getId());        
        	isValid = true;
        	response.getWriter().print(JSONArray.fromObject(isValid));
        }catch(Exception ex){
            ex.printStackTrace();
        }
	}
}
