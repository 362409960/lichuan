package cloud.shop.goods.controller;

import java.io.PrintWriter;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import cloud.shop.common.Constants;
import cloud.shop.goods.entity.Customer;
import cloud.shop.goods.entity.Region;
import cloud.shop.goods.entity.ShippingAddress;
import cloud.shop.goods.service.RegionService;
import cloud.shop.goods.service.ShippingAddressService;


@Controller
@RequestMapping("/shipAddress")
public class ShippingAddressController {
	
	@Autowired
	private ShippingAddressService shippingAddressService;
	@Autowired
	private RegionService regionService;
	/**
	 * 指向add界面。
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "/add")
	public String add(ModelMap model) throws Exception
	{
		return "page/shop/home/member/add_shop_address";
	}
	
	/**
	 * 新增
	 * @param request
	 * @param response
	 * @param catalog
	 */
	@RequestMapping(value = "/save")
	public String save(HttpServletRequest request,HttpServletResponse response,ShippingAddress shippingAddress,ModelMap model)throws Exception{
		       	
		    HttpSession session=request.getSession();
		    Customer user=(Customer) session.getAttribute(Constants.SESSION_LOGIN_USER_GOODS);
        	shippingAddress.setId(UUID.randomUUID().toString().replace("-", ""));
        	shippingAddress.setCustomer_id(user.getId());
            shippingAddress.setCreate_time(new Date());
        	shippingAddressService.insertShippingAddress(shippingAddress);
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
	
	/**
	 * 修改
	 * @param request
	 * @param response
	 * @param Catalog
	 */
	@RequestMapping(value = "/update")
	public String update(HttpServletRequest request,HttpServletResponse response,ShippingAddress shippingAddress,ModelMap model)throws Exception{
	
		     HttpSession session=request.getSession();
		     Customer user=(Customer) session.getAttribute(Constants.SESSION_LOGIN_USER_GOODS);
        	shippingAddress.setId(request.getParameter("id"));        
        	shippingAddressService.updateShippingAddress(shippingAddress);
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
	
	/**
	 * 指向edit界面。
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "/edit")
	public String edit(ModelMap model,HttpServletRequest request,HttpServletResponse response,ShippingAddress shippingAddress) throws Exception
	{
		shippingAddress.setId(request.getParameter("id"));
		List<ShippingAddress> list=shippingAddressService.getShippingAddressIdList(shippingAddress);
		if(null != list && !list.isEmpty())
		{
			ShippingAddress shipArddress=list.get(0);
			Region region=new Region();
			region.setId(shipArddress.getProvince_id());
			Region province=regionService.getRegionConData(region);
			model.addAttribute("province", province);
			
			region.setId(shipArddress.getCity_id());
			Region city=regionService.getRegionConData(region);
			model.addAttribute("city", city);
			
		
			region.setId(shipArddress.getDistrict_id());
			Region district=regionService.getRegionConData(region);
			model.addAttribute("district", district);
			
			model.addAttribute("address", shipArddress);
		}
		return "page/shop/home/member/edit_shop_address";
	}
	
	/**
	 * 删除
	 * @param request
	 * @param response
	 * @param catalog
	 */
	@RequestMapping(value = "/deleteShipAddress")
	public void deleteShipAddress(HttpServletRequest request,HttpServletResponse response,ShippingAddress shippingAddress){
		response.setContentType("text/html;charset=utf-8"); //指定输出内容类型和编码
        try{
        	PrintWriter out = response.getWriter();//获取输出口
        	 boolean isValid = false;
             shippingAddressService.deleteById(request.getParameter("id")); 
        	isValid = true;
        	out.print(isValid);//返回结果
            out.flush();  
            out.close(); 
        }catch(Exception ex){
            ex.printStackTrace();
        }
	}
	
	
	/**
	 * 在订单页面新增
	 * @param request
	 * @param response
	 * @param catalog
	 */
	@RequestMapping(value = "/saveJson")
	public void saveJson(HttpServletRequest request,HttpServletResponse response,ShippingAddress shippingAddress){
		response.setContentType("text/html;charset=utf-8"); //指定输出内容类型和编码
        try{
        	PrintWriter out = response.getWriter();//获取输出口
  		    Customer user=(Customer) request.getSession().getAttribute(Constants.SESSION_LOGIN_USER_GOODS);
          	shippingAddress.setId(UUID.randomUUID().toString().replace("-", ""));
          	shippingAddress.setCustomer_id(user.getId());
          	shippingAddress.setCreate_time(new Date());
          	shippingAddressService.insertShippingAddress(shippingAddress);          	  		
    		List<ShippingAddress> saList=new LinkedList<ShippingAddress>();
    		saList.add(shippingAddress);
    		String json = JSONArray.fromObject(saList).toString();//转化为JSON	
    		out.write(json);
			out.flush();
			out.close();
        }catch(Exception ex){
            ex.printStackTrace();
        }
	}

}
