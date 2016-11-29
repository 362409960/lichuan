package cloud.shop.goods.dao;

import java.util.List;


import cloud.shop.goods.entity.Orders;

public interface OrdersDAO {
	
    void save(Orders orders) throws Exception;
	
	void deleteById(String id) throws Exception;

	void update(Orders orders) throws Exception;
	
	void updateByOid(Orders orders) throws Exception;
	
	List<Orders> getOrdersList(Orders orders) throws Exception;
	
	Orders getOrdersByOidList(String oid) throws Exception;
	
	List<Orders> getOrdersAndStatusList(Orders orders) throws Exception;
	
	int getStatusCount(String userId)throws Exception;
}
