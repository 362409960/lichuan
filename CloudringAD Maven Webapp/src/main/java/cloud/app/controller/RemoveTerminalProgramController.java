package cloud.app.controller;

import java.util.Date;
import java.util.HashMap;
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
import cloud.app.entity.Terminal;
import cloud.app.service.ProgramService;
import cloud.app.service.TerminalService;
import cloud.app.service.mqtt.impl.WebMqttClient;
import cloud.app.system.vo.SysUserVO;


@Controller
@RequestMapping("/removeTerminalProgram")
public class RemoveTerminalProgramController {
	
	Logger logger = Logger.getLogger(this.getClass());
	
	@Autowired
	private ProgramService programService;
	@Autowired
	WebMqttClient webMqttClient;
	@Autowired
	private TerminalService terminalService;
	
	
	@RequestMapping(value = "/toList")
	public String toList(ModelMap model,HttpServletRequest request,HttpServletResponse response) throws Exception
	{
		SysUserVO user=(SysUserVO) request.getSession().getAttribute(Constants.SESSION_LOGIN_USER);
		Program program=new Program();
		program.setUser_id(user.getId());
		 program.setPageNumber(1);
		 program.setPageSize(10);
		 program.setPageIndex((program.getPageNumber()-1)*program.getPageSize());		 
		List<Program> mList=programService.getProgramByStateList(program);
		Integer total=programService.countByState(program);
		
		  Integer count=((total%program.getPageSize())==0)?total/program.getPageSize():(total/program.getPageSize()+1);//最大页数			
		  program.setTotal(total);
		  program.setRows(mList);
		  program.setPageMax(count);
		 model.addAttribute("program", program);
		return "page/program/delete_terminal";
	}
	
	
	/**
	 * 查询条件界面
	 * @param model
	 * @param request
	 * @param response
	 * @param program
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/toSearch")
	public String toSearch(ModelMap model,HttpServletRequest request,HttpServletResponse response,Program program) throws Exception
	{
		SysUserVO user=(SysUserVO) request.getSession().getAttribute(Constants.SESSION_LOGIN_USER);	
		program.setUser_id(user.getId());	
		 program.setPageIndex((program.getPageNumber()-1)*program.getPageSize());		 
		List<Program> mList=programService.getProgramByStateList(program);
		Integer total=programService.countByState(program);		
		Integer count=((total%program.getPageSize())==0)?total/program.getPageSize():(total/program.getPageSize()+1);//最大页数			
		program.setTotal(total);
		program.setRows(mList);
		program.setPageMax(count);
		 model.addAttribute("program", program);
		return "page/program/delete_terminal";
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
			String [] temp=ids[0].split(",");
			isValid=programService.deleteTerminalId(request, temp);
			response.getWriter().print(JSONArray.fromObject(isValid));
		} catch (Exception e) {
			logger.debug(e);
		}
	}

}
