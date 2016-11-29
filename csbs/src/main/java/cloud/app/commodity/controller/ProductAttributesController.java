package cloud.app.commodity.controller;

import java.lang.ProcessBuilder.Redirect;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


import cloud.app.commodity.model.ProductAttributes;
import cloud.app.commodity.model.ProductCategory;
import cloud.app.commodity.service.ProductAttributesService;
import cloud.app.commodity.service.ProductCategoryService;


@Controller
@RequestMapping("/admin/attributes")
public class ProductAttributesController {
	Logger log = Logger.getLogger(this.getClass());
	
	@Autowired
	private ProductAttributesService productAttributesService;
	@Autowired
	private ProductCategoryService productCategoryService;
	
	@RequestMapping(value = "/toList")
	public String toList(ModelMap model,HttpServletRequest request,HttpServletResponse response) throws Exception
	{
		ProductAttributes attr=new ProductAttributes();
		attr.setPageIndex(0);
		attr.setPageSize(20);
		List<ProductAttributes> list=productAttributesService.getList(attr);
		Integer total=productAttributesService.count(attr);
		Integer count=((total%attr.getPageSize())==0)?total/attr.getPageSize():(total/attr.getPageSize()+1);//最大页数
		Integer p_begin=0;
		if(attr.getPageIndex()>1){
			p_begin=attr.getPageIndex()+1-2;
		}else{
			p_begin=1;
		}
		Integer p_end=0;
		if(count<5){
			p_end=5;
		}else{
			p_end=p_begin+4;
		}
		attr.setTotal(total);
		attr.setRows(list);
		attr.setPageMax(count);
		model.addAttribute("attr", attr);
		model.addAttribute("total", total);
		model.addAttribute("p_begin", p_begin);
		model.addAttribute("p_end", p_end);
		return   "page/commodity/attributes/list";
	}
	
