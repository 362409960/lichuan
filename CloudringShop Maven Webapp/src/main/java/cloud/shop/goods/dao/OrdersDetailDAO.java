package cloud.shop.goods.dao;

import java.util.List;


import cloud.shop.goods.entity.OrdersDetail;

public interface OrdersDetailDAO {
	
    void save(OrdersDetail ordersDetail) throws Exception;
	
	void deleteById(String id) throws Exception;

	void update(OrdersDetail ordersDetail) throws Exception;
	
	List<OrdersDetail> getOrdersDetailList(OrdersDetail ordersDetail) throws Exception;
	
	List<OrdersDetail> getOrdersDetailByOidList(String oid) throws Exception;

}
