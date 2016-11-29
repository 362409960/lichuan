package cloud.shop.goods.service;

import java.util.List;

import cloud.shop.goods.entity.Orders;

public interface OrdersService {
	
    public void save(Orders orders) throws Exception;
	
    public void deleteById(String id) throws Exception;

    public void update(Orders orders) throws Exception;
    
    public void updateByOid(Orders orders) throws Exception;
	
    public List<Orders> getOrdersList(Orders orders) throws Exception;
    
    public Orders getOrdersByOidList(String oid) throws Exception;
    
    public List<Orders> getOrdersAndStatusList(Orders orders) throws Exception;
    
    public int getStatusCount(String userId)throws Exception;

}
