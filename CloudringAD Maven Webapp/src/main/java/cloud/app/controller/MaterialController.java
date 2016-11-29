package cloud.app.controller;

import it.sauronsoftware.jave.Encoder;
import it.sauronsoftware.jave.MultimediaInfo;

import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import com.alibaba.fastjson.JSONObject;

import cloud.app.common.Constants;
import cloud.app.common.EnumtTextType;
import cloud.app.common.OpenOffice2PDF;
import cloud.app.common.ReadResolution;
import cloud.app.common.StringUtil;
import cloud.app.entity.Material;
import cloud.app.entity.MaterialType;
import cloud.app.service.MaterialService;
import cloud.app.service.MaterialTypeService;
import cloud.app.system.service.DepartmentService;
import cloud.app.system.vo.SysUserVO;

@Controller
@RequestMapping("/material")
public class MaterialController {
	Logger logger = Logger.getLogger(this.getClass());
	@Autowired
	private MaterialService materialService;
	@Autowired
	private MaterialTypeService materialTypeService;
	@Autowired
	private DepartmentService departmentService;
	
	/**
	 * 初始化界面
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/toList")
	public String toList(ModelMap model,HttpServletRequest request,HttpServletResponse response) throws Exception
	{
		List<String> listMenuId = departmentService.getDepartmentIds(request);
		String departIds = "";
	 	for(int i=0;i<listMenuId.size();i++){
	 		String id = listMenuId.get(i);
	 		departIds+=id;
            if(listMenuId.size()-1!=i){
            	departIds+=",";
            }
        }
		
		Material material=new Material();
		SysUserVO user=(SysUserVO) request.getSession().getAttribute(Constants.SESSION_LOGIN_USER);
		material.setUser_id(user.getId());
		material.setDepartment_id(departIds);
        material.setPageNumber(1);
		material.setPageSize(10);
		material.setPageIndex((material.getPageNumber()-1)*material.getPageSize());
		String typeId = request.getParameter("typeId");
		String typePId = request.getParameter("typePId");
		MaterialType materialType = new MaterialType();
		materialType.setId(typeId);
		if(StringUtils.isEmpty(typePId))
			materialType.setpId(typeId);
		else if(typePId.equals("0"))
			materialType.setpId(typeId);
		else
			materialType.setpId(typeId);
		
		String mTypeIds = "";
	 	List<MaterialType> materialTypes=materialTypeService.getTypeTreeList(materialType);
	 	for(int i=0;i<materialTypes.size();i++){
	 		MaterialType type = materialTypes.get(i);
	 		mTypeIds+=type.getId();
            if(materialTypes.size()-1!=i){
            	mTypeIds+=",";
            }
        }
	 	material.setMaterial_type(mTypeIds);
		List<Material> mList=materialService.getList(material);
		Integer total=materialService.count(material);
		material.setTotal(total);
		Integer count=((total%material.getPageSize())==0)?total/material.getPageSize():(total/material.getPageSize()+1);//最大页数			
		material.setTotal(total);
		material.setRows(mList);
		material.setPageMax(count);
	 	model.addAttribute("material", material);
	 	model.addAttribute("typeId", typeId);
	 	//素材分类显示下拉框
	 	MaterialType mt = new MaterialType();
	 	mt.setpId(Constants.PARENT_ID);
	 	List<MaterialType> types=materialTypeService.getTypeList(mt);
	 	List<MaterialType> trees=materialTypeService.getTypeTreeList(null);
	 	
	 	for (MaterialType type : trees) {
			if(Constants.PARENT_ID.equals(type.getpId())){
				type.setParentCheck(true);//最顶级父节点不显示复选框
			}
		}
	 	
	 	String jsonTree = com.alibaba.fastjson.JSONArray.toJSONString(trees).replaceAll("parentCheck", "nocheck").replace("[", "").replace("]", "");
	 	String jsonNodes = "[{'id':'" + Constants.PARENT_ID + "','name':'" + Constants.MATERIAL_PARENT_NAME + "','open':true,'nocheck':true},"+jsonTree+"]";//最顶级菜单
	 	model.addAttribute("mList", jsonNodes.replaceAll("'", "\""));
	 	model.addAttribute("types", types);
		return "page/material/material/list";
	}
	
	@RequestMapping(value = "/toSearch")
	public String toSearch(ModelMap model,HttpServletRequest request,HttpServletResponse response,Material material) throws Exception
	{
		List<String> listMenuId = departmentService.getDepartmentIds(request);
		String departIds = "";
	 	for(int i=0;i<listMenuId.size();i++){
	 		String id = listMenuId.get(i);
	 		departIds+=id;
            if(listMenuId.size()-1!=i){
            	departIds+=",";
            }
        }
		
		SysUserVO user=(SysUserVO) request.getSession().getAttribute(Constants.SESSION_LOGIN_USER);
		material.setUser_id(user.getId());
		material.setDepartment_id(departIds);
		material.setPageIndex((material.getPageNumber()-1)*material.getPageSize());
		String typeId = request.getParameter("typeId");
		String typePId = request.getParameter("typePId");
		MaterialType materialType = new MaterialType();
		materialType.setId(typeId);
		if(StringUtils.isEmpty(typePId))
			materialType.setpId(typeId);
		else if(typePId.equals("0"))
			materialType.setpId(typeId);
		else
			materialType.setpId(typeId);
		
		String mTypeIds = "";
	 	List<MaterialType> materialTypes=materialTypeService.getTypeTreeList(materialType);
	 	for(int i=0;i<materialTypes.size();i++){
	 		MaterialType type = materialTypes.get(i);
	 		mTypeIds+=type.getId();
            if(materialTypes.size()-1!=i){
            	mTypeIds+=",";
            }
        }
	 	material.setMaterial_type(mTypeIds);
		List<Material> mList=materialService.getList(material);
		Integer total=materialService.count(material);
		material.setTotal(total);
		Integer count=((total%material.getPageSize())==0)?total/material.getPageSize():(total/material.getPageSize()+1);//最大页数			
		material.setTotal(total);
		material.setRows(mList);
		material.setPageMax(count);
	 	model.addAttribute("material", material);
	 	model.addAttribute("typeId", typeId);
	 	//素材分类显示下拉框
	 	MaterialType mt = new MaterialType();
	 	mt.setpId(Constants.PARENT_ID);
	 	List<MaterialType> types=materialTypeService.getTypeList(mt);
	 	List<MaterialType> trees=materialTypeService.getTypeTreeList(null);
	 	
	 	for (MaterialType type : trees) {
			if(Constants.PARENT_ID.equals(type.getpId())){
				type.setParentCheck(true);//最顶级父节点不显示复选框
			}
		}
	 	
	 	String jsonTree = com.alibaba.fastjson.JSONArray.toJSONString(trees).replaceAll("parentCheck", "nocheck").replace("[", "").replace("]", "");
	 	String jsonNodes = "[{'id':'" + Constants.PARENT_ID + "','name':'" + Constants.MATERIAL_PARENT_NAME + "','open':true,'nocheck':true},"+jsonTree+"]";//最顶级菜单
	 	model.addAttribute("mList", jsonNodes.replaceAll("'", "\""));
	 	model.addAttribute("types", types);
		return "page/material/material/list";
	}
	
	//添加修改素材节点
	@RequestMapping(value = "/update_material")
	public void update_material(HttpServletRequest request,HttpServletResponse response){
		response.setContentType("text/html;charset=utf-8"); //指定输出内容类型和编码
		List<MaterialType> treeList = null;
        try{
        	String id = request.getParameter("id");
			String pId = request.getParameter("pId");
			String name = request.getParameter("name");
			String type = request.getParameter("type");
			
			MaterialType mType = new MaterialType();

			if(pId == null || "null".equals(pId) || "".equals(pId)){
				pId = "0";
			}
			
			mType.setpId(pId);
			mType.setName(name);
			mType.setType(type);
			
			if(id == null || "null".equals(id) || "".equals(id)){
				mType.setId(StringUtil.getUUID());
				materialTypeService.save(mType);
			}else{
				mType.setId(id);
				materialTypeService.update(mType);
			}
			treeList = materialTypeService.getTypeTreeList(null);
        	response.getWriter().print(com.alibaba.fastjson.JSONArray.toJSONString(treeList));
        }catch(Exception ex){
            ex.printStackTrace();
        }
	}
	
	//删除素材节点
	@RequestMapping(value = "/delete_material")
	public void delete_material(HttpServletRequest request,HttpServletResponse response) throws IOException{
		response.setContentType("text/html;charset=utf-8"); //指定输出内容类型和编码
		boolean isValid = false;
        try{
        	String typeIds = request.getParameter("typeIds");
        	Map<String, Object> map = new HashMap<String, Object>();
    		map.put("ids", typeIds.split(","));
    		try {
    			materialTypeService.deleteByIds(map);
    			isValid = true;
    		} catch (Exception e) {
    			logger.error(e.getMessage());
    		}
        	
        }catch(Exception ex){
            ex.printStackTrace();
        }
        response.getWriter().print(JSONArray.fromObject(isValid));
	}
	
	/**
	 * 制作界面查询
	 * 
	 * @param request
	 * @param response
	 */
	@RequestMapping(value = "/search")
	public void search(HttpServletRequest request,HttpServletResponse response) {
		response.setContentType("text/html;charset=utf-8"); // 指定输出内容类型和编码
		try {
		    String name=request.getParameter("name");
		    String type=request.getParameter("type");
		    if(EnumtTextType.VIDEO.getValues().equals(type)){
		    	type=materialTypeId(EnumtTextType.VIDEO.getValues());
		    }else if(EnumtTextType.IMAGE.getValues().equals(type)){
		    	type=materialTypeId(EnumtTextType.IMAGE.getValues());
		    }else if(EnumtTextType.DOC.getValues().equals(type)){
		    	type=materialTypeId(EnumtTextType.DOC.getValues());
		    }
			List<String> listMenuId = departmentService.getDepartmentIds(request);
			String departIds = "";
		 	for(int i=0;i<listMenuId.size();i++){
		 		String id = listMenuId.get(i);
		 		departIds+=id;
	            if(listMenuId.size()-1!=i){
	            	departIds+=",";
	            }
	        }
		    
		    Material material=new Material();
		    material.setName(name);
		    material.setMaterial_type(type);
		    material.setPageSize(Integer.MAX_VALUE);
		    material.setPageIndex(0);
		    material.setDepartment_id(departIds);
		    List<Material> list=materialService.getList(material);
			response.getWriter().print(JSONArray.fromObject(list));
		} catch (Exception e) {
			e.printStackTrace();
			logger.debug(e);
		}
	}

