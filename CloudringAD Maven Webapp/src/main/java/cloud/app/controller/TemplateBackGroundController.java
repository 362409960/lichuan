package cloud.app.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
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

import org.springframework.web.multipart.MultipartFile;

import com.alibaba.fastjson.JSONObject;

import cloud.app.common.Constants;
import cloud.app.common.EnumtTextType;
import cloud.app.common.ReadResolution;
import cloud.app.entity.Material;
import cloud.app.entity.MaterialType;
import cloud.app.entity.Template;
import cloud.app.entity.TemplateBackGround;
import cloud.app.service.MaterialService;
import cloud.app.service.MaterialTypeService;
import cloud.app.service.SurveillanceService;
import cloud.app.service.TemplateBackGroundService;
import cloud.app.service.TemplateService;
import cloud.app.system.service.DepartmentService;
import cloud.app.system.vo.SysUserVO;

@Controller
@RequestMapping("/templateBackGround")
public class TemplateBackGroundController {
	
	Logger logger = Logger.getLogger(this.getClass());
	private static SimpleDateFormat dirSf = new SimpleDateFormat("yyyyMMdd");
	@Autowired
	private TemplateService templateService;
	@Autowired
	private TemplateBackGroundService templateBackGroundService;
	@Autowired
	private MaterialTypeService materialTypeService;
	@Autowired
	private MaterialService materialService;
	@Autowired
	private DepartmentService departmentService;
	@Autowired
	private SurveillanceService surveillanceService;
	
	
	
