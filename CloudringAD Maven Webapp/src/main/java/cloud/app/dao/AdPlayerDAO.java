package cloud.app.dao;

import cloud.app.entity.AdPlayer;

public interface AdPlayerDAO extends BaseDAO<AdPlayer>{
    int deleteByPrimaryKey(String id);

    int insert(AdPlayer record);

    int insertSelective(AdPlayer record);

    AdPlayer selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(AdPlayer record);

    int updateByPrimaryKey(AdPlayer record);
}