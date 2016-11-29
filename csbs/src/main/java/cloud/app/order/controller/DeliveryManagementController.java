/**
 * 发货点管理
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

import cloud.app.order.service.DeliveryManagementService;

/**
 * @author zhoushunfang
 *
 */
@Controller
@RequestMapping("/admin/delivery")
public class DeliveryManagementController {
	
	Logger logger = Logger.getLogger(this.getClass());
	
	@Autowired
	private DeliveryManagementService deliveryManagementService;
	
	/**
	 * 查询发货点列表
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/delivery_list.do")
	public String getDeliveryList(HttpServletRequest request,HttpServletResponse response){
		try {
			deliveryManagementService.getList(null);
		} catch (Exception e) {
			logger.error("search delivery list error:"+e.getMessage());
		}
		return "/page/order/delivery_list";
	}
	
	/**
	 * 删除发货点信息
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/delivery_delete.do")
	public Map<String,Object> deleteDelivery(HttpServletRequest request,HttpServletResponse response){
		String deliveryId = request.getParameter("deliveryId");
		Map<String,Object> result = new HashMap<String, Object>();
		try {
			deliveryManagementService.deleteById(deliveryId);
		} catch (Exception e) {
			logger.error("delete delivery error:"+e.getMessage());
		}
		
		return result;
	}
	
	
	/**
	 * 添加发货点
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/delivery_add.do")
	public String addDeliveryInfo(HttpServletRequest request,HttpServletResponse response){
		String deliveryId = request.getParameter("deliveryId");
		try {
			deliveryManagementService.getObjById(deliveryId);
		} catch (Exception e) {
			logger.error("add delivery error:"+e.getMessage());
		}
		return "/page/order/delivery_add";
	}
	
	
	/**
	 * 查看发货点详情
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/delivery_view.do")
	public String viewDeliveryInfo(HttpServletRequest request,HttpServletResponse response){
		String deliveryId = request.getParameter("deliveryId");
		try {
			deliveryManagementService.getObjById(deliveryId);
		} catch (Exception e) {
			logger.error("search delivery error:"+e.getMessage());
		}
		return "/page/order/delivery_edit";
	}
	
	/**
	 * 修改发货点信息
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/delivery_edit.do")
	public String editDeliveryInfo(HttpServletRequest request,HttpServletResponse response){
		String deliveryId = request.getParameter("deliveryId");
		try {
			deliveryManagementService.getObjById(deliveryId);
		} catch (Exception e) {
			logger.error("search delivery error:"+e.getMessage());
		}
		return "redirect:/delivery_list.do";
	}
}
