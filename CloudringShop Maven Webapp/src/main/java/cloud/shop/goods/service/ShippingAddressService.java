package cloud.shop.goods.service;

import java.util.List;

import cloud.shop.goods.entity.ShippingAddress;

public interface ShippingAddressService {
	
	public void insertShippingAddress(ShippingAddress shippingAddress) throws Exception;

	public void updateShippingAddress(ShippingAddress shippingAddress) throws Exception;

	public void deleteById(String id) throws Exception;
	
	public List<ShippingAddress> getShippingAddressList(ShippingAddress shippingAddress) throws Exception;
	
	public List<ShippingAddress> getShippingAddressIdList(ShippingAddress shippingAddress) throws Exception;

	public ShippingAddress getShoppingAddressByIdList(String userId) throws Exception;
}
