package cloud.shop.goods.dao;

import java.util.List;


import cloud.shop.goods.entity.ShippingCart;

public interface ShippingCartDAO {
	
	void insertShippingCart(ShippingCart shippingCart) throws Exception;

	void updateShippingCart(ShippingCart shippingCart) throws Exception;

	void deleteById(String id) throws Exception;
	
	List<ShippingCart> getShippingCartList(ShippingCart shippingCart) throws Exception;
	
   int ShippingCartCount(ShippingCart shippingCart) throws Exception; 
   
   ShippingCart selectCheckId(String id)throws Exception ;
   
   List<ShippingCart> geteShippingCartIp(String ip) throws Exception;
   
   List<ShippingCart> getCartByUserNameList(String ip) throws Exception;
   
   List<ShippingCart> geteShippingCartByUserIdList(String userId) throws Exception;
   
   
   

}
