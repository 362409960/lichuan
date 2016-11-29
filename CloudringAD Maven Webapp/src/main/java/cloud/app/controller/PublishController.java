package cloud.app.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map.Entry;
import java.util.Set;

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
import cloud.app.entity.Program;

import cloud.app.entity.Publish;
import cloud.app.entity.Terminal;
import cloud.app.entity.TimeVO;
import cloud.app.service.BtService;
import cloud.app.service.ProgramService;
import cloud.app.service.PublishService;
import cloud.app.service.PublishTerminalService;
import cloud.app.service.TerminalService;
import cloud.app.system.service.DepartmentService;
import cloud.app.system.vo.SysUserVO;

/**
 * 
 * @author lichuan
 *
 */
@Controller
@RequestMapping("/publish")
public class PublishController {
	
	
	private static SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	
	private static SimpleDateFormat dsf = new SimpleDateFormat("yyyy/MM/dd HH:mm");
	
	Logger logger = Logger.getLogger(this.getClass());
	@Autowired
	private PublishService publishService;	
	@Autowired
	private ProgramService programService;
	@Autowired
	private BtService btService;
	@Autowired
	private TerminalService terminalService;
	@Autowired
	private PublishTerminalService publishTerminalService;
	
	@Autowired
	private DepartmentService departmentService;
	
