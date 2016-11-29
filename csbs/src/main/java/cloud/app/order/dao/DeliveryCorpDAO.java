package cloud.app.order.dao;

import cloud.app.order.model.DeliveryCorp;

public interface DeliveryCorpDAO {
    int deleteByPrimaryKey(String id);

    int insert(DeliveryCorp record);

    int insertSelective(DeliveryCorp record);

    DeliveryCorp selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(DeliveryCorp record);

    int updateByPrimaryKey(DeliveryCorp record);
}