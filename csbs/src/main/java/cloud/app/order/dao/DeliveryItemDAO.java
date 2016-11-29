package cloud.app.order.dao;

import cloud.app.order.model.DeliveryItem;

public interface DeliveryItemDAO {
    int deleteByPrimaryKey(String id);

    int insert(DeliveryItem record);

    int insertSelective(DeliveryItem record);

    DeliveryItem selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(DeliveryItem record);

    int updateByPrimaryKey(DeliveryItem record);
}