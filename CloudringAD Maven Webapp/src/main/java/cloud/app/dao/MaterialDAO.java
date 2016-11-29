package cloud.app.dao;

import java.util.List;
import java.util.Map;



import cloud.app.entity.Material;

public interface MaterialDAO extends BaseDAO<Material> {
	
	List<Material> getListByUrl(Map<String,Object> map)throws Exception;
	
	
}
