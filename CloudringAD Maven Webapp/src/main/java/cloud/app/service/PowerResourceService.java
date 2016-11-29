package cloud.app.service;

import java.util.Map;

import cloud.app.vo.PowerProgramResourceVO;

public interface PowerResourceService {
	public Map<String, PowerProgramResourceVO> getProgramByTerminalId(String terminalId) throws Exception;
	
}
