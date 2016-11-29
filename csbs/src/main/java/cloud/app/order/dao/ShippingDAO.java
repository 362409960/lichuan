package cloud.app.order.dao;

import cloud.app.order.model.Shipping;

public interface ShippingDAO {
    int deleteByPrimaryKey(String id);

    int insert(Shipping record);

    int insertSelective(Shipping record);

    Shipping selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(Shipping record);

    int updateByPrimaryKeyWithBLOBs(Shipping record);

    int updateByPrimaryKey(Shipping record);
}