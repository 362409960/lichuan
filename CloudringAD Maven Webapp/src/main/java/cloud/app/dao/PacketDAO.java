package cloud.app.dao;

import java.util.List;

import cloud.app.entity.Packet;
import cloud.app.system.vo.TreeVO;

public interface PacketDAO extends BaseDAO<Packet>{
    int deleteByPrimaryKey(String id);

    int insert(Packet record);

    int insertSelective(Packet record);

    Packet selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(Packet record);

    int updateByPrimaryKey(Packet record);

	List<TreeVO> selectTree(List<String> mechanisms);

	void deleteTree(String id);
}