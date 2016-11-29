package cloud.app.common;

import java.util.Date;  
import java.util.Properties;  
  
import javax.mail.Message;  
import javax.mail.Session;  
import javax.mail.Transport;  
import javax.mail.internet.InternetAddress;  
import javax.mail.internet.MimeMessage; 

import org.apache.log4j.Logger;

import cloud.app.entity.Mail;


public class SendMail {
	Logger log = Logger.getLogger(this.getClass());
	
	private static SendMail instance = null;  
	  
    private SendMail() {  
  
    }  
  
    public static SendMail getInstance() {  
        if (instance == null) {  
            instance = new SendMail();  
        }  
        return instance;  
    }  
      
    @SuppressWarnings("static-access")
	public void send(Mail mail) {  
        try {  
           // String to[]={"362409960@qq.com","2038493952@qq.com"};  
            Properties p = new Properties(); //Properties p = System.getProperties();     
            p.put("mail.smtp.auth", "true");     
            p.put("mail.transport.protocol", "smtp");     
            p.put("mail.smtp.host", "smtp.fgecctv.com");     
            p.put("mail.smtp.port", "25");     
            //建立会话     
            Session session = Session.getInstance(p);     
            Message msg = new MimeMessage(session); //建立信息           
            msg.setFrom(new InternetAddress("chuan.li@fgecctv.com")); //发件人    
         
            String toList = getMailList(mail.getTo());  
            InternetAddress[] iaToList = new InternetAddress().parse(toList); 
            msg.setRecipients(Message.RecipientType.TO,iaToList); //收件人     
            msg.setSentDate(new Date()); // 发送日期     
            msg.setSubject(mail.getSuject()); // 主题     
            msg.setText(mail.getBody()); //内容     
            // 邮件服务器进行验证     
            Transport tran = session.getTransport("smtp");     
            tran.connect("smtp.fgecctv.com", "chuan.li@fgecctv.com", "Fgfgfg123");     
            // bluebit_cn是用户名，xiaohao是密码     
            tran.sendMessage(msg, msg.getAllRecipients()); // 发送     
            System.out.println("邮件发送成功");     
      
        } catch (Exception e) {
        	log.debug(e);
           // e.printStackTrace();     
        }     
    }     
      /**
       * 多个邮件地址分解成字符串
       * @param mailArray
       * @return
       */
private String getMailList(String[] mailArray){            
    StringBuffer toList = new StringBuffer();  
    int length = mailArray.length;  
    if(mailArray!=null && length <2){  
         toList.append(mailArray[0]);  
    }else{  
         for(int i=0;i<length;i++){  
                 toList.append(mailArray[i]);  
                 if(i!=(length-1)){  
                     toList.append(",");  
                     }  
             }  
         }  
     return toList.toString();
}   

}
