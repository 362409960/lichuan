package cloud.shop.goods.service;

import java.util.List;

import cloud.shop.goods.entity.Pay;

public interface PayService {
	
	public void save(Pay pay) throws Exception;
	
	public void deleteById(String id) throws Exception;

	public void update(Pay pay) throws Exception;
	
	public List<Pay> getPayList(Pay pay) throws Exception;

}
