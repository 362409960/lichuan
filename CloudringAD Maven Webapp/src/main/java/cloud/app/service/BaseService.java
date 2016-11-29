package cloud.app.service;

import java.util.List;
import java.util.Map;

public interface BaseService<T> {
	
	public  void save(T obj)throws Exception;
		
	public	void update(T obj)throws Exception;
		
	public	void deleteById(String id)throws Exception;
		
	public	List<T> getList(T obj)throws Exception; 
	
	public Integer count(T obj)throws Exception; 
		
	public	T getObjById(String id)throws Exception;
	
	public void deleteByIdS(Map<String,Object> map)throws Exception;

}