	/**
	 * 
	 * @param model
	 * @param request
	 * @param response
	 * @param brand
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "/toSearch")
	public String toSearch(ModelMap model,HttpServletRequest request,HttpServletResponse response,ProductAttributes attr) throws Exception
	{
		attr.setPageIndex((Integer.parseInt(request.getParameter("pageNumber"))-1));
		attr.setPageSize(Integer.parseInt(request.getParameter("pageSize")));
		ProductAttributes pt=new ProductAttributes();
		String searchProperty=request.getParameter("searchProperty");
		if(!searchProperty.isEmpty()&&!"".equals(searchProperty)){
			String searchValue=request.getParameter("searchValue");
			if("attr_name".equals(searchProperty)){
				pt.setAttr_name(searchValue);
			}
		}
		//asc desc
		String orderProperty=request.getParameter("orderProperty");
		if(!orderProperty.isEmpty()&&!"".equals(orderProperty)){
			String orderDirection=request.getParameter("orderDirection");
			pt.setStringAsc(orderProperty+" "+orderDirection);
		}
		pt.setPageIndex(attr.getPageIndex()*attr.getPageSize());
		pt.setPageSize(attr.getPageSize());
		List<ProductAttributes> list=productAttributesService.getList(pt);
		Integer total=productAttributesService.count(pt);
		Integer count=((total%attr.getPageSize())==0)?total/attr.getPageSize():(total/attr.getPageSize()+1);//最大页数
		Integer p_begin=0;
		if(attr.getPageIndex()+1>2){
			p_begin=attr.getPageIndex()+1-2;
		}else{
			p_begin=1;
		}
		Integer p_end=0;
		if(count<5){
			p_end=5;
		}else{
			p_end=p_begin+4;
		}
		attr.setTotal(total);
		attr.setRows(list);
		attr.setPageMax(count);
		model.addAttribute("attr", attr);
		model.addAttribute("total", total);
		model.addAttribute("p_begin", p_begin);
		model.addAttribute("p_end", p_end);
		return "page/commodity/attributes/list";
	}
	/**
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/toAdd")
	public String toAdd(HttpServletRequest request,HttpServletResponse response,ModelMap model) throws Exception{		
		ProductCategory category=new ProductCategory();
		List<ProductCategory> categoryList=productCategoryService.getList(category);
		for(ProductCategory p:categoryList){			
			p.setCategory_name(getBlank(p.getLevel())+p.getCategory_name());			
		}
		model.addAttribute("category", categoryList);
		
		return "page/commodity/attributes/add";
	}
	/**
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/save" ,method=RequestMethod.POST)
	public String save(HttpServletRequest request,HttpServletResponse response,ProductAttributes attr,ModelMap model) throws Exception{
		attr.setId(UUID.randomUUID().toString().replace("-", ""));
		attr.setCreate_time(new Date());
		attr.setCreate_user(request.getSession().getAttribute("username").toString());
		attr.setUpdate_time(new Date());
		attr.setUpdate_user(request.getSession().getAttribute("username").toString());
		String sp_options="";
	    for(String option:attr.getOptions()){
	    	sp_options+=option+"&nbsp;";
	    }
	    attr.setAtt_options(sp_options);
	    productAttributesService.save(attr);	
		return   toList(model,request,response);
	}
	/**
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/toEdit")
	public String toEdit(HttpServletRequest request,HttpServletResponse response,ModelMap model) throws Exception{
		String id=request.getParameter("id");
		ProductCategory category=new ProductCategory();
		List<ProductCategory> categoryList=productCategoryService.getList(category);
		for(ProductCategory p:categoryList){			
			p.setCategory_name(getBlank(p.getLevel())+p.getCategory_name());			
		}
		ProductAttributes attr=productAttributesService.getObjById(id);	
		attr.setOptions(attr.getAtt_options().split("&nbsp;"));
		model.addAttribute("category", categoryList);
		model.addAttribute("attr", attr);
		return "page/commodity/attributes/edit";
	}
	
	
	/**
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/edit")
	public String edit(HttpServletRequest request,HttpServletResponse response,ProductAttributes attr,ModelMap model) throws Exception{		
		attr.setUpdate_user(request.getSession().getAttribute("username").toString());
		  String sp_options="";
		    for(String option:attr.getOptions()){
		    	sp_options+=option+"&nbsp;";
		    }
		    attr.setAtt_options(sp_options);
		    productAttributesService.update(attr);
		  return toList(model,request,response);
	}
	
	/**
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/toCopy")
	public String toCopy(HttpServletRequest request,HttpServletResponse response,ModelMap model) throws Exception{
		String id=request.getParameter("id");
		ProductCategory category=new ProductCategory();
		List<ProductCategory> categoryList=productCategoryService.getList(category);
		for(ProductCategory p:categoryList){			
			p.setCategory_name(getBlank(p.getLevel())+p.getCategory_name());			
		}
		ProductAttributes attr=productAttributesService.getObjById(id);	
		attr.setOptions(attr.getAtt_options().split("&nbsp;"));
		model.addAttribute("category", categoryList);
		model.addAttribute("attr", attr);
		return "page/commodity/attributes/copy";
	}
	/**
	 * 删除
	 * @param request
	 * @param response
	 */
	@RequestMapping(value = "/deleteById")
	public void deleteById(HttpServletRequest request,HttpServletResponse response){
		response.setContentType("text/html;charset=utf-8"); //指定输出内容类型和编码
        try{
        	boolean isValid = false;
             String[] ids=request.getParameterValues("ids"); 
             productAttributesService.deleteByIdS(ids);
        	isValid = true;
        	response.getWriter().print(JSONArray.fromObject(isValid));
        }catch(Exception e){
        	log.debug(e);
        }
	}
	/**
	 * 循环空格次数，为树形结构准备
	 * @param number
	 * @return
	 */
	private String getBlank(int number){
		String str="&nbsp;&nbsp;";
		String blank="";
		for(int i=1;i<=number;i++)
		{
			blank+=str;
		}
		return blank;
	}
}
