package cloud.app.quartz;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.util.StringUtils;

import cloud.app.common.PropertiesUtils;
import cloud.app.dao.TerminalDAO;


//更新终端在线状态
public class UpdateTerminalStatusQuartzJob {
	
	Logger logger = Logger.getLogger(this.getClass());
	int keepAliveInterval = 0;   //如果超过该时间，就认为离线， 单位秒
	
	@Resource
	TerminalDAO terminalDAO;
	
	public void execute()throws Exception{
		if(logger.isDebugEnabled()){
			logger.debug(System.currentTimeMillis()+ " start update terminal status");
		}
		
		String tempkeepAliveInterval = PropertiesUtils.getInstance().getValue("keepAliveInterval");
		if(!StringUtils.isEmpty(tempkeepAliveInterval)){
			//比实际心跳时间多5秒，
			keepAliveInterval = Integer.parseInt(tempkeepAliveInterval) + 5;
		}
		
		terminalDAO.UpdateTerminalStatus(keepAliveInterval);
		
		if(logger.isDebugEnabled()){
			logger.debug(System.currentTimeMillis()+ " end update terminal status");
		}
	}
}
