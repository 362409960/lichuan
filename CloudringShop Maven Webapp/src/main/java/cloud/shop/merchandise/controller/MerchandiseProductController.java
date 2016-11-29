package cloud.shop.merchandise.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedHashMap;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.databind.ObjectMapper;

import cloud.shop.common.Constants;
import cloud.shop.common.ImageUtil;
import cloud.shop.common.TreeNode;
import cloud.shop.merchandise.entity.MerchandiseBrand;
import cloud.shop.merchandise.entity.MerchandiseCategories;
import cloud.shop.merchandise.entity.MerchandiseProduct;
import cloud.shop.merchandise.entity.MerchandiseType;
import cloud.shop.merchandise.service.MerchandiseBrandService;
import cloud.shop.merchandise.service.MerchandiseCategoriesService;
import cloud.shop.merchandise.service.MerchandiseProductService;
import cloud.shop.merchandise.service.MerchandiseTypeService;


@Controller
@RequestMapping("/admin/product")
public class MerchandiseProductController {
	Logger log=Logger.getLogger(MerchandiseProductController.class);
	@Autowired
	private MerchandiseProductService merchandiseProductService;
	@Autowired
	private MerchandiseCategoriesService merchandiseCategoriesService;
	@Autowired
	private MerchandiseBrandService merchandiseBrandService;
	@Autowired
	private MerchandiseTypeService merchandiseTypeService;
	
	
	@RequestMapping(value = "/list")
	public String showForm(ModelMap model) throws Exception {
		List<MerchandiseType> mtList=merchandiseTypeService.getTypeList();
		Map<String, String> typeMap=new LinkedHashMap<String, String>();
		if(null != mtList && !mtList.isEmpty())
		{
			for(MerchandiseType type:mtList)
			{
				typeMap.put(type.getId(), type.getName());
			}
		}
		List<MerchandiseBrand> mbList=merchandiseBrandService.geteBrandList();
		Map<String, String> brandMap=new LinkedHashMap<String, String>();
		if(null != mbList && !mbList.isEmpty())
		{
			for(MerchandiseBrand brand:mbList)
			{
				brandMap.put(brand.getId(), brand.getName());
			}
		}
		List<MerchandiseCategories> caList=merchandiseCategoriesService.getCategorieList();
		Map<String, String> categoriesMap=new LinkedHashMap<String, String>();
		if(null != caList && !caList.isEmpty())
		{
			for(MerchandiseCategories mc:caList)
			{
				categoriesMap.put(mc.getId(), mc.getName());
			}
		}
		model.addAttribute("brandMap", brandMap);
		model.addAttribute("categoriesMap", categoriesMap);
		model.addAttribute("typeMap", typeMap);
		return "page/shop/merchandise/product/list";
	}
	
