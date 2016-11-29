package cloud.app.commodity.controller;


import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import cloud.app.commodity.model.Brand;
import cloud.app.commodity.model.Product;
import cloud.app.commodity.model.ProductCategory;
import cloud.app.commodity.model.ProductPicture;

import cloud.app.commodity.model.ProductVO;
import cloud.app.commodity.service.AttrProductService;
import cloud.app.commodity.service.BrandService;
import cloud.app.commodity.service.ParametersGroupService;
import cloud.app.commodity.service.ProductCategoryService;
import cloud.app.commodity.service.ProductConditionService;
import cloud.app.commodity.service.ProductPictureService;
import cloud.app.commodity.service.ProductService;



@Controller
@RequestMapping("/admin/product")
public class ProductController {
	
	Logger log = Logger.getLogger(this.getClass());
	@Autowired
	private BrandService brandService;
	@Autowired
	private ProductService productService;
	@Autowired
	private ProductCategoryService productCategoryService;
	@Autowired
	private ProductConditionService productConditionService;
	@Autowired
	private ParametersGroupService parametersGroupService;
	@Autowired
	private AttrProductService attrProductService;
	@Autowired
	private ProductPictureService productPictureService;
	
	
	/**
	 * 指向list界面
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/toList")
	public String toList(ModelMap model,HttpServletRequest request,HttpServletResponse response)
	{
		try {
			Product product=new Product();
			product.setPageIndex(0);
			product.setPageSize(20);
			List<Product> list=productService.getList(product);
			Integer total=productService.count(product);
			Integer count=((total%product.getPageSize())==0)?total/product.getPageSize():(total/product.getPageSize()+1);//最大页数
			Integer p_begin=0;
			if(product.getPageIndex()+1-2>0){
				p_begin=product.getPageIndex()+1-2;
			}else{
				p_begin=1;
			}
			Integer p_end=0;
			if(count-5>0){
				p_end=5;
			}else{
				p_end=count;
			}
			product.setTotal(total);
			product.setRows(list);
			product.setPageMax(count);
			model.addAttribute("product", product);
			model.put("total", total);
			model.put("p_begin", p_begin);
			model.put("p_end", p_end);
		} catch (Exception e) {
			log.debug(e);
		}
		return "page/commodity/product_manage/product_list";
	}
	/**
	 * 条件查询
	 * @param model
	 * @param request
	 * @param response
	 * @param product
	 * @return
	 */
	@RequestMapping(value = "/toSearch")
	public String toSearch(ModelMap model,HttpServletRequest request,HttpServletResponse response,Product product)
	{
		try {
			product.setPageIndex((Integer.parseInt(request.getParameter("pageNumber"))-1));
			product.setPageSize(Integer.parseInt(request.getParameter("pageSize")));
			Product pt=new Product();
			String searchProperty=request.getParameter("searchProperty");
			if(!searchProperty.isEmpty()&&!"".equals(searchProperty)){
				String searchValue=request.getParameter("searchValue");
				if("product_no".equals(searchProperty)){
					pt.setProduct_no(searchValue);
				}else if("product_name".equals(searchProperty)){
					pt.setProduct_name(searchValue);
				}
			}
			//asc desc
			String orderProperty=request.getParameter("orderProperty");
			if(!orderProperty.isEmpty()&&!"".equals(orderProperty)){
				String orderDirection=request.getParameter("orderDirection");
				pt.setStringAsc(orderProperty+" "+orderDirection);
			}
			pt.setPageIndex(product.getPageIndex()*product.getPageSize());
			pt.setPageSize(product.getPageSize());
			List<Product> list=productService.getList(pt);
			Integer total=productService.count(pt);
			Integer count=((total%product.getPageSize())==0)?total/product.getPageSize():(total/product.getPageSize()+1);//最大页数
			Integer p_begin=0;
			if(product.getPageIndex()+1>2){
				p_begin=product.getPageIndex()+1-2;
			}else{
				p_begin=1;
			}
			Integer p_end=0;
			if(count<5){
				p_end=5;
			}else{
				p_end=p_begin+4;
			}
			product.setTotal(total);
			product.setRows(list);
			product.setPageMax(count);
			model.addAttribute("product", product);
			model.put("total", total);
			model.put("p_begin", p_begin);
			model.put("p_end", p_end);
		} catch (Exception e) {
			log.debug(e);
		}
		return "page/commodity/product_manage/product_list";
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
		List<Brand> brandList=brandService.getAll();
		model.addAttribute("category", categoryList);
		model.addAttribute("brand", brandList);
		
		return "page/commodity/product_manage/add";
	}
	
	/**
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @param productVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/save")
	public String save(HttpServletRequest request,HttpServletResponse response,ModelMap model,ProductVO productVO) throws Exception{
		productVO.setCreate_user(request.getSession().getAttribute("username").toString());
		productVO.setUpdate_user(request.getSession().getAttribute("username").toString());
		productConditionService.save(productVO);
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
		List<Brand> brandList=brandService.getAll();
		//商品内容
		Product product=productService.getObjById(id);		
		//所有的子表全部放在这个vo里面
		ProductVO productVO=new ProductVO();	
		//商品图片
		List<ProductPicture> productPicture=productPictureService.getListObjByFatherId(id);
		Integer imgesLength=0;
		if(productPicture.size()>0 &&!productPicture.isEmpty()){			
			ProductPicture [] np=new ProductPicture[productPicture.size()];
			for(int i=0;i<productPicture.size();i++){
				np[i]=productPicture.get(i);
			}
			productVO.setProductImages(np);			
			imgesLength=np.length;
		}
	
		//
		
		model.addAttribute("category", categoryList);
		model.addAttribute("brand", brandList);
		model.addAttribute("product", product);
		model.addAttribute("productVO", productVO);
		model.addAttribute("imgesLength", imgesLength);
		return "page/commodity/product_manage/edit";
	}
	
	/**
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @param productVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/edit")
	public String edit(HttpServletRequest request,HttpServletResponse response,ModelMap model,ProductVO productVO) throws Exception{
		 productVO.setUpdate_user(request.getSession().getAttribute("username").toString());
		 productConditionService.update(productVO);
		return toList(model,request,response);
	}
	/**
	 * 删除
	 * @param request
	 * @param response
	 */
	@RequestMapping(value = "/deleteProductById")
	public void deleteProductById(HttpServletRequest request,HttpServletResponse response){
		response.setContentType("text/html;charset=utf-8"); //指定输出内容类型和编码
        try{
        	boolean isValid = false;
             String[] ids=request.getParameterValues("ids"); 
             productConditionService.deleteByIdS(ids);
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
