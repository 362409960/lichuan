/**
 * 终端命令controller
 */
package cloud.app.controller;

import java.io.File;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import cloud.app.common.StringUtil;
import cloud.app.entity.Publish;
import cloud.app.entity.Terminal;
import cloud.app.entity.TimeVO;
import cloud.app.service.PublishService;
import cloud.app.service.TerminalService;
import cloud.app.service.mqtt.impl.MqttBroker;
import cloud.app.service.mqtt.impl.WebMqttClient;

import com.alibaba.fastjson.JSONArray;

/**
 * @author zhoushunfang
 * 
 */
@Controller
@RequestMapping("/terminalCommand")
public class TerminalOfCommandController {

	Logger logger = Logger.getLogger(this.getClass());
	SimpleDateFormat sdf= new SimpleDateFormat("yyyy-MM-dd HH:mm");

	@Autowired
	private PublishService publishService;
	
	@Autowired
	private TerminalService terminalService;
	
	@Autowired
	WebMqttClient tempClient;
	/**
	 * 发送清空消息指令
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/emptyMessage.do")
	@ResponseBody
	public Map<String, Object> emptyMessageAction(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String[] terminalIds = request.getParameter("ids").split(",");
		Map<String, Object> result = new HashMap<String, Object>();
		
		String makeInstruction = "{\"action\":\"emptyMessage\"}";
//		TerminalOfCommandThred thread = new TerminalOfCommandThred(terminalIds,userId,makeInstruction);
//		new Thread(thread).start(); 
		String topic = null;
		for(String terminaId : terminalIds){
			if(terminaId == null || "".equals(terminaId.trim()) || "null".equals(terminaId)){
				break;
			}
			topic = "cloudringAd/server/web/" + terminaId + "/out";
			logger.info("-----------web发送清空信息到mqtt服务器上------------ "+topic);
			logger.info("-----------web发送清空信息到mqtt服务器上------------ "+makeInstruction);
			tempClient.publish(topic, MqttBroker.QOS_VALUES[0], makeInstruction.getBytes());
		}
		  
		if(logger.isDebugEnabled()){
			logger.debug("消息发送完成...");
		}
		
		result.put("message", 1);
		return result;
	}

	/**
	 * 发送清空节目指令
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/emptyProgram.do")
	@ResponseBody
	public Map<String, Object> emptyProgramAction(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String[] terminalIds = request.getParameter("ids").split(",");
		Map<String, Object> result = new HashMap<String, Object>();
		for (String terminalId : terminalIds) {
			if(StringUtil.isBlank(terminalId)){
				break;
			}
			List<Publish> programs = publishService.getProgramListByTerminal(terminalId);//得到当前终端下的节目单
			programs = processingData(programs);
			for (Publish program : programs) {
				
				String oldTerminalIds [] = program.getTermianl_id().split(",");
				String newTerminalIds = "";
				for (int i = 0 ; i < oldTerminalIds.length ; i ++) {
					String oldTerminalId = oldTerminalIds[i];
					if(!oldTerminalId.equals(terminalId) && !StringUtil.isBlank(oldTerminalId)){
						if(i + 1 >= oldTerminalIds.length){
							newTerminalIds += oldTerminalId;
						}else{
							newTerminalIds += oldTerminalId+",";
						}
						
					}
				}
				
				if(StringUtil.isBlank(newTerminalIds)){
					publishService.deleteById(program.getId());
				}else{
					program.setTermianl_id(newTerminalIds);
					publishService.update(program);
				}
				
				String makeInstruction = "{\"action\":\"emptyProgram\",\"id\":\""+program.getProgram_id()+"\"}";
//				TerminalOfCommandThred thread = new TerminalOfCommandThred(terminalIds,userId,makeInstruction);
//				new Thread(thread).start(); 
				
				if(terminalId == null || "".equals(terminalId.trim()) || "null".equals(terminalId)){
					break;
				}
				String topic = null;
				
				topic = "cloudringAd/server/web/" + terminalId + "/out";
				logger.info("-----------web发送节目清空信息到mqtt服务器上------------ "+topic);
				logger.info("-----------web发送节目清空信息到mqtt服务器上------------ "+makeInstruction);
				tempClient.publish(topic, MqttBroker.QOS_VALUES[0], makeInstruction.getBytes());
				  
				if(logger.isDebugEnabled()){
					logger.debug("消息发送完成...");
				}
			}
			
		}
		
		
		
		result.put("message", 1);
		return result;
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
	 * 发送重启终端指令
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/restart.do")
	@ResponseBody
	public Map<String, Object> restartAction(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String[] terminalIds = request.getParameter("ids").split(",");
		Map<String, Object> result = new HashMap<String, Object>();
		
		String makeInstruction = "{\"action\":\"restart\"}";
//		TerminalOfCommandThred thread = new TerminalOfCommandThred(terminalIds,userId,makeInstruction);
//		new Thread(thread).start(); 
		String topic = null;
		for(String terminaId : terminalIds){
			if(terminaId == null || "".equals(terminaId.trim()) || "null".equals(terminaId)){
				break;
			}
			topic = "cloudringAd/server/web/" + terminaId + "/out";
			logger.info("-----------web发送重启信息到mqtt服务器上------------ "+topic);
			logger.info("-----------web发送重启信息到mqtt服务器上------------ "+makeInstruction);
			tempClient.publish(topic, MqttBroker.QOS_VALUES[0], makeInstruction.getBytes());
		}
		  
		if(logger.isDebugEnabled()){
			logger.debug("消息发送完成...");
		}
		result.put("message", 1);
		return result;
	}

	/**
	 * 发送设置音量指令
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/setVolume.do")
	@ResponseBody
	public Map<String, Object> setVolumeAction(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		System.out.println("request.getParameter(\"ids\"): ------------------------> "+request.getParameter("ids"));
		
		String[] terminalIds = request.getParameter("ids").split(",");
		String volume = request.getParameter("volume");
		Map<String, Object> result = new HashMap<String, Object>();
		
		String makeInstruction = "{\"action\":\"setVolume\",\"val\":" + volume + "}";
//		TerminalOfCommandThred thread = new TerminalOfCommandThred(terminalIds,userId,makeInstruction);
//		new Thread(thread).start();
		
		String topic = null;
		Terminal terminal = new Terminal();
		terminal.setVolume(Integer.valueOf(volume));
		for(String terminaId : terminalIds){
			if(terminaId == null || "".equals(terminaId.trim()) || "null".equals(terminaId)){
				break;
			}
			terminal.setId(terminaId);
			terminalService.update(terminal);
			
			topic = "cloudringAd/server/web/" + terminaId + "/out";
			logger.info("-----------web发送音量信息到mqtt服务器上------------ "+topic);
			logger.info("-----------web发送音量信息到mqtt服务器上------------ "+makeInstruction);
			tempClient.publish(topic, MqttBroker.QOS_VALUES[0], makeInstruction.getBytes());
		}
		  
		if(logger.isDebugEnabled()){
			logger.debug("消息发送完成...");
		}
		result.put("message", 1);
		return result;
	}

	/**
	 * 发送远程安装指令
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/remoeInstall.do")
	@ResponseBody
	public Map<String,Object> remoeInstallAction( @RequestParam(value = "apkFile") MultipartFile apkFile,HttpServletRequest request, HttpServletResponse response) throws Exception{
		String apkName = request.getParameter("apkName");
		//获取保存的路径，
		String realPath = cloud.app.common.ImageUtil.getSaveAttachmentFilePath(cloud.app.common.Constants.CLOUD_FILE_FILE);
		if(!new File(realPath).exists()){
			new File(realPath).mkdirs();
		}
		if (apkFile != null) {
			
	      if (apkFile.isEmpty()) {
	          // 未选择文件
	      } else{
	          // 文件原名称
	          String originFileName = apkName;
	          try {
	              //这里使用Apache的FileUtils方法来进行保存
	        	  logger.info(apkFile.getOriginalFilename().split("\\.")[1]);
	              FileUtils.copyInputStreamToFile(apkFile.getInputStream(),
	                      new File(realPath, originFileName+"."+apkFile.getOriginalFilename().split("\\.")[1]));
	          } catch (IOException e) {
	              logger.error(e.getMessage());
	          }
		   }
		}
		
		String[] terminalIds = request.getParameter("ids").split(",");
		String apkUrl = realPath+File.separator+apkName+"."+apkFile.getOriginalFilename().split("\\.")[1];
		Map<String,Object> result = new HashMap<String,Object>();
		
		String makeInstruction = "{\"action\":\"remoeInstall\",\"apkUrl\":\""+apkUrl+"\",\"apkName\":\""+apkName+"."+apkFile.getOriginalFilename().split("\\.")[1]+"\"}";
//		TerminalOfCommandThred thread = new TerminalOfCommandThred(terminalIds,userId,makeInstruction);
//		new Thread(thread).start();
		String topic = null;
		for(String terminaId : terminalIds){
			if(terminaId == null || "".equals(terminaId.trim()) || "null".equals(terminaId)){
				break;
			}
			topic = "cloudringAd/server/web/" + terminaId + "/out";
			logger.info("-----------web发送远程安装信息到mqtt服务器上------------ "+topic);
			logger.info("-----------web发送远程安装信息到mqtt服务器上------------ "+makeInstruction);
			tempClient.publish(topic, MqttBroker.QOS_VALUES[0], makeInstruction.getBytes());
		}
		  
		if(logger.isDebugEnabled()){
			logger.debug("消息发送完成...");
		}
		
		result.put("message", 1);
		return result;
	}

	/**
	 * 发送远程卸载指令
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/reoteUninstall.do")
	@ResponseBody
	public Map<String, Object> reoteUninstallAction(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String[] terminalIds = request.getParameter("ids").split(",");
		String apkName = request.getParameter("apkName");
		Map<String, Object> result = new HashMap<String, Object>();
		
		String makeInstruction = "{\"action\":\"reoteUninstall\",\"apkName\":\"" + apkName + "\"}";
//		TerminalOfCommandThred thread = new TerminalOfCommandThred(terminalIds,userId,makeInstruction);
//		new Thread(thread).start();
		
		String topic = null;
		for(String terminaId : terminalIds){
			if(terminaId == null || "".equals(terminaId.trim()) || "null".equals(terminaId)){
				break;
			}
			topic = "cloudringAd/server/web/" + terminaId + "/out";
			logger.info("-----------web发送远程卸载信息到mqtt服务器上------------ "+topic);
			logger.info("-----------web发送远程卸载信息到mqtt服务器上------------ "+makeInstruction);
			tempClient.publish(topic, MqttBroker.QOS_VALUES[0], makeInstruction.getBytes());
		}
		  
		if(logger.isDebugEnabled()){
			logger.debug("消息发送完成...");
		}
		
		result.put("message", 1);
		return result;
	}

	/**
	 * 发送固件升级指令
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/firmwareUpgrade.do")
	@ResponseBody
	public Map<String, Object> updateVersionAction(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String[] terminalIds = request.getParameter("ids").split(",");
		String firmwareUrl = request.getParameter("firmwareUrl");
		String version = request.getParameter("version");
		Map<String, Object> result = new HashMap<String, Object>();
		
		String makeInstruction = "{\"action\":\"firmwareUpgrade\",\"firmwareUrl\":\"" + firmwareUrl + "\",\"version\":\"" + version + "\"}";
//		TerminalOfCommandThred thread = new TerminalOfCommandThred(terminalIds,userId,makeInstruction);
//		new Thread(thread).start();
		
		String topic = null;
		for(String terminaId : terminalIds){
			if(terminaId == null || "".equals(terminaId.trim()) || "null".equals(terminaId)){
				break;
			}
			topic = "cloudringAd/server/web/" + terminaId + "/out";
			logger.info("-----------web发送固件升级信息到mqtt服务器上------------ "+topic);
			logger.info("-----------web发送固件升级信息到mqtt服务器上------------ "+makeInstruction);
			tempClient.publish(topic, MqttBroker.QOS_VALUES[0], makeInstruction.getBytes());
		}
		  
		if(logger.isDebugEnabled()){
			logger.debug("消息发送完成...");
		}
		
		result.put("message", 1);
		return result;
	}

}
