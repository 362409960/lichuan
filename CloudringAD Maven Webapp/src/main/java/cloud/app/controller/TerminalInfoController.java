/**
 * 终端管理controller
 */
package cloud.app.controller;

import java.io.File;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import cloud.app.common.StringUtil;
import cloud.app.common.Utils;
import cloud.app.entity.FirnwareFile;
import cloud.app.entity.NewsStream;
import cloud.app.entity.Publish;
import cloud.app.entity.Surveillance;
import cloud.app.entity.Terminal;
import cloud.app.entity.TimeVO;
import cloud.app.service.NewsStreamService;
import cloud.app.service.PublishService;
import cloud.app.service.SurveillanceService;
import cloud.app.service.TerminalService;
import cloud.app.service.mqtt.impl.MqttBroker;
import cloud.app.service.mqtt.impl.WebMqttClient;
import cloud.app.system.service.DepartmentService;
import cloud.app.system.vo.SysUserVO;

import com.alibaba.fastjson.JSONArray;

/**
 * @author zhoushunfang
 *
 */
@Controller
@RequestMapping("/terminalInfo")
public class TerminalInfoController {
	Logger logger = Logger.getLogger(this.getClass()); 
	SimpleDateFormat sdf= new SimpleDateFormat("yyyy-MM-dd HH:mm");
	
	@Autowired
	private TerminalService terminalService ;
	
	@Autowired
	private PublishService publishService;
	
	@Autowired
	private SurveillanceService surveillanceService;
	
	@Autowired
	private NewsStreamService newsStreamService ;
	
	@Autowired
	private DepartmentService departmentService; 
	
