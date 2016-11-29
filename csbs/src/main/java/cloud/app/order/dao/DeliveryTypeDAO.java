package cloud.app.order.dao;

import java.util.List;

import cloud.app.order.model.DeliveryType;

public interface DeliveryTypeDAO {
    int deleteByPrimaryKey(String id);

    int insert(DeliveryType record);

    int insertSelective(DeliveryType record);

    DeliveryType selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(DeliveryType record);

    int updateByPrimaryKeyWithBLOBs(DeliveryType record);

    int updateByPrimaryKey(DeliveryType record);

	List<DeliveryType> getDeliveryTypes(DeliveryType deliveryType);
}