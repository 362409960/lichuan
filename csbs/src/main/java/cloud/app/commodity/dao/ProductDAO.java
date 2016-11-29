package cloud.app.commodity.dao;

import java.util.List;

import cloud.app.commodity.model.Product;
import cloud.app.commodity.model.ProductVO;
import cloud.app.dao.BaseDAO;

public interface ProductDAO extends BaseDAO<Product>{
	
	List<Product> getObjByName(String name)throws Exception;
	
	   void saveVO(ProductVO productVO)throws Exception;
		
		 void updateVO(ProductVO productVO)throws Exception;

}