	@Autowired
	WebMqttClient tempClient;
	/**
	 * 查询终端列表
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/terminal_list.do")
	private String getTerminalList(HttpServletRequest request, HttpServletResponse response,Terminal terminal){
		terminal.setPageNumber(1);
		terminal.setPageSize(10);
		terminal.setPageIndex((terminal.getPageNumber() - 1) * terminal.getPageSize());
		List<Terminal> terminals = null;
		try {
			List<String> departments = departmentService.getDepartmentIds(request);
			
			terminal.setDepartmentIds(departments);
			terminals = terminalService.getList(terminal);
			
//			for (Terminal terminal2 : terminals) {
//				Surveillance surveillance = new Surveillance(); 
//				surveillance.setTerminalId(terminal2.getId());
//				terminal2.setSurveillances(surveillanceService.getList(surveillance));
//			}
			
			terminal.setRows(terminals);
			terminal.setTotal(terminalService.count(terminal));
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		int pageTotal = 1;//总页数
		if(terminal.getTotal() != 0 && (terminal.getTotal()%terminal.getPageSize() == 0)){
			pageTotal = terminal.getTotal()/terminal.getPageSize();
		}else{
			pageTotal = terminal.getTotal()/terminal.getPageSize() + 1;
		}
		request.setAttribute("pageTotal", pageTotal);
		request.setAttribute("terminal", terminal);
		return "/page/terminal/terminal_info";
	}
	
	
	/**
	 * 条件查询终端列表
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/terminal_search.do")
	private String getTerminalListSearch(HttpServletRequest request, HttpServletResponse response,Terminal terminal){
		if(terminal.getPageNumber() == null || terminal.getPageSize() == null){
			terminal.setPageNumber(1);
			terminal.setPageSize(10);
		}
		terminal.setPageIndex((terminal.getPageNumber() - 1) * terminal.getPageSize());
		List<Terminal> terminals = new ArrayList<Terminal>();
		try {
			String packetIds [] = terminal.getPacket().split(",");
			for (String packet : packetIds) {
				terminal.setPacket(packet);
				List<String> departments = departmentService.getDepartmentIds(request);
				
				terminal.setDepartmentIds(departments);
				terminals.addAll(terminalService.getList(terminal));
				for (Terminal terminal2 : terminals) {
					Surveillance surveillance = new Surveillance(); 
					surveillance.setTerminalId(terminal2.getId());
					terminal2.setSurveillances(surveillanceService.getList(surveillance));
				}
				if(terminal.getTotal() != null){
					terminal.setTotal(terminal.getTotal()+terminalService.count(terminal));
				}else{
					terminal.setTotal(terminalService.count(terminal));
				}
			}
			terminal.setRows(terminals);
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		int pageTotal = 1;//总页数
		if(terminal.getTotal() != 0 && (terminal.getTotal()%terminal.getPageSize() == 0)){
			pageTotal = terminal.getTotal()/terminal.getPageSize();
		}else{
			pageTotal = terminal.getTotal()/terminal.getPageSize() + 1;
		}
		request.setAttribute("pageTotal", pageTotal);
		request.setAttribute("terminal", terminal);
		return "/page/terminal/terminal_info";
	}
	
	/**
	 * 删除终端
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/terminal_delete.do")
	@ResponseBody
	private Map<String,Object> deleteTerminal(HttpServletRequest request, HttpServletResponse response){
		Map<String,Object> map = new HashMap<String,Object>();
		String terminalIds [] = request.getParameter("ids").split(",");
		map.put("ids", terminalIds);
		try {
			terminalService.deleteByIdS(map);
			
			for (String terminalId : terminalIds) {
				NewsStream newsStream = new NewsStream();
				newsStream.setTerminalId(terminalId);
				List<NewsStream> newsStreamList = newsStreamService.getList(newsStream);
				
				for (NewsStream newsStreams : newsStreamList) {
					String oldTerminalId = newsStreams.getTerminalId();
					String oldTerminalIds [] = oldTerminalId.split(",");
					String newTerminalId = "";
					for (int i = 0; i< oldTerminalIds.length; i++) {
						String oldId = oldTerminalIds[i];
						if(!terminalId.equals(oldId)){
							if(i+1 >= oldTerminalIds.length){
								newTerminalId += oldId;
							}
							else{
								newTerminalId += oldId + ",";
							}
						}
					}
					newsStreams.setTerminalId(newTerminalId);
					newsStreamService.update(newsStreams);
				}
			}
			
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		map = new HashMap<String, Object>();
		map.put("erron", 1);
		return map;
	}
	
	/**
	 * 修改终端信息
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/terminal_update.do")
	private String updateTerminal(HttpServletRequest request, HttpServletResponse response,Terminal terminal){
		try {
			terminalService.update(terminal);
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		return "redirect:/terminalInfo/terminal_info.do?terminalId="+terminal.getId()+"&action=search";
	}
	
	
	/**
	 * 新增终端信息
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/terminal_add.do")
	@ResponseBody
	private Map<String,Object> addTerminal(HttpServletRequest request, HttpServletResponse response,Terminal terminal){
		Map<String,Object> map = new HashMap<String,Object>();
		String ip = request.getParameter("ip");
		String name = request.getParameter("name");
		try {
			SysUserVO user = Utils.getUserbySession(request);
			terminal.setName(name);
			terminal.setIp(ip);
			terminal.setMechanism(user.getDepartmentid());
			terminal.setId(UUID.randomUUID().toString().replace("-", ""));
			terminal.setCreateDate(new Date());
			terminal.setModifyDate(new Date());
			terminalService.save(terminal);
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		map.put("message", 1);
		return map;
	}
	
	/**
	 * 终端详情
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/terminal_info.do")
	private String getTerminalInfo(HttpServletRequest request, HttpServletResponse response){
		String terminalId = request.getParameter("terminalId");
		String action = request.getParameter("action");
		Terminal terminal = null;
		List<Publish>  publishs = null;
		try {
			terminal = terminalService.getObjById(terminalId);//得到终端详情
			publishs = publishService.getProgramListByTerminal(terminalId);//得到当前终端下的节目单
			publishs = processingData(publishs);
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		request.setAttribute("terminal", terminal);
		request.setAttribute("publishs", publishs);
		String returnUrl = "";
		if("search".equals(action)){
			returnUrl = "/page/terminal/terminal_detail";
		}
		if("update".equals(action)){
			returnUrl = "/page/terminal/terminal_edit";
		}
		
		return returnUrl;
	}
	
	
	/**
	 * 处理节目数据
	 * @param publishs
	 * @throws ParseException 
	 */
	private List<Publish> processingData(List<Publish> publishs) throws ParseException {
		List<Publish> list = new ArrayList<Publish>();
		long nowTime = new Date().getTime();
		for (Publish publish : publishs) {
			
			if("0".equals(publish.getPlayMode())){
				if(publish.getScheduledPublish() != "" && publish.getScheduledPublish() != null){
					long publishTime = sdf.parse(publish.getScheduledPublish()).getTime();
					if(nowTime > publishTime){
						list.add(publish);
					}
				}else{
					list.add(publish);
				}
			}
			if("1".equals(publish.getPlayMode())){
				String week = getWeek();
				String modeContent = publish.getModeContent();
				if(modeContent.contains(week)){
					if(publish.getScheduledPublish() != "" && publish.getScheduledPublish() != null){
						long publishTime = sdf.parse(publish.getScheduledPublish()).getTime();
						if(nowTime > publishTime){
							list.add(publish);
						}
					}else{
						list.add(publish);
					}
				}
				
			}
			if("2".equals(publish.getPlayMode())){
				String modeContent = publish.getModeContent();
				List<TimeVO> timeVOs = JSONArray.parseArray(modeContent, TimeVO.class);
				for (TimeVO timeVO : timeVOs) {
					long startPublishTime = sdf.parse(timeVO.getStartTime()).getTime();
					long endPublishTime = sdf.parse(timeVO.getEndTime()).getTime();
					
					if(startPublishTime < nowTime && nowTime < endPublishTime){
						if(publish.getScheduledPublish() != "" && publish.getScheduledPublish() != null){
							long publishTime = sdf.parse(publish.getScheduledPublish()).getTime();
							if(nowTime > publishTime){
								list.add(publish);
								break;
							}
						}else{
							list.add(publish);
							break;
						}
					}
				}
			}
			
		}
		return list;
	}	

