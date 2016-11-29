package cloud.shop.goods.controller;

import java.io.PrintWriter;
import java.util.Date;

import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import cloud.shop.common.Common;
import cloud.shop.common.Constants;
import cloud.shop.common.MD5Encrypt;
import cloud.shop.goods.entity.Customer;

import cloud.shop.goods.service.CustomerService;

import cloud.shop.merchandise.service.MerchandiseCategoriesService;

@Controller
@RequestMapping("/register")
public class RegisterController {
	
	@Autowired
	private CustomerService customerService;  
	@Autowired
	private MerchandiseCategoriesService merchandiseCategoriesService;
	
	/**
	 * 注册
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/showShopRegister")
	public String showShopRegister(ModelMap model) throws Exception
	{
		return "page/shop/home/register/register";
	}
	
	/**
	 * 提交数据到数据库
	 * @param request
	 * @param response
	 * @param catalog
	 */
	@RequestMapping(value = "/submit")
	public String submit(HttpServletRequest request,HttpServletResponse response,Customer user,ModelMap model)throws Exception
	{       
		    String enPassword=request.getParameter("password");
    		String mobile=request.getParameter("mobile");
    		 Integer sum=(int)((Math.random()*9+1)*100000000);
		    user.setName(sum.toString());
		    user.setMobile(mobile);
			user.setCreate_time(new Date());
			user.setUpdate_time(new Date());
			user.setId(UUID.randomUUID().toString().replace("-", ""));
			user.setStatus("0");
			user.setType("0");	
			user.setPassword(MD5Encrypt.encrypt(enPassword));
			customerService.insertCustomer(user);
			request.getSession().setAttribute(Constants.SESSION_LOGIN_USER_GOODS, user);//将用户信息放入session
		
		return "tologin";
				
	}
	
	
	@RequestMapping(value = "/toSms")
	public String toSms(HttpServletRequest request,HttpServletResponse response,ModelMap model)throws Exception
	{
		String mobile=request.getParameter("mobile");
		model.addAttribute("mobile", mobile);
		return "page/shop/home/register/sms";
		
	}
	
	@RequestMapping(value = "/writPwd")
	public String writPwd(HttpServletRequest request,HttpServletResponse response,ModelMap model)throws Exception
	{
		String mobile=request.getParameter("phone");
		model.addAttribute("mobile", mobile);
		return "page/shop/home/register/edit";
		
	}
	
	/**
	 * 检查用户是否有
	 * @param request
	 * @param response
	 * @param catalog
	 */
	@RequestMapping(value = "/check_username")
	public void check_username(HttpServletRequest request,HttpServletResponse response,ModelMap model){
		response.setContentType("text/html;charset=utf-8"); //指定输出内容类型和编码
        try{
        	PrintWriter out = response.getWriter();//获取输出口
        	boolean isValid = true;
        	int num=customerService.checkUsername(request.getParameter("name"));        	
        	if(num!=0)
        	{
        		isValid = false;
        	}        	
        	out.print(isValid);//返回结果
            out.flush();  
            out.close(); 
        }catch(Exception ex){
            ex.printStackTrace();
        }
	}
	
	
	/**
	 * 检查用户是否没有
	 * @param request
	 * @param response
	 * @param catalog
	 */
	@RequestMapping(value = "/check_username_no")
	public void check_username_no(HttpServletRequest request,HttpServletResponse response,ModelMap model){
		response.setContentType("text/html;charset=utf-8"); //指定输出内容类型和编码
        try{
        	PrintWriter out = response.getWriter();//获取输出口
        	boolean isValid = false;
        	int num=0;
        	if(Common.isMobileNO(request.getParameter("name")))
        	{
        		 
        		 num=customerService.checkPhone(request.getParameter("name"));
        	}
        	else
        	{
        		num=customerService.checkUsername(request.getParameter("name"));    
        	}
        	if(num!=0)
        	{
        		isValid = true;
        	}        	
        	out.print(isValid);//返回结果
            out.flush();  
            out.close(); 
        }catch(Exception ex){
            ex.printStackTrace();
        }
	}
	/**
	 * 检查邮件是否有
	 * @param request
	 * @param response
	 * @param catalog
	 */
	@RequestMapping(value = "/check_email")
	public void check_email(HttpServletRequest request,HttpServletResponse response,ModelMap model){
		response.setContentType("text/html;charset=utf-8"); //指定输出内容类型和编码
        try{
        	PrintWriter out = response.getWriter();//获取输出口
        	boolean isValid = true;
            HttpSession session=request.getSession();
    		Customer user=(Customer) session.getAttribute(Constants.SESSION_LOGIN_USER_GOODS);
    		if(null==user)
    		{
    			user=new Customer();
    		}    		
        	user.setEmail(request.getParameter("email"));
        	int num=customerService.checkFieldStatus(user); 
        	if(num!=0)
        	{
        		isValid = false;
        	}
        	out.print(isValid);//返回结果
            out.flush();  
            out.close(); 
        }catch(Exception ex){
            ex.printStackTrace();
        }
	}
	
	/**
	 * 检查电话是否有
	 * @param request
	 * @param response
	 * @param catalog
	 */
	@RequestMapping(value = "/check_phone")
	public void check_phone(HttpServletRequest request,HttpServletResponse response){
		response.setContentType("text/html;charset=utf-8"); //指定输出内容类型和编码
        try{
        	PrintWriter out = response.getWriter();//获取输出口
        	boolean isValid = true;
            HttpSession session=request.getSession();
    		Customer user=(Customer) session.getAttribute(Constants.SESSION_LOGIN_USER_GOODS);
    		if(null==user)
    		{
    			user=new Customer();
    		}    		
        	user.setMobile(request.getParameter("mobile"));
        	int num=customerService.checkFieldStatus(user); 
        	if(num!=0)
        	{
        		isValid = false;
        	}
        	out.print(isValid);//返回结果
            out.flush();  
            out.close(); 
        }catch(Exception ex){
            ex.printStackTrace();
        }
	}
 
}
