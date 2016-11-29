/**
 * 
 */
package cloud.app.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import cloud.app.entity.AdPlayer;
import cloud.app.service.TerminalProgramService;
import cloud.app.system.service.DepartmentService;

/**
 * @author zhoushunfang
 *
 */
@Controller
@RequestMapping("/terminalProgram")
public class TerminalProgramController {
	
	Logger logger = Logger.getLogger(this.getClass()); 
	
	@Autowired
	private TerminalProgramService terminalProgramService;
	
	@Autowired
	private DepartmentService departmentService;
	/**
	 * 终端播放节目统计
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/program_list.do")
	public String getTerminalProgramList(HttpServletRequest request, HttpServletResponse response,AdPlayer adPlayer){
		adPlayer.setPageNumber(1);
		adPlayer.setPageSize(10);
		adPlayer.setPageIndex((adPlayer.getPageNumber() - 1) * adPlayer.getPageSize());
		List<AdPlayer> plays = null; 
		try {
			
			List<String> departments = departmentService.getDepartmentIds(request);
			
			adPlayer.setDepartmentIds(departments);
			
			plays = terminalProgramService.getList(adPlayer);
			
			adPlayer.setRows(plays);
			adPlayer.setTotal(plays.size());
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		
		int pageTotal = 1;//总页数
		if(adPlayer.getTotal() != 0 && (adPlayer.getTotal()%adPlayer.getPageSize() == 0)){
			pageTotal = adPlayer.getTotal()/adPlayer.getPageSize();
		}else{
			pageTotal = adPlayer.getTotal()/adPlayer.getPageSize() + 1;
		}
		request.setAttribute("pageTotal", pageTotal);
		request.setAttribute("adPlayer", adPlayer);
		return "/page/terminal/terminal_program_info";
	}
	
	/**
	 * 条件查询
	 * @param request
	 * @param response
	 * @param adPlayer
	 * @return
	 */
	@RequestMapping(value = "/program_list_search.do")
	public String getTerminalProgramListSearch(HttpServletRequest request, HttpServletResponse response,AdPlayer adPlayer){
		if(adPlayer.getPageNumber() == null || adPlayer.getPageSize() == null){
			adPlayer.setPageNumber(1);
			adPlayer.setPageSize(10);
		}
		adPlayer.setPageIndex((adPlayer.getPageNumber() - 1) * adPlayer.getPageSize());
		List<AdPlayer> plays = null; 
		try {
			
			List<String> departments = departmentService.getDepartmentIds(request);
			adPlayer.setDepartmentIds(departments);
			
			plays = terminalProgramService.getList(adPlayer);
			
			adPlayer.setRows(plays);
			adPlayer.setTotal(plays.size());
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		
		int pageTotal = 1;//总页数
		if(adPlayer.getTotal() != 0 && (adPlayer.getTotal()%adPlayer.getPageSize() == 0)){
			pageTotal = adPlayer.getTotal()/adPlayer.getPageSize();
		}else{
			pageTotal = adPlayer.getTotal()/adPlayer.getPageSize() + 1;
		}
		request.setAttribute("pageTotal", pageTotal);
		request.setAttribute("adPlayer", adPlayer);
		return "/page/terminal/terminal_program_info";
	}
	
}