	@RequestMapping(value = "/searchTree")
	public void searchTree(HttpServletRequest request,HttpServletResponse response) {
		response.setContentType("text/html;charset=utf-8"); // 指定输出内容类型和编码
		try {	
			Map<String,Object> jsonMap = new HashMap<String, Object>();
		    MaterialType material=new MaterialType();
		    material.setType(EnumtTextType.VIDEO.getValues());
		    List<MaterialType> listVideo=materialTypeService.getTypeList(material);
		    jsonMap.put("video", listVideo);
		    
		    material.setType(EnumtTextType.IMAGE.getValues());
		    List<MaterialType> listImage=materialTypeService.getTypeList(material);
		    jsonMap.put("image", listImage);
		    
		    material.setType(EnumtTextType.DOC.getValues());
		    List<MaterialType> listDoc=materialTypeService.getTypeList(material);
		    jsonMap.put("doc", listDoc);
		    
			response.getWriter().print(JSONArray.fromObject(jsonMap));
		} catch (Exception e) {
			e.printStackTrace();
			logger.debug(e);
		}
	}
	
	/**
	 * 制作界面查询
	 * 
	 * @param request
	 * @param response
	 */
	@RequestMapping(value = "/treeSearch")
	public void treeSearch(HttpServletRequest request,HttpServletResponse response) {
		response.setContentType("text/html;charset=utf-8"); // 指定输出内容类型和编码
		try {
		    String type=request.getParameter("type");
			List<String> listMenuId = departmentService.getDepartmentIds(request);
			String departIds = "";
		 	for(int i=0;i<listMenuId.size();i++){
		 		String id = listMenuId.get(i);
		 		departIds+=id;
	            if(listMenuId.size()-1!=i){
	            	departIds+=",";
	            }
	        }
		    
		    Material material=new Material();		   
		    material.setMaterial_type(type);
		    material.setPageSize(Integer.MAX_VALUE);
		    material.setPageIndex(0);
		    material.setDepartment_id(departIds);
		    List<Material> list=materialService.getList(material);
			response.getWriter().print(JSONArray.fromObject(list));
		} catch (Exception e) {
			e.printStackTrace();
			logger.debug(e);
		}
	}

	
	@RequestMapping(value = "/saveFile.do")
	public void saveFile(HttpServletRequest request,HttpServletResponse response, Material material, ModelMap model) throws IOException{
		JSONObject obj = new JSONObject();
		try {
			String type = request.getParameter("materialType");
		    material.setId(UUID.randomUUID().toString().replace("-", ""));
		    SysUserVO user=(SysUserVO) request.getSession().getAttribute(Constants.SESSION_LOGIN_USER);
		    material.setUser_id(user.getId());
		    material.setDepartment_id(user.getDepartmentid());//机构ID
		    material.setUpload_time(new Date());
		    material.setCreate_user(user.getUserCode());
		    material.setMaterial_type(type);
		    MultipartFile fileUrl =  material.getFile();
		    long size=fileUrl.getSize();
		    material.setFile_size(bytes2kb(size));
		    String file1=fileUrl.getOriginalFilename();
		     if ( null != file1 && !"".equals(file1) ) {
		    	 String suffix=file1.substring(file1.indexOf("."), file1.length());		    	
		    	 material.setName(file1);
		    	 MaterialType mt = new MaterialType();
		    	 mt.setId(type);
		    	 List<MaterialType> listM=materialTypeService.getTypeList(mt);
		    	 mt=listM.get(0);
		    	 String path=saveFile(fileUrl,mt.getType());
		    	 String binPath=System.getProperty("user.dir");	
		    	 String tempdir = binPath.replace("bin", "webapps");
		    	 String filePath=tempdir+path;
		    	 
		    	 if(mt.getType().equals(EnumtTextType.IMAGE.getValues())){
		    		 material.setPixels(ReadResolution.getResolution1(new File(filePath)));
		    	 }
		    	 else if(mt.getType().equals(EnumtTextType.VIDEO.getValues())){
		    		 File source=new File(filePath);
		    		 Encoder encoder = new Encoder();		    		
    	             MultimediaInfo m = encoder.getInfo(source);
    	             long ls = m.getDuration();
    	             material.setVideo_play_time( new BigDecimal(ls/1000).toString());    	         
		    	      int width=m.getVideo().getSize().getWidth();
		    	      int height=m.getVideo().getSize().getHeight();		    	      
		    	     material.setPixels(String.valueOf(width+"*"+height));
		    	 }
		    	 if(mt.getType().equals(EnumtTextType.DOC.getValues())){ 
		    		 if(".pdf".equalsIgnoreCase(suffix)){		    			
		    			 material.setFile_path(path);
		    		 }else{		    			
		    			 OpenOffice2PDF office2pdf = new OpenOffice2PDF();
		    			 boolean flag=office2pdf.openOffice2Pdf(filePath, filePath.substring(0, filePath.indexOf("."))+".pdf");
		    			 if(flag){
		    				 material.setFile_path(path.substring(0, path.indexOf("."))+".pdf");
		    			 }else{
		    				 logger.error("转换pdf失败");		    				
		    			 }
		    			
		    		 }
		    		  
		    	 }else{
		    		 
		    		 material.setFile_path(path);
		    	 }
		    	
		     } 
		    materialService.save(material);
	        obj.put("status", "success");
		} catch (Exception e) {
			
		}
		//返回结果
        response.getWriter().print(obj);
	}
	
