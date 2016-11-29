package cloud.shop.merchandise.controller;

import java.io.PrintWriter;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import cloud.shop.merchandise.entity.MerchandiseType;
import cloud.shop.merchandise.service.MerchandiseTypeService;

import com.fasterxml.jackson.databind.ObjectMapper;





@Controller
@RequestMapping("/admin/type")
public class MerchandiseTypeController {
	@Autowired
	private MerchandiseTypeService merchandiseTypeService;

	
	@RequestMapping(value = "/list")
	public String showForm(ModelMap model) {
		return "page/shop/merchandise/type/list";
	}
	
	/**
	 * 分页返回用户列表
	 */
	@RequestMapping(value = "/listMerchandiseTypeList")
	public void listMerchandiseTypeList(HttpServletRequest request,
			HttpServletResponse response,
			@RequestParam(required = false, defaultValue = "1") Integer page,
			@RequestParam(required = false, defaultValue = "15") Integer rows,
			MerchandiseType merchandiseType) {
		response.setContentType("text/html;charset=utf-8"); // 指定输出内容类型和编码
		try {
			PrintWriter out = response.getWriter();// 获取输出口		
			merchandiseType.setPageIndex((page - 1) * rows);
			merchandiseType.setPageSize(rows);
			List<MerchandiseType> list =merchandiseTypeService.getMerchandiseTypeList(merchandiseType);
			int total = merchandiseTypeService.merchandiseTypeCount(merchandiseType);
			merchandiseType.setTotal(total);
			merchandiseType.setRows(list);
			// 获取分页返回的数据,格式化数据并返回JSON
			ObjectMapper mapper = new ObjectMapper();
			out.write(mapper.writeValueAsString(merchandiseType));
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
	 */
	@RequestMapping(value = "/addMerchandiseType")
	public String addMerchandiseType(ModelMap model)
	{
		return "page/shop/merchandise/type/add";
	}
	
	 
	/**
	 *验证分类名称的重复
	 */
	@RequestMapping(value = "/verDataIsEffectivenes")
	public void verDataIsEffectivenes(HttpServletRequest request,
			HttpServletResponse response,
			MerchandiseType merchandiseType) {
		response.setContentType("text/html;charset=utf-8"); // 指定输出内容类型和编码
		try {
			boolean isValid = false;   
			if(null != merchandiseType.getName() && !"".equals(merchandiseType.getName()))
			{
				int total = merchandiseTypeService.isEffectivenes(merchandiseType);	
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
	@RequestMapping(value = "/insertMerchandiseType")
	public void insertMerchandiseType(HttpServletRequest request,HttpServletResponse response,MerchandiseType merchandiseType){
		response.setContentType("text/html;charset=utf-8"); //指定输出内容类型和编码
        try{
        	boolean isValid = false;         	
        	merchandiseType.setId(UUID.randomUUID().toString().replace("-", ""));
        	merchandiseTypeService.insertMerchandiseType(merchandiseType);
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
	@RequestMapping(value = "/editMerchandiseType")
	public String editMerchandiseType(ModelMap model,HttpServletRequest request,HttpServletResponse response)
	{
		try {
			MerchandiseType merchandiseType=merchandiseTypeService.selectCheckId(request.getParameter("id"));
			model.put("merch", merchandiseType);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "page/shop/merchandise/type/edit";
	}
	/**
	 * 修改
	 * @param request
	 * @param response
	 * @param Catalog
	 */
	@RequestMapping(value = "/updateMerchandiseType")
	public void updateMerchandiseType(HttpServletRequest request,HttpServletResponse response,MerchandiseType merchandiseType){
		response.setContentType("text/html;charset=utf-8"); //指定输出内容类型和编码
        try{
        	boolean isValid = false;
        	merchandiseType.setId(merchandiseType.getId());        
        	merchandiseTypeService.updateMerchandiseType(merchandiseType);
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
	@RequestMapping(value = "/deleteMerchandiseType")
	public void deleteMerchandiseType(HttpServletRequest request,HttpServletResponse response,MerchandiseType merchandiseType){
		response.setContentType("text/html;charset=utf-8"); //指定输出内容类型和编码
        try{
        	boolean isValid = false;
        	merchandiseTypeService.deleteByPkId(merchandiseType.getId());        
        	isValid = true;
        	response.getWriter().print(JSONArray.fromObject(isValid));
        }catch(Exception ex){
            ex.printStackTrace();
        }
	}

}
