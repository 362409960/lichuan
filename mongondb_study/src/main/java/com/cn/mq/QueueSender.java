package com.cn.mq;

import javax.jms.Connection;
import javax.jms.DeliveryMode;
import javax.jms.MapMessage;
import javax.jms.Queue;
import javax.jms.QueueConnection;
import javax.jms.QueueConnectionFactory;
import javax.jms.QueueSession;
import javax.jms.Session;

import org.apache.activemq.ActiveMQConnection;
import org.apache.activemq.ActiveMQConnectionFactory;
/**
 * 
 * @author lichuan(p2p)
 *
 */
public class QueueSender {
	
	// 发送次数
    public static final int SEND_NUM = 5;
    // tcp 地址
    public static final String BROKER_URL = "tcp://localhost:61616";
    // 目标，在ActiveMQ管理员控制台创建 http://localhost:8161/admin/queues.jsp
    public static final String DESTINATION = "lee.mq.queue";
    
    public static void sendMsg(QueueSession session,javax.jms.QueueSender sender)throws Exception{
    	for(int i = 0;i < SEND_NUM; i++){
    		 String message = "发送消息第" + (i + 1) + "条";
    		 MapMessage map = session.createMapMessage();
    		 map.setString("text", message);
             map.setLong("time", System.currentTimeMillis());
             System.out.println(map);
             sender.send(map);
    	}
    }
    
    public static void run()throws Exception{
    	//p2p的连接
    	 QueueConnection connection = null;
    	 QueueSession session = null;
    	 try {
    		 QueueConnectionFactory factory = new ActiveMQConnectionFactory(ActiveMQConnection.DEFAULT_USER, ActiveMQConnection.DEFAULT_PASSWORD, BROKER_URL);
    		 connection = factory.createQueueConnection();
    		 connection.start();
    		 session = connection.createQueueSession(Boolean.TRUE, Session.AUTO_ACKNOWLEDGE);
    		 Queue queue = session.createQueue(DESTINATION);
    		 javax.jms.QueueSender sender = session.createSender(queue);
    		 sender.setDeliveryMode(DeliveryMode.NON_PERSISTENT);
    		 sendMsg(session, sender);
    		 session.commit();
    		 
		} catch (Exception e) {
			// TODO: handle exception
		}finally {
			if(session != null){
				session.close();
			}
			if(connection != null){
				connection.close();
			}
		}
    	 
    }
    
    public static void main(String[] args) throws Exception {
		QueueSender.run();
	}

}