	/**
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/toEdit")
	public String toEdit(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		String id = request.getParameter("id");
		String action = request.getParameter("action");
		Material material=materialService.getObjById(id);
		model.addAttribute("material", material);
		
		if(StringUtils.isEmpty(action)){
			return "page/material/material/details";
        }else{
        	return "page/material/material/edit";
        }
	}

	/**
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/edit")
	public String edit(HttpServletRequest request,
			HttpServletResponse response, Material material, ModelMap model)
			throws Exception {
		  SysUserVO user=(SysUserVO) request.getSession().getAttribute(Constants.SESSION_LOGIN_USER);
	         material.setUpdate_time(new Date());
	         material.setUpdate_user(user.getUserCode());		
	     materialService.update(material);
	     return "redirect:/material/toList.do";
	}

	/**
	 * 删除
	 * 
	 * @param request
	 * @param response
	 */
	@RequestMapping(value = "/deleteById")
	public void deleteById(HttpServletRequest request,
			HttpServletResponse response) {
		response.setContentType("text/html;charset=utf-8"); // 指定输出内容类型和编码
		try {
			boolean isValid = false;
			String[] ids = request.getParameterValues("ids");
			Map<String, Object> map=new HashMap<String, Object>();
			String [] temp=ids[0].split(",");
			map.put("ids", temp);
            materialService.deleteByIdS(map);
			isValid = true;
			response.getWriter().print(JSONArray.fromObject(isValid));
		} catch (Exception e) {
			logger.debug(e);
		}
	}
	
