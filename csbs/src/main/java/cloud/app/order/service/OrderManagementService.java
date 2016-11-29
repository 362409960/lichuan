/**
 * 
 */
package cloud.app.order.service;

import java.util.List;

import cloud.app.order.model.DeliveryType;
import cloud.app.order.model.OrderItem;
import cloud.app.order.model.OrderLog;
import cloud.app.order.model.PaymentConfig;
import cloud.app.order.vo.OrdersVO;
import cloud.app.service.BaseService;

/**
 * @author zhoushunfang
 *
 */
public interface OrderManagementService extends BaseService<OrdersVO>{

	List<OrderItem> getOrderItemList(OrderItem orderItem);

	List<OrderLog> getOrderLogList(OrderLog orderLog);

	List<PaymentConfig> getPaymentConfigList(PaymentConfig paymentConfig);

	List<DeliveryType> getDeliveryTypeList(DeliveryType deliveryType);
	
}
