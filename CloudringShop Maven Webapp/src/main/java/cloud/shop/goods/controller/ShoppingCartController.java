package cloud.shop.goods.controller;

import java.io.PrintWriter;
import java.math.BigDecimal;

import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.fasterxml.jackson.databind.ObjectMapper;

import cloud.shop.common.Common;
import cloud.shop.common.Constants;
import cloud.shop.goods.entity.Customer;
import cloud.shop.goods.entity.ShippingCart;
import cloud.shop.goods.service.ShippingCartService;
import cloud.shop.merchandise.entity.MerchandiseCategories;
import cloud.shop.merchandise.entity.MerchandiseProduct;
import cloud.shop.merchandise.service.MerchandiseCategoriesService;
import cloud.shop.merchandise.service.MerchandiseProductService;

@Controller
@RequestMapping("/cart")
public class ShoppingCartController {
	
	@Autowired
	private MerchandiseCategoriesService merchandiseCategoriesService;
	@Autowired
	private ShippingCartService shippingCartService;
	@Autowired
	private MerchandiseProductService merchandiseProductService;
	
	/**
	 * 购物车
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@SuppressWarnings({ "rawtypes" })
	@RequestMapping(value="/showShopCart")
	public String showShopCart(ModelMap model,HttpServletRequest request,HttpServletResponse response) throws Exception
	{
		List<MerchandiseCategories> categoriesList=merchandiseCategoriesService.getCategorieConditionList();
		//顶级map设计
		Map<Map, Object> topMap=new LinkedHashMap<Map, Object>();	
		Map<String,String> menu=new LinkedHashMap<String,String>();
		if(null != categoriesList && !categoriesList.isEmpty())
		{
			for(MerchandiseCategories mc:categoriesList)
			{
				menu.put(mc.getId(), mc.getName());
				Map<String,String> top=new LinkedHashMap<String,String>();
				top.put(mc.getId(), mc.getName());
				List<MerchandiseCategories> mcList=merchandiseCategoriesService.selectPId(mc.getId());
				topMap.put(top, mcList);
				
			}
		}
		String ip =Common.getIpAddr(request);
		Customer user=(Customer) request.getSession().getAttribute(Constants.SESSION_LOGIN_USER_GOODS);
		List<ShippingCart> cartList=null;
		if(null!=user)
		{
			cartList=shippingCartService.geteShippingCartByUserIdList(user.getId());
		}
		else
		{
			 cartList=shippingCartService.geteShippingCartIp(ip);
		}
		
		BigDecimal sum=new BigDecimal(0);
		if(null != cartList && !cartList.isEmpty() )
		{
			model.addAttribute("isTrue", true);
			for(ShippingCart sc:cartList)
			{
				sum=sum.add(sc.getPrice().multiply(new BigDecimal(sc.getQuantity())));
			}
			//推荐
			List<MerchandiseProduct> reList=merchandiseProductService.getRecommendProdouctList();
			model.addAttribute("length", cartList.size());
			model.addAttribute("sum", sum);
			model.addAttribute("cart", cartList);
			model.addAttribute("reList", reList);
		}
		else
		{
			model.addAttribute("isTrue", false);
		}
		model.addAttribute("menu", menu);
		model.addAttribute("topMap", topMap);
		return "page/shop/home/cart/shop_cart";
	}

	/**
	 * 新增
	 * @param request
	 * @param response
	 * @param shippingCart
	 */
	@RequestMapping(value = "/insertCart")
	public String insertCart(ModelMap model,HttpServletRequest request,HttpServletResponse response,ShippingCart shippingCart)throws Exception
	{
       List<MerchandiseCategories> categoriesList=merchandiseCategoriesService.getCategorieConditionList();
		
		Map<String,String> menu=new LinkedHashMap<String,String>();
		Map<Map, Object> topMap=new LinkedHashMap<Map, Object>();	
		if(null != categoriesList && !categoriesList.isEmpty())
		{
			for(MerchandiseCategories mc:categoriesList)
			{
				Map<String, Object> threeMap=new LinkedHashMap<String, Object>();
				Map<Object, Object> listMap=new LinkedHashMap<Object, Object>();
				//求产品分类第二级的前三列的数据。【根据新的需求，把所有的都显示】
				List<MerchandiseCategories> mcThreeList=merchandiseCategoriesService.selectThreePId(mc.getId());
				String mcategName="";
				if(null != mcThreeList && ! mcThreeList.isEmpty())
				{
					for(MerchandiseCategories mec:mcThreeList)
					{
						//threeMap.put(mec.getId(), mec.getName());
						mcategName=mcategName+mec.getName()+" ";
					}
				}
				threeMap.put(mc.getId(), mcategName);
				//求商品
				String ids=getProductLowList(mc.getId());
				String[]str=ids.split(",");
				//根据IDS【所有二级ID和其下级的所有ID】
				List<MerchandiseProduct> mpList=merchandiseProductService.getProductConditionFiveList(str);
				listMap.put(mc.getId(), mpList);
				topMap.put(threeMap, listMap);
				menu.put(mc.getId(), mc.getName());
			}
		}
		
        	String ip =Common.getIpAddr(request);
        	shippingCart.setId(UUID.randomUUID().toString().replace("-", ""));
        	shippingCart.setIp(ip);
        	shippingCart.setQuantity(1);
        	String pid=request.getParameter("productId");
        	shippingCart.setGoods_id(pid);
        	List<ShippingCart> list=shippingCartService.getShippingCartList(shippingCart);
        	if(null!=list && !list.isEmpty())
        	{
        		ShippingCart car=list.get(0);
        		car.setQuantity(car.getQuantity()+shippingCart.getQuantity());        		
        		shippingCartService.updateShippingCart(car);
        		model.addAttribute("cart", car);
        	}
        	else
        	{
        		MerchandiseProduct product= merchandiseProductService.selectCheckId(pid);
            	shippingCart.setGoods_url(product.getProductImageListStore());
            	shippingCart.setPrice(product.getPrice());
            	shippingCart.setPicture(product.getName());
            	HttpSession session=request.getSession();
        		Customer user=(Customer) session.getAttribute(Constants.SESSION_LOGIN_USER_GOODS);
        		if(null !=user)
        		{
        			shippingCart.setUser_id(user.getId());
        		}
        		shippingCartService.insertShippingCart(shippingCart);
        		model.addAttribute("cart", shippingCart);
        	}
        	
        	//推荐
			List<MerchandiseProduct> reList=merchandiseProductService.getRecommendProdouctList();
			model.addAttribute("reList", reList);
        	model.addAttribute("menu", menu);
    		model.addAttribute("topMap", topMap);	
        
		return "page/shop/home/cart/add_cart";
	}
	
