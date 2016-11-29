package cloud.shop.goods.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cloud.shop.goods.dao.OrdersDAO;
import cloud.shop.goods.entity.Orders;
import cloud.shop.goods.service.OrdersService;
@Service
public class OrdersServiceImpl implements OrdersService {
    
	@Autowired
	private OrdersDAO ordersDAO;
	@Override
	public void save(Orders orders) throws Exception {
		this.ordersDAO.save(orders);
		
	}

	@Override
	public void deleteById(String id) throws Exception {
		this.ordersDAO.deleteById(id);
		
	}

	@Override
	public void update(Orders orders) throws Exception {
		this.ordersDAO.update(orders);
		
	}

	@Override
	public List<Orders> getOrdersList(Orders orders) throws Exception {
		// TODO Auto-generated method stub
		return this.ordersDAO.getOrdersList(orders);
	}

	@Override
	public Orders getOrdersByOidList(String oid) throws Exception {
		// TODO Auto-generated method stub
		return this.ordersDAO.getOrdersByOidList(oid);
	}

	@Override
	public List<Orders> getOrdersAndStatusList(Orders orders) throws Exception {
		// TODO Auto-generated method stub
		return this.ordersDAO.getOrdersAndStatusList(orders);
	}

	@Override
	public int getStatusCount(String userId) throws Exception {
		// TODO Auto-generated method stub
		return this.ordersDAO.getStatusCount(userId);
	}

	@Override
	public void updateByOid(Orders orders) throws Exception {
		 this.ordersDAO.updateByOid(orders);
		
	}
	

}
