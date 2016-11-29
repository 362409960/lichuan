/**
 * 收款管理
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

import cloud.app.order.service.PaymentManagementService;

/**
 * @author zhoushunfang
 *
 */
@Controller
@RequestMapping("/admin/payment")
public class PaymentManagementController {
	
	Logger logger = Logger.getLogger(this.getClass());
	
	@Autowired
	private PaymentManagementService paymentManagementService;
	
	/**
	 * 查询收款列表
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/payment_list.do")
	public String getPaymentList(HttpServletRequest request,HttpServletResponse response){
		try {
			paymentManagementService.getList(null);
		} catch (Exception e) {
			logger.error("search payment list error:"+e.getMessage());
		}
		return "/page/order/payment_list";
	}
	
	/**
	 * 删除收款信息
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/payment_delete.do")
	public Map<String,Object> deletePayment(HttpServletRequest request,HttpServletResponse response){
		String payId = request.getParameter("payId");
		Map<String,Object> result = new HashMap<String, Object>();
		try {
			paymentManagementService.deleteById(payId);
		} catch (Exception e) {
			logger.error("delete payment error:"+e.getMessage());
		}
		
		return result;
	}
	
	/**
	 * 查看收款详情
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/payment_view.do")
	public String viewPaymentInfo(HttpServletRequest request,HttpServletResponse response){
		String payId = request.getParameter("payId");
		try {
			paymentManagementService.getObjById(payId);
		} catch (Exception e) {
			logger.error("search payment error:"+e.getMessage());
		}
		return "";
	}
	
	/**
	 * 修改收款信息
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/payment_edit.do")
	public String editPaymentInfo(HttpServletRequest request,HttpServletResponse response){
		String payId = request.getParameter("payId");
		try {
			paymentManagementService.getObjById(payId);
		} catch (Exception e) {
			logger.error("search payment error:"+e.getMessage());
		}
		return "redirect:/payment_list.do";
	}
}
