package cloud.app.service;

import java.util.List;
import java.util.Map;

import cloud.app.entity.Material;

public interface MaterialService extends BaseService<Material> {
	public	List<Material> getListByUrl(Map<String,Object> map)throws Exception;
}