	/**
	 * 分页返回用户列表
	 */
	@RequestMapping(value = "/listMerchandiseProductList")
	public void listMerchandiseProductList(HttpServletRequest request,
			HttpServletResponse response,
			@RequestParam(required = false, defaultValue = "1") Integer page,
			@RequestParam(required = false, defaultValue = "15") Integer rows,
			MerchandiseProduct merchandiseProduct) {
		response.setContentType("text/html;charset=utf-8"); // 指定输出内容类型和编码
		try {
			
			PrintWriter out = response.getWriter();// 获取输出口		
			merchandiseProduct.setPageIndex((page - 1) * rows);
			merchandiseProduct.setPageSize(rows);
			List<MerchandiseProduct> list =merchandiseProductService.getMerchandiseProductList(merchandiseProduct);
			int total = merchandiseProductService.merchandiseProductCount(merchandiseProduct);
			merchandiseProduct.setTotal(total);
			merchandiseProduct.setRows(list);
			// 获取分页返回的数据,格式化数据并返回JSON
			ObjectMapper mapper = new ObjectMapper();
			out.write(mapper.writeValueAsString(merchandiseProduct));
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
	@RequestMapping(value = "/addMerchandiseProduct")
	public String addMerchandiseProduct(ModelMap model) throws Exception
	{
		List<MerchandiseType> mtList=merchandiseTypeService.getTypeList();
		Map<String, String> typeMap=new LinkedHashMap<String, String>();
		if(null != mtList && !mtList.isEmpty())
		{
			for(MerchandiseType type:mtList)
			{
				typeMap.put(type.getId(), type.getName());
			}
		}
		List<MerchandiseBrand> mbList=merchandiseBrandService.geteBrandList();
		Map<String, String> brandMap=new LinkedHashMap<String, String>();
		if(null != mbList && !mbList.isEmpty())
		{
			for(MerchandiseBrand brand:mbList)
			{
				brandMap.put(brand.getId(), brand.getName());
			}
		}
		model.addAttribute("brandMap", brandMap);
		model.addAttribute("typeMap", typeMap);
		
		return "page/shop/merchandise/product/add";
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
	 * 新增
	 * @param request
	 * @param response
	 * @param 
	 */
	@RequestMapping(value = "/insertMerchandiseProduct")
	public void insertMerchandiseProduct(HttpServletRequest request,HttpServletResponse response,MerchandiseProduct merchandiseProduct){
		response.setContentType("text/html;charset=utf-8"); //指定输出内容类型和编码
        try{
        	boolean isValid = false;         	
        	merchandiseProduct.setId(UUID.randomUUID().toString().replace("-", ""));
        	merchandiseProduct.setUpdate_time(new Date());
        	merchandiseProduct.setCreate_time(new Date());
        	MultipartFile uploadFile1 =  merchandiseProduct.getProductAssemblyImageListStoreFile();
        	MultipartFile uploadFile2 =  merchandiseProduct.getProductDetailImageListStoreFile(); 
        	MultipartFile uploadFile3 =  merchandiseProduct.getProductEntiretyImageListStoreFile(); 
        	MultipartFile uploadFile4 =  merchandiseProduct.getProductImageListStoreFile(); 
            merchandiseProduct.setProductAssemblyImageListStore(saveFile(uploadFile1));
            merchandiseProduct.setProductDetailImageListStore(saveFile(uploadFile2));
            merchandiseProduct.setProductEntiretyImageListStore(saveFile(uploadFile3));
            merchandiseProduct.setProductImageListStore(saveFile(uploadFile4));	       
        	merchandiseProductService.insertMerchandiseProduct(merchandiseProduct);
        	isValid = true;
        	response.getWriter().print(JSONArray.fromObject(isValid));
        }catch(Exception ex){
        	log.info(ex);
        	log.error(ex);
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
	@RequestMapping(value = "/editMerchandiseProduct")
	public String editMerchandiseProduct(ModelMap model,HttpServletRequest request,HttpServletResponse response)
	{
		try {
			MerchandiseProduct merchandiseProduct=merchandiseProductService.selectCheckId(request.getParameter("id"));
			model.put("merch", merchandiseProduct);
			MerchandiseCategories me=merchandiseCategoriesService.selectCheckId(merchandiseProduct.getProductcategory_id());
			model.put("me", me);
			List<MerchandiseType> mtList=merchandiseTypeService.getTypeList();
			Map<String, String> typeMap=new LinkedHashMap<String, String>();
			if(null != mtList && !mtList.isEmpty())
			{
				for(MerchandiseType type:mtList)
				{
					typeMap.put(type.getId(), type.getName());
				}
			}
			List<MerchandiseBrand> mbList=merchandiseBrandService.geteBrandList();
			Map<String, String> brandMap=new LinkedHashMap<String, String>();
			if(null != mbList && !mbList.isEmpty())
			{
				for(MerchandiseBrand brand:mbList)
				{
					brandMap.put(brand.getId(), brand.getName());
				}
			}
			model.addAttribute("brandMap", brandMap);			
			model.addAttribute("typeMap", typeMap);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "page/shop/merchandise/product/edit";
	}
	/**
	 * 修改
	 * @param request
	 * @param response
	 * @param Catalog
	 */
	@RequestMapping(value = "/updateMerchandiseProduct")
	public void updateMerchandiseProduct(HttpServletRequest request,HttpServletResponse response,MerchandiseProduct merchandiseProduct){
		response.setContentType("text/html;charset=utf-8"); //指定输出内容类型和编码
        try{
        	boolean isValid = false;
        	merchandiseProduct.setId(merchandiseProduct.getId());
        	merchandiseProduct.setUpdate_time(new Date());
        	MultipartFile uploadFile1 =  merchandiseProduct.getProductAssemblyImageListStoreFile();
        	MultipartFile uploadFile2 =  merchandiseProduct.getProductDetailImageListStoreFile(); 
        	MultipartFile uploadFile3 =  merchandiseProduct.getProductEntiretyImageListStoreFile(); 
        	MultipartFile uploadFile4 =  merchandiseProduct.getProductImageListStoreFile();          	
            String file1=uploadFile1.getOriginalFilename();
            String file2=uploadFile2.getOriginalFilename();
            String file3=uploadFile3.getOriginalFilename();
            String file4=uploadFile4.getOriginalFilename();
            if ( null != file1 && !"".equals(file1) ) 
            {
            	 merchandiseProduct.setProductAssemblyImageListStore(saveFile(uploadFile1));
            }
            if ( null != file2 && !"".equals(file2) ) 
            {
            	merchandiseProduct.setProductDetailImageListStore(saveFile(uploadFile2));
            }
            if ( null != file3 && !"".equals(file3) ) 
            {
            	merchandiseProduct.setProductEntiretyImageListStore(saveFile(uploadFile3));
            }
            if ( null != file4 && !"".equals(file4) ) 
            {
            	 merchandiseProduct.setProductImageListStore(saveFile(uploadFile4));	 
            }
        	merchandiseProductService.updateMerchandiseProduct(merchandiseProduct);        	
        	isValid = true;
        	response.getWriter().print(JSONArray.fromObject(isValid));
        }catch(Exception ex){
        	log.info(ex);
        	log.error(ex);
            ex.printStackTrace();
        }
	}
	
	/**
	 * 删除
	 * @param request
	 * @param response	
	 */
	@RequestMapping(value = "/deleteMerchandiseProduct")
	public void deleteMerchandiseProduct(HttpServletRequest request,HttpServletResponse response,MerchandiseProduct merchandiseProduct){
		response.setContentType("text/html;charset=utf-8"); //指定输出内容类型和编码
        try{
        	boolean isValid = false;
        	merchandiseProductService.deleteById(merchandiseProduct.getId());        
        	isValid = true;
        	response.getWriter().print(JSONArray.fromObject(isValid));
        }catch(Exception ex){
            ex.printStackTrace();
        }
	}
    @SuppressWarnings("unused")
	private String saveFile(MultipartFile uploadFile)
    {
    	   String uploadPath = ImageUtil.getSaveAttachmentFilePath(Constants.CLOUD_SHOP_FILE);
	        File uploadPathFile = new File(uploadPath);
	        if(!uploadPathFile.exists()){
	        	uploadPathFile.mkdir();
	        }
	        String expandedName = ""; // 文件扩展名
	       
	        String uploadContentType = uploadFile.getContentType();
	        if (uploadContentType.equals("image/pjpeg") || uploadContentType.equals("image/jpeg")) {  
	            // IE6上传jpg图片的headimageContentType是image/pjpeg，而IE9以及火狐上传的jpg图片是image/jpeg  
	            expandedName = ".jpg";  
	        } else if (uploadContentType.equals("image/png") || uploadContentType.equals("image/x-png")) {  
	            // IE6上传的png图片的headimageContentType是"image/x-png"  
	            expandedName = ".png";  
	        } else if (uploadContentType.equals("image/gif")) {  
	            expandedName = ".gif";  
	        } else if (uploadContentType.equals("image/bmp")) {  
	            expandedName = ".bmp";  
	        }
	        
	        String fileName = java.util.UUID.randomUUID().toString().replace("-", ""); // 采用UUID的方式命名保证不会重复  
	        fileName += expandedName;  
	        File targetFile = new File(uploadPath, fileName);
	        
	        //保存  
	        try {
				uploadFile.transferTo(targetFile);
			} catch (IllegalStateException | IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}  
	        
	        String tempImageUrl = uploadPath + File.separator + fileName;
	        String imageUrl =  this.getUrl(tempImageUrl).replace("\\", "/");
	        
	        return imageUrl;
    }
	
	private String getUrl(String imageUrl){
		int num = imageUrl.indexOf("webapps");
		return imageUrl.substring(num+7, imageUrl.length());
	}
}
