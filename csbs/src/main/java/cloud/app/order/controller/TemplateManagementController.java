/**
 * 快递单模版管理
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

import cloud.app.order.service.TemplageManagementService;

/**
 * @author zhoushunfang
 *
 */
@Controller
@RequestMapping("/admin/template")
public class TemplateManagementController {
Logger logger = Logger.getLogger(this.getClass());
	
	@Autowired
	private TemplageManagementService templageManagementService;
	
	/**
	 * 查询快递单模版
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/template_list.do")
	public String getTemplateList(HttpServletRequest request,HttpServletResponse response){
		try {
			templageManagementService.getList(null);
		} catch (Exception e) {
			logger.error("search template list error:"+e.getMessage());
		}
		return "/page/order/template_list";
	}
	
	/**
	 * 删除快递单模版信息
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/template_delete.do")
	public Map<String,Object> deleteTemplate(HttpServletRequest request,HttpServletResponse response){
		String templateId = request.getParameter("templateId");
		Map<String,Object> result = new HashMap<String, Object>();
		try {
			templageManagementService.deleteById(templateId);
		} catch (Exception e) {
			logger.error("delete template error:"+e.getMessage());
		}
		
		return result;
	}
	
	/**
	 * 查看快递单模版详情
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/template_view.do")
	public String viewTemplateInfo(HttpServletRequest request,HttpServletResponse response){
		String templateId = request.getParameter("templateId");
		try {
			templageManagementService.getObjById(templateId);
		} catch (Exception e) {
			logger.error("search template error:"+e.getMessage());
		}
		return "/page/order/template_edit";
	}
	
	/**
	 * 修改快递单模版信息
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/template_edit.do")
	public String editTemplateInfo(HttpServletRequest request,HttpServletResponse response){
		String templateId = request.getParameter("templateId");
		try {
			templageManagementService.getObjById(templateId);
		} catch (Exception e) {
			logger.error("search template error:"+e.getMessage());
		}
		return "redirect:/template_list.do";
	}
}
