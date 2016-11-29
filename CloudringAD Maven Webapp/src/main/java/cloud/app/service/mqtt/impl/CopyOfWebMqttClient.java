package cloud.app.service.mqtt.impl;

import org.apache.log4j.Logger;
import org.eclipse.paho.client.mqttv3.MqttCallback;
import org.eclipse.paho.client.mqttv3.MqttClient;
import org.eclipse.paho.client.mqttv3.MqttConnectOptions;
import org.eclipse.paho.client.mqttv3.MqttDeliveryToken;
import org.eclipse.paho.client.mqttv3.MqttException;
import org.eclipse.paho.client.mqttv3.MqttMessage;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import cloud.app.common.Constants;
import cloud.app.common.PropertiesUtils;


@Service
public class CopyOfWebMqttClient {
	Logger logger = Logger.getLogger(this.getClass());
	 
	String brokerUrl = null;
	String clientId = null;
	boolean cleanSession = false;
	String userName = null;
	String password = null;
	int connectionTimeout = 200;  //默认30秒
	int keepAliveInterval = 120;  //默认2分钟，心跳一次
	boolean retained = false;

	public final static String[] TOPICS = new String[2];
	public final static int[] QOS_VALUES = {1};//对应主题的消息级别   至多一次（QoS=0）、至少一次 （QoS=1，默认值）和刚好一次 （QoS=2）
	
	MqttClient mqttClient = null;  
	MqttConnectOptions options = null;
	
	public CopyOfWebMqttClient(){
		
	}
	
	public void connection(String userId, String userCode){
		try{
			brokerUrl = PropertiesUtils.getInstance().getValue("brokerUrl");
			userName = PropertiesUtils.getInstance().getValue("userName");
			password = PropertiesUtils.getInstance().getValue("password");
			//clientId能够26位，而userId32位，所有用userCode来使用
			//clientId = "ad_"+userCode;
        	
			String tempConnectionTimeout = PropertiesUtils.getInstance().getValue("connectionTimeout");
			if(!StringUtils.isEmpty(tempConnectionTimeout)){
				connectionTimeout = Integer.parseInt(tempConnectionTimeout);
			}
			
			String tempkeepAliveInterval = PropertiesUtils.getInstance().getValue("keepAliveInterval");
			if(!StringUtils.isEmpty(tempkeepAliveInterval)){
				keepAliveInterval = Integer.parseInt(tempkeepAliveInterval);
			}

			if(logger.isDebugEnabled()){
				logger.debug(">>>>>>>>>>>>>>>>>>>> start connection mqtt broker <<<<<<<<<<<<<<<<<<<< ");
			}
			// options 构造函数的一个选项参数
			options = new MqttConnectOptions();
			//控制是否接收到先前所发送的发布 true:不接受之前不在线的消息
			options.setCleanSession(cleanSession);
			//设置用户名和密码
			if(!StringUtils.isEmpty(userName)){
				options.setUserName(userName);
			}
			if(!StringUtils.isEmpty(password)){
				options.setPassword(password.toCharArray());
			}
			//设置超时时间 
			options.setConnectionTimeout(connectionTimeout);
			//设置会话心跳时间
			options.setKeepAliveInterval(keepAliveInterval);
			options.setCleanSession(true);
			
			
			//构造异步对象
			//mqttClient = new MqttClient(brokerUrl, clientId);
			mqttClient = new MqttClient(brokerUrl, MqttClient.generateClientId());
			this.setMqttClient(mqttClient);
			
			//回调
			MqttCallback callback = new WebMqttCaqllbackImpl();
			mqttClient.setCallback(callback);
			if(!mqttClient.isConnected()){
				mqttClient.connect(options);
			}

			//订阅主题: 设置主题，并订阅主题 : cloudringAd/client/web/userId/#
			String topic1 = "cloudringAd/client"+Constants.TOPIC_SEPARATOR+"web"+Constants.TOPIC_SEPARATOR+userId+Constants.TOPIC_SEPARATOR+"#";
			TOPICS[0] = topic1;
			mqttClient.subscribe(TOPICS, QOS_VALUES);

			/** 
	         * 完成订阅后，可以增加心跳，保持网络通畅，也可以发布自己的消息 , false:消息是否保存在服务器上
	         */  
			//mqttClient.publish("keepalive", "keepalive".getBytes(), 0, false);// 增加心跳，保持网络通畅 
			logger.info(">>> connection success. <<<");
		}catch(Exception ex){
			logger.error(" web connection mqtt is error occurred "+ex.getMessage());
		}
	}

	public void publish(String topic, int qos, byte[] payload)throws MqttException{
		try {
			if(mqttClient == null){
				return;
			}

			if(!mqttClient.isConnected()){
				mqttClient.connect(options);
			}

			//create and configure a message
			MqttMessage message = new MqttMessage(payload);
			message.setQos(qos);
			message.setRetained(retained);

			//发布并取得回执
			MqttDeliveryToken token = mqttClient.getTopic(topic).publish(message);
			if(logger.isDebugEnabled()){
				logger.debug("With delivery token \"" + token.hashCode() +" messageId: "+ token.getMessageId() + " delivered: " + token.isComplete()); 	
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public MqttClient getMqttClient() {
		return mqttClient;
	}

	public void setMqttClient(MqttClient mqttClient) {
		this.mqttClient = mqttClient;
	}
	
 

 
	
	
}
