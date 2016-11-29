package cloud.app.service;

import java.util.List;
import java.util.Map;

import cloud.app.entity.MaterialType;

public interface MaterialTypeService {
	
	public	List<MaterialType> getTypeList(MaterialType obj)throws Exception;
	
	public	List<MaterialType> getTypeTreeList(MaterialType obj)throws Exception;
	
	public void save(MaterialType obj)throws Exception;
	
	public void update(MaterialType obj)throws Exception;
	//多个id删除
	void deleteByIds(Map<String,Object> map)throws Exception;
}
