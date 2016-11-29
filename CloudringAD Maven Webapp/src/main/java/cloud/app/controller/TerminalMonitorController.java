/**
 * 终端监控controller
 */
package cloud.app.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import cloud.app.common.PropertiesUtils;
import cloud.app.entity.DataGathering;
import cloud.app.entity.Publish;
import cloud.app.entity.Terminal;
import cloud.app.entity.TimeVO;
import cloud.app.service.DataGatheringService;
import cloud.app.service.PublishService;
import cloud.app.service.TerminalService;
import cloud.app.system.service.DepartmentService;

import com.alibaba.fastjson.JSONArray;

/**
 * @author zhoushunfang
 *
 */
@Controller
@RequestMapping("/terminalMonitor")
public class TerminalMonitorController {
	
	Logger logger = Logger.getLogger(this.getClass()); 
	
	SimpleDateFormat sdf= new SimpleDateFormat("yyyy-MM-dd HH:mm");
	
	@Autowired
	private TerminalService terminalService ;
	
	@Autowired
	private PublishService publishService;
	
	@Autowired
	private DepartmentService departmentService; 
	
	@Autowired
	private DataGatheringService dataGatheringService;
	
	/**
	 * 查询终端列表
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/terminal_list.do")
	private String getTerminalList(HttpServletRequest request, HttpServletResponse response,Terminal terminal){
		terminal.setPageNumber(1);
		terminal.setPageSize(10);
		terminal.setPageIndex((terminal.getPageNumber() - 1) * terminal.getPageSize());
		List<Terminal> terminals = null;
		int onLine = 0;
		Terminal countTerminal = new Terminal();
		int offLine = 0;
		try {
			List<String> departments = departmentService.getDepartmentIds(request);
			
			terminal.setDepartmentIds(departments);
			terminals = terminalService.getList(terminal);
			terminal.setRows(terminals);
			terminal.setTotal(terminalService.count(terminal));
			countTerminal.setStatus("1");
			countTerminal.setDepartmentIds(departments);
			onLine = terminalService.count(countTerminal);
			countTerminal.setStatus("0");
			offLine = terminalService.count(countTerminal);
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		
		int pageTotal = 1;//总页数
		if(terminal.getTotal() != 0 && (terminal.getTotal()%terminal.getPageSize() == 0)){
			pageTotal = terminal.getTotal()/terminal.getPageSize();
		}else{
			pageTotal = terminal.getTotal()/terminal.getPageSize() + 1;
		}
		request.setAttribute("pageTotal", pageTotal);
		request.setAttribute("onLine", onLine);
		request.setAttribute("offLine", offLine);
		request.setAttribute("terminal", terminal);
		return "/page/terminal/terminal_monitor_info";
	}
	
	
	/**
	 * 条件查询终端列表
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/terminal_list_search.do")
	private String getTerminalListSearch(HttpServletRequest request, HttpServletResponse response,Terminal terminal){
		if(terminal.getPageNumber() == null || terminal.getPageSize() == null){
			terminal.setPageNumber(1);
			terminal.setPageSize(10);
		}
		terminal.setPageIndex((terminal.getPageNumber() - 1) * terminal.getPageSize());
		List<Terminal> terminals = null;
		int onLine = 0;
		Terminal countTerminal = new Terminal();
		int offLine = 0;
		try {
			List<String> departments = departmentService.getDepartmentIds(request);
			
			terminal.setDepartmentIds(departments);
			terminals = terminalService.getList(terminal);
			terminal.setRows(terminals);
			terminal.setTotal(terminalService.count(terminal));
			countTerminal.setStatus("1");
			countTerminal.setDepartmentIds(departments);
			onLine = terminalService.count(countTerminal);
			countTerminal.setStatus("0");
			offLine = terminalService.count(countTerminal);
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		
		int pageTotal = 1;//总页数
		if(terminal.getTotal() != 0 && (terminal.getTotal()%terminal.getPageSize() == 0)){
			pageTotal = terminal.getTotal()/terminal.getPageSize();
		}else{
			pageTotal = terminal.getTotal()/terminal.getPageSize() + 1;
		}
		request.setAttribute("pageTotal", pageTotal);
		request.setAttribute("onLine", onLine);
		request.setAttribute("offLine", offLine);
		request.setAttribute("terminal", terminal);
		return "/page/terminal/terminal_monitor_info";
	}
	
	/**
	 * 终端详情
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/terminal_info.do")
	private String getTerminalInfo(HttpServletRequest request, HttpServletResponse response){
		String terminalId = request.getParameter("terminalId");
		Terminal terminal = null;
		List<Publish> publishs = null;
		try {
			terminal = terminalService.getObjById(terminalId);
			publishs = publishService.getProgramListByTerminal(terminalId);//得到当前终端下的节目单
			publishs = processingData(publishs);
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		request.setAttribute("terminal", terminal);
		request.setAttribute("publishs", publishs);
		return "/page/terminal/terminal_monitor_detail";
	}
	
	/**
	 * 处理节目数据
	 * @param publishs
	 * @throws ParseException 
	 */
	private List<Publish> processingData(List<Publish> publishs) throws ParseException {
		List<Publish> list = new ArrayList<Publish>();
		long nowTime = new Date().getTime();
		for (Publish publish : publishs) {
			
			if("0".equals(publish.getPlayMode())){
				if(publish.getScheduledPublish() != "" && publish.getScheduledPublish() != null){
					long publishTime = sdf.parse(publish.getScheduledPublish()).getTime();
					if(nowTime > publishTime){
						list.add(publish);
					}
				}else{
					list.add(publish);
				}
			}
			if("1".equals(publish.getPlayMode())){
				String week = getWeek();
				String modeContent = publish.getModeContent();
				if(modeContent.contains(week)){
					if(publish.getScheduledPublish() != "" && publish.getScheduledPublish() != null){
						long publishTime = sdf.parse(publish.getScheduledPublish()).getTime();
						if(nowTime > publishTime){
							list.add(publish);
						}
					}else{
						list.add(publish);
					}
				}
				
			}
			if("2".equals(publish.getPlayMode())){
				String modeContent = publish.getModeContent();
				List<TimeVO> timeVOs = JSONArray.parseArray(modeContent, TimeVO.class);
				for (TimeVO timeVO : timeVOs) {
					long startPublishTime = sdf.parse(timeVO.getStartTime()).getTime();
					long endPublishTime = sdf.parse(timeVO.getEndTime()).getTime();
					
					if(startPublishTime < nowTime && nowTime < endPublishTime){
						if(publish.getScheduledPublish() != "" && publish.getScheduledPublish() != null){
							long publishTime = sdf.parse(publish.getScheduledPublish()).getTime();
							if(nowTime > publishTime){
								list.add(publish);
								break;
							}
						}else{
							list.add(publish);
							break;
						}
					}
				}
			}
			
		}
		return list;
	}	

