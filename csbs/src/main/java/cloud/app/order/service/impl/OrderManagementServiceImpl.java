/**
 * 
 */
package cloud.app.order.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cloud.app.order.dao.DeliveryTypeDAO;
import cloud.app.order.dao.OrderItemDAO;
import cloud.app.order.dao.OrderLogDAO;
import cloud.app.order.dao.OrdersDAO;
import cloud.app.order.dao.PaymentConfigDAO;
import cloud.app.order.model.DeliveryType;
import cloud.app.order.model.OrderItem;
import cloud.app.order.model.OrderLog;
import cloud.app.order.model.PaymentConfig;
import cloud.app.order.service.OrderManagementService;
import cloud.app.order.vo.OrdersVO;

/**
 * @author zhoushunfang
 *
 */
@Service
public class OrderManagementServiceImpl implements OrderManagementService {

	@Autowired 
	private OrdersDAO ordersDAO;
	
	@Autowired 
	private OrderItemDAO orderItemDAO;
	
	@Autowired
	private OrderLogDAO orderLogDAO;
	
	@Autowired
	private PaymentConfigDAO paymentConfigDAO;
	
	@Autowired
	private DeliveryTypeDAO deliveryTypeDAO;
	
	@Override
	public void save(OrdersVO obj) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void update(OrdersVO obj) throws Exception {
		ordersDAO.updateSelective(obj);
	}

	@Override
	public void deleteById(String id) throws Exception {
		ordersDAO.deleteByPrimaryKey(id);
	}

	@Override
	public List<OrdersVO> getList(OrdersVO obj) throws Exception {
		return ordersDAO.searchOrderList(obj);
	}

	@Override
	public OrdersVO getObjById(String id) throws Exception {
		return ordersDAO.selectByPrimaryKey(id);
	}

	@Override
	public Integer count(OrdersVO obj) throws Exception {
		return ordersDAO.searchOrderListCount(obj);
	}

	@Override
	public void deleteByIdS(String[] ids) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<OrderItem> getOrderItemList(OrderItem orderItem) {
		return orderItemDAO.searchOrderItems(orderItem);
	}

	@Override
	public List<OrderLog> getOrderLogList(OrderLog orderLog) {
		return orderLogDAO.searchOrderLogs(orderLog);
	}

	@Override
	public List<PaymentConfig> getPaymentConfigList(PaymentConfig paymentConfig) {
		return paymentConfigDAO.getPaymentConfigs(paymentConfig);
	}

	@Override
	public List<DeliveryType> getDeliveryTypeList(DeliveryType deliveryType) {
		return deliveryTypeDAO.getDeliveryTypes(deliveryType);
	}

}
