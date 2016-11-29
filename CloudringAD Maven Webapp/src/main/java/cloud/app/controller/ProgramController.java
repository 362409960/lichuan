package cloud.app.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;

import java.util.List;
import java.util.Map;

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
import cloud.app.common.IPUtils;
import cloud.app.entity.Material;
import cloud.app.entity.MaterialType;
import cloud.app.entity.Program;
import cloud.app.entity.ProgramDetails;
import cloud.app.entity.Template;

import cloud.app.service.BtService;
import cloud.app.service.MaterialService;
import cloud.app.service.MaterialTypeService;
import cloud.app.service.ProgramDetailsService;
import cloud.app.service.ProgramService;
import cloud.app.service.SurveillanceService;
import cloud.app.service.TemplateService;
import cloud.app.system.service.DepartmentService;
import cloud.app.system.service.SysUserService;
import cloud.app.system.vo.SysUserVO;
import cloud.app.webservice.Weather;

/**
 * 
 * @author lichuan
 * 
 */
@Controller
@RequestMapping("/program")
public class ProgramController {
	Logger logger = Logger.getLogger(this.getClass());

	@Autowired
	private ProgramService programService;
	@Autowired
	private BtService btService;
	@Autowired
	private MaterialService materialService;
	@Autowired
	private MaterialTypeService materialTypeService;
	@Autowired
	private SysUserService sysUserService;
	@Autowired
	private ProgramDetailsService programDetailsService;
	@Autowired
	private SurveillanceService surveillanceService;
	@Autowired
	private DepartmentService departmentService;
	@Autowired
	private TemplateService templateService;

