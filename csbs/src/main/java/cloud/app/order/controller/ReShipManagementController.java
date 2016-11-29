/**
 * 退货管理
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

import cloud.app.order.service.ReShipManagementService;

/**
 * @author zhoushunfang
 *
 */
@Controller
@RequestMapping("/admin/reship")
public class ReShipManagementController {
	
	Logger logger = Logger.getLogger(this.getClass());
	
	@Autowired
	private ReShipManagementService reShipManagementService;
	
	/**
	 * 查询退货列表
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/reship_list.do")
	public String getReshipList(HttpServletRequest request,HttpServletResponse response){
		try {
			reShipManagementService.getList(null);
		} catch (Exception e) {
			logger.error("search reship list error:"+e.getMessage());
		}
		return "/page/order/reship_list";
	}
	
	/**
	 * 删除退货信息
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/reship_delete.do")
	public Map<String,Object> deleteReship(HttpServletRequest request,HttpServletResponse response){
		String reshipId = request.getParameter("reshipId");
		Map<String,Object> result = new HashMap<String, Object>();
		try {
			reShipManagementService.deleteById(reshipId);
		} catch (Exception e) {
			logger.error("delete reship error:"+e.getMessage());
		}
		
		return result;
	}
	
	/**
	 * 查看退货详情
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/reship_view.do")
	public String viewReshipInfo(HttpServletRequest request,HttpServletResponse response){
		String reshipId = request.getParameter("reshipId");
		try {
			reShipManagementService.getObjById(reshipId);
		} catch (Exception e) {
			logger.error("search reship error:"+e.getMessage());
		}
		return "";
	}
	
	/**
	 * 修改退货信息
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/reship_edit.do")
	public String editReshipInfo(HttpServletRequest request,HttpServletResponse response){
		String reshipId = request.getParameter("reshipId");
		try {
			reShipManagementService.getObjById(reshipId);
		} catch (Exception e) {
			logger.error("search reship error:"+e.getMessage());
		}
		return "redirect:/reship_list.do";
	}
}
