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






import cloud.app.commodity.model.ProductCategory;
import cloud.app.commodity.model.SpecificationManagement;
import cloud.app.commodity.service.ProductCategoryService;
import cloud.app.commodity.service.SpecificationManagementService;
@Controller
@RequestMapping("/admin/specification")
public class SpecificationManagementController {
	Logger log = Logger.getLogger(this.getClass());
	
	@Autowired
	private SpecificationManagementService specificationManagementService;
	@Autowired
	private ProductCategoryService productCategoryService;
	
	
	@RequestMapping(value = "/toList")
	public String toList(ModelMap model,HttpServletRequest request,HttpServletResponse response) throws Exception
	{
		SpecificationManagement spec=new SpecificationManagement();
		spec.setPageIndex(0);
		spec.setPageSize(20);
		List<SpecificationManagement> list=specificationManagementService.getList(spec);
		Integer total=specificationManagementService.count(spec);
		Integer count=((total%spec.getPageSize())==0)?total/spec.getPageSize():(total/spec.getPageSize()+1);//最大页数
		Integer p_begin=0;
		if(spec.getPageIndex()>1){
			p_begin=spec.getPageIndex()+1-2;
		}else{
			p_begin=1;
		}
		Integer p_end=0;
		if(count<5){
			p_end=5;
		}else{
			p_end=p_begin+4;
		}
		spec.setTotal(total);
		spec.setRows(list);
		spec.setPageMax(count);
		model.addAttribute("spec", spec);
		model.addAttribute("total", total);
		model.addAttribute("p_begin", p_begin);
		model.addAttribute("p_end", p_end);
		return "page/commodity/specification/list";
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
	public String toSearch(ModelMap model,HttpServletRequest request,HttpServletResponse response,SpecificationManagement spec) throws Exception
	{
		spec.setPageIndex((Integer.parseInt(request.getParameter("pageNumber"))-1));
		spec.setPageSize(Integer.parseInt(request.getParameter("pageSize")));
		SpecificationManagement pt=new SpecificationManagement();
		String searchProperty=request.getParameter("searchProperty");
		if(!searchProperty.isEmpty()&&!"".equals(searchProperty)){
			String searchValue=request.getParameter("searchValue");
			if("group_name".equals(searchProperty)){
				pt.setGroup_name(searchValue);
			}
		}
		//asc desc
		String orderProperty=request.getParameter("orderProperty");
		if(!orderProperty.isEmpty()&&!"".equals(orderProperty)){
			String orderDirection=request.getParameter("orderDirection");
			pt.setStringAsc(orderProperty+" "+orderDirection);
		}
		pt.setPageIndex(spec.getPageIndex()*spec.getPageSize());
		pt.setPageSize(spec.getPageSize());
		List<SpecificationManagement> list=specificationManagementService.getList(pt);
		Integer total=specificationManagementService.count(pt);
		Integer count=((total%spec.getPageSize())==0)?total/spec.getPageSize():(total/spec.getPageSize()+1);//最大页数
		Integer p_begin=0;
		if(spec.getPageIndex()+1>2){
			p_begin=spec.getPageIndex()+1-2;
		}else{
			p_begin=1;
		}
		Integer p_end=0;
		if(count<5){
			p_end=5;
		}else{
			p_end=p_begin+4;
		}
		spec.setTotal(total);
		spec.setRows(list);
		spec.setPageMax(count);
		model.addAttribute("spec", spec);
		model.addAttribute("total", total);
		model.addAttribute("p_begin", p_begin);
		model.addAttribute("p_end", p_end);
		return "page/commodity/specification/list";
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
		
		return "page/commodity/specification/add";
	}
	
	/**
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/save")
	public String save(HttpServletRequest request,HttpServletResponse response,SpecificationManagement spec,ModelMap model) throws Exception{
		spec.setId(UUID.randomUUID().toString().replace("-", ""));
		spec.setCreate_time(new Date());
		spec.setCreate_user(request.getSession().getAttribute("username").toString());
		spec.setUpdate_time(new Date());
		spec.setUpdate_user(request.getSession().getAttribute("username").toString());
		String sp_options="";
	    for(String option:spec.getOptions()){
	    	sp_options+=option+"&nbsp;";
	    }
	    spec.setSp_options(sp_options);
	    specificationManagementService.save(spec);	
		return toList(model,request,response);
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
		SpecificationManagement spec=specificationManagementService.getObjById(id);	
		spec.setOptions(spec.getSp_options().split("&nbsp;"));
		model.addAttribute("category", categoryList);
		model.addAttribute("spec", spec);
		return "page/commodity/specification/edit";
	}
	
	
	/**
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/edit")
	public String edit(HttpServletRequest request,HttpServletResponse response,SpecificationManagement spec,ModelMap model) throws Exception{		
		  spec.setUpdate_user(request.getSession().getAttribute("username").toString());
		  String sp_options="";
		    for(String option:spec.getOptions()){
		    	sp_options+=option+"&nbsp;";
		    }
		    spec.setSp_options(sp_options);
		  specificationManagementService.update(spec);
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
		SpecificationManagement spec=specificationManagementService.getObjById(id);	
		spec.setOptions(spec.getSp_options().split("&nbsp;"));
		model.addAttribute("category", categoryList);
		model.addAttribute("spec", spec);
		return "page/commodity/specification/copy";
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
             specificationManagementService.deleteByIdS(ids);
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