	/**
	 * 得到当前星期几
	 * @return
	 */
	private String getWeek(){
		String [] weekDays = {"Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"};
		Calendar c = Calendar.getInstance();
		int w = c.get(Calendar.DAY_OF_WEEK) - 1;
		if (w < 0)
			w = 0;
        return weekDays[w];
	}
	
	/**
	 * 设置音量页面
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "/volume_page.do")
	private String getVolumePage(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String terminalIds = request.getParameter("terminalIds");
		for (String terminalId : terminalIds.split(",")) {
			Terminal terminal = terminalService.getObjById(terminalId);
			if(terminal.getVolume() != 0){
				request.setAttribute("terminalVolume", terminal.getVolume());
				break;
			}
		}
		
		request.setAttribute("terminalIds", terminalIds);
		return "/page/terminal/setVolume";
	}
	
	
	/**
	 * 终端监控返回的记录
	 * @param request
	 * @param response
	 * @param dataGathering
	 * @return
	 */
	@RequestMapping(value = "/monitor_list.do")
	private String getMonitorList(HttpServletRequest request, HttpServletResponse response,DataGathering dataGathering){
		dataGathering.setPageNumber(1);
		dataGathering.setPageSize(10);
		dataGathering.setPageIndex((dataGathering.getPageNumber() - 1) * dataGathering.getPageSize());
		List<DataGathering> dataGatherings = null;
		
		try {
			
			dataGatherings = dataGatheringService.getList(dataGathering);
			for (DataGathering data : dataGatherings) {
				data.setContent(PropertiesUtils.getInstance().getValue("background-image")+data.getContent());
			}
			dataGathering.setRows(dataGatherings);
			dataGathering.setTotal(dataGatheringService.count(dataGathering));
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		
		int pageTotal = 1;//总页数
		if(dataGathering.getTotal() != 0 && (dataGathering.getTotal()%dataGathering.getPageSize() == 0)){
			pageTotal = dataGathering.getTotal()/dataGathering.getPageSize();
		}else{
			pageTotal = dataGathering.getTotal()/dataGathering.getPageSize() + 1;
		}
		request.setAttribute("pageTotal", pageTotal);
		request.setAttribute("dataGathering", dataGathering);
		return "/page/terminal/monitor_info";
	}
	
	
	/**
	 * 终端监控返回的记录
	 * @param request
	 * @param response
	 * @param dataGathering
	 * @return
	 */
	@RequestMapping(value = "/monitor_list_search.do")
	private String getMonitorListSearch(HttpServletRequest request, HttpServletResponse response,DataGathering dataGathering){
		if(dataGathering.getPageNumber() == null || dataGathering.getPageSize() == null){
			dataGathering.setPageNumber(1);
			dataGathering.setPageSize(10);
		}
		dataGathering.setPageIndex((dataGathering.getPageNumber() - 1) * dataGathering.getPageSize());
		List<DataGathering> dataGatherings = null;
		
		try {
			
			dataGatherings = dataGatheringService.getList(dataGathering);
			for (DataGathering data : dataGatherings) {
				data.setContent(PropertiesUtils.getInstance().getValue("background-image")+data.getContent());
			}
			dataGathering.setRows(dataGatherings);
			dataGathering.setTotal(dataGatheringService.count(dataGathering));
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		
		int pageTotal = 1;//总页数
		if(dataGathering.getTotal() != 0 && (dataGathering.getTotal()%dataGathering.getPageSize() == 0)){
			pageTotal = dataGathering.getTotal()/dataGathering.getPageSize();
		}else{
			pageTotal = dataGathering.getTotal()/dataGathering.getPageSize() + 1;
		}
		request.setAttribute("pageTotal", pageTotal);
		request.setAttribute("dataGathering", dataGathering);
		return "/page/terminal/monitor_info";
	}
	
	
}
