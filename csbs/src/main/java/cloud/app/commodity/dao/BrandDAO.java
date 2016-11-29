package cloud.app.commodity.dao;




import java.util.List;

import cloud.app.dao.BaseDAO;
import cloud.app.commodity.model.Brand;

public interface BrandDAO extends BaseDAO<Brand> {
	
	List<Brand> getAll()throws Exception;
	

}
