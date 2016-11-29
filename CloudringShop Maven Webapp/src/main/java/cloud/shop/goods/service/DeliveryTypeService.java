package cloud.shop.goods.service;

import java.util.List;

import cloud.shop.goods.entity.DeliveryType;

public interface DeliveryTypeService {
	
	public void save(DeliveryType deliveryType) throws Exception;
	
	public void deleteById(String id) throws Exception;

	public void update(DeliveryType deliveryType) throws Exception;
	
	public List<DeliveryType> getDeliveryTypeList(DeliveryType deliveryType) throws Exception;

}
