/**
 * 定时开关机
 */
package cloud.app.controller;

import java.util.ArrayList;
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

import cloud.app.entity.TempTimeSwitch;
import cloud.app.entity.TimeSwitch;
import cloud.app.service.TimeSwitchService;
import cloud.app.service.mqtt.impl.MqttBroker;
import cloud.app.service.mqtt.impl.WebMqttClient;

import com.alibaba.fastjson.JSONArray;

/**
 * @author zhoushunfang
 *
 */
@Controller
@RequestMapping("/timeSwitch")
public class TimeSwitchController {
	
	Logger logger = Logger.getLogger(this.getClass()); 
	
	@Autowired
	private TimeSwitchService timeSwitchService;
	
	@Autowired
	private WebMqttClient webMqttClient;
	
	/**
	 * 查询定时开关记录
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/timeSwitch_list.do")
	public String getTimeSwitchList(HttpServletRequest request, HttpServletResponse response,TimeSwitch timeSwitch){
		String ids [] = request.getParameter("ids").split(",");
		timeSwitch.setTerminalId(ids[0]);
		List<TimeSwitch> timeSwitchs = new ArrayList<TimeSwitch>();
		try {
			timeSwitchs = timeSwitchService.getList(timeSwitch);
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		request.setAttribute("timeSwitchs", timeSwitchs);
		request.setAttribute("ids", request.getParameter("ids"));
		return "/page/terminal/clockSetting";
	}
	
	/**
	 * 更新或增加定时记录 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "/timeSwitch_update.do")
	@ResponseBody
	public Map<String,Object> updateTimeSwitch(HttpServletRequest request, HttpServletResponse response) throws Exception{
		Map<String,Object> map = new HashMap<String,Object>();
		String[] terminalIds = request.getParameter("terminalIds").split(",");
		String timeSwitchs = request.getParameter("timeSwitchs");
		List<TempTimeSwitch> actionlist = JSONArray.parseArray(timeSwitchs, TempTimeSwitch.class);
		boolean flag = false;
		try {
			
			map.put("ids", terminalIds);
			timeSwitchService.deleteByIdS(map);
			
			String instruction = "{\"action\":\"timingSwitch\",\"list\":[";
			for (int i = 0; i< actionlist.size(); i ++) {
				TempTimeSwitch temp = actionlist.get(i);
				TimeSwitch timeSwitch = new TimeSwitch();
				timeSwitch.setIscycling(temp.getIscycling());
				timeSwitch.setpowerHour(temp.getPowerHour());
				timeSwitch.setPowerMinute(temp.getPowerMinute());
				timeSwitch.setshutdownHour(temp.getShutdownHour());
				timeSwitch.setShutdownMinute(temp.getShutdownMinute());
				timeSwitch.setWeek(temp.getWeek());
				
				for (String terminalId : terminalIds) {
					timeSwitch.setTerminalId(terminalId);
					timeSwitch.setId(UUID.randomUUID().toString().replace("-", ""));
					timeSwitchService.save(timeSwitch);
				}
				
				if(temp.getIscycling().equals("1")){
					flag = true;
					instruction += "{\"week\":\""+timeSwitch.getWeek()+"\",\"powerHour\":\""+timeSwitch.getpowerHour()+"\",\"powerMinute\":\""+timeSwitch.getPowerMinute()+"\",\"closeHour\":\""+timeSwitch.getshutdownHour()+"\",\"closeMinute\":\""+timeSwitch.getShutdownMinute()+"\"}";
					if(i+1 != actionlist.size()){
						instruction += ",";
					}
				}
			}
			
			instruction += "]}";
			
			if(flag){
//				TerminalOfCommandThred thread = new TerminalOfCommandThred(terminalIds,userId,instruction);
//				new Thread(thread).start(); 
				String topic = null;
				for(String terminaId : terminalIds){
					if(terminaId == null || "".equals(terminaId.trim()) || "null".equals(terminaId)){
						break;
					}
					topic = "cloudringAd/server/web/" + terminaId + "/out";
					logger.info("-----------web发送定时开关机信息到mqtt服务器上------------ "+topic);
					logger.info("-----------web发送定时开关机信息到mqtt服务器上------------ "+instruction);
					webMqttClient.publish(topic, MqttBroker.QOS_VALUES[0], instruction.getBytes());
				}
				  
				if(logger.isDebugEnabled()){
					logger.debug("消息发送完成...");
				}
			}
			
			
			map.put("message", 1);
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		return map;
	}
	
	/**
	 * 删除定时记录 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "/timeSwitch_delete.do")
	@ResponseBody
	public Map<String,Object> deleteTimeSwitch(HttpServletRequest request, HttpServletResponse response) throws Exception{
		Map<String,Object> map = new HashMap<String,Object>();
		String timeSwitchId = request.getParameter("timeSwitchId");
		try {
			timeSwitchService.deleteById(timeSwitchId);
			map.put("message", 1);
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		return map;
	}
	
}
