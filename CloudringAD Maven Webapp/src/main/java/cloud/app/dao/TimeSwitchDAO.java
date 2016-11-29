package cloud.app.dao;

import cloud.app.entity.TimeSwitch;

public interface TimeSwitchDAO extends BaseDAO<TimeSwitch>{
    int deleteByPrimaryKey(String id);

    int insert(TimeSwitch record);

    int insertSelective(TimeSwitch record);

    TimeSwitch selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(TimeSwitch record);

    int updateByPrimaryKey(TimeSwitch record);
}