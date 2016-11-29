package cloud.app.service.mqtt.impl;

import java.text.SimpleDateFormat;


import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.eclipse.paho.client.mqttv3.MqttException;
import org.fusesource.mqtt.client.Future;
import org.fusesource.mqtt.client.FutureConnection;
import org.fusesource.mqtt.client.MQTT;
import org.fusesource.mqtt.client.Message;
import org.fusesource.mqtt.client.QoS;
import org.fusesource.mqtt.client.Topic;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import cloud.app.common.Constants;
import cloud.app.common.PropertiesUtils;
import cloud.app.dao.MessageDAO;
import cloud.app.dao.SurveillanceDAO;
import cloud.app.dao.TerminalDAO;
import cloud.app.service.PowerResourceService;
import cloud.app.service.PublishTerminalService;
import cloud.app.vo.ResultLock;


@Service
public class WebMqttClient {
    private static final Logger logger = Logger.getLogger(MQTTFutureServer.class);
    
    SimpleDateFormat sf = new SimpleDateFormat("yyyyMMddHHmmss");
    
	final static String ACTION_BINDING = "binding";
	final static String ACTION_CALLBACK = "callback";
	final static String ACTION_DOWNLOADPROGRESS = "downloadProgress";
	final static String ACTION_SYNCRESOURCES = "syncResources";
    
    
    String brokerUrl = "tcp://localhost:61615";
    short KEEP_ALIVE = 30;// 低耗网络，但是又需要及时获取数据，心跳30s  
	String clientId = null;
	boolean cleanSession = true;
	String userName = null;
	String password = null;
    public final  static long RECONNECTION_ATTEMPT_MAX=6;  
    public final  static long RECONNECTION_DELAY=2000;  
      
    public final static int SEND_BUFFER_SIZE=2*1024*1024;//发送最大缓冲为2M  
    
	@Resource
	MessageDAO messageDAQ;
	@Resource
	SurveillanceDAO surveillanceDAO;
	@Resource
	TerminalDAO terminalDAO;
	@Autowired
	PublishTerminalService publishTerminalService;
	@Autowired
	PowerResourceService powerResourceService;
 
	MQTT mqtt = null;
	FutureConnection futureConnection = null;

	public void connection(String userId, String userCode){
		//创建MQTT对象
		mqtt = new MQTT();

        try {
        	brokerUrl = PropertiesUtils.getInstance().getValue("brokerUrl");
			userName = PropertiesUtils.getInstance().getValue("userName");
			password = PropertiesUtils.getInstance().getValue("password");
        	clientId = "ad_".concat(userCode);;
        	
        	//设置mqtt broker的ip和端口  
            mqtt.setHost(brokerUrl);
            mqtt.setUserName(userName);
            mqtt.setPassword(password);
            //连接前清空会话信息  
            mqtt.setCleanSession(cleanSession);  
            //设置重新连接的次数  
            mqtt.setReconnectAttemptsMax(RECONNECTION_ATTEMPT_MAX);  
            //设置重连的间隔时间  
            mqtt.setReconnectDelay(RECONNECTION_DELAY);  
            //设置心跳时间  
            mqtt.setKeepAlive(KEEP_ALIVE);  
            //设置缓冲的大小  
            mqtt.setSendBufferSize(SEND_BUFFER_SIZE);
            mqtt.setClientId(clientId);
              
			//订阅主题: 设置主题，并订阅主题 : cloudringAd/client/web/userId/#
			Topic[] subscribeTopics = {new Topic("cloudringAd/client"+Constants.TOPIC_SEPARATOR+"web"+Constants.TOPIC_SEPARATOR+userId+Constants.TOPIC_SEPARATOR+"#", QoS.AT_LEAST_ONCE)}; 
            
            //获取mqtt的连接对象BlockingConnection  
            futureConnection = mqtt.futureConnection();  
            futureConnection.connect();  
            futureConnection.subscribe(subscribeTopics); 
  
            new Thread(new Runnable(){
				public void run() {
					try {
			            while(true){
			                Future<Message> futrueMessage = futureConnection.receive();  
			                Message message =futrueMessage.await();
			                
			                if(message == null){
			                	return;
			                }

			                //根据主题转发
			    			String[] topics = message.getTopic().split(Constants.TOPIC_SEPARATOR);
			    			if(topics.length == 1){
			    				return;  //心跳不用处理
			    			}
			    			if(topics.length<=2){
			    				//主题格式不正确
			    				return;
			    			}
			    			
			    			//收到网关返回的消息
			    			if(Constants.TOPIC_IN.equals(topics[4])){
			    				ResultLock resultLock = WebMqttCaqllbackImpl.resultMap.get(topics[3]);
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
			            }  
					} catch (Exception ex) {
						ex.printStackTrace();
					}
				}
            }).start();
        } catch (Exception e) {
            e.printStackTrace();  
        }finally{  
              
        }  
    }
	
	
	public void publish(String topic, int qos, byte[] payload)throws MqttException{
		if(mqtt == null){
			System.out.println("************************ WebMqttClient mqtt is null ********************************** ");
		    return;	
		}

		if(futureConnection != null && futureConnection.isConnected()){
			if(logger.isDebugEnabled()){
				logger.debug("************ futureConnection is not null ********** futureConnection.isConnected() "+futureConnection.isConnected());
			}
			
		}else{
			if(logger.isDebugEnabled()){
				logger.debug("************ futureConnection is null ********** futureConnection.isConnected() "+ futureConnection.isConnected());
				futureConnection = mqtt.futureConnection();
				futureConnection.connect();
			}
		}
		
		futureConnection.publish(topic, payload, QoS.EXACTLY_ONCE, false);
	}

	public MQTT getMqtt() {
		return mqtt;
	}
	public void setMqtt(MQTT mqtt) {
		this.mqtt = mqtt;
	}
	public FutureConnection getFutureConnection() {
		return futureConnection;
	}
	public void setFutureConnection(FutureConnection futureConnection) {
		this.futureConnection = futureConnection;
	}
}
