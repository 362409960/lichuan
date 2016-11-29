package cloud.shop.goods.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cloud.shop.goods.dao.OrdersDetailDAO;
import cloud.shop.goods.entity.OrdersDetail;
import cloud.shop.goods.service.OrdersDetailService;
@Service
public class OrdersDetailServiceImpl implements OrdersDetailService {

	@Autowired
	private OrdersDetailDAO ordersDetailDAO;
	@Override
	public void save(OrdersDetail ordersDetail) throws Exception {
		this.ordersDetailDAO.save(ordersDetail);

	}

	@Override
	public void deleteById(String id) throws Exception {
		this.ordersDetailDAO.deleteById(id);

	}

	@Override
	public void update(OrdersDetail ordersDetail) throws Exception {
		this.ordersDetailDAO.update(ordersDetail);

	}

	@Override
	public List<OrdersDetail> getOrdersDetailList(OrdersDetail ordersDetail)
			throws Exception {
		// TODO Auto-generated method stub
		return this.ordersDetailDAO.getOrdersDetailList(ordersDetail);
	}

	@Override
	public List<OrdersDetail> getOrdersDetailByOidList(String oid)
			throws Exception {
		// TODO Auto-generated method stub
		return this.ordersDetailDAO.getOrdersDetailByOidList(oid);
	}

}
