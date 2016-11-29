package cloud.shop.goods.controller;


import java.io.PrintWriter;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;




import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


import cloud.shop.common.Common;
import cloud.shop.common.Constants;
import cloud.shop.goods.entity.Customer;
import cloud.shop.goods.entity.ShippingCart;

import cloud.shop.goods.service.CustomerService;
import cloud.shop.goods.service.ShippingCartService;

import cloud.shop.merchandise.entity.MerchandiseCategories;
import cloud.shop.merchandise.service.MerchandiseCategoriesService;
import cloud.shop.system.service.LoginService;
import cloud.shop.system.vo.SysUserVO;


@Controller
@RequestMapping("/login")
public class CustomerController {
	@Autowired
	private CustomerService customerService;
	
	@Autowired
	private ShippingCartService shippingCartService;
	
	@Autowired
	private MerchandiseCategoriesService merchandiseCategoriesService;
	@Autowired
	private LoginService loginService;
	public Customer getUser() {
		return user;
	}
	public void setUser(Customer user) {
		this.user = user;
	}
	private Customer user;
	/*@RequestMapping(value = "/login")
	public String login(HttpServletRequest request, HttpServletResponse response)throws Exception {
		String username = (String) request.getSession().getAttribute("username");
		if(null==username)
		{
			return "home";
		}
		else
		{
		String ip = Common.getIpAddr(request);
		if (!"admin".equals(username)) 
		{
			if (user == null) 
			{
				user = new Customer();
			}
			//判断是否是手机
			if(Common.isMobileNO(username))
			{
				user.setMobile(username);
			}
			else
			{
				user.setName(username);
			}
			user = customerService.getUser(user);
			if (user != null) 
			{
				List<ShippingCart> list = shippingCartService.getCartByUserNameList(ip);
				if (null != list && !list.isEmpty()) {
					for (ShippingCart cart : list) {
						cart.setUser_id(user.getId());
						shippingCartService.updateShippingCart(cart);
					}
				}
				request.getSession().setAttribute(Constants.SESSION_LOGIN_USER_GOODS, user);// 将用户信息放入session
			}
			return "home";
		} 
		else 
		{
			SysUserVO user=new SysUserVO();
			user.setUserCode(username);        
        	user = loginService.updateLogin(user, ip);        	 
        	if (user != null) {
        		request.getSession().setAttribute(Constants.SESSION_LOGIN_USER, user);//将用户信息放入session				
			}        	
			return "redirect:/index.jsp";
		}

		}
	}*/
	
	@RequestMapping(value = "/login")
	public void login(HttpServletRequest request,HttpServletResponse response) throws Exception{
        response.setContentType("text/html;charset=utf-8"); //指定输出内容类型和编码    
        try{  
        	PrintWriter out = response.getWriter();//获取输出口
        	String ip =Common.getIpAddr(request);
        	String msg="{\"type\":\"success\"}";
        	if(user == null){
        		user = new Customer();
        	}
        		String code=request.getParameter("username");
        		Boolean flag=Common.isMobileNO(code);
        		if(!flag)
        		{
        			int num=customerService.checkUsername(request.getParameter("username"));
        			 if(num==0)
                     {
                     	msg="{\"error\":\"1\"}";
                     }
                     else
                     {
                     	user.setName(request.getParameter("username"));
                     	user.setPassword(request.getParameter("enPassword"));
                     	user = customerService.getUser(user);
                     	if (user != null) {//检查用户名和密码是否有效
                     		List<ShippingCart> list=shippingCartService.getCartByUserNameList(ip);
                     		if(null != list && !list.isEmpty()){
                     			for(ShippingCart cart:list)
                     			{
                     				cart.setUser_id(user.getId());
                     				shippingCartService.updateShippingCart(cart);
                     			}
                     		}
                     		request.getSession().setAttribute(Constants.SESSION_LOGIN_USER_GOODS, user);//将用户信息放入session
             				
             			}
                     	else
                     	{
                     		msg="{\"error\":\"2\"}";
                     	}
                     }
        		}
        		else
        		{
        			int num=customerService.checkPhone(request.getParameter("username"));
       			 if(num==0)
                    {
                    	msg="{\"error\":\"1\"}";
                    }
                    else
                    {
                    	user.setMobile(request.getParameter("username"));
                    	user.setPassword(request.getParameter("enPassword"));
                    	user = customerService.getUser(user);
                    	if (user != null) {//检查用户名和密码是否有效
                    		List<ShippingCart> list=shippingCartService.getCartByUserNameList(ip);
                    		if(null != list && !list.isEmpty()){
                    			for(ShippingCart cart:list)
                    			{
                    				cart.setUser_id(user.getId());
                    				shippingCartService.updateShippingCart(cart);
                    			}
                    		}
                    		request.getSession().setAttribute(Constants.SESSION_LOGIN_USER_GOODS, user);//将用户信息放入session
            				
            			}
                    	else
                    	{
                    		msg="{\"error\":\"2\"}";
                    	}
                    }
        		}
        	
            out.write(msg);//返回结果
            out.flush();  
            out.close();  
        }catch(Exception ex){
            ex.printStackTrace();
        }
	}
	@RequestMapping(value = "/loginout", method = RequestMethod.GET)
	public String loginOut(ModelMap model,HttpServletRequest request,HttpServletResponse response) throws Exception {
	        // 清除session
	        request.getSession().removeAttribute(Constants.SESSION_LOGIN_USER_GOODS);	
	        request.getSession().invalidate();
	        List<MerchandiseCategories> categoriesList=merchandiseCategoriesService.getCategorieConditionList();
			Map<String,String> menu=new LinkedHashMap<String,String>();
			if(null != categoriesList && !categoriesList.isEmpty())
			{
				for(MerchandiseCategories mc:categoriesList)
				{
					menu.put(mc.getId(), mc.getName());
					
				}
			}
			model.addAttribute("menu", menu);
			return "page/shop/home/reception_login";
	    }
	@RequestMapping(value = "/check")
	public void check(HttpServletRequest request,HttpServletResponse response) throws Exception{
        response.setContentType("text/html;charset=utf-8"); //指定输出内容类型和编码    
        try{  
        	PrintWriter out = response.getWriter();//获取输出口
        	boolean isValid=false;//用户信息是否有效标识
        	HttpSession sesion=request.getSession();
        	user=(Customer) sesion.getAttribute(Constants.SESSION_LOGIN_USER_GOODS);
        	if(user != null){
        		isValid=true;
        	}
            out.print(isValid);//返回结果
            out.flush();  
            out.close();  
        }catch(Exception ex){
            ex.printStackTrace();
        }
	}
}
