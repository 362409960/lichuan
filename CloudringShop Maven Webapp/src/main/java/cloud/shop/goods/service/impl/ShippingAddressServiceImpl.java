package cloud.shop.goods.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cloud.shop.goods.dao.ShippingAddressDAO;
import cloud.shop.goods.entity.ShippingAddress;
import cloud.shop.goods.service.ShippingAddressService;
@Service
public class ShippingAddressServiceImpl implements ShippingAddressService {

	@Autowired
	private ShippingAddressDAO shippingAddressDAO;
	@Override
	public void insertShippingAddress(ShippingAddress shippingAddress)
			throws Exception {
		this.shippingAddressDAO.insertShippingAddress(shippingAddress);
		
	}

	@Override
	public void updateShippingAddress(ShippingAddress shippingAddress)
			throws Exception {
		this.shippingAddressDAO.updateShippingAddress(shippingAddress);
		
	}

	@Override
	public void deleteById(String id) throws Exception {
		this.shippingAddressDAO.deleteById(id);
		
	}

	@Override
	public List<ShippingAddress> getShippingAddressList(
			ShippingAddress shippingAddress) throws Exception {
		// TODO Auto-generated method stub
		return this.shippingAddressDAO.getShippingAddressList(shippingAddress);
	}

	@Override
	public List<ShippingAddress> getShippingAddressIdList(
			ShippingAddress shippingAddress) throws Exception {
		// TODO Auto-generated method stub
		return this.shippingAddressDAO.getShippingAddressIdList(shippingAddress);
	}

	@Override
	public ShippingAddress getShoppingAddressByIdList(String userId)
			throws Exception {
		// TODO Auto-generated method stub
		return this.shippingAddressDAO.getShoppingAddressByIdList(userId);
	}

}
