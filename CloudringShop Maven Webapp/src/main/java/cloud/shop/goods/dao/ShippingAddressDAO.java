package cloud.shop.goods.dao;

import java.util.List;

import cloud.shop.goods.entity.ShippingAddress;



public interface ShippingAddressDAO {
	
	void insertShippingAddress(ShippingAddress shippingAddress) throws Exception;

	void updateShippingAddress(ShippingAddress shippingAddress) throws Exception;

	void deleteById(String id) throws Exception;
	
	List<ShippingAddress> getShippingAddressList(ShippingAddress shippingAddress) throws Exception;
	
	List<ShippingAddress> getShippingAddressIdList(ShippingAddress shippingAddress) throws Exception;
	
	ShippingAddress getShoppingAddressByIdList(String userId) throws Exception;
   

}
