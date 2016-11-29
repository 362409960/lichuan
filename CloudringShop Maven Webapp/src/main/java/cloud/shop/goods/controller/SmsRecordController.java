package cloud.shop.goods.controller;

import java.io.PrintWriter;
import java.util.Date;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;


import cloud.shop.common.CommSendSMS;
import cloud.shop.goods.entity.SmsRecord;
import cloud.shop.goods.service.SmsRecordService;

@Controller
@RequestMapping("/sms")
public class SmsRecordController {
	
	private static Logger log=Logger.getLogger(SmsRecordController.class);
	
	@Autowired
	private SmsRecordService smsRecordService;
	
	@RequestMapping(value = "/send")
	public void send(HttpServletRequest request,HttpServletResponse response) throws Exception{
        response.setContentType("text/html;charset=utf-8"); //指定输出内容类型和编码   
        String msg="{\"type\":\"success\"}";
        PrintWriter out = response.getWriter();//获取输出口        	
        try{  
        	String jbPhone=request.getParameter("jbPhone");
        	String code=request.getParameter("code");
        	String name=request.getParameter("name");
        	String content="尊敬的用户，您好：您正在进行手机验证,验证码是:"+code+"(客服绝不会索取此验证码，切勿要告诉他人),请在页面中输入以完成验证";
        	String result=CommSendSMS.sendSMS(jbPhone, content);
        	SmsRecord smsrecord=new SmsRecord();
        	smsrecord.setPhone(jbPhone);
        	request.getSession().setAttribute("code", code);
        	int count=smsRecordService.countSmsRecord(smsrecord);
        	if(count<10)
        	{
        		if("0".equals(result.substring(0, 1)))
            	{
            		SmsRecord sms=new SmsRecord();
            		sms.setId(UUID.randomUUID().toString().replace("-", ""));
            		sms.setPhone(jbPhone);
            		sms.setContents(content);
            		sms.setCreate_time(new Date());
            		sms.setSender(name);
            		sms.setCode(code);
            		smsRecordService.save(sms);
            	}
            	else
            	{
            		msg="{\"error\":\"error\"}";
            		log.info("手机发送短信失败"+result);
            	}
        	}
        	else
        	{
        		msg="{\"error\":\"count\"}";
        		log.info("在一天之内本手机发送短信超过10条");
        	}
            out.write(msg);//返回结果
            out.flush();  
            out.close();  
        }catch(Exception ex){
        	log.error(ex);
            msg="{\"error\":\"短信发送出现系统错误.\"}";
            out.write(msg);//返回结果
            out.flush();  
            out.close();  
        }
	}

	
	@RequestMapping(value = "/sms")
	public void sms(HttpServletRequest request,HttpServletResponse response) throws Exception{
        response.setContentType("text/html;charset=utf-8"); //指定输出内容类型和编码   
        String msg="{\"type\":\"success\"}";
        PrintWriter out = response.getWriter();//获取输出口        	
        try{  
        	String jbPhone=request.getParameter("jbPhone");
        	String code=request.getParameter("code");        
        	String content="尊敬的用户，您好：您正在进行手机验证,验证码是:"+code+"(客服绝不会索取此验证码，切勿要告诉他人),请在页面中输入以完成验证";
        	String result=CommSendSMS.sendSMS(jbPhone, content);
        	SmsRecord smsrecord=new SmsRecord();
        	smsrecord.setPhone(jbPhone);
        	request.getSession().setAttribute("code", code);
        	int count=smsRecordService.countSmsRecord(smsrecord);
        	if(count<10)
        	{
        		if("0".equals(result.substring(0, 1)))
            	{
            		SmsRecord sms=new SmsRecord();
            		sms.setId(UUID.randomUUID().toString().replace("-", ""));
            		sms.setPhone(jbPhone);
            		sms.setContents(content);
            		sms.setCreate_time(new Date());            		
            		sms.setCode(code);
            		smsRecordService.save(sms);
            	}
            	else
            	{
            		msg="{\"error\":\"error\"}";
            		log.info("手机发送短信失败"+result);
            	}
        	}
        	else
        	{
        		msg="{\"error\":\"count\"}";
        		log.info("在一天之内本手机发送短信超过10条");
        	}
            out.write(msg);//返回结果
            out.flush();  
            out.close();  
        }catch(Exception ex){
        	log.error(ex);
            msg="{\"error\":\"短信发送出现系统错误.\"}";
            out.write(msg);//返回结果
            out.flush();  
            out.close();  
        }
	}
	/**
	 * 检查用户code是否有
	 * @param request
	 * @param response
	 * @param catalog
	 */
	@RequestMapping(value = "/check_sms")
	public void check_sms(HttpServletRequest request,HttpServletResponse response,ModelMap model){
		response.setContentType("text/html;charset=utf-8"); //指定输出内容类型和编码
        try{
       	PrintWriter out = response.getWriter();//获取输出口
        	boolean isValid = false;
        	String smscode=request.getParameter("smscode");
        	String code=(String) request.getSession().getAttribute("code");
        	if(code.equals(smscode))
        	{
        		isValid=true;
        	}
        	out.print(isValid);//返回结果
            out.flush();  
            out.close(); 
        }catch(Exception ex){
            ex.printStackTrace();
        }
	}
	
	/**
	 * 在120秒session失效.
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "setSessionFail")
	public void setSessionFail(HttpServletRequest request,HttpServletResponse response) throws Exception{
        response.setContentType("text/html;charset=utf-8"); //指定输出内容类型和编码   
        String msg="{\"type\":\"success\"}";
        PrintWriter out = response.getWriter();//获取输出口        	
        try{      	
        	request.getSession().removeAttribute("code");        	
            out.write(msg);//返回结果
            out.flush();  
            out.close();  
        }catch(Exception ex){
        	log.error(ex);
            msg="{\"error\":\"提交出现不可预料的错误.\"}";
            out.write(msg);//返回结果
            out.flush();  
            out.close();  
        }
	}

	
}
