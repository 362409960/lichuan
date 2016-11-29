/**
 * 订单管理
 */
package cloud.app.order.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cloud.app.order.model.DeliveryType;
import cloud.app.order.model.OrderItem;
import cloud.app.order.model.OrderLog;
import cloud.app.order.model.Payment;
import cloud.app.order.model.PaymentConfig;
import cloud.app.order.model.Refund;
import cloud.app.order.model.Reship;
import cloud.app.order.model.Shipping;
import cloud.app.order.service.OrderManagementService;
import cloud.app.order.service.PaymentManagementService;
import cloud.app.order.service.ReFundManagementService;
import cloud.app.order.service.ReShipManagementService;
import cloud.app.order.service.ShippingManagementService;
import cloud.app.order.vo.OrdersVO;

/**
 * @author zhoushunfang
 *
 */
@Controller
@RequestMapping("/admin/order")
public class OrderManagementController {
	
	Logger logger = Logger.getLogger(this.getClass());
	
	@Autowired
	private OrderManagementService orderManagementService;
	
	@Autowired
	private PaymentManagementService paymentManagementService;
	
	@Autowired
	private ReFundManagementService reFundManagementService;
	
	@Autowired
	private ShippingManagementService shippingManagementService;
	
	@Autowired
	private ReShipManagementService reShipManagementService;
	
	
	/**
	 * 查询订单列表
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/order_list.do")
	public String getOrderList(HttpServletRequest request,HttpServletResponse response,OrdersVO ordersVO){
		try {
			ordersVO.setPageIndex(0);
			ordersVO.setPageSize(20);
			List<OrdersVO> orders = orderManagementService.getList(ordersVO);
			int count = orderManagementService.count(ordersVO);
			Integer pageMax = count % ordersVO.getPageSize() == 0 ? count / ordersVO.getPageSize() : count / ordersVO.getPageSize()+1;
			ordersVO.setTotal(count);
			ordersVO.setRows(orders);
			ordersVO.setPageMax(pageMax);//最大页数
			ordersVO.setOrderStatus(null);
			request.setAttribute("ordersVO", ordersVO);
		} catch (Exception e) {
			logger.error("search order list is error by:"+e.getMessage());
		}
		
		
		return "/page/order/order_list";
	}
	
	
	/**
	 * 查询订单列表(条件查询)
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/order_search.do")
	public String getOrderListForSearch(HttpServletRequest request,HttpServletResponse response,OrdersVO ordersVO){
		try {
			ordersVO.setPageIndex(ordersVO.getPageIndex()-1);
			if(ordersVO.getPageIndex() < 0){
				ordersVO.setPageIndex(0);
			}
			List<OrdersVO> orders = orderManagementService.getList(ordersVO);
			int count = orderManagementService.count(ordersVO);
			Integer pageMax = count % ordersVO.getPageSize() == 0 ? count / ordersVO.getPageSize() : count / ordersVO.getPageSize()+1;
			ordersVO.setTotal(count);
			ordersVO.setRows(orders);
			ordersVO.setPageMax(pageMax);//最大页数
			request.setAttribute("ordersVO", ordersVO);
			request.setAttribute("searchPram", request.getParameter("searchPram"));//下拉框查询条件
			request.setAttribute("searchValue", request.getParameter("searchValue"));//下拉框查询条件
		} catch (Exception e) {
			logger.error("search order list is error by:"+e.getMessage());
		}
		
		
		return "/page/order/order_list";
	}
	
	/**
	 * 删除订单
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/order_delete.do")
	@ResponseBody
	public Map<String,Object> deleteOrder(HttpServletRequest request,HttpServletResponse response){
		String orderIds [] = request.getParameterValues("ids");
		Map<String,Object> result = new HashMap<String, Object>();
		try {
			for (String orderId : orderIds) {
				orderManagementService.deleteById(orderId);
			}
		} catch (Exception e) {
			logger.error("delete order is error by:"+e.getMessage());
		}
		
		return result;
	}
	
	/**
	 * 查询订单信息
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/order_view.do")
	public String viewOrderInfo(HttpServletRequest request,HttpServletResponse response){
		String orderId  = request.getParameter("orderId");
		try {
			OrdersVO ordersVO = orderManagementService.getObjById(orderId);
			OrderItem orderItem = new OrderItem();
			orderItem.setOrderId(ordersVO.getId());
			Payment payment = new Payment();
			payment.setOrderId(ordersVO.getId());
			Refund refund = new Refund();
			refund.setOrderId(ordersVO.getId());
			Shipping shipping = new Shipping();
			shipping.setOderId(ordersVO.getId());
			Reship reship = new Reship();
			reship.setOrderId(ordersVO.getId());
			OrderLog orderLog = new OrderLog();
			orderLog.setOrderId(ordersVO.getId());
			List<OrderItem> orderItems = orderManagementService.getOrderItemList(orderItem);//订单详情（商品信息）
			List<Payment> payments = paymentManagementService.getList(payment);//付款信息
			List<Refund> refunds = reFundManagementService.getList(refund);//退款信息
			List<Shipping> shippings = shippingManagementService.getList(shipping);//发货信息
			List<Reship> reships = reShipManagementService.getList(reship);//退货信息
			List<OrderLog> orderLogs = orderManagementService.getOrderLogList(orderLog);//订单记录
			ordersVO.setOrderItemList(orderItems);
			ordersVO.setPayment(payments);
			ordersVO.setRefund(refunds);
			ordersVO.setShipping(shippings);
			ordersVO.setReship(reships);
			ordersVO.setOrderLogList(orderLogs);
			request.setAttribute("ordersVO", ordersVO);
			
		} catch (Exception e) {
			logger.error("view order is error by:"+e.getMessage());
		}
		return "/page/order/order_view";
	}
	
	/**
	 * 修改订单信息
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/order_edit.do")
	public String editOrderInfo(HttpServletRequest request,HttpServletResponse response){
		String orderId  = request.getParameter("orderId");
		try {
			OrdersVO ordersVO = orderManagementService.getObjById(orderId);
			OrderItem orderItem = new OrderItem();
			orderItem.setOrderId(ordersVO.getId());
			PaymentConfig paymentConfig = new PaymentConfig();
			DeliveryType deliveryType = new DeliveryType();
			List<OrderItem> orderItems = orderManagementService.getOrderItemList(orderItem);//订单详情（商品信息）
			List<PaymentConfig> paymentConfigs = orderManagementService.getPaymentConfigList(paymentConfig);//支付方式
			List<DeliveryType> deliveryTypes = orderManagementService.getDeliveryTypeList(deliveryType);//配送方式
			ordersVO.setOrderItemList(orderItems);
			request.setAttribute("ordersVO", ordersVO);
			request.setAttribute("paymentConfigs", paymentConfigs);
			request.setAttribute("deliveryTypes", deliveryTypes);
		} catch (Exception e) {
			logger.error("edit order is error by:"+e.getMessage());
		}
		return "/page/order/order_edit";
	}
	
	/**
	 * 修改订单信息
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/order_update.do")
	public String updateOrderInfo(HttpServletRequest request,HttpServletResponse response,OrdersVO ordersVO){
		try {
			orderManagementService.update(ordersVO);
		} catch (Exception e) {
			logger.error("update order is error by:"+e.getMessage());
		}
		return "redirect:order_list.do";
	}
}
