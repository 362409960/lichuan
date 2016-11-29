package cloud.app.dao;

import cloud.app.entity.DataGathering;

public interface DataGatheringDAO extends BaseDAO<DataGathering>{
    int deleteByPrimaryKey(String id);

    int insert(DataGathering record);

    int insertSelective(DataGathering record);

    DataGathering selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(DataGathering record);

    int updateByPrimaryKey(DataGathering record);
}