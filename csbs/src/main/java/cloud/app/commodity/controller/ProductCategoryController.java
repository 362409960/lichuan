package cloud.app.commodity.controller;

import java.io.PrintWriter;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;



import cloud.app.commodity.model.Brand;
import cloud.app.commodity.model.ProductCategory;
import cloud.app.commodity.service.BrandService;
import cloud.app.commodity.service.ProductCategoryService;
import cloud.app.common.StringUtil;



@Controller
@RequestMapping("/admin/category")
public class ProductCategoryController {
	
	Logger log = Logger.getLogger(this.getClass());
	@Autowired
	private ProductCategoryService productCategoryService;
	@Autowired
	private BrandService brandService;
	
	/**
	 * 
	 * @param model
	 * @param request
	 * @param response	
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "/toList")
	public String toList(ModelMap model,HttpServletRequest request,HttpServletResponse response) throws Exception
	{
		ProductCategory category=new ProductCategory();		
		List<ProductCategory> list=productCategoryService.getList(category);
		model.addAttribute("list", list);
		return "page/commodity/category/list";
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
	
		List<Brand> brandList=brandService.getAll();
		Map<String,Object> bMap=new HashMap<String, Object>();
		for(Brand b:brandList){
			bMap.put(b.getId(), b.getBrand_name());
		}
		ProductCategory category=new ProductCategory();
		List<ProductCategory> categoryList=productCategoryService.getList(category);
		for(ProductCategory p:categoryList){			
			p.setCategory_name(getBlank(p.getLevel())+p.getCategory_name());			
		}
		model.addAttribute("bMap", bMap);//品牌checkbox
		model.addAttribute("category", categoryList);
		return "page/commodity/category/add";
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
	/**
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/save")
	public String save(HttpServletRequest request,HttpServletResponse response,ModelMap model,ProductCategory category) throws Exception{
		String uuid=UUID.randomUUID().toString().replace("-", "");
		category.setId(uuid);
		category.setCreate_time(new Date());
		category.setCreate_user(request.getSession().getAttribute("username").toString());
		category.setUpdate_time(new Date());
		category.setUpdate_user(request.getSession().getAttribute("username").toString());
		if("".equals(category.getParent_id()) && category.getParent_id()==""){
			category.setPath(uuid);
		}else{
			String pid=getProducToptList(category.getParent_id());
			category.setPath(pid.substring(0, pid.length()-1)+","+uuid);
		}
		if(category.getBrandIds()!=null){
			category.setBrand_id(getString(category.getBrandIds()));
		}
		if(category.getPromotions()!=null){
			category.setPromotion(getString(category.getPromotions()));
		}
		productCategoryService.save(category);
		
		return toList(model,request,response);
	}
	
	
	private String getString(String []ary){
		StringBuffer sb = new StringBuffer();
		for(int i = 0; i < ary.length; i++){
		 sb. append(ary[i]+",");
		}
		String newStr = sb.toString();
		return newStr.substring(0, newStr.length()-1);
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
		ProductCategory categ=productCategoryService.getObjById(id);
		
		String [] ban=null;
		if(null!= categ.getBrand_id() ){
			ban=categ.getBrand_id().split(",");
		}
		String [] pan=null;
		if(null!= categ.getPromotion()){
			pan=categ.getPromotion().split(",");
		}
		List<Brand> brandList=brandService.getAll();
		Map<String,Object> bMap=new HashMap<String, Object>();
		for(Brand b:brandList){
			bMap.put(b.getId(), b.getBrand_name());
		}
		ProductCategory category=new ProductCategory();
		List<ProductCategory> categoryList=productCategoryService.getList(category);
		for(ProductCategory p:categoryList){			
			p.setCategory_name(getBlank(p.getLevel())+p.getCategory_name());			
		}
		model.addAttribute("bMap", bMap);//品牌checkbox
		model.addAttribute("category", categoryList);
		model.addAttribute("categ", categ);
		model.addAttribute("ban", ban);
		model.addAttribute("pan", pan);
		return "page/commodity/category/edit";
	}
	
	/**
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/edit")
	public String edit(HttpServletRequest request,HttpServletResponse response,ModelMap model,ProductCategory category) throws Exception{
		
		category.setUpdate_user(request.getSession().getAttribute("username").toString());
		if(null==category.getParent_id()){
			category.setPath(request.getParameter("id"));
		}else{
			String pid=getProducToptList(category.getParent_id());
			category.setPath(pid.substring(0, pid.length()-1)+","+request.getParameter("id"));
		}
		if(category.getBrandIds()!=null){
			category.setBrand_id(getString(category.getBrandIds()));
		}
		if(category.getPromotions()!=null){
			category.setPromotion(getString(category.getPromotions()));
		}
		productCategoryService.update(category);
		return toList(model,request,response);
	}
	
	/**
	 * 删除
	 * @param request
	 * @param response
	 */
	@RequestMapping(value = "/deleteById")
	public String deleteById(HttpServletRequest request,HttpServletResponse response,ModelMap model,ProductCategory category)throws Exception{
		response.setContentType("text/html;charset=utf-8"); //指定输出内容类型和编码
        try{
        	boolean isValid = false;
             String id=request.getParameter("id");
             String ids=getProductLowList(id);             
             productCategoryService.deleteByIdS(ids.split(","));
        	isValid = true;
        	response.getWriter().print(JSONArray.fromObject(isValid));
        }catch(Exception e){
        	log.debug(e);
        }
        return toList(model,request,response);
	}
	
	/**
	 * 检查名称是否已经有了
	 * @param request
	 * @param response
	 * @param model
	 */
	@RequestMapping(value = "/checkNname")
	public void checkNname(HttpServletRequest request,HttpServletResponse response,ModelMap model){
		response.setContentType("text/html;charset=utf-8"); //指定输出内容类型和编码
        try{
        	PrintWriter out = response.getWriter();//获取输出口
        	boolean isValid = true;
        	int num=productCategoryService.checkName(new String(request.getParameter("category_name").getBytes("ISO-8859-1"),"utf-8"));        	
        	if(num!=0)
        	{
        		isValid = false;
        	}        	
        	out.print(isValid);//返回结果
            out.flush();  
            out.close(); 
        }catch(Exception ex){
            ex.printStackTrace();
        }
	}

	
	public String getProductLowList(String id) throws Exception
	{
		String ids=id;
		List<ProductCategory> melist=productCategoryService.selectPId(id);
		if(null != melist && !melist.isEmpty())
		{
			for(ProductCategory me :melist)
			{	
				List<ProductCategory> list=productCategoryService.selectPId(me.getId());
				if(null !=list && !list.isEmpty())
				{
					ids=ids+","+me.getId()+","+getProductLowList(me.getId());
				}
				else
				{
					ids=ids+","+me.getId();		
				}
			}
		}
		return ids;
	}
	public String getProducToptList(String id) throws Exception
	{
		String ids="";
		ProductCategory melist=productCategoryService.getObjById(id);
		if(!StringUtil.isNullOrEmpty(melist))
		{	
			ProductCategory list=productCategoryService.getObjById(melist.getParent_id());
			if(!StringUtil.isNullOrEmpty(list))
			{
				ids=melist.getParent_id()+","+id+","+getProducToptList(melist.getParent_id());
			}
		}
		return ids;
	}
}
