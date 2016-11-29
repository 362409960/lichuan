package cloud.app.commodity.controller;

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




import cloud.app.commodity.model.ProductCategory;
import cloud.app.commodity.model.ProductParameters;
import cloud.app.commodity.service.ProductCategoryService;
import cloud.app.commodity.service.ProductParametersService;

@Controller
@RequestMapping("/admin/parameters")
public class ProductParametersController {
	Logger log = Logger.getLogger(this.getClass());
	@Autowired
	private ProductParametersService productParametersService;
	
	@Autowired
	private ProductCategoryService productCategoryService;
	
	@RequestMapping(value = "/toList")
	public String toList(ModelMap model,HttpServletRequest request,HttpServletResponse response) throws Exception
	{
		ProductParameters paramerter=new ProductParameters();
		paramerter.setPageIndex(0);
		paramerter.setPageSize(20);
		List<ProductParameters> list=productParametersService.getList(paramerter);
		Integer total=productParametersService.count(paramerter);
		Integer count=((total%paramerter.getPageSize())==0)?total/paramerter.getPageSize():(total/paramerter.getPageSize()+1);//最大页数
		Integer p_begin=0;
		if(paramerter.getPageIndex()>1){
			p_begin=paramerter.getPageIndex()+1-2;
		}else{
			p_begin=1;
		}
		Integer p_end=0;
		if(count<5){
			p_end=5;
		}else{
			p_end=p_begin+4;
		}
		paramerter.setTotal(total);
		paramerter.setRows(list);
		paramerter.setPageMax(count);
		model.addAttribute("paramerter", paramerter);
		model.addAttribute("total", total);
		model.addAttribute("p_begin", p_begin);
		model.addAttribute("p_end", p_end);
		return   "page/commodity/parameters/list";
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
	public String toSearch(ModelMap model,HttpServletRequest request,HttpServletResponse response,ProductParameters paramerter) throws Exception
	{
		paramerter.setPageIndex((Integer.parseInt(request.getParameter("pageNumber"))-1));
		paramerter.setPageSize(Integer.parseInt(request.getParameter("pageSize")));
		ProductParameters pt=new ProductParameters();
		String searchProperty=request.getParameter("searchProperty");
		if(!searchProperty.isEmpty()&&!"".equals(searchProperty)){
			String searchValue=request.getParameter("searchValue");
			if("para_name".equals(searchProperty)){
				pt.setPara_name(searchValue);
			}
		}
		//asc desc
		String orderProperty=request.getParameter("orderProperty");
		if(!orderProperty.isEmpty()&&!"".equals(orderProperty)){
			String orderDirection=request.getParameter("orderDirection");
			pt.setStringAsc(orderProperty+" "+orderDirection);
		}
		pt.setPageIndex(paramerter.getPageIndex()*paramerter.getPageSize());
		pt.setPageSize(paramerter.getPageSize());
		List<ProductParameters> list=productParametersService.getList(pt);
		Integer total=productParametersService.count(pt);
		Integer count=((total%paramerter.getPageSize())==0)?total/paramerter.getPageSize():(total/paramerter.getPageSize()+1);//最大页数
		Integer p_begin=0;
		if(paramerter.getPageIndex()+1>2){
			p_begin=paramerter.getPageIndex()+1-2;
		}else{
			p_begin=1;
		}
		Integer p_end=0;
		if(count<5){
			p_end=5;
		}else{
			p_end=p_begin+4;
		}
		paramerter.setTotal(total);
		paramerter.setRows(list);
		paramerter.setPageMax(count);
		model.addAttribute("paramerter", paramerter);
		model.addAttribute("total", total);
		model.addAttribute("p_begin", p_begin);
		model.addAttribute("p_end", p_end);
		return "page/commodity/parameters/list";
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
		
		return "page/commodity/parameters/add";
	}
	/**
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/save" ,method=RequestMethod.POST)
	public String save(HttpServletRequest request,HttpServletResponse response,ProductParameters paramerter,ModelMap model) throws Exception{
		paramerter.setId(UUID.randomUUID().toString().replace("-", ""));
		paramerter.setCreate_time(new Date());
		paramerter.setCreate_user(request.getSession().getAttribute("username").toString());
		paramerter.setUpdate_time(new Date());
		paramerter.setUpdate_user(request.getSession().getAttribute("username").toString());
		String sp_options="";
	    for(String option:paramerter.getOptions()){
	    	sp_options+=option+"&nbsp;";
	    }
	    paramerter.setPar_options(sp_options);
	    productParametersService.save(paramerter);	
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
		ProductParameters paramerter=productParametersService.getObjById(id);	
		paramerter.setOptions(paramerter.getPar_options().split("&nbsp;"));
		model.addAttribute("category", categoryList);
		model.addAttribute("paramerter", paramerter);
		return "page/commodity/parameters/edit";
	}
	
	
	/**
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/edit")
	public String edit(HttpServletRequest request,HttpServletResponse response,ProductParameters paramerter,ModelMap model) throws Exception{		
		paramerter.setUpdate_user(request.getSession().getAttribute("username").toString());
		  String sp_options="";
		    for(String option:paramerter.getOptions()){
		    	sp_options+=option+"&nbsp;";
		    }
		    paramerter.setPar_options(sp_options);
		    productParametersService.update(paramerter);
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
		ProductParameters paramerter=productParametersService.getObjById(id);	
		paramerter.setOptions(paramerter.getPar_options().split("&nbsp;"));
		model.addAttribute("category", categoryList);
		model.addAttribute("paramerter", paramerter);
		return "page/commodity/parameters/copy";
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
             productParametersService.deleteByIdS(ids);
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