	/**
	 * 得到当前星期几
	 * @return
	 */
	private String getWeek(){
		String [] weekDays = {"Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"};
		Calendar c = Calendar.getInstance();
		int w = c.get(Calendar.DAY_OF_WEEK) - 1;
		if (w < 0)
			w = 0;
        return weekDays[w];
	}
	
	
	/**
	 * 得到硬件目录下所有文件
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/firnware_list.do")
	private String getFirmwareList(HttpServletRequest request, HttpServletResponse response){
		String filePath = request.getParameter("filePath");
		if(StringUtil.isBlank(filePath)){
			filePath = cloud.app.common.ImageUtil.getSaveAttachmentFilePath(cloud.app.common.Constants.CLOUD_FILE_FILE);
		}
		List<FirnwareFile> firnwareFiles = new ArrayList<FirnwareFile>(); 
		getFileList(filePath,firnwareFiles);
		request.setAttribute("firnwareFiles", firnwareFiles);
		request.setAttribute("parentPath",new File(filePath).getParent());
		request.setAttribute("absolutePath",filePath);
		return "/page/terminal/files";
	}


	private void getFileList(String filePath,List<FirnwareFile> firnwareFiles) {
		File file = new File(filePath);
		if(!file.exists()){
			file.mkdirs();
		}
		if (file.isFile()) {
			FirnwareFile firnwareFile = new FirnwareFile();
			firnwareFile.setFileName(file.getName());
			firnwareFile.setAbsolutePath(file.getAbsolutePath().replace("\\", "/"));
			firnwareFile.setFileSize(file.length()/1024+"");
			firnwareFile.setFileSuffixname(file.getName().split("\\.")[1]);
			firnwareFile.setFileUpdateTime(new Date(file.lastModified()));
			firnwareFile.setIsFile(1);
			firnwareFile.setParentPath(file.getParent().replace("\\", "/"));
			firnwareFiles.add(firnwareFile);

	    } else if (file.isDirectory()) {
            String[] filelist = file.list();
            if(filelist == null){
            	FirnwareFile firnwareFile = new FirnwareFile();
    			firnwareFile.setFileName(file.getName());
    			firnwareFile.setAbsolutePath(file.getAbsolutePath().replace("\\", "/"));
    			firnwareFile.setFileSize(file.length()/1024+"");
    			firnwareFile.setFileUpdateTime(new Date(file.lastModified()));
    			firnwareFile.setIsFile(0);
    			firnwareFile.setParentPath(file.getParent().replace("\\", "/"));
    			firnwareFiles.add(firnwareFile);
            }else{
	            for (int i = 0; i < filelist.length; i++) {
                    File readfile = new File(filePath + File.separator + filelist[i]);
                	FirnwareFile firnwareFile = new FirnwareFile();
        			firnwareFile.setFileName(readfile.getName());
        			firnwareFile.setAbsolutePath(readfile.getAbsolutePath().replace("\\", "/"));
        			firnwareFile.setIsFile(0);
        			if(readfile.isFile()){
        				firnwareFile.setFileSize(readfile.length()/1024+"");
        				firnwareFile.setFileSuffixname(readfile.getName().split("\\.")[1]);
        				firnwareFile.setIsFile(1); 
        			}
        			firnwareFile.setFileUpdateTime(new Date(readfile.lastModified()));
        			firnwareFile.setParentPath(readfile.getParent().replace("\\", "/"));
        			firnwareFiles.add(firnwareFile);
	            }
            }
	    }
	}
	
	/**
	 * 文件上传
	 * @param apkFile
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/firnware_upload.do")
	@ResponseBody
	public Map<String,Object> firnwareUpload( @RequestParam(value = "zipFile") MultipartFile zipFile,HttpServletRequest request, HttpServletResponse response) throws Exception{
		//获取保存的路径，
		String realPath = cloud.app.common.ImageUtil.getSaveAttachmentFilePath(cloud.app.common.Constants.CLOUD_FILE_FILE);
		if(!new File(realPath).exists()){
			new File(realPath).mkdirs();
		}
		if (zipFile != null) {
			
	      if (zipFile.isEmpty()) {
	          // 未选择文件
	      } else{
	          // 文件原名称
	          String originFileName = zipFile.getOriginalFilename();
	          try {
	              //这里使用Apache的FileUtils方法来进行保存
	              FileUtils.copyInputStreamToFile(zipFile.getInputStream(),
	                      new File(realPath, originFileName));
	          } catch (IOException e) {
	              logger.error(e.getMessage());
	          }
		   }
		}
		Map<String,Object> result = new HashMap<String,Object>();
		result.put("message", 1);
		return result;
	}
	
	
	/**
	 * 修改终端信息
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/terminal_packet_update.do")
	@ResponseBody
	private Map<String,Object> updatePacketTerminal(HttpServletRequest request, HttpServletResponse response){
		String terminalIds [] = request.getParameter("ids").split(",");
		String packet = request.getParameter("packet");
		Map<String,Object> map = new HashMap<String, Object>();
		Terminal terminal = new Terminal();
		try {
			for (String terminalId : terminalIds) {
				terminal.setId(terminalId);
				terminal.setPacket(packet);
				terminalService.update(terminal);
			}
			map.put("message", 1);
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		return map;
	}
	
	
	/**
	 * 删除终端下的节目
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/terminal_program_delete.do")
	@ResponseBody
	private Map<String,Object> deleteTerminalProgram(HttpServletRequest request, HttpServletResponse response){
		Map<String,Object> map = new HashMap<String, Object>();
		String publishId = request.getParameter("publishId");
		String terminalId = request.getParameter("terminalId");
		if(terminalId == null || "".equals(terminalId.trim()) || "null".equals(terminalId)){
			return map;
		}
		if(publishId == null || "".equals(publishId.trim()) || "null".equals(publishId)){
			return map;
		}
		try { 
			
			Publish publish = publishService.getObjById(publishId);
			String oldTerminalIds [] = publish.getTermianl_id().split(",");
			String newTerminalIds = "";
			for (int i = 0 ; i < oldTerminalIds.length ; i ++) {
				String oldTerminalId = oldTerminalIds[i];
				if(!oldTerminalId.equals(terminalId) && !StringUtil.isBlank(oldTerminalId)){
					if(i + 1 >= oldTerminalIds.length){
						newTerminalIds += oldTerminalId;
					}else{
						newTerminalIds += oldTerminalId+",";
					}
					
				}
			}
			
			if(StringUtil.isBlank(newTerminalIds)){
				publishService.deleteById(publish.getId());
			}else{
				publish.setTermianl_id(newTerminalIds);
				publishService.update(publish);
			}
			
			if(terminalId == null || "".equals(terminalId.trim()) || "null".equals(terminalId)){
				return map;
			}
			String makeInstruction = "{\"action\":\"emptyProgram\",\"id\":\""+publish.getProgram_id()+"\"}";
			String topic = "cloudringAd/server/web/" + terminalId + "/out";
			logger.info("-----------web发送节目清空信息到mqtt服务器上------------ "+topic);
			logger.info("-----------web发送节目清空信息到mqtt服务器上------------ "+makeInstruction);
			tempClient.publish(topic, MqttBroker.QOS_VALUES[0], makeInstruction.getBytes());
			
			
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		map.put("message", 1);
		return map;
	}
}
