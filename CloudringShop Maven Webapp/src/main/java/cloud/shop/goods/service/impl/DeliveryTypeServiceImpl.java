package cloud.shop.goods.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cloud.shop.goods.dao.DeliveryTypeDAO;
import cloud.shop.goods.entity.DeliveryType;
import cloud.shop.goods.service.DeliveryTypeService;

@Service
public class DeliveryTypeServiceImpl implements DeliveryTypeService {

	@Autowired
	private DeliveryTypeDAO deliveryTypeDAO;
	@Override
	public void save(DeliveryType deliveryType) throws Exception {
		this.deliveryTypeDAO.save(deliveryType);

	}

	@Override
	public void deleteById(String id) throws Exception {
		this.deliveryTypeDAO.deleteById(id);

	}

	@Override
	public void update(DeliveryType deliveryType) throws Exception {
		this.deliveryTypeDAO.update(deliveryType);

	}

	@Override
	public List<DeliveryType> getDeliveryTypeList(DeliveryType deliveryType)
			throws Exception {
		// TODO Auto-generated method stub
		return this.deliveryTypeDAO.getDeliveryTypeList(deliveryType);
	}

}
