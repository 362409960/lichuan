package cloud.app.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import cloud.app.entity.Program;
import cloud.app.entity.Terminal;
import cloud.app.service.ProgramService;
import cloud.app.service.TerminalService;
import cloud.app.system.service.DepartmentService;


@Controller
@RequestMapping("/hs")
public class HomeSystemController {
	Logger logger = Logger.getLogger(this.getClass());
	
	final static String I_ONE = "1";
	
	Integer programTotal = 0;
	List<Program> waitApprovalList = null;
	List<Terminal> terminalList = null;
	List<Program> programList = null;
	
	@Autowired
	TerminalService terminalService;
	@Autowired
	ProgramService programService;
	@Autowired
	 DepartmentService departmentService;
	
	@RequestMapping(value = "/index")
	public String index(HttpServletRequest request,HttpServletResponse response)throws Exception {
		try {
			
			//基本信息：终端数、节目数
			Terminal terminal = new Terminal();
			
			List<String> departments = departmentService.getDepartmentIds(request);
			terminal.setDepartmentIds(departments);
			terminalList = terminalService.getList(terminal);

			Program program = new Program();
			program.setPageIndex(0);
			program.setPageSize(Integer.MAX_VALUE);
			program.setPageNumber(0);
			program.setDepartmentidList(departmentService.getDepartmentIds(request));
			programTotal = programService.count(program);
			
			program.setPageSize(3);
			programList = programService.getList(program);

			//得到待审批的节目
			for(Program po : programList){
				if(I_ONE.equals(po.getState())){
					waitApprovalList.add(po);
					break;
				}
			}

			request.setAttribute("terminalList", terminalList);
			request.setAttribute("waitApprovalList", waitApprovalList);
			request.setAttribute("programList", programList);
			request.setAttribute("programTotal", programTotal);
		} catch (Exception e) {			
			return "error";
		}
		
		return "page/index";
	}


	public List<Program> getWaitApprovalList() {
		return waitApprovalList;
	}
	public void setWaitApprovalList(List<Program> waitApprovalList) {
		this.waitApprovalList = waitApprovalList;
	}
	public List<Terminal> getTerminalList() {
		return terminalList;
	}
	public void setTerminalList(List<Terminal> terminalList) {
		this.terminalList = terminalList;
	}
	public List<Program> getProgramList() {
		return programList;
	}
	public void setProgramList(List<Program> programList) {
		this.programList = programList;
	}
	public Integer getProgramTotal() {
		return programTotal;
	}
	public void setProgramTotal(Integer programTotal) {
		this.programTotal = programTotal;
	}
	
}
