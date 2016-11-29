package cloud.app.commodity.service;

import java.util.List;

import cloud.app.commodity.model.Product;
import cloud.app.commodity.model.ProductVO;
import cloud.app.service.BaseService;

public interface ProductService extends BaseService<Product>{
	
	public List<Product> getObjByName(String name)throws Exception;
	
    public void saveVO(ProductVO productVO)throws Exception;
	
	public void updateVO(ProductVO productVO)throws Exception;

}
