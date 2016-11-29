package cloud.app.commodity.service.impl;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import cloud.app.commodity.dao.AttrProductDAO;
import cloud.app.commodity.dao.ParametersGroupDAO;
import cloud.app.commodity.dao.ProductAttributesDAO;
import cloud.app.commodity.dao.ProductCategoryDAO;
import cloud.app.commodity.dao.ProductDAO;
import cloud.app.commodity.dao.ProductParametersDAO;
import cloud.app.commodity.dao.ProductPictureDAO;
import cloud.app.commodity.dao.SpecificationManagementDAO;
import cloud.app.commodity.model.Product;
import cloud.app.commodity.model.ProductPicture;
import cloud.app.commodity.model.ProductVO;
import cloud.app.commodity.service.AttrProductService;
import cloud.app.commodity.service.ParametersGroupService;
import cloud.app.commodity.service.ProductConditionService;
import cloud.app.commodity.service.ProductPictureService;
import cloud.app.commodity.service.ProductService;
@Service
public class ProductConditionServiceImpl implements ProductConditionService {
	
	 private SimpleDateFormat sf = new SimpleDateFormat("yyyyMMddHHmmss");
	 @Autowired
	private ParametersGroupService parametersGroupService;
	@Autowired
	private AttrProductService attrProductService;
	@Autowired
	private ProductPictureService productPictureService;
	
	
	@Autowired
	private ProductParametersDAO productParametersDAO;
	@Autowired
	private ProductAttributesDAO productAttributesDAO;
	@Autowired
	private SpecificationManagementDAO specificationManagementDAO;
	@Autowired
	private ProductService productService;

	@Override
	public void save(ProductVO productVO) throws Exception {
		String mainId=UUID.randomUUID().toString().replace("-", "");
		//商品表添加数据【主表】	
		productVO.setId(mainId);
		if(null ==productVO.getProduct_no() || "".equals(productVO.getProduct_no())){
			productVO.setProduct_no(sf.format(new Date()));
		}
		MultipartFile fileUrl =  productVO.getFile(); 
		 String file1=fileUrl.getOriginalFilename();
	     if ( null != file1 && !"".equals(file1) ) {
	    	 productVO.setPicture(saveFile(productVO.getFile()));
	     }
	     productService.saveVO(productVO);
		//商品图片添加数据【子表】
		if(null !=productVO.getProductImages() && productVO.getProductImages().length>0){
			for(ProductPicture p:productVO.getProductImages()){
				p.setId(UUID.randomUUID().toString().replace("-", ""));
				p.setProduct_id(mainId);
				MultipartFile filePImg =  p.getFile(); 
				 String filP=filePImg.getOriginalFilename();
			     if ( null != filP && !"".equals(filP) ) {
			    	 p.setFile_url(saveFile(p.getFile()));
			     }
			     p.setCreate_time(new Date());
			     p.setUpdate_time(new Date());
			     p.setCreate_user(productVO.getCreate_user());
			     p.setUpdate_user(productVO.getUpdate_user());
			     productPictureService.save(p);
			}
		}
		//商品参数表添加数据【子表】
		
		//商品属性表添加数据【子表】
		
		//商品规格表添加数据【子表】

	}

	@Override
	public void update(ProductVO productVO) throws Exception {
		//更新主表[商品表]
		productService.updateVO(productVO);
		//更新子表，先判断子表id是否有，如果没有就新增，有则修改。[商品图片]
		if(null !=productVO.getProductImages() && productVO.getProductImages().length>0){
			for(ProductPicture p:productVO.getProductImages()){
				if(null==p.getId() || "".equals(p.getId())){
					p.setId(UUID.randomUUID().toString().replace("-", ""));
					p.setProduct_id(productVO.getId());
					MultipartFile filePImg =  p.getFile(); 
					 String filP=filePImg.getOriginalFilename();
				     if ( null != filP && !"".equals(filP) ) {
				    	 p.setFile_url(saveFile(p.getFile()));
				     }
				     p.setCreate_time(new Date());
				     p.setUpdate_time(new Date());
				     p.setCreate_user(productVO.getCreate_user());
				     p.setUpdate_user(productVO.getUpdate_user());
				}else{
					productPictureService.update(p);
				}
			}
		}
		
		//商品参数表修改数据【子表】
		
		//商品属性表修改数据【子表】
				
		//商品规格表修改数据【子表】

	}

	@Override
	public void deleteByIdS(String[] ids) throws Exception {
	  //先删掉主表的数据。
		productService.deleteByIdS(ids);
	 //子表数据删除	
       productPictureService.deleteByIdS(ids);
		//商品参数表删除数据【子表】
		
		//商品属性表删除数据【子表】
				
		//商品规格表删除数据【子表】
	}
	
/**
 * 上传图片到服务器，并把上传的文件名返回。	
 * @param uploadFile
 * @return
 */
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
