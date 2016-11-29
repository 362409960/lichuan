package cloud.shop.goods.controller;



import java.io.PrintWriter;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import cloud.shop.common.Constants;
import cloud.shop.common.MD5Encrypt;
import cloud.shop.goods.entity.Customer;
import cloud.shop.goods.entity.Orders;
import cloud.shop.goods.entity.OrdersDetail;
import cloud.shop.goods.entity.ShippingAddress;
import cloud.shop.goods.service.CustomerService;
import cloud.shop.goods.service.OrdersDetailService;
import cloud.shop.goods.service.OrdersService;
import cloud.shop.goods.service.ShippingAddressService;
import cloud.shop.goods.vo.OrdersVO;
import cloud.shop.merchandise.entity.MerchandiseCategories;
import cloud.shop.merchandise.service.MerchandiseCategoriesService;


@Controller
@RequestMapping("/member")
public class MemberCentreController {
	
	@Autowired
	private MerchandiseCategoriesService merchandiseCategoriesService;
	@Autowired
	private CustomerService customerService;
	@Autowired
	private ShippingAddressService shippingAddressService;
	@Autowired
	private OrdersDetailService ordersDetailService;
	@Autowired
	private OrdersService ordersService;
	
	@RequestMapping(value="/showCentre")
	public String showCentre(ModelMap model) throws Exception
	{
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
	     return "page/shop/home/member/index";
		}
	/**
	 * 初始化页面
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/showInit")
	public String showInit(ModelMap model,HttpServletRequest request,HttpServletResponse response) throws Exception
	{
		Customer user=(Customer) request.getSession().getAttribute(Constants.SESSION_LOGIN_USER_GOODS);
		Orders orders=new Orders();
		orders.setAccount_id(user.getId());
		List<Orders> ordersList=ordersService.getOrdersAndStatusList(orders);
		List<OrdersVO> ordersVOList=new LinkedList<OrdersVO>();
		if(null != ordersList && !ordersList.isEmpty())
		{
			for(Orders o:ordersList)
			{
				OrdersVO ordersVO=new OrdersVO();
				ordersVO.setAmount(o.getOrder_amount());
				ordersVO.setCreatDate(o.getCreate_time());
				ordersVO.setOid(o.getOid());
				ordersVO.setReceiver(o.getReceiver());
				ordersVO.setStatus(o.getStatus());
				List<OrdersDetail> odList=ordersDetailService.getOrdersDetailByOidList(o.getOid());	
				ordersVO.setOrdlist(odList);
				ordersVOList.add(ordersVO);
			}
			
			model.addAttribute("ordersVOList", ordersVOList);
			model.addAttribute("isTrue", true);
		}
		else
		{
			model.addAttribute("isTrue", false);
		}
		//需要付款的数量
		Integer total=ordersService.getStatusCount(user.getId());
		model.addAttribute("total", total);
	     return "page/shop/home/member/init";
	}
	
	@RequestMapping(value="/showUserData")
	public String showUserData(ModelMap model,HttpServletRequest request,HttpServletResponse response) throws Exception
	{
		HttpSession session=request.getSession();
		Customer user1=(Customer) session.getAttribute(Constants.SESSION_LOGIN_USER_GOODS);
		Customer user=customerService.getUser(user1);
		model.addAttribute("user", user);
	     return "page/shop/home/member/user_data";
	}
	
	@RequestMapping(value="/showUserPassword")
	public String showUserPassword(ModelMap model,HttpServletRequest request,HttpServletResponse response) throws Exception
	{
		HttpSession session=request.getSession();
		Customer user1=(Customer) session.getAttribute(Constants.SESSION_LOGIN_USER_GOODS);
		Customer user=customerService.getUser(user1);
		model.addAttribute("user", user);
	     return "page/shop/home/member/user_password";
	}
	/**
	 * 修改用户资料
	 * @param request
	 * @param response
	 * @param catalog
	 * @throws Exception 
	 */
	@RequestMapping(value = "/updateUserData")
	public String updateUserData(HttpServletRequest request,HttpServletResponse response,ModelMap model,Customer user) throws Exception{
		user.setUpdate_time(new Date());
		user.setId(request.getParameter("id")); 
		user.setUpdate_time(new Date());
		customerService.updateUser(user);
		return  showUserData(model, request, response);
	}
	
	/**
	 * 修改用户密码
	 * @param request
	 * @param response
	 * @param catalog
	 * @throws Exception 
	 */
	@RequestMapping(value = "/updateUserPassword")
	public String updateUserPassword(HttpServletRequest request,HttpServletResponse response,ModelMap model,Customer user) throws Exception{
		user.setUpdate_time(new Date());
		user.setId(request.getParameter("id")); 
		user.setUpdate_time(new Date());
		user.setPassword(MD5Encrypt.encrypt(user.getPassword()));
		customerService.updateUserPassword(user);
		return  showUserPassword(model, request, response);
	}
	
	/**
	 * 检查密码是否正确
	 * @param request
	 * @param response
	 * @param catalog
	 */
	@RequestMapping(value = "/check_password")
	public void check_password(HttpServletRequest request,HttpServletResponse response,ModelMap model){
		response.setContentType("text/html;charset=utf-8"); //指定输出内容类型和编码
        try{
        	PrintWriter out = response.getWriter();//获取输出口
        	boolean isValid = false;
            HttpSession session=request.getSession();
    		Customer user=(Customer) session.getAttribute(Constants.SESSION_LOGIN_USER_GOODS);    		  		
        	user.setPassword(MD5Encrypt.encrypt(request.getParameter("currentPassword")));
        	int num=customerService.checkFieldStatus(user); 
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
	 * 
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/showShippingAddress")
	public String showShippingAddress(ModelMap model,HttpServletRequest request,HttpServletResponse response) throws Exception
	{
		HttpSession session=request.getSession();
		Customer user=(Customer) session.getAttribute(Constants.SESSION_LOGIN_USER_GOODS);
		ShippingAddress sh=new ShippingAddress();
		sh.setCustomer_id(user.getId());
		List<ShippingAddress> saList=shippingAddressService.getShippingAddressList(sh);
		if(null !=saList && !saList.isEmpty())
		{
			model.addAttribute("user", saList);
			model.addAttribute("isTrue", true);
		}
		else
		{
			model.addAttribute("isTrue", false);
		}
	     return "page/shop/home/member/shop_address";
	}
}
