package cloud.app.dao;

import java.util.List;
import java.util.Map;

import cloud.app.entity.Terminal;

public interface TerminalDAO extends BaseDAO<Terminal>{
    int deleteByPrimaryKey(String id);

    int insert(Terminal record);

    int insertSelective(Terminal record);

    Terminal selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(Terminal record);

    int updateByPrimaryKey(Terminal record);

	List<Terminal> getListAndMessage(Terminal obj);

	Integer getListAndMessageCount(Terminal obj);
	
	void UpdateTerminalStatus(int keepAliveInterval);

	void updateByPacket(Map<String, Object> map);

	Terminal queryTerminalByUser(Map<String, String> map);
}