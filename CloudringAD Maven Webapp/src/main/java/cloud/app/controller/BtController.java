package cloud.app.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import cloud.app.common.Constants;
import cloud.app.common.Utils;
import cloud.app.service.BtService;
import cloud.app.service.mqtt.impl.MqttBroker;
import cloud.app.service.mqtt.impl.WebMqttCaqllbackImpl;
import cloud.app.service.mqtt.impl.WebMqttClient;
import cloud.app.vo.ResultLock;


@Controller
@RequestMapping("/bt")
public class BtController {
	Logger logger = Logger.getLogger(this.getClass());
	
	@Autowired
	BtService btService;
	@Autowired
	WebMqttClient webMqttClient;

	@RequestMapping(value = "/create")
	public void toAdd(HttpServletRequest request, HttpServletResponse response) throws Exception {
		try {
			String userId = "baf83f1b741643f7a7bafdd7f5c06a35";
			String name = "funvideo05.mp4";
			String comment = "this is a fun music";
			String creator = "huangxc";

			btService.btHandle(userId, name, comment, creator);
			System.out.println("this test is over...");
		} catch (Exception ex) {
			ex.printStackTrace();
		}

		return;
	}
	
	@RequestMapping(value = "/mqtt")
	public void mqtt(HttpServletRequest request, HttpServletResponse response) throws Exception {
		try {
			String userId = "0c517db57d6c4d708719b8b0362c3735";
			
		//	String userId = Utils.getUserIdbySession(request);
			//发送数据到mqtt数据服务器(cloudring/ad/server/web/terminalId/out)
			String topic = "cloudringAd/server/web/ad123456/out";
			//String topic1 = "cloudringAd/server/web/abc234/out";
			
			logger.info("-------------------------> "+topic);
			String message = "{\"action\":\"sendMessage\",\"message\":\"this is a test message\"}";
			
			logger.info("send start.");
			webMqttClient.publish(topic, MqttBroker.QOS_VALUES[0], message.getBytes());	
			logger.info("send over.");
			
			//同步处理
			ResultLock  resultLock = new ResultLock(userId);
			WebMqttCaqllbackImpl.resultMap.put(userId, resultLock);
			try{
				synchronized (resultLock) {
					resultLock.wait(Constants.I_WAITING_TIME);
				}
			}catch(Exception ex){
				ex.printStackTrace();
			}
			
			Object resultJson = resultLock.getMessage();

			if(resultJson == null){
				resultJson = "{\"no\": 28,\"errno\": \"0\",\"value\": 0}";
			}
			logger.info(resultJson);
			
			WebMqttCaqllbackImpl.resultMap.remove(userId);
		} catch (Exception ex) {
			ex.printStackTrace();
		}

		return;
	}
	
	
	
}
