package cloud.app.commodity.controller;



import java.io.File;
import java.io.IOException;
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
import org.springframework.web.multipart.MultipartFile;

import cloud.app.commodity.model.Brand;

import cloud.app.commodity.service.BrandService;




@Controller
@RequestMapping("/admin/band")
public class BrandController {
	
	Logger log = Logger.getLogger(this.getClass());
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
		Brand brand=new Brand();
		brand.setPageIndex(0);
		brand.setPageSize(20);
		List<Brand> list=brandService.getList(brand);
		Integer total=brandService.count(brand);
		Integer count=((total%brand.getPageSize())==0)?total/brand.getPageSize():(total/brand.getPageSize()+1);//最大页数
		Integer p_begin=0;
		if(brand.getPageIndex()>1){
			p_begin=brand.getPageIndex()+1-2;
		}else{
			p_begin=1;
		}
		Integer p_end=0;
		if(count<5){
			p_end=5;
		}else{
			p_end=p_begin+4;
		}
		brand.setTotal(total);
		brand.setRows(list);
		brand.setPageMax(count);
		model.addAttribute("brand", brand);
		model.addAttribute("total", total);
		model.addAttribute("p_begin", p_begin);
		model.addAttribute("p_end", p_end);
		return "page/commodity/brand/list";
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
	public String toSearch(ModelMap model,HttpServletRequest request,HttpServletResponse response,Brand brand) throws Exception
	{
		brand.setPageIndex((Integer.parseInt(request.getParameter("pageNumber"))-1));
		brand.setPageSize(Integer.parseInt(request.getParameter("pageSize")));
		Brand pt=new Brand();
		String searchProperty=request.getParameter("searchProperty");
		if(!searchProperty.isEmpty()&&!"".equals(searchProperty)){
			String searchValue=request.getParameter("searchValue");
			if("brand_name".equals(searchProperty)){
				pt.setBrand_name(searchValue);
			}else if("url".equals(searchProperty)){
				pt.setUrl(searchValue);
			}
		}
		//asc desc
		String orderProperty=request.getParameter("orderProperty");
		if(!orderProperty.isEmpty()&&!"".equals(orderProperty)){
			String orderDirection=request.getParameter("orderDirection");
			pt.setStringAsc(orderProperty+" "+orderDirection);
		}
		pt.setPageIndex(brand.getPageIndex()*brand.getPageSize());
		pt.setPageSize(brand.getPageSize());
		List<Brand> list=brandService.getList(pt);
		Integer total=brandService.count(pt);
		Integer count=((total%brand.getPageSize())==0)?total/brand.getPageSize():(total/brand.getPageSize()+1);//最大页数
		Integer p_begin=0;
		if(brand.getPageIndex()+1>2){
			p_begin=brand.getPageIndex()+1-2;
		}else{
			p_begin=1;
		}
		Integer p_end=0;
		if(count<5){
			p_end=5;
		}else{
			p_end=p_begin+4;
		}
		brand.setTotal(total);
		brand.setRows(list);
		brand.setPageMax(count);
		model.addAttribute("brand", brand);
		model.addAttribute("total", total);
		model.addAttribute("p_begin", p_begin);
		model.addAttribute("p_end", p_end);
		return "page/commodity/brand/list";
	}
	/**
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/toAdd")
	public String toAdd(HttpServletRequest request,HttpServletResponse response){
		return "page/commodity/brand/add";
	}
	
	
	/**
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/save")
	public String save(HttpServletRequest request,HttpServletResponse response,Brand brand,ModelMap model) throws Exception{
		  brand.setId(UUID.randomUUID().toString().replace("-", ""));
		  brand.setCreate_time(new Date());
		  brand.setCreate_user(request.getSession().getAttribute("username").toString());
		  brand.setUpdate_time(new Date());
		  brand.setUpdate_user(request.getSession().getAttribute("username").toString());			  
		  MultipartFile fileUrl =  brand.getFile(); 
	
		  String file1=fileUrl.getOriginalFilename();
		     if ( null != file1 && !"".equals(file1) ) {
		    	 brand.setLogo(saveFile(fileUrl));
		     }else{
		    	 brand.setLogo("#"); 
		     } 
		 
		  brandService.save(brand);	
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
		Brand brand=brandService.getObjById(id);
		model.addAttribute("brand", brand);
		return "page/commodity/brand/edit";
	}
	
	
	/**
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/edit")
	public String edit(HttpServletRequest request,HttpServletResponse response,Brand brand,ModelMap model) throws Exception{
		
		  brand.setUpdate_user(request.getSession().getAttribute("username").toString());
		  MultipartFile fileUrl =  brand.getFile();
		  String file1=fileUrl.getOriginalFilename();
		     if ( null != file1 && !"".equals(file1) ) {
		    	 brand.setLogo(saveFile(fileUrl));
		     } 
		  brandService.update(brand);
		  return toList(model,request,response);
	}
	
	/**
	 * 删除
	 * @param request
	 * @param response
	 */
	@RequestMapping(value = "/deleteBrandById")
	public void deleteBrandById(HttpServletRequest request,HttpServletResponse response){
		response.setContentType("text/html;charset=utf-8"); //指定输出内容类型和编码
        try{
        	boolean isValid = false;
             String[] ids=request.getParameterValues("ids"); 
             brandService.deleteByIdS(ids);
        	isValid = true;
        	response.getWriter().print(JSONArray.fromObject(isValid));
        }catch(Exception e){
        	log.debug(e);
        }
	}

	
	
		private String saveFile(MultipartFile uploadFile)
	    {
	    	   String uploadPath = cloud.app.common.ImageUtil.getSaveAttachmentFilePath(cloud.app.common.Constants.CLOUD_CSBS_FILE);
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
