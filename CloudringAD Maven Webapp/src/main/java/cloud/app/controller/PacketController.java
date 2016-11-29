/**
 * 分组管理
 */
package cloud.app.controller;

import java.util.Date;
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

import cloud.app.common.Constants;
import cloud.app.common.StringUtil;
import cloud.app.common.TreeUtils;
import cloud.app.common.Utils;
import cloud.app.entity.Packet;
import cloud.app.service.PacketService;
import cloud.app.service.TerminalService;
import cloud.app.system.service.DepartmentService;
import cloud.app.system.vo.SysUserVO;
import cloud.app.system.vo.TreeVO;

/**
 * @author zhoushunfang
 *
 */
@Controller
@RequestMapping(value = "/packet")
public class PacketController {
	
	Logger logger = Logger.getLogger(this.getClass());
	
	@Autowired
	private PacketService packetService;
	
	@Autowired
	private TerminalService terminalService;
	
	@Autowired
	private DepartmentService departmentService; 
	/**
	 * 删除一个分组
	 * @param request
	 * @param response
	 * @param packet
	 * @return
	 */
	@RequestMapping(value = "/packet_delete.do")
	@ResponseBody
	public Map<String, Object> deletePacket(HttpServletRequest request, HttpServletResponse response){
		String packetIds = request.getParameter("packetIds");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("ids", packetIds.split(","));
		try {
			packetService.deleteByIdS(map);
			terminalService.updateByPacket(map);
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		map.put("message", 1);
		return map;
	}
	
	
	/**
	 * 查询分组记录
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/packet_list.do")
	@ResponseBody
	public Map<String,Object> queryPacketList(HttpServletRequest request, HttpServletResponse response){
		List<TreeVO> treeList = null;
		String result = "";
		Map<String,Object> jsonMap = new HashMap<String, Object>();
		
		try {
			SysUserVO user = Utils.getUserbySession(request);
			if(user == null){
				throw new Exception("session is null");
			}
			
			List<String> departments = departmentService.getDepartmentIds(request);
			
			
			treeList = packetService.queryPacketList(departments);
			
			result = TreeUtils.createJson4PacketTree(treeList);
			jsonMap.put("packets", result);
			logger.info("返回的json: "+result);
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		
		return jsonMap;
	}
 
	/**
	 * 更新分组信息
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/packet_update.do")
	@ResponseBody
	public Map<String,Object> addLeaf(HttpServletRequest request, HttpServletResponse response){
		List<TreeVO> treeList = null;
		String result = "";
		Map<String,Object> jsonMap = new HashMap<String, Object>();
		
		try {
			String id = request.getParameter("id");

			String pId = request.getParameter("pId");
			String name = request.getParameter("name");
			SysUserVO user = (SysUserVO) request.getSession().getAttribute(Constants.SESSION_LOGIN_USER);
			if(user == null){
				throw new Exception("session is null");
			}
			
			Packet packet = new Packet();
			packet.setCreateDate(new Date());
			if(pId == null || "null".equals(pId) || "".equals(pId)){
				pId = "0";
			}
			packet.setfId(pId);
			packet.setName(name);
			packet.setRemark(name);
			packet.setMechanism(user.getDepartmentid());
			
			if(id == null || "null".equals(id) || "".equals(id)){
				packet.setId(StringUtil.getUUID());
				packetService.save(packet);
			}else{
				packet.setId(id);
				packetService.update(packet);
			}

			
			List<String> departments = departmentService.getDepartmentIds(request);
			treeList = packetService.queryPacketList(departments);
			
			result = TreeUtils.createJson4PacketTree(treeList);
			jsonMap.put("packets", result);
			logger.info("返回的json: "+result);
			
		} catch (Exception e) {
			return null;
		}
		return jsonMap;
	}
	
	
	/**
	 * 打开分组页面
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/packet_page.do")
	public String getPacketPage(HttpServletRequest request, HttpServletResponse response){
		request.setAttribute("terminalIds",request.getParameter("terminalIds"));
		return "/page/terminal/packet_info";
	}
}
