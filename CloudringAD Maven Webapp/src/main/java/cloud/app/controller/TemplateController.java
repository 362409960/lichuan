package cloud.app.controller;



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


import cloud.app.common.Constants;
import cloud.app.common.EnumtTextType;

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
@RequestMapping("/template")
public class TemplateController {
	Logger logger = Logger.getLogger(this.getClass());
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
	 * 普通模板
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/toList")
	public String toList(ModelMap model,HttpServletRequest request,HttpServletResponse response) throws Exception
	{
		//SysUserVO user=(SysUserVO) request.getSession().getAttribute(Constants.SESSION_LOGIN_USER);
		Template template=new Template();
		template.setAffiliationsLists(departmentService.getDepartmentIds(request));
		template.setPageNumber(1);	
		template.setPageSize(10);
		template.setPageIndex((template.getPageNumber()-1)*template.getPageSize());
		List<Template> mList=templateService.getList(template);
		Integer total=templateService.count(template);
		template.setTotal(total);
		Integer count=((total%template.getPageSize())==0)?total/template.getPageSize():(total/template.getPageSize()+1);//最大页数			
		template.setTotal(total);
		template.setRows(mList);
		template.setPageMax(count);
		TemplateBackGround ground=new TemplateBackGround();
		ground.setAffiliationsLists(departmentService.getDepartmentIds(request));
		Integer totalBackground=templateBackGroundService.count(ground);
	 	model.addAttribute("template", template);
	 	model.addAttribute("totalBackground", totalBackground);
		return "page/material/template/template_list";
	}
	
	/**
	 * 普通模板
	 * @param model
	 * @param request
	 * @param response
	 * @param template
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/toSearch")
	public String toSearch(ModelMap model,HttpServletRequest request,HttpServletResponse response,Template template) throws Exception
	{
		
		template.setAffiliationsLists(departmentService.getDepartmentIds(request));
		template.setPageIndex((template.getPageNumber()-1)*template.getPageSize());
		List<Template> mList=templateService.getList(template);
		Integer total=templateService.count(template);
		template.setTotal(total);
		Integer count=((total%template.getPageSize())==0)?total/template.getPageSize():(total/template.getPageSize()+1);//最大页数			
		template.setTotal(total);
		template.setRows(mList);
		template.setPageMax(count);
		TemplateBackGround ground=new TemplateBackGround();
		ground.setAffiliationsLists(departmentService.getDepartmentIds(request));
		Integer totalBackground=templateBackGroundService.count(ground);
	 	model.addAttribute("template", template);
	 	model.addAttribute("totalBackground", totalBackground);	 
		return "page/material/template/template_list";
	}
	
	
	
	/**
	 * 普通模板预览
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/toPreview")
	public String toPreview(HttpServletRequest request,HttpServletResponse response,ModelMap model) throws Exception
	{
		String text= request.getParameter("text");		
		model.addAttribute("text", text);
		return "page/material/template/preview";
	}
	/**
	 * 指向添加页面
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "/toAdd")
	public String toAdd(HttpServletRequest request, HttpServletResponse response,ModelMap model) throws Exception {	
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
		 material.setPageIndex(0);	
		 material.setDepartment_id(departIds);
		 material.setPageSize(Integer.MAX_VALUE);
		 
		 
		 material.setMaterial_type(materialTypeId(EnumtTextType.IMAGE.getValues()));
		 List<Material> mImageList=materialService.getList(material);//图片
		 
		 material.setMaterial_type(materialTypeId(EnumtTextType.VIDEO.getValues()));
		 List<Material> mVideoList=materialService.getList(material);//视频
		 
		
		 
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
		
		 model.addAttribute("mImageList", mImageList);
		 model.addAttribute("mVideoList", mVideoList);
		 model.addAttribute("matIamgelist", matIamgelist);
		 model.addAttribute("matVideolist", matVideolist);		
		 model.addAttribute("listSu", listSu);
		 model.addAttribute("matDoclist", matDoclist);
		 model.addAttribute("mDocList", mDocList);
		return "page/material/template/add";
	}

	/**
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/save")
	public String save(HttpServletRequest request,HttpServletResponse response, Template template, ModelMap model)
			throws Exception {
		 SysUserVO user=(SysUserVO) request.getSession().getAttribute(Constants.SESSION_LOGIN_USER);
		if(template.getId().isEmpty()&&"".equals(template.getId())){
		 template.setId(UUID.randomUUID().toString().replace("-", ""));
		 template.setCreate_date(new Date());
		 template.setUpdate_date(new Date());	
		 template.setAffiliations(user.getDepartmentid());
		 template.setCreateor(user.getUserCode());
		 template.setEditor(user.getUserCode());		 
		 templateService.save(template);
		}else{			
			template.setUpdate_date(new Date());	
			template.setEditor(user.getUserCode());
			templateService.update(template);
		}
		 return "redirect:/template/toList.do";
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
		Template template=templateService.getObjById(id);
		model.addAttribute("template", template);		
	return "page/material/template/edit";
	}
	
	
	/**
	 * 指向添加页面
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "/toMakeEdit")
	public String toMakeEdit(HttpServletRequest request, HttpServletResponse response,ModelMap model) throws Exception {
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
		 Template template=templateService.getObjById(id);
		 
		
		 
		 model.addAttribute("mImageList", mImageList);
		 model.addAttribute("mVideoList", mVideoList);
		 model.addAttribute("matIamgelist", matIamgelist);
		 model.addAttribute("matVideolist", matVideolist);		
		 model.addAttribute("listSu", listSu);
		 model.addAttribute("matDoclist", matDoclist);
		 model.addAttribute("mDocList", mDocList);
		 model.addAttribute("template", template);
		
		return "page/material/template/make_edit";
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
		 Template template=templateService.getObjById(id);
		 
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
		return "page/material/template/template_make";
	}


	/**
	 * 删除
	 * 
	 * @param request
	 * @param response
	 */
	@RequestMapping(value = "/deleteById")
	public void deleteById(HttpServletRequest request,HttpServletResponse response) {
		response.setContentType("text/html;charset=utf-8"); // 指定输出内容类型和编码
		try {
			boolean isValid = false;
			String[] ids = request.getParameterValues("ids");
			Map<String, Object> map=new HashMap<String, Object>();
			String [] temp=ids[0].split(",");
			map.put("ids", temp);
			templateService.deleteByIdS(map);
			isValid = true;
			response.getWriter().print(JSONArray.fromObject(isValid));
		} catch (Exception e) {
			logger.debug(e);
		}
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
