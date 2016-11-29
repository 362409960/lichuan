package cloud.app.order.dao;

import java.util.List;

import cloud.app.order.model.PaymentConfig;

public interface PaymentConfigDAO {
    int deleteByPrimaryKey(String id);

    int insert(PaymentConfig record);

    int insertSelective(PaymentConfig record);

    PaymentConfig selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(PaymentConfig record);

    int updateByPrimaryKeyWithBLOBs(PaymentConfig record);

    int updateByPrimaryKey(PaymentConfig record);

	List<PaymentConfig> getPaymentConfigs(PaymentConfig paymentConfig);
}