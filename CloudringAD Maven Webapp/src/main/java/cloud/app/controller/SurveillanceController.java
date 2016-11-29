/**
 * 
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

import cloud.app.common.TreeUtils;
import cloud.app.common.Utils;
import cloud.app.entity.Surveillance;
import cloud.app.service.SurveillanceService;
import cloud.app.service.mqtt.impl.MqttBroker;
import cloud.app.service.mqtt.impl.WebMqttClient;
import cloud.app.system.vo.TreeVO;

import com.alibaba.fastjson.JSONArray;

/**
 * @author zhoushunfang
 *
 */
@Controller
@RequestMapping("/surveillance")
public class SurveillanceController {
	Logger logger = Logger.getLogger(this.getClass()); 
	
	@Autowired
	private SurveillanceService surveillanceService;
	
	@Autowired
	WebMqttClient webMqttClient;
	
	
	/**
	 * 查询监视器记录
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/surveillance_list.do")
	@ResponseBody
	public Map<String,Object> querySurveillanceList(HttpServletRequest request, HttpServletResponse response){
		String terminalId = request.getParameter("terminalId");
		List<TreeVO> treeList = null;
		String result = "";
		Map<String,Object> jsonMap = new HashMap<String, Object>();
		
		try {
			
			
			treeList = surveillanceService.selectTree(terminalId);
			
			result = TreeUtils.createJson4SurveillanceTree(treeList);
			jsonMap.put("packets", result);
			logger.info("返回的json: "+result);
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		
		return jsonMap;
	}
	
	
	
	/**
	 * 增加监控器信息
	 * @param request
	 * @param response
	 * @param surveillance
	 * @return
	 */
	@RequestMapping("/surveillance_insert")
	@ResponseBody
	private Map<String,Object> insertSurveillance(HttpServletRequest request, HttpServletResponse response){
		String surveillances = request.getParameter("surveillances");
		String terminalId = request.getParameter("terminalId");
		Surveillance action = JSONArray.parseObject(surveillances, Surveillance.class);
		Map<String,Object> map = new HashMap<String,Object>();
		try {
			String userId = Utils.getUserIdbySession(request);
			
			Surveillance tempSurveillance = new Surveillance();
			tempSurveillance.setTerminalId(terminalId);
			int surveillanceCount = surveillanceService.count(tempSurveillance);
			if(surveillanceCount+1 > 16){
				map.put("message", "监视器最多增加16个，当前个数："+(surveillanceCount+1));
				return map;
			}
			
			tempSurveillance.setIp(action.getIp().toUpperCase());
			surveillanceCount = surveillanceService.count(tempSurveillance);
			
			if(surveillanceCount > 0){
				map.put("message", "监视器IP相同，不能增加");
				return map;
			}
			
			action.setId(UUID.randomUUID().toString().replace("-", ""));
			action.setCreateDate(new Date());
			//增加监控信息
			surveillanceService.save(action);
			
			//发送指令
			makeInstruction(userId, "insert",action);
			
			
			map.put("message", 1);
		} catch (Exception e) {
			logger.error(e.getMessage());
			map.put("message", "增加监视器失败");
		}
		return map;
	}
	
	
	private void makeInstruction(String userId, String action,Surveillance surveillance) throws Exception {
		
		String terminalId = "";
		Integer delayTime = 0;
		Integer switchingTime = 0;
		String ips_A = "{\"ipGroup\": \"A\",\"ips\":[";
		String ips_B = "{\"ipGroup\": \"B\",\"ips\":[";
		String ips_C = "{\"ipGroup\": \"C\",\"ips\":[";
		String ips_D = "{\"ipGroup\": \"D\",\"ips\":[";
		String ips_E = "{\"ipGroup\": \"E\",\"ips\":[";
		String oldIp = "";
		
		int count_A = 0;
		int count_B = 0;
		int count_C = 0;
		int count_D = 0;
		int count_E = 0;
		
			terminalId = surveillance.getTerminalId();
			delayTime = surveillance.getDelayTime();
			switchingTime = surveillance.getTransitTime();
			
			if(action.equals("update")){
				Surveillance surveillance2 = surveillanceService.getObjById(surveillance.getId());
				oldIp = surveillance2.getIp();
			}
			
			if("A".equals(surveillance.getPacketName())){
				ips_A += "{\"ip\":\""+surveillance.getIp()+"\",\"oldIP\":\""+oldIp+"\"}";
				count_A ++;
			}
			if("B".equals(surveillance.getPacketName())){
				ips_B += "{\"ip\":\""+surveillance.getIp()+"\",\"oldIP\":\""+oldIp+"\"}";
				count_B ++;
			}
			if("C".equals(surveillance.getPacketName())){
				ips_C += "{\"ip\":\""+surveillance.getIp()+"\",\"oldIP\":\""+oldIp+"\"}";
				count_C ++;
			}
			if("D".equals(surveillance.getPacketName())){
				ips_D += "{\"ip\":\""+surveillance.getIp()+"\",\"oldIP\":\""+oldIp+"\"}";
				count_D ++;
			}
			if("E".equals(surveillance.getPacketName())){
				ips_E += "{\"ip\":\""+surveillance.getIp()+"\",\"oldIP\":\""+oldIp+"\"}";
				count_E ++;
			}
			
		
		ips_A += "]}";
		ips_B += "]}";
		ips_C += "]}";
		ips_D += "]}";
		ips_E += "]}";
		
		if(count_A == 0){
			ips_A = "";
		}
		if(count_B == 0){
			ips_B = "";
		}
		if(count_C == 0){
			ips_C = "";
		}
		if(count_D == 0){
			ips_D = "";
		}
		if(count_E == 0){
			ips_E = "";
		}
		
		
		String instruction = "{\"action\":\"videoIpManager\",\"method\":\""+action+"\",\"switchingTime\":"+switchingTime+",\"delayTime\":"+delayTime+",\"list\": [" +
				ips_A+ips_B+ips_C+ips_D+ips_E+"]}";
		
//		TerminalOfCommandThred thread = new TerminalOfCommandThred(terminalId.split(","),userId,instruction);
//		new Thread(thread).start(); 
		String topic = null;
		for(String terminaId : terminalId.split(",")){
			if(terminaId == null || "".equals(terminaId.trim()) || "null".equals(terminaId)){
				break;
			}
			topic = "cloudringAd/server/web/" + terminaId + "/out";
			logger.info("-----------web发送监控器信息到mqtt服务器上------------ "+topic);
			logger.info("-----------web发送监控器信息到mqtt服务器上------------ "+instruction);
			webMqttClient.publish(topic, MqttBroker.QOS_VALUES[0], instruction.getBytes());
		}
		  
		if(logger.isDebugEnabled()){
			logger.debug("消息发送完成...");
		}
		
	}


