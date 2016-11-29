package cloud.shop.goods.service;

import java.util.List;

import cloud.shop.goods.entity.ShippingCart;

public interface ShippingCartService {
	public void insertShippingCart(ShippingCart shippingCart) throws Exception;

	public void updateShippingCart(ShippingCart shippingCart) throws Exception;

	public void deleteById(String id) throws Exception;
	
	public List<ShippingCart> getShippingCartList(ShippingCart shippingCart) throws Exception;
	
	public int ShippingCartCount(ShippingCart shippingCart) throws Exception; 
   
	public ShippingCart selectCheckId(String id)throws Exception ;
   
	public List<ShippingCart> geteShippingCartIp(String ip) throws Exception;
	
	public List<ShippingCart> getCartByUserNameList(String ip) throws Exception;
	
	public List<ShippingCart> geteShippingCartByUserIdList(String userId) throws Exception;

}
