package cloud.app.commodity.service;

import cloud.app.commodity.model.ProductVO;

public interface ProductConditionService {
	
	public void save(ProductVO productVO)throws Exception;
	
	public void update(ProductVO productVO)throws Exception;
	
	public	void deleteByIdS(String [] ids)throws Exception;

}