	private String saveFile(MultipartFile uploadFile, String type) {
		String uploadPath = cloud.app.common.ImageUtil.getSaveAttachmentFilePath(cloud.app.common.Constants.CLOUD_FILE_FILE);
		if(EnumtTextType.VIDEO.getValues().equals(type)){
			uploadPath=uploadPath+File.separator+EnumtTextType.VIDEO.getValues();
		}else if(EnumtTextType.IMAGE.getValues().equals(type)){
			uploadPath=uploadPath+File.separator+EnumtTextType.IMAGE.getValues();
		}else if(EnumtTextType.MUSIC.getValues().equals(type)){
			uploadPath=uploadPath+File.separator+EnumtTextType.MUSIC.getValues();
		}else{
			uploadPath=uploadPath+File.separator+EnumtTextType.DOC.getValues();
		}
		  	 
		File uploadPathFile = new File(uploadPath);
		if (!uploadPathFile.exists()) {
			uploadPathFile.mkdirs();
		}
		String expandedName = ""; // 文件扩展名

		String uploadContentType = uploadFile.getContentType();
		if (uploadContentType.equals("image/pjpeg")
				|| uploadContentType.equals("image/jpeg")) {
			// IE6上传jpg图片的headimageContentType是image/pjpeg，而IE9以及火狐上传的jpg图片是image/jpeg
			expandedName = ".jpg";
		} else if (uploadContentType.equals("image/png")
				|| uploadContentType.equals("image/x-png")) {
			// IE6上传的png图片的headimageContentType是"image/x-png"
			expandedName = ".png";
		} else if (uploadContentType.equals("image/gif")) {
			expandedName = ".gif";
		} else if (uploadContentType.equals("image/bmp")) {
			expandedName = ".bmp";
		}else if(uploadContentType.equals("video/mp4")){
			expandedName=".mp4";
		}else{
			String fileName=uploadFile.getOriginalFilename();	
			String [] oFileName=fileName.split("\\.");
			expandedName="."+oFileName[oFileName.length-1];
		}

		String fileName = java.util.UUID.randomUUID().toString()
				.replace("-", ""); // 采用UUID的方式命名保证不会重复
		fileName += expandedName;
		File targetFile = new File(uploadPath, fileName);

		// 保存
		try {
			uploadFile.transferTo(targetFile);
		} catch (IllegalStateException | IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		String tempImageUrl = uploadPath + File.separator + fileName;
		String imageUrl = this.getUrl(tempImageUrl).replace("\\", "/");

		return imageUrl;
	}

	private String getUrl(String imageUrl) {
		int num = imageUrl.indexOf("webapps");
		return imageUrl.substring(num + 7, imageUrl.length());
	}
	
	
	/** 
     * byte(字节)根据长度转成kb(千字节)和mb(兆字节) 
     *  
     * @param bytes 
     * @return 
     */  
    public static String bytes2kb(long bytes) {  
        BigDecimal filesize = new BigDecimal(bytes);  
        BigDecimal megabyte = new BigDecimal(1024 * 1024);  
        float returnValue = filesize.divide(megabyte, 2, BigDecimal.ROUND_UP)  
                .floatValue();  
        if (returnValue > 1)  
            return (returnValue + "MB");  
        BigDecimal kilobyte = new BigDecimal(1024);  
        returnValue = filesize.divide(kilobyte, 2, BigDecimal.ROUND_UP)  
                .floatValue();  
        return (returnValue + "KB");  
    }  
    public String materialTypeId(String mater) throws Exception{
  	  MaterialType materialType = new MaterialType();			
  		String mTypeIds = "";
  		materialType.setType(mater);
  	 	List<MaterialType> materialTypes=materialTypeService.getTypeTreeList(materialType);
  	 	for(int i=0;i<materialTypes.size();i++){
  	 		MaterialType type = materialTypes.get(i);
  	 		mTypeIds+=type.getId();
           if(materialTypes.size()-1!=i){
           	mTypeIds+=",";
           }
       }
  	 	return mTypeIds;
  }
}
