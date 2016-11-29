package cloud.app.common;

import org.apache.log4j.Logger;
import org.eclipse.paho.client.mqttv3.MqttException;
import org.springframework.beans.factory.annotation.Autowired;

import cloud.app.service.mqtt.impl.MqttBroker;
import cloud.app.service.mqtt.impl.WebMqttCaqllbackImpl;
import cloud.app.service.mqtt.impl.WebMqttClient;
import cloud.app.vo.ResultLock;

public class TerminalOfCommandThred implements  Runnable {
	
	@Autowired
	WebMqttClient tempClient;
	
	Logger logger = Logger.getLogger(this.getClass()); 
	
	private String[] terminalIds;
	
	private String userId;
	
	private String instruction;
	
	public TerminalOfCommandThred(){
		
	}
 
	public TerminalOfCommandThred(String [] terminalIds,String userId,String instruction){
		this.terminalIds = terminalIds;
		this.userId = userId;
		this.instruction = instruction;
	}
	
	@Override
	public void run() {
		final WebMqttClient  tempClient = (WebMqttClient) ContextUtil.getSpringBean("webMqttClient");
		
		for (String terminalId : terminalIds) {
			logger.info("-------------------------->发送给终端的指令：" + instruction);
			String topic = "cloudringAd/server/web/" + terminalId + "/out";
			logger.info("-------------------------->topic:" + topic);
			try {
				tempClient.publish(topic, MqttBroker.QOS_VALUES[0],
						instruction.getBytes());
			} catch (MqttException e) {
				logger.error(e.getMessage());
			}

			// 同步处理
			ResultLock resultLock = new ResultLock(userId);
			WebMqttCaqllbackImpl.resultMap.put(userId, resultLock);
			try {
				synchronized (resultLock) {
					resultLock.wait(Constants.I_WAITING_TIME);
				}
			} catch (Exception ex) {
				logger.error("同步等待错误：" + ex.getMessage());
			}

			resultLock.getMessage();

			// 清空Map中之前对应用户ID
			WebMqttCaqllbackImpl.resultMap.remove(userId);
		}
		
	}

}
