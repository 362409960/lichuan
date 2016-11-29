package cloud.shop.goods.controller;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.math.BigDecimal;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.alipay.config.AlipayConfig;
import com.alipay.util.AlipayNotify;
import com.alipay.util.AlipaySubmit;
import com.alipay.util.UtilDate;



import cloud.shop.common.Constants;
import cloud.shop.goods.entity.Customer;
import cloud.shop.goods.entity.Orders;
import cloud.shop.goods.entity.OrdersDetail;
import cloud.shop.goods.entity.ShippingAddress;
import cloud.shop.goods.entity.ShippingCart;
import cloud.shop.goods.entity.TradInfo;
import cloud.shop.goods.service.OrdersDetailService;
import cloud.shop.goods.service.OrdersService;
import cloud.shop.goods.service.ShippingAddressService;
import cloud.shop.goods.service.ShippingCartService;
import cloud.shop.goods.service.TradInfoService;
import cloud.shop.goods.vo.OrdersVO;
import cloud.shop.merchandise.entity.MerchandiseCategories;
import cloud.shop.merchandise.service.MerchandiseCategoriesService;

@Controller
@RequestMapping("/orders")
public class OrdersController {
	
	Logger log=Logger.getLogger(OrdersController.class);
	
	@Autowired
	private MerchandiseCategoriesService merchandiseCategoriesService;
	@Autowired
	private ShippingAddressService shippingAddressService;
	@Autowired
	private OrdersDetailService ordersDetailService;
	@Autowired
	private OrdersService ordersService;
	@Autowired
	private ShippingCartService shippingCartService;
	@Autowired
	private TradInfoService tradInfoService;
	
	@RequestMapping(value="/checkout")
	public String checkout(ModelMap model,HttpServletRequest request,HttpServletResponse response) throws Exception
	{
		Customer user=(Customer) request.getSession().getAttribute(Constants.SESSION_LOGIN_USER_GOODS);
		List<MerchandiseCategories> categoriesList=merchandiseCategoriesService.getCategorieConditionList();
		Map<String,String> menu=new LinkedHashMap<String,String>();
		if(null != categoriesList && !categoriesList.isEmpty())
		{
			for(MerchandiseCategories mc:categoriesList)
			{
				menu.put(mc.getId(), mc.getName());
			}
		}
		ShippingAddress shop=new ShippingAddress();
		shop.setCustomer_id(user.getId());
		List<ShippingAddress> addressList=shippingAddressService.getShippingAddressList(shop);
		if(null != addressList && !addressList.isEmpty())
		{
			ShippingAddress ress=addressList.get(0);
			model.addAttribute("ress", ress);
			model.addAttribute("isTrue", true);
			model.addAttribute("aList", addressList);
		}
		else
		{
			model.addAttribute("isTrue", false);
		}
		BigDecimal total=new BigDecimal(0.00);
		ShippingCart cart=new ShippingCart();
		cart.setUser_id(user.getId());
		List<ShippingCart> cartList=shippingCartService.getShippingCartList(cart);
		if(null != cartList && !cartList.isEmpty())
		{
			for(ShippingCart c:cartList)
			{
				total=total.add(new BigDecimal(c.getSubtotal()));				
			}
		}
		
		model.addAttribute("total", total);
		 model.addAttribute("cartList", cartList);
		 model.addAttribute("menu", menu);
	     return "page/shop/home/orders/checkout";
		}
	
