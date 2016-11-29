package cloud.app.dao;

import java.util.List;

import cloud.app.entity.Surveillance;
import cloud.app.system.vo.TreeVO;
import cloud.app.vo.SurveillanceVO;

public interface SurveillanceDAO extends BaseDAO<Surveillance>{
    int deleteByPrimaryKey(String id);

    int insert(Surveillance record);

    int insertSelective(Surveillance record);

    Surveillance selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(Surveillance record);

    int updateByPrimaryKey(Surveillance record);
    
    List<String> getPacketList();

	List<TreeVO> selectTree(String terminalId);
	
	List<SurveillanceVO> getSurveillanceListByTerminalId(String terminalId);
}