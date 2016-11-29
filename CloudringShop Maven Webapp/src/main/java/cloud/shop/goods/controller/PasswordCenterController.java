package cloud.shop.goods.controller;

import java.io.PrintWriter;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;



import cloud.shop.common.Common;
import cloud.shop.goods.entity.Customer;
import cloud.shop.goods.service.CustomerService;
import cloud.shop.merchandise.entity.MerchandiseCategories;
import cloud.shop.merchandise.service.MerchandiseCategoriesService;


@Controller
@RequestMapping("/password")
public class PasswordCenterController {
	
	private static Logger log=Logger.getLogger(PasswordCenterController.class);
	
	@Autowired
	private CustomerService customerService;
	
	@Autowired
	private MerchandiseCategoriesService merchandiseCategoriesService;
	
	@RequestMapping(value = "/find")
	public String find(ModelMap model,HttpServletRequest request,HttpServletResponse response) throws Exception {	        
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
			return "page/shop/home/password/find";
	    }
	
	@RequestMapping(value = "/edit")
	public String edit(ModelMap model,HttpServletRequest request,HttpServletResponse response) throws Exception {	        
	        
			String name=request.getParameter("name");
			Boolean flag=Common.isMobileNO(name);
			if(!flag)
			{
				Customer user=customerService.getUserIphone(name);		
				model.addAttribute("phone", user.getMobile());
			}
			else
			{
				model.addAttribute("phone", name);
				
			}
			
			return "page/shop/home/password/sms";
	    }
	
	
	@RequestMapping(value = "/toEdit")
	public String toEdit(ModelMap model,HttpServletRequest request,HttpServletResponse response) throws Exception {
			String name=request.getParameter("phone");
			model.addAttribute("phone", name);
			return "page/shop/home/password/update";
	    }
	@RequestMapping(value = "/updatePassword")
	public void updatePassword(HttpServletRequest request,HttpServletResponse response) throws Exception{
        response.setContentType("text/html;charset=utf-8"); //指定输出内容类型和编码   
        String msg="{\"type\":\"success\"}";
        PrintWriter out = response.getWriter();//获取输出口        	
        try{  
        	String name=request.getParameter("phone");
        	String password=request.getParameter("enpassword");
        	Customer user=new Customer();
        	user.setMobile(name);
        	user.setPassword(password);
        	customerService.updateUserPasswordByName(user);
            out.write(msg);//返回结果
            out.flush();  
            out.close();  
        }catch(Exception ex){
        	log.error(ex);
            msg="{\"error\":\"密码更新失败.\"}";
            out.write(msg);//返回结果
            out.flush();  
            out.close();  
        }
	}

}