	/**
	 * 背景模板
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/toList")
	public String toBackGroundList(ModelMap model,HttpServletRequest request,HttpServletResponse response) throws Exception
	{
	
		TemplateBackGround ground=new TemplateBackGround();
		ground.setPageNumber(1);	
		ground.setPageSize(10);
		ground.setAffiliationsLists(departmentService.getDepartmentIds(request));
		ground.setPageIndex((ground.getPageNumber()-1)*ground.getPageSize());
		List<TemplateBackGround> mList=templateBackGroundService.getList(ground);
		Integer total=templateBackGroundService.count(ground);
		ground.setTotal(total);
		Integer count=((total%ground.getPageSize())==0)?total/ground.getPageSize():(total/ground.getPageSize()+1);//最大页数			
		ground.setTotal(total);
		ground.setRows(mList);
		ground.setPageMax(count);
		Template template=new Template();
		template.setAffiliationsLists(departmentService.getDepartmentIds(request));
		Integer totalTemplate=templateService.count(template);
	 	model.addAttribute("ground", ground);
	 	model.addAttribute("totalTemplate", totalTemplate);
		return "page/material/template/template_background_list";
	}
	
	/**
	 * 背景模板
	 * @param model
	 * @param request
	 * @param response
	 * @param template
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/toSearch")
	public String toBackGroundSearch(ModelMap model,HttpServletRequest request,HttpServletResponse response,TemplateBackGround ground) throws Exception
	{
		
		ground.setPageIndex((ground.getPageNumber()-1)*ground.getPageSize());
		ground.setAffiliationsLists(departmentService.getDepartmentIds(request));
		List<TemplateBackGround> mList=templateBackGroundService.getList(ground);
		Integer total=templateBackGroundService.count(ground);
		ground.setTotal(total);
		Integer count=((total%ground.getPageSize())==0)?total/ground.getPageSize():(total/ground.getPageSize()+1);//最大页数			
		ground.setTotal(total);
		ground.setRows(mList);
		ground.setPageMax(count);
		Template template=new Template();
		template.setAffiliationsLists(departmentService.getDepartmentIds(request));
		Integer totalTemplate=templateService.count(template);
	 	model.addAttribute("ground", ground);
	 	model.addAttribute("totalTemplate", totalTemplate);
		return "page/material/template/template_background_list";
	}
	
	
	/**
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/save")
	public void save(HttpServletRequest request,HttpServletResponse response, TemplateBackGround ground, ModelMap model)
			throws Exception {
		JSONObject obj = new JSONObject();
		 ground.setId(UUID.randomUUID().toString().replace("-", ""));
		 ground.setCreate_date(new Date());			
		 SysUserVO user=(SysUserVO) request.getSession().getAttribute(Constants.SESSION_LOGIN_USER);
         ground.setAffiliations(user.getDepartmentid());
		 ground.setCreateor(user.getUserCode());
		 ground.setEditor(user.getUserCode());	
		 MultipartFile fileUrl =  ground.getFile();
		 String fileName=fileUrl.getOriginalFilename();
	     if ( null != fileName && !"".equals(fileName) ) {
	    	 ground.setName(fileName);
	    	 String path=saveFile(fileUrl);
	    	 String binPath=System.getProperty("user.dir");	
	    	 String tempdir = binPath.replace("bin", "webapps");
	    	 String filePath=tempdir+path;
	    	 ground.setPhysical_path(filePath);
	    	 ground.setVirtual_path(path);
	    	 ground.setResolution(ReadResolution.getResolution1(new File(filePath)));
	     }
		 templateBackGroundService.save(ground);
		 obj.put("status", "success");
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
	public String toEdit(HttpServletRequest request,HttpServletResponse response, ModelMap model) throws Exception {
		String id = request.getParameter("id");		
		TemplateBackGround templateBackGround=templateBackGroundService.getObjById(id);
		model.addAttribute("templateBackGround", templateBackGround);		
	return "page/material/template/edit_backgroud";
	}

	
	/**
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/edit")
	public String edit(HttpServletRequest request,HttpServletResponse response, TemplateBackGround ground, ModelMap model)
			throws Exception {		  
		    SysUserVO user=(SysUserVO) request.getSession().getAttribute(Constants.SESSION_LOGIN_USER);	
		    ground.setUpdate_date(new Date());
		    ground.setEditor(user.getUserCode());			 
	     templateBackGroundService.update(ground);
	     return "redirect:/templateBackGround/toList.do";
	}
	/**
	 * 指向添加页面
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "/toMake")
	public String toMake(HttpServletRequest request, HttpServletResponse response,ModelMap model) throws Exception {
		 SimpleDateFormat dsf = new SimpleDateFormat("yyMMddHHmmssSSS");
		List<String> listMenuId = departmentService.getDepartmentIds(request);
		String departIds = "";
	 	for(int i=0;i<listMenuId.size();i++){
	 		String id = listMenuId.get(i);
	 		departIds+=id;
            if(listMenuId.size()-1!=i){
            	departIds+=",";
            }
        }
		 String id=request.getParameter("id");
		
		 Material material=new Material();
		
		 material.setPageIndex(0);	
		 material.setDepartment_id(departIds);
		 material.setPageSize(Integer.MAX_VALUE);	
		 
		 material.setMaterial_type(materialTypeId(EnumtTextType.IMAGE.getValues()));
		 List<Material> mImageList=materialService.getList(material);//图片
		 
		 material.setMaterial_type(materialTypeId(EnumtTextType.VIDEO.getValues()));
		 List<Material> mVideoList=materialService.getList(material);//视频
		 
		 material.setMaterial_type(materialTypeId(EnumtTextType.MUSIC.getValues()));
		 List<Material> mMusicList=materialService.getList(material);//音乐
		 
		 material.setMaterial_type(materialTypeId(EnumtTextType.DOC.getValues()));
		 List<Material> mDocList=materialService.getList(material);//文本
		 
		 MaterialType obj = new MaterialType();
		 
		 obj.setType(EnumtTextType.IMAGE.getValues());
		 List<MaterialType> matIamgelist=materialTypeService.getTypeList(obj);
		 
		 obj.setType(EnumtTextType.VIDEO.getValues());
		 List<MaterialType> matVideolist=materialTypeService.getTypeList(obj);	
		 
		 obj.setType(EnumtTextType.DOC.getValues());
		 List<MaterialType> matDoclist=materialTypeService.getTypeList(obj);
	
		 List<String> listSu=surveillanceService.getPacketList();
		 TemplateBackGround template=templateBackGroundService.getObjById(id);
		 
		 Template template1=new Template();
	 	 template1.setAffiliationsLists(departmentService.getDepartmentIds(request));
		 template1.setPageNumber(1);	
		 template1.setPageSize(Integer.MAX_VALUE);
		 template1.setPageIndex((template1.getPageNumber()-1)*template1.getPageSize());
		 List<Template> mList=templateService.getList(template1);
		 
		 model.addAttribute("mImageList", mImageList);
		 model.addAttribute("mVideoList", mVideoList);
		 model.addAttribute("matIamgelist", matIamgelist);
		 model.addAttribute("matVideolist", matVideolist);		
		 model.addAttribute("listSu", listSu);
		 model.addAttribute("mMusicList", mMusicList);
		 model.addAttribute("matDoclist", matDoclist);
		 model.addAttribute("mDocList", mDocList);
		 model.addAttribute("template", template);
		 model.addAttribute("now_time", dsf.format(new Date()));
		 model.addAttribute("templateList", mList);
		return "page/material/template/back_make";
	}

	
	/**
	 * 背景删除
	 * 
	 * @param request
	 * @param response
	 */
	@RequestMapping(value = "/deleteById")
	public void deleteBackGroundById(HttpServletRequest request,HttpServletResponse response) {
		response.setContentType("text/html;charset=utf-8"); // 指定输出内容类型和编码
		try {
			boolean isValid = false;
			String[] ids = request.getParameterValues("ids");
			Map<String, Object> map=new HashMap<String, Object>();
			String [] temp=ids[0].split(",");
			map.put("ids", temp);
			templateBackGroundService.deleteByIdS(map);
			isValid = true;
			response.getWriter().print(JSONArray.fromObject(isValid));
		} catch (Exception e) {
			logger.debug(e);
		}
	}
	
	private String saveFile(MultipartFile uploadFile) {
		String uploadPath = cloud.app.common.ImageUtil.getSaveAttachmentFilePath(cloud.app.common.Constants.CLOUD_FILE_FILE);		
		uploadPath=uploadPath+File.separator+"bgpicture";
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
