package cloud.app.order.dao;

import cloud.app.order.model.Payment;

public interface PaymentDAO {
    int deleteByPrimaryKey(String id);

    int insert(Payment record);

    int insertSelective(Payment record);

    Payment selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(Payment record);

    int updateByPrimaryKeyWithBLOBs(Payment record);

    int updateByPrimaryKey(Payment record);
}