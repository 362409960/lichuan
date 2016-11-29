package cloud.app.dao;

import java.util.List;
import java.util.Map;

import cloud.app.entity.Publish;

public interface PublishDAO extends BaseDAO<Publish> {
	
	Integer getObjByProgramId(String id)throws Exception;
	
	void updateBatch(Map<String, Object> map)throws Exception;
	
	List<Publish> getByDownlodPublish(Publish publish)throws Exception;
	
	Integer countDownlodPublish(Publish publish)throws Exception;

	List<Publish> getProgramListByTerminal(String terminalId); 
	
	List<Publish> getPublishByTerminalId(String terminalId)throws Exception;
	
	Integer getMaxVersionByProgramId(String programId)throws Exception;
}
