package cloud.app.service.mqtt.impl;


import java.util.HashMap;
import java.util.Map;

import org.apache.log4j.Logger;
import org.eclipse.paho.client.mqttv3.IMqttDeliveryToken;
import org.eclipse.paho.client.mqttv3.MqttCallback;
import org.eclipse.paho.client.mqttv3.MqttMessage;
import org.springframework.stereotype.Service;

import cloud.app.common.Constants;
import cloud.app.vo.ResultLock;

@Service
public class WebMqttCaqllbackImpl implements MqttCallback {
	Logger logger = Logger.getLogger(this.getClass());
	public static Map<String, ResultLock> resultMap = new HashMap<String, ResultLock>();

	String[] temp = null;
	String tempTopic = null;
	
	public void connectionLost(Throwable cause) {
		cause.printStackTrace();
		logger.error(">>> connection lost <<< ");
	}

	public void messageArrived(String topic, MqttMessage message) throws Exception {
		try {
			temp = topic.split(Constants.TOPIC_SEPARATOR);
			if(temp == null || temp.length <4){
				logger.error(">>>>>>>>>>>>>>>>>>>>>>>>>> topic error.<<<<<<<<<<<<<<<<<<<<<<<<<<");
				return;
			}
			
			//收到网关返回的消息
			if(Constants.TOPIC_IN.equals(temp[4])){
				ResultLock resultLock = resultMap.get(temp[3]);
				if(logger.isDebugEnabled()){
					logger.debug("resultLock:  "+resultLock);
				}
				
				if(resultLock != null){
					synchronized (resultLock) {
						resultLock.notify();
						if(logger.isDebugEnabled()){
							logger.info("resultLock被唤醒， 设置 "+message+" 到resultLock中 ");
						}
						resultLock.setMessage(new String(message.getPayload(), Constants.ENCODING));
					}
				}else{
					logger.error(">>> The object is not sent. <<<");
				}
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}

	public void deliveryComplete(IMqttDeliveryToken token) {
		logger.error(" delivery complete clientId: "+ token.getClient().getClientId() + " messageId: "+token.getMessageId());
	}

}
