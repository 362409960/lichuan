package cloud.shop.goods.service;

import java.util.List;

import cloud.shop.goods.entity.OrdersDetail;

public interface OrdersDetailService {
	
	public void save(OrdersDetail ordersDetail) throws Exception;
	
	public void deleteById(String id) throws Exception;

	public void update(OrdersDetail ordersDetail) throws Exception;
	
	public List<OrdersDetail> getOrdersDetailList(OrdersDetail ordersDetail) throws Exception;
	
	public List<OrdersDetail> getOrdersDetailByOidList(String oid) throws Exception;

}
