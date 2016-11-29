package cloud.app.controller;



import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import cloud.app.common.Constants;
import cloud.app.entity.Publish;
import cloud.app.entity.PublishTerminal;

import cloud.app.service.PublishService;
import cloud.app.service.PublishTerminalService;
import cloud.app.system.service.DepartmentService;
import cloud.app.system.vo.SysUserVO;


@Controller
@RequestMapping("/programDownloadManager")
public class ProgramDownloadManagerController {
	
	Logger logger = Logger.getLogger(this.getClass());
	@Autowired
	private PublishService publishService;	
	@Autowired
	private DepartmentService departmentService;
	@Autowired
	PublishTerminalService publishTerminalService;
	
	/**
	 * 按照发布单
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/toPublishList")
	public String toPublishList(ModelMap model,HttpServletRequest request,HttpServletResponse response) throws Exception
	{
		 SysUserVO user=(SysUserVO) request.getSession().getAttribute(Constants.SESSION_LOGIN_USER);
		 Publish publish=new Publish();
		 publish.setUser_id(user.getId());
		 publish.setPageNumber(1);
		 publish.setPageSize(10);
		 publish.setPageIndex((publish.getPageNumber()-1)*publish.getPageSize());	
		 publish.setDepartmentidList(departmentService.getDepartmentIds(request));
		  List<Publish> proList=publishService.getByDownlodPublish(publish);
		  
		 Integer total=publishService.countDownlodPublish(publish);		
		  Integer count=((total%publish.getPageSize())==0)?total/publish.getPageSize():(total/publish.getPageSize()+1);//最大页数			
		  publish.setTotal(total);
		  publish.setRows(proList);
		  publish.setPageMax(count);
		 model.addAttribute("publish", publish);
		return "page/program/project_download_list";
	}
	
	/**
	 * 按照终端
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/toTerminalList")
	public String toTerminalList(ModelMap model,HttpServletRequest request,HttpServletResponse response) throws Exception
	{
		 SysUserVO user=(SysUserVO) request.getSession().getAttribute(Constants.SESSION_LOGIN_USER);
		 Publish publish=new Publish();
		 publish.setUser_id(user.getId());
		 publish.setPageNumber(1);
		 publish.setPageSize(10);		
		 publish.setPageIndex((publish.getPageNumber()-1)*publish.getPageSize());	
		 publish.setDepartmentidList(departmentService.getDepartmentIds(request));
		  List<Publish> proList=publishService.getByDownlodPublish(publish);
		
		 Integer total=publishService.countDownlodPublish(publish);		
		  Integer count=((total%publish.getPageSize())==0)?total/publish.getPageSize():(total/publish.getPageSize()+1);//最大页数			
		  publish.setTotal(total);
		  publish.setRows(proList);
		  publish.setPageMax(count);
		 model.addAttribute("publish", publish);
		 
		return "page/program/project_download_list";
	}
	/**
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @param publish
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/toPublishSearch")
	public String toSearch(HttpServletRequest request,HttpServletResponse response,ModelMap model,Publish publish) throws Exception
	{
		 
		
		 publish.setDepartmentidList(departmentService.getDepartmentIds(request));
		 publish.setPageIndex((publish.getPageNumber()-1)*publish.getPageSize());
		 List<Publish> proList=publishService.getByDownlodPublish(publish);
		
		 Integer total=publishService.countDownlodPublish(publish);		
		  Integer count=((total%publish.getPageSize())==0)?total/publish.getPageSize():(total/publish.getPageSize()+1);//最大页数			
		  publish.setTotal(total);
		  publish.setRows(proList);
		  publish.setPageMax(count);
		 model.addAttribute("publish", publish);
		return "page/program/project_download_list";
	}
	
	
	@RequestMapping(value = "/toDetailedList")
	public String toDetailedList(HttpServletRequest request,HttpServletResponse response,ModelMap model) throws Exception
	{
		String id=request.getParameter("id");
		String task_name=request.getParameter("task_name");
		 PublishTerminal publish=new PublishTerminal();
		 publish.setPageNumber(1);
		 publish.setPageSize(10);
		 publish.setPublish_id(id);
		 publish.setTask_name(task_name);
		 publish.setPageIndex((publish.getPageNumber()-1)*publish.getPageSize());
		 List<PublishTerminal> proList=publishTerminalService.getList(publish);			
		 Integer total=publishTerminalService.count(publish);		
		  Integer count=((total%publish.getPageSize())==0)?total/publish.getPageSize():(total/publish.getPageSize()+1);//最大页数			
		  publish.setTotal(total);
		  publish.setRows(proList);
		  publish.setPageMax(count);
		 model.addAttribute("PublishTerminal", publish);
		return "page/program/download_details";
	}
	
	@RequestMapping(value = "/toSeatchDetailedList")
	public String toSeatchDetailedList(HttpServletRequest request,HttpServletResponse response,ModelMap model,PublishTerminal publish) throws Exception
	{
		 publish.setPageIndex((publish.getPageNumber()-1)*publish.getPageSize());
		 List<PublishTerminal> proList=publishTerminalService.getList(publish);			
		 Integer total=publishTerminalService.count(publish);		
		  Integer count=((total%publish.getPageSize())==0)?total/publish.getPageSize():(total/publish.getPageSize()+1);//最大页数			
		  publish.setTotal(total);
		  publish.setRows(proList);
		  publish.setPageMax(count);
		 model.addAttribute("PublishTerminal", publish);
		return "page/program/download_details";
	}
}
