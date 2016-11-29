/**
 * 发货管理
 */
package cloud.app.order.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import cloud.app.order.service.ShippingManagementService;

/**
 * @author zhoushunfang
 *
 */
@Controller
@RequestMapping("/admin/shipping")
public class ShippingManagementController {
	
	Logger logger = Logger.getLogger(this.getClass());
	
	@Autowired
	private ShippingManagementService shippingManagementService;
	
	/**
	 * 查询发货列表
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/shipping_list.do")
	public String getShippingList(HttpServletRequest request,HttpServletResponse response){
		try {
			shippingManagementService.getList(null);
		} catch (Exception e) {
			logger.error("search shipping list error:"+e.getMessage());
		}
		return "/page/order/shipping_list";
	}
	
	/**
	 * 删除发货信息
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/shipping_delete.do")
	public Map<String,Object> deleteShipping(HttpServletRequest request,HttpServletResponse response){
		String shippingId = request.getParameter("shippingId");
		Map<String,Object> result = new HashMap<String, Object>();
		try {
			shippingManagementService.deleteById(shippingId);
		} catch (Exception e) {
			logger.error("delete shipping error:"+e.getMessage());
		}
		
		return result;
	}
	
	/**
	 * 查看发货详情
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/shipping_view.do")
	public String viewShippingInfo(HttpServletRequest request,HttpServletResponse response){
		String shippingId = request.getParameter("shippingId");
		try {
			shippingManagementService.getObjById(shippingId);
		} catch (Exception e) {
			logger.error("search shipping error:"+e.getMessage());
		}
		return "";
	}
	
	/**
	 * 修改发货信息
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/shipping_edit.do")
	public String editShippingInfo(HttpServletRequest request,HttpServletResponse response){
		String shippingId = request.getParameter("shippingId");
		try {
			shippingManagementService.getObjById(shippingId);
		} catch (Exception e) {
			logger.error("search shipping error:"+e.getMessage());
		}
		return "redirect:/shipping_list.do";
	}
}