	/**
	 * 修改
	 * @param request
	 * @param response
	 * @param shippingCart
	 */
	@RequestMapping(value = "/updateCart")
	public void updateCart(HttpServletRequest request,HttpServletResponse response,ShippingCart shippingCart,ModelMap model){
		response.setContentType("text/html;charset=utf-8"); //指定输出内容类型和编码
        try{
        	boolean isValid = false;
        	String ip =Common.getIpAddr(request);
        	shippingCart.setId(shippingCart.getId());
            shippingCart.setIp(ip);
            shippingCart.setQuantity(shippingCart.getQuantity());
            HttpSession session=request.getSession();
    		Customer user=(Customer) session.getAttribute(Constants.SESSION_LOGIN_USER_GOODS);
    		if(null !=user)
    		{
    			shippingCart.setUser_id(user.getId());
    		}
        	shippingCartService.updateShippingCart(shippingCart);        	
        	isValid = true;
        	response.getWriter().print(JSONArray.fromObject(isValid));
        }catch(Exception ex){
            ex.printStackTrace();
        }
	}

	/**
	 * 删除
	 * @param request
	 * @param response
	 * @param shippingCart
	 */
	@RequestMapping(value = "/deleteCart")
	public void deleteCart(HttpServletRequest request,HttpServletResponse response,ShippingCart shippingCart,ModelMap model){
		response.setContentType("text/html;charset=utf-8"); //指定输出内容类型和编码
        try{
        	boolean isValid = false;
        	shippingCartService.deleteById(shippingCart.getId());
        	isValid = true;
        	response.getWriter().print(JSONArray.fromObject(isValid));
        }catch(Exception ex){
            ex.printStackTrace();
        }
	}
	
	
	/**
	 * 清空
	 * @param request
	 * @param response
	 * @param shippingCart
	 */
	@RequestMapping(value = "/clearCart")
	public void clearCart(HttpServletRequest request,HttpServletResponse response,ShippingCart shippingCart,ModelMap model){
		response.setContentType("text/html;charset=utf-8"); //指定输出内容类型和编码
        try{
        	boolean isValid = false;
        	String ip =Common.getIpAddr(request);
        	List<ShippingCart> cartList=shippingCartService.geteShippingCartIp(ip);
        	if(null != cartList && !cartList.isEmpty() )
    		{
        		for(ShippingCart ship:cartList)
        		{
        			shippingCartService.deleteById(ship.getId());     
        		}
    		}
    		
        	isValid = true;
        	response.getWriter().print(JSONArray.fromObject(isValid));
        }catch(Exception ex){
            ex.printStackTrace();
        }
	}
	
