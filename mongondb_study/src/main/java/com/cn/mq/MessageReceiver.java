package com.cn.mq;

import javax.jms.Connection;
import javax.jms.ConnectionFactory;
import javax.jms.Destination;
import javax.jms.Message;
import javax.jms.MessageConsumer;
import javax.jms.Session;
import javax.jms.TextMessage;

import org.apache.activemq.ActiveMQConnection;
import org.apache.activemq.ActiveMQConnectionFactory;
/**
 * 消息消费者
 * @author lichuan
 *
 */
public class MessageReceiver {
	
	
    // tcp 地址
    public static final String BROKER_URL = "tcp://localhost:61616";
    // 目标，在ActiveMQ管理员控制台创建 http://localhost:8161/admin/queues.jsp
    public static final String DESTINATION = "lee.mq.queue";
    
    private static void run()throws Exception{
    	
    	Connection connetion = null;
    	Session session = null;
    	
    	try {
    		//创建一个工厂
    		ConnectionFactory  factory = new ActiveMQConnectionFactory(ActiveMQConnection.DEFAULT_USER, ActiveMQConnection.DEFAULT_PASSWORD, BROKER_URL);
    		connetion = factory.createConnection();
    		connetion.start();
    		
    		session = connetion.createSession(true, Session.AUTO_ACKNOWLEDGE);
    		
    		Destination destination = session.createQueue(DESTINATION);
    		
    		MessageConsumer consumer = session.createConsumer(destination); 
    		 
    		while(true){
    			Message msg = consumer.receive(1000 * 10);
    			TextMessage text = (TextMessage) msg;
    			if(null != text){
    				System.out.println("接收：" + text.getText());
    			}else{
    				break;
    			}
    		}
    		session.commit();
    		
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(session != null){
				session.close();
			}
			if(connetion != null){
				connetion.close();
			}
		}
    	
    }
    public static void main(String[] args) throws Exception {
    	MessageReceiver.run();
	}

}
