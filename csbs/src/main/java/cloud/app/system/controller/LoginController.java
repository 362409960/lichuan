package cloud.app.system.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import cloud.app.common.Constants;
import cloud.app.system.service.LoginService;
import cloud.app.system.service.SysUserService;
import cloud.app.system.vo.SysUserVO;


@Controller
@RequestMapping("/sys")
public class LoginController {

	private SysUserVO user;
	
	@Autowired
	private SysUserService sysUserService;
	@Autowired
	private LoginService loginService;
	
	
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public void login(HttpServletRequest request,HttpServletResponse response) throws Exception{
        response.setContentType("text/html;charset=utf-8"); //指定输出内容类型和编码    
        try{  
        	PrintWriter out = response.getWriter();//获取输出口
        	boolean isValid=false;//用户信息是否有效标识
        	if(user == null){
        		user = new SysUserVO();
        	}
        	user.setUserCode(request.getParameter("usercode"));
        	user.setUserPassword(request.getParameter("password"));

        	String ip = request.getRemoteHost();
        	user = loginService.updateLogin(user, ip);
        	 
        	if (user != null) {//检查用户名和密码是否有效
        		request.getSession().setAttribute(Constants.SESSION_LOGIN_USER, user);//将用户信息放入session
        		request.getSession().setAttribute("username", request.getParameter("usercode"));
				isValid=true;
			}
        	
            out.print(isValid);//返回结果
            out.flush();  
            out.close();  
        }catch(Exception ex){
            ex.printStackTrace();
        }
	}

	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public void logout(HttpServletRequest request,HttpServletResponse response) throws IOException {
	        // 清除session
	        request.getSession().removeAttribute(Constants.SESSION_LOGIN_USER);	
	        request.getSession().removeAttribute("username");
	        request.getSession().invalidate();	
	        String path = request.getContextPath();
			response.sendRedirect(path+"/login.jsp"); 
	    }

	public SysUserVO getUser() {
		return user;
	}
	public void setUser(SysUserVO user) {
		this.user = user;
	}
	
	
	
}
