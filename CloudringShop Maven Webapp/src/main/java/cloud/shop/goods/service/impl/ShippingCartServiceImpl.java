package cloud.shop.goods.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cloud.shop.goods.dao.ShippingCartDAO;
import cloud.shop.goods.entity.ShippingCart;
import cloud.shop.goods.service.ShippingCartService;
@Service
public class ShippingCartServiceImpl implements ShippingCartService {
	@Autowired
	private ShippingCartDAO shippingCartDAO;

	@Override
	public void insertShippingCart(ShippingCart shippingCart) throws Exception {
		this.shippingCartDAO.insertShippingCart(shippingCart);
		
	}

	@Override
	public void updateShippingCart(ShippingCart shippingCart) throws Exception {
		this.shippingCartDAO.updateShippingCart(shippingCart);
		
	}

	@Override
	public void deleteById(String id) throws Exception {
		this.shippingCartDAO.deleteById(id);
		
	}

	@Override
	public List<ShippingCart> getShippingCartList(ShippingCart shippingCart)
			throws Exception {
		
		return this.shippingCartDAO.getShippingCartList(shippingCart);
	}

	@Override
	public int ShippingCartCount(ShippingCart shippingCart) throws Exception {
		// TODO Auto-generated method stub
		return this.shippingCartDAO.ShippingCartCount(shippingCart);
	}

	@Override
	public ShippingCart selectCheckId(String id) throws Exception {
		// TODO Auto-generated method stub
		return this.shippingCartDAO.selectCheckId(id);
	}

	@Override
	public List<ShippingCart> geteShippingCartIp(String ip) throws Exception {
		// TODO Auto-generated method stub
		return this.shippingCartDAO.geteShippingCartIp(ip);
	}

	@Override
	public List<ShippingCart> getCartByUserNameList(String ip) throws Exception {
		// TODO Auto-generated method stub
		return this.shippingCartDAO.getCartByUserNameList(ip);
	}

	@Override
	public List<ShippingCart> geteShippingCartByUserIdList(String userId)
			throws Exception {
		// TODO Auto-generated method stub
		return this.shippingCartDAO.geteShippingCartByUserIdList(userId);
	}

}
