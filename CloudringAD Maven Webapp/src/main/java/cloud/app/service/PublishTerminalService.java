package cloud.app.service;

import java.util.Map;

import cloud.app.entity.PublishTerminal;

public interface PublishTerminalService extends  BaseService<PublishTerminal>{
	
	public void updateBatch(Map<String, Object> map)throws Exception;
		
	public PublishTerminal getByTerminalId(PublishTerminal publishTerminal)throws Exception;

}
