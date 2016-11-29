package cloud.shop.goods.dao;

import java.util.List;

import cloud.shop.goods.entity.Pay;


public interface PayDAO {
	
     void save(Pay pay) throws Exception;
	
	void deleteById(String id) throws Exception;

	void update(Pay pay) throws Exception;
	
	List<Pay> getPayList(Pay pay) throws Exception;

}
