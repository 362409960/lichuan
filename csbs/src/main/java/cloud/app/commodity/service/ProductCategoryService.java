package cloud.app.commodity.service;

import java.util.List;

import cloud.app.commodity.model.ProductCategory;
import cloud.app.service.BaseService;

public interface ProductCategoryService  extends BaseService<ProductCategory>{
	public List<ProductCategory> selectPId(String id)throws Exception ; 
	
	public Integer checkName(String name)throws Exception;

}