	/**
	 * 制作节目
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/toMake")
	public String toMake(HttpServletRequest request,
			HttpServletResponse response, ModelMap model) throws Exception {
		List<String> listMenuId = departmentService.getDepartmentIds(request);
		String departIds = "";
		for (int i = 0; i < listMenuId.size(); i++) {
			String id = listMenuId.get(i);
			departIds += id;
			if (listMenuId.size() - 1 != i) {
				departIds += ",";
			}
		}

		SimpleDateFormat dsf = new SimpleDateFormat("yyMMddHHmmssSSS");

		Material material = new Material();

		material.setPageIndex(0);
		material.setDepartment_id(departIds);
		material.setPageSize(Integer.MAX_VALUE);

		material.setMaterial_type(materialTypeId(EnumtTextType.IMAGE
				.getValues()));
		List<Material> mImageList = materialService.getList(material);// 图片

		material.setMaterial_type(materialTypeId(EnumtTextType.VIDEO
				.getValues()));
		List<Material> mVideoList = materialService.getList(material);// 视频

		material.setMaterial_type(materialTypeId(EnumtTextType.MUSIC
				.getValues()));
		List<Material> mMusicList = materialService.getList(material);// 音乐

		material.setMaterial_type(materialTypeId(EnumtTextType.DOC.getValues()));
		List<Material> mDocList = materialService.getList(material);// 文本

		MaterialType obj = new MaterialType();

		obj.setType(EnumtTextType.IMAGE.getValues());
		List<MaterialType> matIamgelist = materialTypeService.getTypeList(obj);

		obj.setType(EnumtTextType.VIDEO.getValues());
		List<MaterialType> matVideolist = materialTypeService.getTypeList(obj);

		obj.setType(EnumtTextType.DOC.getValues());
		List<MaterialType> matDoclist = materialTypeService.getTypeList(obj);

		List<String> listSu = surveillanceService.getPacketList();

		Template template = new Template();
		template.setAffiliationsLists(departmentService
				.getDepartmentIds(request));
		template.setPageNumber(1);
		template.setPageSize(Integer.MAX_VALUE);
		template.setPageIndex((template.getPageNumber() - 1)
				* template.getPageSize());
		List<Template> mList = templateService.getList(template);

		model.addAttribute("now_time", dsf.format(new Date()));
		model.addAttribute("mImageList", mImageList);
		model.addAttribute("mVideoList", mVideoList);
		model.addAttribute("matIamgelist", matIamgelist);
		model.addAttribute("matVideolist", matVideolist);
		model.addAttribute("mMusicList", mMusicList);
		model.addAttribute("listSu", listSu);
		model.addAttribute("matDoclist", matDoclist);
		model.addAttribute("mDocList", mDocList);
		model.addAttribute("templateList", mList);
		return "page/program/make";
	}

	/**
	 * 预览
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/toPreview")
	public String toPreview(HttpServletRequest request,
			HttpServletResponse response, ModelMap model) throws Exception {
		String text = request.getParameter("text");
		model.addAttribute("text", text);
		return "page/program/preview";
	}

	/**
	 * 查询预览[主表查找]
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/toSearchPreview")
	public String toSearchPreview(HttpServletRequest request,
			HttpServletResponse response, ModelMap model) throws Exception {
		String id = request.getParameter("id");
		Program program = programService.getObjById(id);
		ProgramDetails programDetails = new ProgramDetails();
		programDetails.setProgramId(id);
		List<ProgramDetails> list = programDetailsService
				.getList(programDetails);
		programDetails = list.get(0);
		model.addAttribute("text", programDetails.getContext());
		return "page/program/preview";
	}

	/**
	 * 查询预览[字表查找]
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/toSearchSonPreview")
	public String toSearchSonPreview(HttpServletRequest request,
			HttpServletResponse response, ModelMap model) throws Exception {
		String id = request.getParameter("id");
		ProgramDetails programDetails = programDetailsService.getObjById(id);
		model.addAttribute("text", programDetails.getContext());
		return "page/program/preview";
	}

	/**
	 * 保存
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @param program
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/save")
	public void save(HttpServletRequest request, HttpServletResponse response,
			ModelMap model, Program program) throws Exception {
		response.setContentType("text/html;charset=utf-8"); // 指定输出内容类型和编码
		response.getWriter().print(
				JSONArray.fromObject(programService.saveProgramSonsTable(
						request, program)));
	}

	@RequestMapping(value = "/toProgramDetailsEdit")
	public String toProgramDetailsEdit(HttpServletRequest request,
			HttpServletResponse response, ModelMap model) throws Exception {
		String id = request.getParameter("id");
		Program program = programService.getObjById(id);
		ProgramDetails programDetails = new ProgramDetails();
		programDetails.setProgramId(program.getId());
		List<ProgramDetails> pDetailsList = programDetailsService
				.getList(programDetails);
		model.addAttribute("program", program);
		model.addAttribute("pDetailsList", pDetailsList);
		return "page/program/edit_item";

	}

	/**
	 * 指向编辑界面
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @param program
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/toEdit")
	public String toEdit(HttpServletRequest request,
			HttpServletResponse response, ModelMap model) throws Exception {
		List<String> listMenuId = departmentService.getDepartmentIds(request);
		String departIds = "";
		for (int i = 0; i < listMenuId.size(); i++) {
			String id = listMenuId.get(i);
			departIds += id;
			if (listMenuId.size() - 1 != i) {
				departIds += ",";
			}
		}

		String id = request.getParameter("id");
		ProgramDetails programDetails = programDetailsService.getObjById(id);
		Program program = programService.getObjById(programDetails
				.getProgramId());

		Material material = new Material();

		material.setPageIndex(0);
		material.setDepartment_id(departIds);
		material.setPageSize(Integer.MAX_VALUE);

		material.setMaterial_type(materialTypeId(EnumtTextType.IMAGE
				.getValues()));
		List<Material> mImageList = materialService.getList(material);// 图片

		material.setMaterial_type(materialTypeId(EnumtTextType.VIDEO
				.getValues()));
		List<Material> mVideoList = materialService.getList(material);// 视频

		material.setMaterial_type(materialTypeId(EnumtTextType.MUSIC
				.getValues()));
		List<Material> mMusicList = materialService.getList(material);// 音乐

		material.setMaterial_type(materialTypeId(EnumtTextType.DOC.getValues()));
		List<Material> mDocList = materialService.getList(material);// 文本

		if (mMusicList.isEmpty()) {
			model.addAttribute("is", "0");
		} else {
			model.addAttribute("is", "1");
		}
		MaterialType obj = new MaterialType();

		obj.setType(EnumtTextType.IMAGE.getValues());
		List<MaterialType> matIamgelist = materialTypeService.getTypeList(obj);

		obj.setType(EnumtTextType.VIDEO.getValues());
		List<MaterialType> matVideolist = materialTypeService.getTypeList(obj);

		obj.setType(EnumtTextType.DOC.getValues());
		List<MaterialType> matDoclist = materialTypeService.getTypeList(obj);

		List<ProgramDetails> list = programDetailsService
				.getList(programDetails);
		List<String> listSu = surveillanceService.getPacketList();

		Template template = new Template();
		template.setAffiliationsLists(departmentService
				.getDepartmentIds(request));
		template.setPageNumber(1);
		template.setPageSize(Integer.MAX_VALUE);
		template.setPageIndex((template.getPageNumber() - 1)
				* template.getPageSize());
		List<Template> mList = templateService.getList(template);

		model.addAttribute("mImageList", mImageList);
		model.addAttribute("mVideoList", mVideoList);
		model.addAttribute("matIamgelist", matIamgelist);
		model.addAttribute("matVideolist", matVideolist);
		model.addAttribute("mMusicList", mMusicList);
		model.addAttribute("program", program);
		model.addAttribute("programDetails", programDetails);
		model.addAttribute("programDetailList", list);
		model.addAttribute("listSu", listSu);
		model.addAttribute("matDoclist", matDoclist);
		model.addAttribute("mDocList", mDocList);
		model.addAttribute("templateList", mList);
		return "page/program/edit";
	}

	/**
	 * 管理界面
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/toProject")
	public String toProject(HttpServletRequest request,
			HttpServletResponse response, ModelMap model) throws Exception {
		SysUserVO user = (SysUserVO) request.getSession().getAttribute(
				Constants.SESSION_LOGIN_USER);
		Program program = new Program();
		program.setUser_id(user.getId());
		program.setPageNumber(1);
		program.setPageSize(5);
		program.setDepartmentidList(departmentService.getDepartmentIds(request));
		program.setPageIndex((program.getPageNumber() - 1)
				* program.getPageSize());
		List<Program> proList = programService.getList(program);
		for (Program p : proList) {
			ProgramDetails pd = new ProgramDetails();
			pd.setProgramId(p.getId());
			List<ProgramDetails> list = programDetailsService.getList(pd);
			p.setScenes(String.valueOf(list.size()));
			int time = 0;
			for (ProgramDetails programDetails : list) {
				time += Integer.parseInt(programDetails.getPlay_time());
			}
			p.setPlay_time(String.valueOf(time));
		}
		Integer total = programService.count(program);
		program.setTotal(total);
		Integer count = ((total % program.getPageSize()) == 0) ? total
				/ program.getPageSize() : (total / program.getPageSize() + 1);// 最大页数
		program.setTotal(total);
		program.setRows(proList);
		program.setPageMax(count);
		model.addAttribute("program", program);
		return "page/program/projects_list";
	}

	/**
	 * 管理界面查询
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @param program
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/toProjectSearch")
	public String toProjectSearch(HttpServletRequest request,
			HttpServletResponse response, ModelMap model, Program program)
			throws Exception {
		SysUserVO user = (SysUserVO) request.getSession().getAttribute(
				Constants.SESSION_LOGIN_USER);
		program.setUser_id(user.getId());
		program.setDepartmentidList(departmentService.getDepartmentIds(request));
		program.setPageIndex((program.getPageNumber() - 1)
				* program.getPageSize());
		List<Program> proList = programService.getList(program);
		for (Program p : proList) {
			ProgramDetails pd = new ProgramDetails();
			pd.setProgramId(p.getId());
			List<ProgramDetails> list = programDetailsService.getList(pd);
			p.setScenes(String.valueOf(list.size()));
			int time = 0;
			for (ProgramDetails programDetails : list) {
				time += Integer.parseInt(programDetails.getPlay_time());
			}
			p.setPlay_time(String.valueOf(time));
		}
		Integer total = programService.count(program);
		program.setTotal(total);
		Integer count = ((total % program.getPageSize()) == 0) ? total
				/ program.getPageSize() : (total / program.getPageSize() + 1);// 最大页数
		program.setTotal(total);
		program.setRows(proList);
		program.setPageMax(count);
		model.addAttribute("program", program);
		return "page/program/projects_list";
	}

	/**
	 * 删除广告
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
			Map<String, Object> map = new HashMap<String, Object>();
			String[] temp = ids[0].split(",");
			map.put("ids", temp);
			programService.deleteByIdS(map);
			programDetailsService.deleteByIdS(map);
			isValid = true;
			response.getWriter().print(JSONArray.fromObject(isValid));
		} catch (Exception e) {
			logger.debug(e);
		}
	}

	@RequestMapping(value = "/deleteDetails")
	public void deleteDetails(HttpServletRequest request,
			HttpServletResponse response) {
		response.setContentType("text/html;charset=utf-8"); // 指定输出内容类型和编码
		try {
			boolean isValid = false;
			String id = request.getParameter("id");
			programDetailsService.deleteById(id);
			isValid = true;
			response.getWriter().print(JSONArray.fromObject(isValid));
		} catch (Exception e) {
			logger.debug(e);
		}
	}

	@RequestMapping(value = "/showWeatherJson")
	public void showWeatherJson(HttpServletRequest request,
			HttpServletResponse response) {
		response.setContentType("text/html;charset=utf-8"); // 指定输出内容类型和编码
		try {
			SysUserVO user = (SysUserVO) request.getSession().getAttribute(
					Constants.SESSION_LOGIN_USER);
			String ip = IPUtils.getIpAddr(request);
			String searchCity = sysUserService.getCtityNameById(user
					.getCity_no());
			String cityName = Weather.resolveIpJons(ip, searchCity);
			String json = Weather.resolveWeatherJons(cityName);
			List<Object> list = new ArrayList<Object>();
			list.add(json);
			response.getWriter().print(JSONArray.fromObject(list));
		} catch (Exception e) {
			logger.debug(e);
		}
	}

	public String materialTypeId(String mater) throws Exception {
		MaterialType materialType = new MaterialType();
		String mTypeIds = "";
		materialType.setType(mater);
		List<MaterialType> materialTypes = materialTypeService
				.getTypeTreeList(materialType);
		for (int i = 0; i < materialTypes.size(); i++) {
			MaterialType type = materialTypes.get(i);
			mTypeIds += type.getId();
			if (materialTypes.size() - 1 != i) {
				mTypeIds += ",";
			}
		}
		return mTypeIds;
	}

	@RequestMapping(value = "/showProgramDetailsJson")
	public void showProgramDetailsJson(HttpServletRequest request,
			HttpServletResponse response) {
		response.setContentType("text/html;charset=utf-8"); // 指定输出内容类型和编码
		try {
			Map<String, Object> mapJson = new LinkedHashMap<String, Object>();
			ProgramDetails programDetails = programDetailsService
					.getObjById(request.getParameter("id"));
			List<ProgramDetails> list = programDetailsService
					.getList(programDetails);
			mapJson.put("programDetails", programDetails);
			mapJson.put("list", list);
			response.getWriter().print(JSONArray.fromObject(mapJson));
		} catch (Exception e) {
			logger.debug(e);
		}
	}

	@RequestMapping(value = "/showProgramDetails")
	public void showProgramDetails(HttpServletRequest request,
			HttpServletResponse response) {
		response.setContentType("text/html;charset=utf-8"); // 指定输出内容类型和编码
		try {
			Map<String, Object> mapJson = new LinkedHashMap<String, Object>();
			ProgramDetails programDetails = new ProgramDetails();
			String id = request.getParameter("id");
			String scenes = request.getParameter("scenes");
			if (!"".equals(id) && id != null) {
				programDetails.setProgramId(id);
				programDetails.setScenes(scenes);
				List<ProgramDetails> list = programDetailsService
						.getList(programDetails);
				Integer time = 0;
				for (ProgramDetails p : list) {
					if (!programDetails.getScenes().equals(p.getScenes())) {
						time = time + Integer.parseInt(p.getPlay_time());
					}
				}
				mapJson.put("list", list);
				mapJson.put("time", time);
			}
			response.getWriter().print(JSONArray.fromObject(mapJson));
		} catch (Exception e) {
			logger.debug(e);
		}
	}

	@RequestMapping(value = "/showImgOrVideo")
	public void showImgOrVideo(HttpServletRequest request,
			HttpServletResponse response) {
		response.setContentType("text/html;charset=utf-8"); // 指定输出内容类型和编码
		try {
			String[] ids = request.getParameterValues("url");
			Map<String, Object> map = new HashMap<String, Object>();
			String[] temp = ids[0].split(",");
			map.put("ids", temp);
			List<Material> list = materialService.getListByUrl(map);
			response.getWriter().print(JSONArray.fromObject(list));
		} catch (Exception e) {
			logger.debug(e);
		}
	}

	@RequestMapping(value = "/showProgramTemplatJson")
	public void showProgramTemplatJson(HttpServletRequest request,
			HttpServletResponse response) {
		response.setContentType("text/html;charset=utf-8"); // 指定输出内容类型和编码
		try {
			Map<String, Object> mapJson = new LinkedHashMap<String, Object>();
			Template template = templateService.getObjById(request
					.getParameter("id"));
			mapJson.put("template", template);
			response.getWriter().print(JSONArray.fromObject(mapJson));
		} catch (Exception e) {
			logger.debug(e);
		}
	}

}
