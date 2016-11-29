package cloud.app.commodity.dao;

import java.util.List;

import cloud.app.commodity.model.ProductCategory;
import cloud.app.dao.BaseDAO;


public interface ProductCategoryDAO extends BaseDAO<ProductCategory> {
	
	List<ProductCategory> selectPId(String id)throws Exception ; 
	
	Integer checkName(String name)throws Exception;

}
