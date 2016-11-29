package cloud.app.webservice;

import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.core.Context;

import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.fusesource.mqtt.client.QoS;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;

import cloud.app.common.Constants;
import cloud.app.common.ThreeDes;
import cloud.app.dao.SurveillanceDAO;
import cloud.app.entity.Terminal;
import cloud.app.service.PowerResourceService;
import cloud.app.service.TerminalService;
import cloud.app.system.service.SysUserService;
import cloud.app.system.vo.SysUserVO;
import cloud.app.vo.PowerProgramResourceVO;
import cloud.app.vo.SurveillanceVO;
import cloud.app.vo.SyncResourcesVO;


@Component
@Path("/third")
public class ThirdPartyProxy {
	Logger logger = Logger.getLogger(this.getClass());
	SimpleDateFormat sf = new SimpleDateFormat("yyyyMMddHHmmss");
	
	String params = null;
	String returnMessage = "";
	final String ACTION_BINDING = "binding";
	final String ACTION_CALLBACK = "callback";
	final static String ACTION_SYNCRESOURCES = "syncResources";
	
	
	@Autowired
	private TerminalService terminalService;
	@Autowired
	SysUserService sysUserService;
	@Resource
	SurveillanceDAO surveillanceDAO;
	@Autowired
	PowerResourceService powerResourceService;
	
	
	
	@GET
	@Path("/")
	public void executeGet(@Context HttpServletRequest request, @Context HttpServletResponse response) throws Exception {
		PrintWriter out = null;
		String info = null;
		String apikey = "";
		String encoding = request.getCharacterEncoding();
		request.setCharacterEncoding(Constants.ENCODING);
		String returnJson = null;
		
		//解决乱码问题
		response.setContentType("text/html; charset=utf-8");
		System.out.println("encoding: "+encoding);
		
		try {
			System.out.println("get start...");
			info = request.getParameter("params");
			System.out.println(info);
			if(info == null || "".equals(info.trim())){
				out = response.getWriter();
				out.write("{\"errno\":\"1\",\"error\":\"参数为空\"}");
				out.flush();
				return;
			}
			
			//解密
			apikey = request.getHeader(Constants.APIKEYHEADFIELD);
			if(StringUtils.isEmpty(apikey)){
				out = response.getWriter();
				out.write("{\"errno\":\"2\",\"error\":\"加解密key为空\"}");
				out.flush();
				return;
			}
			
			System.out.println(info);
			String tempInfo = ThreeDes.decrypt(info, apikey, encoding);
			System.out.println(" ------------------> "+tempInfo);
			
			//用alibaba的json包来处理json串
			JSONObject jsonOject = (JSONObject)JSON.parse(tempInfo);
			String action = jsonOject.getString("action");
			//终端信息绑定
			if(action != null && ACTION_BINDING.equals(action.trim())){
				//先验证登录
				SysUserVO sysUserVO = new SysUserVO();
				sysUserVO.setUserCode(jsonOject.getString(Constants.JSON_KEY_USERCODE));
				sysUserVO.setUserPassword(jsonOject.getString(Constants.JSON_KEY_PASSWORD));
				sysUserVO.setState(Constants.C_STATUS_NORMAL);
				List<SysUserVO> userList = sysUserService.getSysUserList(sysUserVO);
				if(userList == null || userList.size() <1){
					out = response.getWriter();
				    out.write("{\"errno\":\"3\",\"error\":\"用户代码或者密码错误\"}");
					out.flush();
					return;
				}else{
					Terminal terminal = JSON.parseObject(tempInfo, Terminal.class);
					if(terminal != null){
						sysUserVO = userList.get(0);
						
						//判断是否绑定
						Object obj = terminalService.getObjById(terminal.getId());
						if(obj == null){
							if(StringUtils.isEmpty(terminal.getId())){
								throw new Exception("错误: 终端ID为空.");
							}
							
							terminal.setStatus(Constants.TERMINAL_ONLINE_IN);
							terminal.setMechanism(sysUserVO.getDepartmentid());
							terminal.setUserId(sysUserVO.getId());
							terminal.setCreateDate(new Date());
							terminal.setModifyDate(new Date());

							terminalService.save(terminal);
						}else{
							//判断是否同一个机构，如果不是同一个机构就抛出错误说明
							Terminal tempTerminal = (Terminal)obj;
							if(!tempTerminal.getMechanism().equals(sysUserVO.getDepartmentid())){
								out = response.getWriter();
							    out.write("{\"errno\":\"5\",\"error\":\"该终端已经绑定，请先登录后台解绑\"}");
								out.flush();
								return;
							}
						}
					}
				}
				
				returnJson = "{\"errno\":\"0\",\"error\":\"\"}";
			}
			//开机取资源
			else if(action != null && ACTION_SYNCRESOURCES.equals(action.trim())){
				String terminalId = jsonOject.getString(Constants.JSON_KEY_TERMINALID);
				
				List<SurveillanceVO> surveillanceList = surveillanceDAO.getSurveillanceListByTerminalId(terminalId);
				
				Map<String, PowerProgramResourceVO> map = powerResourceService.getProgramByTerminalId(terminalId);
				Collection<PowerProgramResourceVO> valueCollection = map.values();
				List<PowerProgramResourceVO> programList = new ArrayList<PowerProgramResourceVO>(valueCollection);
				
				SyncResourcesVO syncResourcesVO = new SyncResourcesVO();
				syncResourcesVO.setAction(ACTION_SYNCRESOURCES);
				syncResourcesVO.setTerminalId(terminalId);
				syncResourcesVO.setErrno("0");
				syncResourcesVO.setTm(sf.format(new Date()));
				syncResourcesVO.setVmIpList(surveillanceList);
				syncResourcesVO.setProgramList(programList);
				
				returnJson = JSONObject.toJSONString(syncResourcesVO);
			}

			out = response.getWriter();
			out.write(returnJson);
			out.flush();
		} catch (Exception ex) {
			if(out == null){
				out = response.getWriter();
			}
			out.write("{\"errno\":\"4\",\"error\":\"system error +"+ex.getMessage()+" \"}");
			out.flush();
			return;
		}finally{
			if(out != null){
				out.close();
			}
		}
	}

	@POST
	@Path("/")
	public void executePost(@Context HttpServletRequest request, @Context HttpServletResponse response) throws Exception {
		System.out.println("post start...");
		this.executeGet(request, response);
	}

	
}