	/**
	 * 发布界面
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/toPublish")
	public String toPublish(HttpServletRequest request,HttpServletResponse response,ModelMap model) throws Exception
	{
		 SysUserVO user=(SysUserVO) request.getSession().getAttribute(Constants.SESSION_LOGIN_USER);
		 Publish publish=new Publish();
		 publish.setUser_id(user.getId());
		 publish.setPageNumber(1);
		 publish.setPageSize(10);
		 publish.setDepartmentidList(departmentService.getDepartmentIds(request));
		 publish.setPageIndex((publish.getPageNumber()-1)*publish.getPageSize());		 
		  List<Publish> proList=publishService.getList(publish);
		 Integer total=publishService.count(publish);		
		  Integer count=((total%publish.getPageSize())==0)?total/publish.getPageSize():(total/publish.getPageSize()+1);//最大页数			
		  publish.setTotal(total);
		  publish.setRows(proList);
		  publish.setPageMax(count);
		 model.addAttribute("publish", publish);
		return "page/program/publish_manage_list";
	}
	
	/**
	 * 发布界面查询
	 * @param request
	 * @param response
	 * @param model
	 * @param program
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/toPublishSearch")
	public String toPublishSearch(HttpServletRequest request,HttpServletResponse response,ModelMap model,Publish publish) throws Exception
	{
		SysUserVO user=(SysUserVO) request.getSession().getAttribute(Constants.SESSION_LOGIN_USER);	
		 publish.setUser_id(user.getId());	
		 publish.setDepartmentidList(departmentService.getDepartmentIds(request));
		 publish.setPageIndex((publish.getPageNumber()-1)*publish.getPageSize());
		  List<Publish> proList=publishService.getList(publish);
		 Integer total=publishService.count(publish);
		 publish.setTotal(total);
		  Integer count=((total%publish.getPageSize())==0)?total/publish.getPageSize():(total/publish.getPageSize()+1);//最大页数			
		  publish.setTotal(total);
		  publish.setRows(proList);
		  publish.setPageMax(count);
		 model.addAttribute("publish", publish);
		return "page/program/publish_manage_list";
	}
	
	/**
	 * 删除发布的节目
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
			publishService.updateBatch(map);
			publishTerminalService.updateBatch(map);
			//publishService.deleteByIdS(map);
			//publishTerminalService.deleteByIdS(map);
			isValid = true;
			response.getWriter().print(JSONArray.fromObject(isValid));
		} catch (Exception e) {
			logger.debug(e);
		}
	}
	
	/**
	 * 发布按钮，先保存才到发布界面。
	 * @param request
	 * @param response
	 * @param model
	 * @param program
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/saveToPublish")
	public String saveToPublish(HttpServletRequest request,HttpServletResponse response,ModelMap model,Program program) throws Exception
	{
		SysUserVO user=(SysUserVO) request.getSession().getAttribute(Constants.SESSION_LOGIN_USER);	
		program=programService.saveProgramSonsTable(user, program);
		Date now=new Date();
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(now);
		calendar.add(Calendar.MONTH, 1);
		String nowTime=sf.format(calendar.getTime());
		//求终端的数量
		Terminal terminal=new Terminal();
		//terminal.setMechanism(user.getDepartmentid());
		terminal.setPageIndex(0);
		terminal.setPageSize(Integer.MAX_VALUE);
		terminal.setDepartmentIds(departmentService.getDepartmentIds(request));
		List<Terminal> terminalList=terminalService.getList(terminal);
		Integer  terminalCount=terminalService.count(terminal);
		terminal.setTotal(terminalCount);
		terminal.setRows(terminalList);
		
		//求节目的数量
		Program pm=new Program();
		pm.setUser_id(user.getId());
		pm.setPageNumber(1);
		pm.setPageSize(10);
		pm.setPageIndex((pm.getPageNumber()-1)*pm.getPageSize());	
		pm.setDepartmentidList(departmentService.getDepartmentIds(request));
		List<Program> pmList=programService.getDeleSonList(pm);	
		Integer total=programService.countDeleSon(pm);			
		Integer count=((total%pm.getPageSize())==0)?total/pm.getPageSize():(total/pm.getPageSize()+1);//最大页数			
		pm.setTotal(total);		
		pm.setPageMax(count);		
        pm.setRows(pmList);
		model.addAttribute("pm", pm);
		//默认的节目名称
		model.addAttribute("program_name", program.getProgram_name());
		model.addAttribute("program_id", program.getId());
		
		model.addAttribute("terminal", terminal);
		model.addAttribute("nowTime", nowTime);
		return "page/program/publish_first";
	}
	/**
	 * 发布第一步，选择发布终端[重发]
	 * @param request
	 * @param response
	 * @param model
	 * @param program
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/toPublishFirst")
	public String toPublishFirst(HttpServletRequest request,HttpServletResponse response,ModelMap model,Publish publish) throws Exception
	{
		SysUserVO user=(SysUserVO) request.getSession().getAttribute(Constants.SESSION_LOGIN_USER);
		String id=request.getParameter("id");
		if(!"".equals(id)&&id!=null){
			Map<String,Object> map=new HashMap<String, Object>();
			String [] ids=id.split(",");
			map.put("ids", ids);
			List<Program> prorgamList=programService.getProgramByIdList(map);
			String program_name = "";
			for (Program program2 : prorgamList) {
				program_name += program2.getProgram_name()+"/";
			}
			model.addAttribute("program_name", program_name.substring(0, program_name.length()-1));
			model.addAttribute("program_id", id);
		}
		//求节目的数量
		Program pm=new Program();
		pm.setUser_id(user.getId());
		pm.setPageNumber(1);
		pm.setPageSize(10);
		pm.setPageIndex((pm.getPageNumber()-1)*pm.getPageSize());
		pm.setDepartmentidList(departmentService.getDepartmentIds(request));
		List<Program> pmList=programService.getDeleSonList(pm);	
		Integer total=programService.countDeleSon(pm);
		Integer count=((total%pm.getPageSize())==0)?total/pm.getPageSize():(total/pm.getPageSize()+1);//最大页数			
		pm.setTotal(total);		
		pm.setPageMax(count);		
		 pm.setRows(pmList);
	     model.addAttribute("pm", pm);
		//求终端的数量
		Terminal terminal=new Terminal();
		//terminal.setMechanism(user.getDepartmentid());
		terminal.setPageIndex(0);
		terminal.setPageSize(Integer.MAX_VALUE);
		terminal.setDepartmentIds(departmentService.getDepartmentIds(request));
		List<Terminal> terminalList=terminalService.getList(terminal);
		Integer  terminalCount=terminalService.count(terminal);
		terminal.setTotal(terminalCount);
		terminal.setRows(terminalList);
		Date now=new Date();
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(now);
		calendar.add(Calendar.MONTH, 1);
		String nowTime=sf.format(calendar.getTime());
		
		model.addAttribute("nowTime", nowTime);
		model.addAttribute("terminal", terminal);
		return "page/program/publish_first";
	}
	
	/**
	 * 发布第一步，选择发布终端[重发]
	 * @param request
	 * @param response
	 * @param model
	 * @param program
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/toPublishResendFirst")
	public String toPublishResendFirst(HttpServletRequest request,HttpServletResponse response,ModelMap model,Publish publish) throws Exception
	{
		SysUserVO user=(SysUserVO) request.getSession().getAttribute(Constants.SESSION_LOGIN_USER);
		String id=request.getParameter("id");
		String termianl_id=request.getParameter("termianl_id");
		if(!"".equals(id)&&id!=null){
			Program program=programService.getObjById(id);
			model.addAttribute("program_name", program.getProgram_name());
			model.addAttribute("program_id", program.getId());
		}
		//求节目的数量
		Program pm=new Program();
		pm.setUser_id(user.getId());
		pm.setPageNumber(1);
		pm.setPageSize(10);
		pm.setPageIndex((pm.getPageNumber()-1)*pm.getPageSize());
		pm.setDepartmentidList(departmentService.getDepartmentIds(request));
		List<Program> pmList=programService.getDeleSonList(pm);	
		Integer total=programService.countDeleSon(pm);	
		Integer count=((total%pm.getPageSize())==0)?total/pm.getPageSize():(total/pm.getPageSize()+1);//最大页数			
		pm.setTotal(total);		
		pm.setPageMax(count);		
		 pm.setRows(pmList);
	     model.addAttribute("pm", pm);
		//求终端的数量
		Terminal terminal=new Terminal();
		//terminal.setMechanism(user.getDepartmentid());
		terminal.setPageIndex(0);
		terminal.setId(termianl_id);
		terminal.setPageSize(Integer.MAX_VALUE);
		terminal.setDepartmentIds(departmentService.getDepartmentIds(request));
		List<Terminal> terminalList=terminalService.getList(terminal);
		Integer  terminalCount=terminalService.count(terminal);
		terminal.setTotal(terminalCount);
		terminal.setRows(terminalList);
		Date now=new Date();
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(now);
		calendar.add(Calendar.MONTH, 1);
		String nowTime=sf.format(calendar.getTime());
		
		model.addAttribute("nowTime", nowTime);
		model.addAttribute("terminal", terminal);
		return "page/program/publish_first";
	}
	
	/**
	 *
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/termianlState")
	public void termianlState(HttpServletRequest request,HttpServletResponse response) throws Exception{
		 response.setContentType("text/html;charset=utf-8"); //指定输出内容类型和编码
		// SysUserVO user=(SysUserVO) request.getSession().getAttribute(Constants.SESSION_LOGIN_USER);
		 Terminal terminal=new Terminal();
		 String[] ids = request.getParameterValues("ids");	
		 if(ids[0]!=""){
			 String [] temp=ids[0].split(",");
			 List<String> list=new ArrayList<String>();
			 for(String str:temp){
				 list.add(str);
			 }
			 terminal.setPackets(list);
		 }
		 //terminal.setMechanism(user.getDepartmentid());
		 terminal.setPageIndex(0);
		 terminal.setDepartmentIds(departmentService.getDepartmentIds(request));
		 terminal.setPageSize(Integer.MAX_VALUE);
		 List<Terminal> terminalList=terminalService.getList(terminal);
		 response.getWriter().print(JSONArray.fromObject(terminalList));
	}
	
	/**
	 *
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/termianlStatuState")
	public void termianlStatuState(HttpServletRequest request,HttpServletResponse response) throws Exception{
		 response.setContentType("text/html;charset=utf-8"); //指定输出内容类型和编码		
		 Terminal terminal=new Terminal();
		 String[] ids = request.getParameterValues("ids");		
		 String [] quickFindParam=request.getParameterValues("quickFindParam");
		 if(ids[0]!=""){
			 String [] temp=ids[0].split(",");
			 List<String> list=new ArrayList<String>();
			 for(String str:temp){
				 list.add(str);
			 }
			 terminal.setPackets(list);
		 }
		 String [] tempQuick=quickFindParam[0].split(",");
		 if(tempQuick.length>0)terminal.setName(tempQuick[0]);		 
		 if(tempQuick.length>1)terminal.setStatus(tempQuick[1]);
		 if(tempQuick.length>2)terminal.setIp(tempQuick[2]);
		 if(tempQuick.length>3)terminal.setReolution(tempQuick[3]);
		 if(tempQuick.length>4)terminal.setFirmware(tempQuick[4]);
		 if(tempQuick.length>5)terminal.setVersion(tempQuick[5]);
		 if(tempQuick.length>6)terminal.setMechanismName(tempQuick[6]);
		 if(tempQuick.length>7)terminal.setVersion(tempQuick[7]);
		 terminal.setPageIndex(0);
		 terminal.setDepartmentIds(departmentService.getDepartmentIds(request));
		 terminal.setPageSize(Integer.MAX_VALUE);
		 List<Terminal> terminalList=terminalService.getList(terminal);
		 response.getWriter().print(JSONArray.fromObject(terminalList));
	}
	
	/**
	 * 发布第二步，发送到终端，完成后或者重新发送。
	 * 先把数据发送的终端,在保存数据.
	 * @param request
	 * @param response
	 * @param model
	 * @param program
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/toPublishSecond")
	public String toPublishSecond(HttpServletRequest request,HttpServletResponse response,ModelMap model,Publish publish) throws Exception
	{
		//SysUserVO user=(SysUserVO) request.getSession().getAttribute(Constants.SESSION_LOGIN_USER);
		String id=publishService.savePublish(request, publish);
		Publish pub=publishService.getObjById(id);	
		if(publish.getProgram_id()!=null && !"".equals(publish.getProgram_id())){
			Map<String,Object> map=new HashMap<String, Object>();
			String [] ids=publish.getProgram_id().split(",");
			map.put("ids", ids);
			List<Program> prorgamList=programService.getProgramByIdList(map);
			model.addAttribute("prorgam", prorgamList);
			model.addAttribute("prorgam_id", publish.getProgram_id());
		}
		publish.setTimeVOlist(createList(publish));
		String terid=publish.getTermianl_id();
		Terminal terminal=terminalService.getObjById(terid);
		model.addAttribute("publish", pub);
		model.addAttribute("terminal", terminal);
		//查出制作出来的广告内容
		return "page/program/publish_second";
	}
	
	/**
	 * 展示界面
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/view")
	public String view(HttpServletRequest request,HttpServletResponse response,ModelMap model) throws Exception
	{
		//SysUserVO user=(SysUserVO) request.getSession().getAttribute(Constants.SESSION_LOGIN_USER);
		String id=request.getParameter("id");
		//String state=request.getParameter("state");			
		Publish publish=publishService.getObjById(id);	
		if(publish.getProgram_id()!=null && !"".equals(publish.getProgram_id())){
			Map<String,Object> map=new HashMap<String, Object>();
			String [] ids=publish.getProgram_id().split(",");
			map.put("ids", ids);
			List<Program> prorgamList=programService.getProgramByIdList(map);
			model.addAttribute("prorgam", prorgamList);
			model.addAttribute("prorgam_id", publish.getProgram_id());
		}
		publish.setTimeVOlist(createList(publish));
		String terid=publish.getTermianl_id();
		Terminal terminal=terminalService.getObjById(terid);
		model.addAttribute("publish", publish);
		model.addAttribute("terminal", terminal);
		return "page/program/publish_second";
	}
	
	/**
	 * 分页查询节目【不包括】
	 * @param request
	 * @param response
	 */
	@RequestMapping(value = "/pageQuery")
	public void pageQuery(HttpServletRequest request,HttpServletResponse response){
		response.setContentType("text/html;charset=utf-8"); // 指定输出内容类型和编码
		try {
			SysUserVO user=(SysUserVO) request.getSession().getAttribute(Constants.SESSION_LOGIN_USER);
			Map<String,Object> mapJson=new LinkedHashMap<String,Object>();
			String programName=request.getParameter("programName");
			String pageNumber=request.getParameter("pageNumber");
			Program pm=new Program();
			pm.setUser_id(user.getId());
			pm.setPageNumber(Integer.parseInt(pageNumber));
			pm.setPageSize(10);
			pm.setPageIndex((pm.getPageNumber()-1)*pm.getPageSize());
			pm.setProgram_name(programName);
			List<Program> pmList=programService.getDeleSonList(pm);
			for(Program program:pmList){
				if(program.getUpdated()!=null){
					program.setView_time(dsf.format(program.getUpdated()));
				}
			
			}
			Integer total=programService.countDeleSon(pm);					
			Integer count=((total%pm.getPageSize())==0)?total/pm.getPageSize():(total/pm.getPageSize()+1);//最大页数			
			pm.setTotal(total);		
			pm.setPageMax(count);				
		   pm.setRows(pmList);
		   mapJson.put("pm", pm);
			response.getWriter().print(JSONArray.fromObject(mapJson));
		} catch (Exception e) {		
			logger.debug(e);
		}
	}
	
