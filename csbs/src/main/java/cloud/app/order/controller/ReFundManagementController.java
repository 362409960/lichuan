/**
 * 退款管理
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

import cloud.app.order.service.ReFundManagementService;

/**
 * @author zhoushunfang
 *
 */
@Controller
@RequestMapping("/admin/rerund")
public class ReFundManagementController {
	
	Logger logger = Logger.getLogger(this.getClass());
	
	@Autowired
	private ReFundManagementService fundManagementService;
	
	/**
	 * 查询退款列表
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/rerund_list.do")
	public String getRerundList(HttpServletRequest request,HttpServletResponse response){
		try {
			fundManagementService.getList(null);
		} catch (Exception e) {
			logger.error("search rerund list error:"+e.getMessage());
		}
		return "/page/order/refund_list";
	}
	
	/**
	 * 删除退款信息
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/rerund_delete.do")
	public Map<String,Object> deleteRerund(HttpServletRequest request,HttpServletResponse response){
		String rerundId = request.getParameter("rerundId");
		Map<String,Object> result = new HashMap<String, Object>();
		try {
			fundManagementService.deleteById(rerundId);
		} catch (Exception e) {
			logger.error("delete rerund error:"+e.getMessage());
		}
		
		return result;
	}
	
	/**
	 * 查看退款详情
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/rerund_view.do")
	public String viewRerundInfo(HttpServletRequest request,HttpServletResponse response){
		String rerundId = request.getParameter("rerundId");
		try {
			fundManagementService.getObjById(rerundId);
		} catch (Exception e) {
			logger.error("search rerund error:"+e.getMessage());
		}
		return "";
	}
	
	/**
	 * 修改退款信息
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/rerund_edit.do")
	public String editRerundInfo(HttpServletRequest request,HttpServletResponse response){
		String rerundId = request.getParameter("rerundId");
		try {
			fundManagementService.getObjById(rerundId);
		} catch (Exception e) {
			logger.error("search rerund error:"+e.getMessage());
		}
		return "redirect:/rerund_list.do";
	}
}
