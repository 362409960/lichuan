package cloud.shop.goods.dao;

import java.util.List;

import cloud.shop.goods.entity.DeliveryType;


public interface DeliveryTypeDAO {
	
     void save(DeliveryType deliveryType) throws Exception;
	
	void deleteById(String id) throws Exception;

	void update(DeliveryType deliveryType) throws Exception;
	
	List<DeliveryType> getDeliveryTypeList(DeliveryType deliveryType) throws Exception;

}
