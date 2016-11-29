package cloud.app.system.controller;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import cloud.app.service.mqtt.impl.WebMqttClient;
import cloud.app.system.service.LoginService;
import cloud.app.system.vo.SysUserVO;
import cloud.app.common.Constants;


@Controller
@RequestMapping("/sys")
public class LoginController {

	private SysUserVO user;
	private String jsonData;

	@Autowired
	private LoginService loginService;
	@Autowired
	WebMqttClient webMqttClient;
	
	@RequestMapping(value = "/reLogin", method = RequestMethod.GET)
	public String SessionReload()throws Exception{
		return "login";
	}
	
	
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public ModelAndView logout(HttpServletRequest request,HttpServletResponse response)throws Exception{
		request.getSession().removeAttribute(Constants.SESSION_LOGIN_USER);
		
		//ModelAndView modelAndView = new ModelAndView("login");
		
		ModelAndView modelAndView = new ModelAndView("init");
		return modelAndView;
	}
	
	 
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public void login(HttpServletRequest request,HttpServletResponse response) throws Exception{
        response.setContentType("text/html;charset=utf-8"); //指定输出内容类型和编码    
        PrintWriter out = response.getWriter();
        try{  
        	String name = request.getParameter("name");
        	String password = request.getParameter("password");
        	SysUserVO user = new SysUserVO();
        	//if(isNumeric(name)){
        	//	user.setPhone(name);
        	//}else{
        		user.setUserCode(name);
        	//}
        	//user.setEmail(name);
        	user.setUserPassword(password);
        	String ip = request.getRemoteHost();
        	
        	SysUserVO vo = loginService.updateLogin(user, ip);
        	
        	if(vo == null){
        		jsonData="{\"success\":\"none\"}";
        	}else{            
            	request.getSession().setAttribute(Constants.SESSION_LOGIN_USER, user);
            	request.getSession().setAttribute("userId", user.getId());
            	request.getSession().setAttribute("userCode", user.getUserCode());
            	jsonData="{\"success\":\"true\",\"id\":\""+user.getId()+"\"}";
            	
            	System.out.println("------------------ "+vo.getUserCode()+" 客户端MQTT登录------------------ ");
            	
            	//订阅主题
            	//用户登录时订阅消息
            	//webMqttClient.connection(vo.getId(), vo.getUserCode());
        	}
        	
        	out.write(jsonData);
			out.flush();
        }catch(Exception ex){
            ex.printStackTrace();
        }
	}

	public String modifyPwd(HttpServletRequest request,HttpServletResponse response)throws Exception {
		SysUserVO sysUserVO;
		
		try {
			HttpSession session = request.getSession();
			Object obj = session.getAttribute(Constants.SESSION_LOGIN_USER);
			if(obj == null){
				throw new Exception("session 失效，请重新登录.");
			}else{
				sysUserVO = (SysUserVO)obj;
			}
			user.setId(sysUserVO.getId());
		
			
			jsonData="{\"success\":\"ture\"}";
	    } catch (Exception e) {
	    	jsonData="{\"success\":\"false\"}";
	    }
	    return jsonData;
	  }
	
	
	 @RequestMapping(value = "/ajaxVerifyYzCode")
	    public void ajaxVerifyYzCode(HttpServletRequest request,HttpServletResponse response){
	    	PrintWriter out = null;	    	
	    	try{
				String rv = (String)request.getSession().getAttribute("rv");
				if (rv == null) {
					jsonData="{\"success\":\"false\"}";
			    }
				String passcode = request.getParameter("passcode");
				
				out = response.getWriter();
				if (!rv.equalsIgnoreCase(passcode)) {
					jsonData="{\"success\":\"false\"}";
			    }else{
			    	jsonData="{\"success\":\"true\"}";
			    }
				out.write(jsonData);
				out.flush();
			}catch(Exception ex){
				jsonData="{\"success\":\"false\"}";
				out.write(jsonData);
				out.flush();
			}finally{
				if(out != null){
					out.close();
				}
			}
	    }

	 @RequestMapping(value = "/loginInit", method = RequestMethod.GET)
	  public String loginInit() throws Exception {
	    	return "init";
	    }
	 
	public SysUserVO getUser() {
		return user;
	}
	public void setUser(SysUserVO user) {
		this.user = user;
	}
	public String getJsonData() {
		return jsonData;
	}
	public void setJsonData(String jsonData) {
		this.jsonData = jsonData;
	}
	
	
	 //判断字符串是否为数字
  	public static boolean isNumeric(String str){
  		for (int i = str.length();--i>=0;){   
  			if (!Character.isDigit(str.charAt(i))){
  				return false;
  			}
  		}
  		return true;
  	}
	
	
}
