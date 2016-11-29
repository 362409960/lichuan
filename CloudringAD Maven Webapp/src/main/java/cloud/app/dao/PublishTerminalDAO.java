package cloud.app.dao;


import java.util.Map;


import cloud.app.entity.PublishTerminal;

public interface PublishTerminalDAO  extends BaseDAO<PublishTerminal>{
	
     void updateBatch(Map<String, Object> map)throws Exception;
	
	 PublishTerminal getByTerminalId(PublishTerminal publishTerminal)throws Exception;

}
