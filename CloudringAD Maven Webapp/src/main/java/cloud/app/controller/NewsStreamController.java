/**
 * 插播消息controller
 */
package cloud.app.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cloud.app.common.Constants;
import cloud.app.entity.NewsStream;
import cloud.app.entity.Terminal;
import cloud.app.service.NewsStreamService;
import cloud.app.service.TerminalService;
import cloud.app.service.mqtt.impl.MqttBroker;
import cloud.app.service.mqtt.impl.WebMqttClient;
import cloud.app.system.service.DepartmentService;
import cloud.app.system.vo.SysUserVO;

import com.alibaba.fastjson.JSONArray;

/**
 * @author zhoushunfang
 *
 */
@Controller
@RequestMapping("/newsStream")
public class NewsStreamController {
	Logger logger = Logger.getLogger(this.getClass()); 
	
	@Autowired
	private NewsStreamService newsStreamService ;
	
	@Autowired
	private TerminalService terminalService ;
	
	@Autowired
	private DepartmentService departmentService; 
	
	@Autowired
	WebMqttClient tempClient;
	
	/**
	 * 查询所有终端  
	 * @return
	 */
	@RequestMapping(value = "/terminal_list.do")
	public String getTerminalListById(HttpServletRequest request, HttpServletResponse response,Terminal terminal){
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
			
			terminals = terminalService.getListAndMessage(terminal);
			terminal.setRows(terminals);
			terminal.setTotal(terminalService.getListAndMessageCount(terminal));
			
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
		request.setAttribute("terminalIds",request.getParameter("terminalIds"));
		return "/page/terminal/newsStream_of_terminal";
	}
	
	
	/**
	 * 查询所有终端 (条件查询)
	 * @return
	 */
	@RequestMapping(value = "/terminal_list_search.do")
	public String getTerminalListSearchById(HttpServletRequest request, HttpServletResponse response,Terminal terminal){
		terminal.setPageIndex((terminal.getPageNumber() - 1) * terminal.getPageSize());
		List<Terminal> terminals = null;
		int onLine = 0;
		Terminal countTerminal = new Terminal();
		int offLine = 0;
		try {
			List<String> departments = departmentService.getDepartmentIds(request);
			
			terminal.setDepartmentIds(departments);
			terminals = terminalService.getListAndMessage(terminal);
			terminal.setRows(terminals);
			terminal.setTotal(terminalService.getListAndMessageCount(terminal));
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
		return "/page/terminal/newsStream_of_terminal";
	}
	
	
	/**
	 * 查询消息列表
	 * @return
	 */
	@RequestMapping(value = "/news_stream_list.do")
	public String getNewsStreamList(HttpServletRequest request, HttpServletResponse response,NewsStream newsStream){
		newsStream.setPageNumber(1);
		newsStream.setPageSize(10);
		newsStream.setPageIndex((newsStream.getPageNumber() - 1) * newsStream.getPageSize());
		List<NewsStream> newsStreams = null;
		try {
			newsStreams = newsStreamService.getList(newsStream);
			newsStream.setTotal(newsStreamService.count(newsStream));
			newsStream.setRows(newsStreams);
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		int pageTotal = 1;//总页数
		if(newsStream.getTotal() != 0 && (newsStream.getTotal()%newsStream.getPageSize() == 0)){
			pageTotal = newsStream.getTotal()/newsStream.getPageSize();
		}else{
			pageTotal = newsStream.getTotal()/newsStream.getPageSize() + 1;
		}
		request.setAttribute("pageTotal", pageTotal);
		request.setAttribute("newsStream", newsStream);
		return "/page/terminal/newsStream_of_message";
	}
	
	
	/**
	 * 条件查询消息列表
	 * @return
	 */
	@RequestMapping(value = "/news_stream_search.do")
	public String getNewsStreamListSearch(HttpServletRequest request, HttpServletResponse response,NewsStream newsStream){
		newsStream.setPageIndex((newsStream.getPageNumber() - 1) * newsStream.getPageSize());
		List<NewsStream> newsStreams = null;
		try {
			newsStreams = newsStreamService.getList(newsStream);
			newsStream.setTotal(newsStreamService.count(newsStream));
			newsStream.setRows(newsStreams);
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		int pageTotal = 1;//总页数
		if(newsStream.getTotal() != 0 && (newsStream.getTotal()%newsStream.getPageSize() == 0)){
			pageTotal = newsStream.getTotal()/newsStream.getPageSize();
		}else{
			pageTotal = newsStream.getTotal()/newsStream.getPageSize() + 1;
		}
		request.setAttribute("pageTotal", pageTotal);
		request.setAttribute("newsStream", newsStreams);
		return "/page/terminal/newsStream_of_message";
	}
	
	
	/**
	 * 删除终端下面的消息
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/newsStream_id_delete.do")
	@ResponseBody
	public Map<String,Object> deleteTerminalById(HttpServletRequest request, HttpServletResponse response){
		Map<String,Object> map = new HashMap<String, Object>();
		String newsStreamIds [] = request.getParameter("newsStreamIds").split(",");
		String terminalId = request.getParameter("terminalId");
		NewsStream newsStream = null;
		try {
			for (String newsStreamId : newsStreamIds) {
				newsStream = newsStreamService.getObjById(newsStreamId);
				String oldTerminalId = newsStream.getTerminalId();
				String oldTerminalIds [] = oldTerminalId.split(",");
				String newTerminalId = "";
				for (int i = 0; i< oldTerminalIds.length; i++) {
					String oldId = oldTerminalIds[i];
					if(!terminalId.equals(oldId)){
						if(i+1 >= oldTerminalIds.length){
							newTerminalId += oldId;
						}
						else{
							newTerminalId += oldId + ",";
						}
					}
				}
				newsStream.setTerminalId(newTerminalId);
				newsStreamService.update(newsStream);
			}
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		map.put("erron", 1);
		return map;
	}
	
	/**
	 * 增加消息
	 * @param request
	 * @param response
	 * @param newsStream
	 * @return
	 */
	@RequestMapping(value = "/news_stream_add.do")
	@ResponseBody
	public Map<String,Object> addNewsStream(HttpServletRequest request, HttpServletResponse response){
		
		String newsStreams = request.getParameter("newsStreams");
		System.out.println("---------------------- newsStreams----------------------> "+newsStreams);
		
		NewsStream newsStream = JSONArray.parseObject(newsStreams, NewsStream.class);
		
		Map<String,Object> map = new HashMap<String, Object>();
		try {
			SysUserVO user = (SysUserVO)request.getSession().getAttribute(Constants.SESSION_LOGIN_USER);
			newsStream.setId(UUID.randomUUID().toString().replace("-", ""));
			newsStream.setCreateDate(new Date());
			newsStream.setCreatorId(user.getId());
			newsStream.setCreator(user.getUserCode());
			newsStreamService.save(newsStream);
			
			String[] terminalIds = newsStream.getTerminalId().split(",");
			String makeInstruction = "{\"action\":\"sendMessage\",\"message\":\""+newsStream.getMessage()+"\", \"time\":"+newsStream.getPlayDuration()+"," +
					" \"unit\":\""+newsStream.getDurationType()+"\",\"speed\":\""+newsStream.getPlaySpeed()+"\",\"isAdd\":"+newsStream.getIsAdd()+"," +
					"\"fontColor\":\""+newsStream.getFontColor()+"\",\"fontSize\":"+newsStream.getFontSize()+",\"position\":"+newsStream.getFontPosition()+"" +
					",\"transparency\":"+newsStream.getFontOpacity()+"}";
			
			
			/*TerminalOfCommandThred thread = new TerminalOfCommandThred(terminalIds,userId,makeInstruction);
			new Thread(thread).start();  
			*/
			
			String topic = null;
			for(String terminaId : terminalIds){
				if(terminaId == null || "".equals(terminaId.trim()) || "null".equals(terminaId)){
					break;
				}
				topic = "cloudringAd/server/web/" + terminaId + "/out";
				logger.info("-----------web发送插播消息到mqtt服务器上------------ "+topic);
				logger.info("-----------web发送插播消息到mqtt服务器上------------ "+makeInstruction);
				tempClient.publish(topic, MqttBroker.QOS_VALUES[0], makeInstruction.getBytes());
			}
			  
			if(logger.isDebugEnabled()){
				logger.debug("消息发送完成...");
			}
			
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		map.put("message", 1);
		return map;
	}
	
	/**
	 * 插播消息页面
	 * @param request
	 * @param response
	 * @param terminal
	 * @return
	 */
	@RequestMapping(value = "/message_page.do")
	public String getMessagePage(HttpServletRequest request, HttpServletResponse response,Terminal terminal){
		request.setAttribute("terminalIds",request.getParameter("terminalIds"));
		return "/page/terminal/insertMessage";
	}
	
	
}