	/**
	 * 在订单页面新增
	 * @param request
	 * @param response
	 * @param catalog
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/save")
	public void save(HttpServletRequest request,HttpServletResponse response,Orders orders){
		response.setContentType("text/html;charset=utf-8"); //指定输出内容类型和编码
        try{
        	PrintWriter out = response.getWriter();//获取输出口
        	boolean isValid = false;
  		    Customer user=(Customer) request.getSession().getAttribute(Constants.SESSION_LOGIN_USER_GOODS);
  		    String ordersId=UUID.randomUUID().toString().replace("-", "");
  		    orders.setId(ordersId);
          	String receiverId=request.getParameter("receiver_id");
          	ShippingAddress shopAddress=shippingAddressService.getShoppingAddressByIdList(receiverId);
          	BigDecimal total=new BigDecimal(0.00);
    		ShippingCart cart=new ShippingCart();
    		cart.setUser_id(user.getId());
    		List<ShippingCart> cartList=shippingCartService.getShippingCartList(cart);
    		if(null != cartList && !cartList.isEmpty())
    		{
    			for(ShippingCart c:cartList)
    			{
    				total=total.add(new BigDecimal(c.getSubtotal()));				
    			}
    		}
          	orders.setAccount_id(user.getId());
    		orders.setAddress(shopAddress.getProvince_id()+shopAddress.getCity_id()+shopAddress.getDistrict_id()+shopAddress.getAddress());
    		orders.setReceiver(shopAddress.getContacts());
    		orders.setZip_code(shopAddress.getZipcode());
    		orders.setTel(shopAddress.getMobile());
    		//返回系统当前时间(精确到毫秒),作为一个唯一的订单编号
    		String oid =UtilDate.getOrderNum();
    		orders.setOid(oid);
    		orders.setPrice(total);
    		orders.setUpdate_time(new Date());
    		orders.setCreate_time(new Date());
    		orders.setOrder_amount(orders.getAmounts_payable());
    		orders.setStatus(Constants.WAIT_FOR_PAY);
    		ordersService.save(orders);
    	
    		if(null != cartList && !cartList.isEmpty())
    		{
    			for(ShippingCart c:cartList)
    			{
    				OrdersDetail od=new OrdersDetail();
    				od.setGoods_url(c.getGoods_url());
    				od.setGoods_id(c.getGoods_id());
    				od.setName(c.getPicture());
    				od.setPrice(c.getPrice());
    				od.setQuantity(c.getQuantity());
    				od.setOid(oid);
    				od.setSubtotal(new BigDecimal(c.getSubtotal()));
    				od.setOrder_info_id(ordersId);
    				od.setId(UUID.randomUUID().toString().replace("-", ""));
    				ordersDetailService.save(od);
    				shippingCartService.deleteById(c.getId());
    			}
    		}
    		isValid = true;
    		List list=new LinkedList();
    		list.add(ordersId);
    		list.add(oid);
    		list.add(isValid);
    		String json = JSONArray.fromObject(list).toString();//转化为JSON	
    		out.write(json);
			out.flush();
			out.close();
        }catch(Exception ex){
            ex.printStackTrace();
        }
	}

	
	@SuppressWarnings("unused")
	@RequestMapping(value="/payment")
	public String payment(ModelMap model,HttpServletRequest request,HttpServletResponse response) throws Exception
	{
		Customer user=(Customer) request.getSession().getAttribute(Constants.SESSION_LOGIN_USER_GOODS);
		List<MerchandiseCategories> categoriesList=merchandiseCategoriesService.getCategorieConditionList();
		Map<String,String> menu=new LinkedHashMap<String,String>();
		if(null != categoriesList && !categoriesList.isEmpty())
		{
			for(MerchandiseCategories mc:categoriesList)
			{
				menu.put(mc.getId(), mc.getName());
			}
		}
		  String sn=request.getParameter("sn");
		  Orders orders=ordersService.getOrdersByOidList(sn);
		  model.addAttribute("orders", orders);
		  model.addAttribute("menu", menu);
	     return "page/shop/home/orders/pay_orders";
		}
	

	@RequestMapping(value="/list")
	public String list(ModelMap model,HttpServletRequest request,HttpServletResponse response) throws Exception
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
	   return "page/shop/home/orders/list";
	}
	
	@RequestMapping(value="/view")
	public String view(ModelMap model,HttpServletRequest request,HttpServletResponse response) throws Exception
	{
		String sn=request.getParameter("sn");
		List<OrdersDetail> detialList=ordersDetailService.getOrdersDetailByOidList(sn);	
		Orders orders=new Orders();
		orders.setOid(sn);
		List<Orders> ordersList=ordersService.getOrdersAndStatusList(orders);
		Orders der=ordersList.get(0);
		if("等待付款".equals(der.getStatus()))
		{
			model.addAttribute("isTrue", true);
		}
		model.addAttribute("orders", der);
		model.addAttribute("detialList", detialList);
	   return "page/shop/home/orders/view";
	}
	
	@RequestMapping(value="viewDetail")
	public String viewDetail(ModelMap model,HttpServletRequest request,HttpServletResponse response) throws Exception
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
		
		String sn=request.getParameter("sn");
		List<OrdersDetail> detialList=ordersDetailService.getOrdersDetailByOidList(sn);	
		Orders orders=new Orders();
		orders.setOid(sn);
		List<Orders> ordersList=ordersService.getOrdersAndStatusList(orders);
		Orders der=ordersList.get(0);
		if("等待付款".equals(der.getStatus()))
		{
			model.addAttribute("isTrue", true);
		}
		model.addAttribute("orders", der);
		model.addAttribute("detialList", detialList);
		 model.addAttribute("menu", menu);
	   return "page/shop/home/orders/view_detail";
	}
	
	/**
	 * 在订单页面新增
	 * @param request
	 * @param response
	 * @param catalog
	 */
	@SuppressWarnings("unused")
	@RequestMapping(value = "/cancel")
	public void cancel(HttpServletRequest request,HttpServletResponse response){
		response.setContentType("text/html;charset=utf-8"); //指定输出内容类型和编码
        try{
        	PrintWriter out = response.getWriter();//获取输出口
        	boolean isValid = false;
  		    Customer user=(Customer) request.getSession().getAttribute(Constants.SESSION_LOGIN_USER_GOODS);
  		    String sn=request.getParameter("sn");
  		    Orders orders=new Orders();
  		  	orders.setOid(sn);
  		    List<Orders> ordersList=ordersService.getOrdersList(orders);
  		     Orders orders1= ordersList.get(0);
  		     orders1.setStatus(Constants.CANCELLED);
  		     ordersService.update(orders1);
  		    isValid=true;
    		out.print(isValid);
			out.flush();
			out.close();
        }catch(Exception ex){
            ex.printStackTrace();
        }
	}

	
	/**
	 * 支付功能
	 * @param model
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("unused")
	@RequestMapping(value="/plugin_submit")
	public String plugin_submit(ModelMap model,HttpServletRequest request,HttpServletResponse response) throws Exception
	{
		Customer user=(Customer) request.getSession().getAttribute(Constants.SESSION_LOGIN_USER_GOODS);
		String sn=request.getParameter("oid");//商户订单号
		String type=request.getParameter("type");
	     Orders orders=ordersService.getOrdersByOidList(sn);
	     List<OrdersDetail> odList=ordersDetailService.getOrdersDetailByOidList(sn);
	     String subjectName="";
	     Integer sum=0;
	     if(null != odList && !odList.isEmpty())
	     {
	    	 for(OrdersDetail ordersDetail:odList)
	    	 {
	    		 subjectName=subjectName+ordersDetail.getName()+",";
	    		 sum+=ordersDetail.getQuantity();
	    	 }
	     }
		if("1".equals(type))//支付宝
		{
			String path = request.getContextPath();
			//支付类型
			String payment_type = "1";
			//服务器异步通知页面路径
			String notify_url = getP().getProperty("service_address")+"/CloudringShop/orders/notify_url.do";
			//页面跳转同步通知页面路径
			String return_url = getP().getProperty("service_address")+"/CloudringShop/orders/return_url.do";
			//商户订单号
			String out_trade_no = sn;
			//订单名称
			String subject = subjectName.substring(0,subjectName.length()-1);
			//必填
			//付款金额
			String total_fee = orders.getAmounts_payable().toString();
			//必填
			//订单描述
			String body = "订单名称："+subject+","+"订单价格："+total_fee+","+"商品数量："+sum+","+"订单号："+sn;
			//商品展示地址
			String show_url = getP().getProperty("service_address")+"/CloudringShop";
			//需以http://开头的完整路径，例如：http://www.商户网址.com/myorder.html
			//客户端的IP地址
			String exter_invoke_ip = getP().getProperty("ip");
			
			Map<String, String> sParaTemp = new HashMap<String, String>();
			sParaTemp.put("service", "create_direct_pay_by_user");//接口名称。 
	        sParaTemp.put("partner", AlipayConfig.partner);//合作身份者ID
	        sParaTemp.put("seller_email", AlipayConfig.seller_email);// 收款支付宝账号
	        sParaTemp.put("_input_charset", AlipayConfig.input_charset); //商户网站使用的编码格式，如utf-8、gbk、gb2312 等。
			sParaTemp.put("payment_type", payment_type);
			sParaTemp.put("notify_url", notify_url);
			sParaTemp.put("return_url", return_url);//支付宝处理完请求后，当前页面自动跳转到商户网站里指定页面的http 路径
			sParaTemp.put("out_trade_no", out_trade_no);
			sParaTemp.put("subject", subject);//订单名称
			sParaTemp.put("total_fee", total_fee);
			sParaTemp.put("body", body);
			sParaTemp.put("show_url", show_url);
			sParaTemp.put("anti_phishing_key", AlipaySubmit.query_timestamp());
			sParaTemp.put("exter_invoke_ip", exter_invoke_ip);
			sParaTemp.put("sign_type", AlipayConfig.sign_type);		
			String sHtmlText = AlipaySubmit.buildRequest(sParaTemp,"get","确认");
			
			model.addAttribute("sHtmlText", sHtmlText);			       
			return "page/shop/home/alipayapi";
		}
		else//其他银行
		{
			return "page/shop/home/alipayapi";
		}
		 
	 }
	
	/**
	 * 支付宝服务器同步通知
	 * @param model
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings({ "unused", "rawtypes" })
	@RequestMapping(value="/return_url",method=RequestMethod.GET)
	public String return_url(ModelMap model,HttpServletRequest request,HttpServletResponse response) throws Exception
	{
		Customer user=(Customer) request.getSession().getAttribute(Constants.SESSION_LOGIN_USER_GOODS);
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
		Map<String,String> params = new HashMap<String,String>();
		Map requestParams = request.getParameterMap();
		for (Iterator iter = requestParams.keySet().iterator(); iter.hasNext();) {
			String name = (String) iter.next();
			String[] values = (String[]) requestParams.get(name);
			String valueStr = "";
			for (int i = 0; i < values.length; i++) {
				valueStr = (i == values.length - 1) ? valueStr + values[i]
						: valueStr + values[i] + ",";
			}
			//乱码解决，这段代码在出现乱码时使用。如果mysign和sign不相等也可以使用这段代码转化
			//valueStr = new String(valueStr.getBytes("ISO-8859-1"), "gbk");
			params.put(name, valueStr);
		}
		//商户订单号
		String out_trade_no = new String(request.getParameter("out_trade_no").getBytes("ISO-8859-1"),"UTF-8");
		//支付宝交易号
		String trade_no = new String(request.getParameter("trade_no").getBytes("ISO-8859-1"),"UTF-8");
		//买家支付宝账号
		String buyer_email= new String(request.getParameter("buyer_email").getBytes("ISO-8859-1"),"UTF-8");
		//交易状态
		String trade_status = new String(request.getParameter("trade_status").getBytes("ISO-8859-1"),"UTF-8");		
		String seller_email = new String(request.getParameter("seller_email").getBytes("ISO-8859-1"),"UTF-8");		
		String seller_id = new String(request.getParameter("seller_id").getBytes("ISO-8859-1"),"UTF-8");		
		String buyer_id = new String(request.getParameter("buyer_id").getBytes("ISO-8859-1"),"UTF-8");		
		String total_fee = new String(request.getParameter("total_fee").getBytes("ISO-8859-1"),"UTF-8");		
		String payment_type = new String(request.getParameter("payment_type").getBytes("ISO-8859-1"),"UTF-8");		
		String notify_type = new String(request.getParameter("notify_type").getBytes("ISO-8859-1"),"UTF-8");		
		String notify_id = new String(request.getParameter("notify_id").getBytes("ISO-8859-1"),"UTF-8");		
		String notify_time = new String(request.getParameter("notify_time").getBytes("ISO-8859-1"),"UTF-8");		
		SimpleDateFormat sdf =new SimpleDateFormat( "yyyy-MM-dd HH:mm:ss" );
		TradInfo tradInfo=new TradInfo();
		tradInfo.setId(UUID.randomUUID().toString().replace("-", ""));
		tradInfo.setNotify_id(notify_id);
		tradInfo.setBuyer_email(buyer_email);
		tradInfo.setBuyer_id(buyer_id);
		tradInfo.setNotify_time(sdf.parse(notify_time));
		tradInfo.setNotify_type(notify_type);
		tradInfo.setOut_trade_no(out_trade_no);
		tradInfo.setPayment_type(payment_type);
		tradInfo.setSeller_email(seller_email);
		tradInfo.setSeller_id(seller_id);
		tradInfo.setTotal_fee(new BigDecimal(total_fee));
		tradInfo.setTrade_no(trade_no);
		tradInfo.setTrade_status(trade_status);
		
		boolean verify_result = AlipayNotify.verify(params);
		
		if(verify_result){
			//——请根据您的业务逻辑来编写程序（以下代码仅作参考）——
			if(trade_status.equals("TRADE_FINISHED") || trade_status.equals("TRADE_SUCCESS")){
				//判断该笔订单是否在商户网站中已经做过处理
					//如果没有做过处理，根据订单号（out_trade_no）在商户网站的订单系统中查到该笔订单的详细，并执行商户的业务程序
					//如果有做过处理，不执行商户的业务程序
				Orders orders=ordersService.getOrdersByOidList(out_trade_no);
				if(!Constants.ALREADY_PAY.equals(orders.getStatus()))
				{
					orders.setStatus(Constants.ALREADY_PAY);
					orders.setUpdate_time(new Date());
					ordersService.update(orders);
					tradInfoService.save(tradInfo);
				}
					
			}
			log.error("同步付款成功。");
			return "page/shop/home/orders/pay_success";
			
		}else{
			log.error("同步付款失败。");
			return "page/shop/home/orders/pay_fail";
			
		}
		 
	 }
	
	
	/**
	 * 支付宝服务器异步通知
	 * @param model
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings({ "unused", "rawtypes" })
	@RequestMapping(value="/notify_url",method=RequestMethod.POST)
	public String notify_url(ModelMap model,HttpServletRequest request,HttpServletResponse response) throws Exception
	{
		Customer user=(Customer) request.getSession().getAttribute(Constants.SESSION_LOGIN_USER_GOODS);
		Map<String,String> params = new HashMap<String,String>();
		Map requestParams = request.getParameterMap();
		for (Iterator iter = requestParams.keySet().iterator(); iter.hasNext();) {
			String name = (String) iter.next();
			String[] values = (String[]) requestParams.get(name);
			String valueStr = "";
			for (int i = 0; i < values.length; i++) {
				valueStr = (i == values.length - 1) ? valueStr + values[i]
						: valueStr + values[i] + ",";
			}
			//乱码解决，这段代码在出现乱码时使用。如果mysign和sign不相等也可以使用这段代码转化
			//valueStr = new String(valueStr.getBytes("ISO-8859-1"), "gbk");
			params.put(name, valueStr);
		}
		//商户订单号
		String out_trade_no = new String(request.getParameter("out_trade_no").getBytes("ISO-8859-1"),"UTF-8");
		//支付宝交易号
		String trade_no = new String(request.getParameter("trade_no").getBytes("ISO-8859-1"),"UTF-8");
		//买家支付宝账号
		String buyer_email= new String(request.getParameter("buyer_email").getBytes("ISO-8859-1"),"UTF-8");
		//交易状态
		String trade_status = new String(request.getParameter("trade_status").getBytes("ISO-8859-1"),"UTF-8");		
		String seller_email = new String(request.getParameter("seller_email").getBytes("ISO-8859-1"),"UTF-8");		
		String seller_id = new String(request.getParameter("seller_id").getBytes("ISO-8859-1"),"UTF-8");		
		String buyer_id = new String(request.getParameter("buyer_id").getBytes("ISO-8859-1"),"UTF-8");		
		String total_fee = new String(request.getParameter("total_fee").getBytes("ISO-8859-1"),"UTF-8");		
		String payment_type = new String(request.getParameter("payment_type").getBytes("ISO-8859-1"),"UTF-8");		
		String notify_type = new String(request.getParameter("notify_type").getBytes("ISO-8859-1"),"UTF-8");		
		String notify_id = new String(request.getParameter("notify_id").getBytes("ISO-8859-1"),"UTF-8");		
		String notify_time = new String(request.getParameter("notify_time").getBytes("ISO-8859-1"),"UTF-8");		
		SimpleDateFormat sdf =new SimpleDateFormat( "yyyy-MM-dd HH:mm:ss" );
		TradInfo tradInfo=new TradInfo();
		tradInfo.setId(UUID.randomUUID().toString().replace("-", ""));
		tradInfo.setNotify_id(notify_id);
		tradInfo.setBuyer_email(buyer_email);
		tradInfo.setBuyer_id(buyer_id);
		tradInfo.setNotify_time(sdf.parse(notify_time));
		tradInfo.setNotify_type(notify_type);
		tradInfo.setOut_trade_no(out_trade_no);
		tradInfo.setPayment_type(payment_type);
		tradInfo.setSeller_email(seller_email);
		tradInfo.setSeller_id(seller_id);
		tradInfo.setTotal_fee(new BigDecimal(total_fee));
		tradInfo.setTrade_no(trade_no);
		tradInfo.setTrade_status(trade_status);
		tradInfoService.save(tradInfo);
		
		if(AlipayNotify.verify(params))
		{//验证成功
			if(trade_status.equals("TRADE_FINISHED"))
			{
				//判断该笔订单是否在商户网站中已经做过处理
					//如果没有做过处理，根据订单号（out_trade_no）在商户网站的订单系统中查到该笔订单的详细，并执行商户的业务程序
					//如果有做过处理，不执行商户的业务程序
					Orders orders=ordersService.getOrdersByOidList(out_trade_no);
					if(!Constants.ALREADY_PAY.equals(orders.getStatus()))
					{
						orders.setStatus(Constants.ALREADY_PAY);
						orders.setUpdate_time(new Date());
						ordersService.update(orders);
					}
				
			} 
			else if (trade_status.equals("TRADE_SUCCESS"))
			{
				//判断该笔订单是否在商户网站中已经做过处理
					//如果没有做过处理，根据订单号（out_trade_no）在商户网站的订单系统中查到该笔订单的详细，并执行商户的业务程序
					//如果有做过处理，不执行商户的业务程序
				Orders orders=ordersService.getOrdersByOidList(out_trade_no);
				if(!Constants.ALREADY_PAY.equals(orders.getStatus()))
				{
					orders.setStatus(Constants.ALREADY_PAY);
					orders.setUpdate_time(new Date());
					ordersService.update(orders);
				}
				
			}
			log.error("付款成功。");
			 model.addAttribute("istrue", "true");
			 return "page/shop/home/orders/notify_url";
		}
		else
		{//验证失败
			//out.println("fail");
			 model.addAttribute("istrue", "false");
			
			log.error("付款失败。");
			 return "page/shop/home/orders/notify_url";
		}
		 
	 }
	
	
	private static Properties getP()
	{
		InputStream inputStream = OrdersController.class.getClassLoader().getResourceAsStream("system.properties");  
        Properties p = new Properties();  
        try {  
            p.load(inputStream);  
            inputStream.close();  
        } catch (IOException e1) {  
            e1.printStackTrace();  
        }
		return p;  
	}
	
	
	
}