	public List<TimeVO> createList(Publish publish){
		List<TimeVO> list=new ArrayList<TimeVO>();
		String context;
		if("1".equals(publish.getPlayMode())){
			 context=publish.getModeContent();
			 JSONArray array = JSONArray.fromObject(context);
				for(int i=0;i<array.size();i++){
					@SuppressWarnings("unchecked")
					Map<String,String> map = array.getJSONObject(i);					
					Set<Entry<String, String>> entries = map.entrySet();
					for (Entry<String, String> entry : entries) {
						String key=entry.getKey();
					    String value=entry.getValue();
					    String [] times=value.split(",");
					    for(String time:times){
					    	TimeVO timeVO=new TimeVO();
					    	timeVO.setDate(key);
					    	timeVO.setStartTime(time.substring(0, 5));
					    	timeVO.setEndTime(time.substring(9, 14));
					    	list.add(timeVO);
					    }
						
					}
					
				}
		
		}else if("2".equals(publish.getPlayMode())){
			context=publish.getModeContent();
			JSONArray array = JSONArray.fromObject(context);
			for(int i=0;i<array.size();i++){
				net.sf.json.JSONObject jsonObject = array.getJSONObject(i);
				TimeVO timeVO=new TimeVO();
				String startTime=(String) jsonObject.get("startTime");
				String endTime=(String) jsonObject.get("endTime");
				timeVO.setStartDate(startTime.substring(0, 10));
				timeVO.setStartTime(startTime.substring(11, startTime.length()));
				timeVO.setEndDate(endTime.substring(0, 10));
				timeVO.setEndTime(endTime.substring(11, endTime.length()));
				list.add(timeVO);
			}
		}
		return list;
		
	}
	
}
