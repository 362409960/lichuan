package cloud.app.order.dao;

import cloud.app.order.model.Reship;

public interface ReshipDAO {
    int deleteByPrimaryKey(String id);

    int insert(Reship record);

    int insertSelective(Reship record);

    Reship selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(Reship record);

    int updateByPrimaryKeyWithBLOBs(Reship record);

    int updateByPrimaryKey(Reship record);
}