	/**
	 * 更新监控器信息
	 * @param request
	 * @param response
	 * @param surveillance
	 * @return
	 */
	@RequestMapping("/surveillance_update")
	@ResponseBody
	private Map<String,Object> updateSurveillance(HttpServletRequest request, HttpServletResponse response){
		String surveillances = request.getParameter("surveillances");
		Surveillance surveillance = JSONArray.parseObject(surveillances, Surveillance.class);
		Map<String,Object> map = new HashMap<String,Object>();
		try {
			Surveillance tempSurveillance = new Surveillance();
			tempSurveillance.setIp(surveillance.getIp().toUpperCase());
			tempSurveillance.setTerminalId(surveillance.getTerminalId());
			int surveillanceCount = surveillanceService.count(tempSurveillance);
			
			if(surveillanceCount > 0){
				map.put("message", "监视器IP相同，不能进行修改");
				return map;
			}
			
			String userId = Utils.getUserIdbySession(request);
			makeInstruction(userId, "update",surveillance);
			//更新监控器信息
			surveillanceService.update(surveillance);
			map.put("message", 1);
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		return map;
	}
	
	/**
	 * 删除监控器
	 * @param request
	 * @param response
	 * @param surveillance
	 * @return
	 */
	@RequestMapping("/surveillance_delete")
	@ResponseBody
	private Map<String,Object> deleteSurveillance(HttpServletRequest request, HttpServletResponse response){
		Map<String,Object> map = new HashMap<String,Object>();
		String surveillanceId = request.getParameter("surveillanceId");
		try {
			String userId = Utils.getUserIdbySession(request);
			Surveillance surveillance = surveillanceService.getObjById(surveillanceId);
			
			makeInstruction(userId, "delete", surveillance);
			
			//删除监控器
			surveillanceService.deleteById(surveillanceId);
			map.put("message", 1);
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		return map;
	}
	
	
	/**
	 * 得到监控器信息
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/surveillance_info")
	@ResponseBody
	private Map<String,Object> getSurveillanceInfo(HttpServletRequest request, HttpServletResponse response){
		String surveillanceId = request.getParameter("surveillanceId");
		Map<String,Object> map = new HashMap<String, Object>();
		try {
			Surveillance surveillance = surveillanceService.getObjById(surveillanceId);
			map.put("surveillance", surveillance);
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		return map;
	}
	
	/**
	 * 打开监视器详情页面
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/surveillance_page")
	private String getSurveillancePage(HttpServletRequest request, HttpServletResponse response){
		String terminalId = request.getParameter("terminalId");
		request.setAttribute("terminalId", terminalId);
		return "/page/terminal/surveillance_info";
	}
	
}