	/**
	 * 查询购物车需要购买的数量
	 * @param request
	 * @param response
	 * @param shippingCart
	 */
	@RequestMapping(value = "/quantity")
	public void quantity(HttpServletRequest request,HttpServletResponse response,ShippingCart shippingCart){
		response.setContentType("text/html;charset=utf-8"); //指定输出内容类型和编码
        try{
        	String ip =Common.getIpAddr(request);
        	int quantity=0;
        	Customer user=(Customer) request.getSession().getAttribute(Constants.SESSION_LOGIN_USER_GOODS);
    		List<ShippingCart> list=null;
    		if(null!=user)
    		{
    			list=shippingCartService.geteShippingCartByUserIdList(user.getId());
    		}
    		else
    		{
    			list=shippingCartService.geteShippingCartIp(ip);
    		}
        	if(null != list && !list.isEmpty())
        	{
        		for(ShippingCart cart:list)
        		{
        			quantity=quantity+cart.getQuantity();
        		}
        	}
        	response.getWriter().print(JSONArray.fromObject(quantity));
        }catch(Exception ex){
            ex.printStackTrace();
        }
	}
	
	
	/**
	 * 查询购物车需要购买的商品
	 * @param request
	 * @param response
	 * @param shippingCart
	 */
	@RequestMapping(value = "/shoppingCart")
	public void shoppingCart(HttpServletRequest request,HttpServletResponse response,ShippingCart shippingCart){
		response.setContentType("text/html;charset=utf-8"); //指定输出内容类型和编码
        try{
        	PrintWriter out = response.getWriter();//获取输出口
        	String ip =Common.getIpAddr(request);
        	BigDecimal totalPrice=new BigDecimal(0);
        	int quantity=0;
        	Customer user=(Customer) request.getSession().getAttribute(Constants.SESSION_LOGIN_USER_GOODS);
    		List<ShippingCart> list=null;
    		if(null!=user)
    		{
    			list=shippingCartService.geteShippingCartByUserIdList(user.getId());
    		}
    		else
    		{
    			list=shippingCartService.geteShippingCartIp(ip);
    		}
        	if(null != list && !list.isEmpty())
        	{
        		for(ShippingCart cart:list)
        		{
        			totalPrice=totalPrice.add(cart.getPrice().multiply(new BigDecimal(cart.getQuantity()))) ;
        			quantity=quantity+cart.getQuantity();
        		}
        	}
        	Map<String,Object> map=new HashMap<String, Object>();
        	map.put("totalPrice", totalPrice);
        	map.put("quantity", quantity);
        	map.put("list", list);
        	ObjectMapper mapper = new ObjectMapper();
        	out.write(mapper.writeValueAsString(map));
    		out.flush();
    		out.close();
        }catch(Exception ex){
            ex.printStackTrace();
        }
	}
	
	//循环求出产品分类下级的ID。
		public String getProductLowList(String id) throws Exception
		{
			String ids=id;
			List<MerchandiseCategories> melist=merchandiseCategoriesService.selectPId(id);
			if(null != melist && !melist.isEmpty())
			{
				for(MerchandiseCategories me :melist)
				{	
					List<MerchandiseCategories> list=merchandiseCategoriesService.selectPId(me.getId());
					if(null !=list && !list.isEmpty())
					{
						ids=ids+","+me.getId()+","+getProductLowList(me.getId());
					}
					else
					{
						ids=ids+","+me.getId();		
					}
					
				}
				
			}
			return ids;
		}
	
}
