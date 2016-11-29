package cloud.shop.merchandise.controller;


import java.io.File;

import java.io.PrintWriter;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.databind.ObjectMapper;

import cloud.shop.common.Constants;

import cloud.shop.common.ImageUtil;

import cloud.shop.merchandise.entity.MerchandiseBrand;
import cloud.shop.merchandise.service.MerchandiseBrandService;
import cloud.shop.system.vo.SysUserVO;







@Controller
@RequestMapping("/admin/brand")
public class MerchandiseBrandController {
  
	Logger log=Logger.getLogger(MerchandiseBrandController.class);
	
	@Autowired
	private MerchandiseBrandService merchandiseBrandService;
	
	
	@RequestMapping(value = "/list")
	public String showForm(ModelMap model) {
		return "page/shop/merchandise/brand/list";
	}
	
	/**
	 * 分页返回用户列表
	 */
	@RequestMapping(value = "/listMerchandisebrand")
	public void listMerchandisebrand(HttpServletRequest request,
			HttpServletResponse response,
			@RequestParam(required = false, defaultValue = "1") Integer page,
			@RequestParam(required = false, defaultValue = "15") Integer rows,
			MerchandiseBrand merchandiseBrand) {
		response.setContentType("text/html;charset=utf-8"); // 指定输出内容类型和编码
		try {
			PrintWriter out = response.getWriter();// 获取输出口		
			merchandiseBrand.setPageIndex((page - 1) * rows);
			merchandiseBrand.setPageSize(rows);
			List<MerchandiseBrand> list = merchandiseBrandService.getMerchandiseBrandList(merchandiseBrand);
			int total = merchandiseBrandService.merchandiseBrandCount(merchandiseBrand);
			merchandiseBrand.setTotal(total);
			merchandiseBrand.setRows(list);
			// 获取分页返回的数据,格式化数据并返回JSON
			ObjectMapper mapper = new ObjectMapper();
			out.write(mapper.writeValueAsString(merchandiseBrand));
			out.flush();
			out.close();
		} catch (Exception ex) {
			log.error(ex);
			log.info(ex);
			ex.printStackTrace();
		}
	}
	
	
	/**
	 * 指向add界面。
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/addMerchandiseBrand")
	public String addMerchandiseBrand(ModelMap model)
	{
		return "page/shop/merchandise/brand/add";
	}
	 
	/**
	 *验证分类名称的重复
	 */
	@RequestMapping(value = "/verDataIsEffectivenes")
	public void verDataIsEffectivenes(HttpServletRequest request,
			HttpServletResponse response,
			MerchandiseBrand merchandiseBrand) {
		response.setContentType("text/html;charset=utf-8"); // 指定输出内容类型和编码
		try {
			boolean isValid = false;
			if(null != merchandiseBrand.getName() && !"".equals(merchandiseBrand.getName()))
			{
				int total = merchandiseBrandService.isEffectivenes(merchandiseBrand);	
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
	 * @param role
	 */
	@RequestMapping(value = "/insertMerchandiseBrand")
	public void insertMerchandiseBrand(HttpServletRequest request,HttpServletResponse response,MerchandiseBrand merchandiseBrand){
		response.setContentType("text/html;charset=utf-8"); //指定输出内容类型和编码
        try{
        	boolean isValid = false;
        	merchandiseBrand.setId(UUID.randomUUID().toString().replace("-", ""));//权限编号
        	SysUserVO user = (SysUserVO)request.getSession().getAttribute(Constants.SESSION_LOGIN_USER);//将用户信息放入session
        	merchandiseBrand.setCreate_user(user.getUserCode());
        	merchandiseBrand.setUpdate_user(user.getUserCode());
        	MultipartFile uploadFile =  merchandiseBrand.getLogoPhoto(); 
        
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
	        uploadFile.transferTo(targetFile);  
	        
	        String tempImageUrl = uploadPath + File.separator + fileName;
	        String imageUrl =  this.getUrl(tempImageUrl).replace("\\", "/");


	        merchandiseBrand.setLogo(imageUrl);
        	merchandiseBrandService.insertMerchandiseBrand(merchandiseBrand);
        	isValid = true;
        	response.getWriter().print(JSONArray.fromObject(isValid));
        }catch(Exception ex){
        	log.info(ex);
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
	@RequestMapping(value = "/editMerchandiseBrand")
	public String editMerchandiseBrand(ModelMap model,HttpServletRequest request,HttpServletResponse response)
	{
		try {
			MerchandiseBrand merchandiseBrand=merchandiseBrandService.selectCheckId(request.getParameter("id"));
			model.put("merch", merchandiseBrand);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "page/shop/merchandise/brand/edit";
	}
	
	/**
	 * 修改
	 * @param request
	 * @param response
	 * @param Catalog
	 */
	@RequestMapping(value = "/updateMerchandiseBrand")
	public void updateMerchandiseBrand(HttpServletRequest request,HttpServletResponse response,MerchandiseBrand merchandiseBrand){
		response.setContentType("text/html;charset=utf-8"); //指定输出内容类型和编码
        try{
        	boolean isValid = false;
        	SysUserVO user = (SysUserVO)request.getSession().getAttribute(Constants.SESSION_LOGIN_USER);//将用户信息放入session       
        	MultipartFile uploadFile =  merchandiseBrand.getLogoPhoto();         	
            String file=uploadFile.getOriginalFilename();
			if ( null != file && !"".equals(file) ) 
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
			        uploadFile.transferTo(targetFile);  			        
			        String tempImageUrl = uploadPath + File.separator + fileName;
			        String imageUrl =  this.getUrl(tempImageUrl).replace("\\", "/");
			        merchandiseBrand.setLogo(imageUrl);
			}
        	
        	merchandiseBrand.setUpdate_user(user.getUserCode());
        	merchandiseBrand.setId(merchandiseBrand.getId());        
        	merchandiseBrandService.updateMerchandiseBrand(merchandiseBrand);
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
	@RequestMapping(value = "/deleteMerchandiseBrand")
	public void deleteMerchandiseBrand(HttpServletRequest request,HttpServletResponse response,MerchandiseBrand merchandiseBrand){
		response.setContentType("text/html;charset=utf-8"); //指定输出内容类型和编码
        try{
        	boolean isValid = false;
        	merchandiseBrandService.deleteById(merchandiseBrand.getId());        
        	isValid = true;
        	response.getWriter().print(JSONArray.fromObject(isValid));
        }catch(Exception ex){
            ex.printStackTrace();
        }
	}

	
	
	private String getUrl(String imageUrl){
		int num = imageUrl.indexOf("webapps");
		return imageUrl.substring(num+7, imageUrl.length());
	}

}
