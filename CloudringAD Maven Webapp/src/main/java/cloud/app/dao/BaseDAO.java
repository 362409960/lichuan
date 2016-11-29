package cloud.app.dao;

import java.util.List;
import java.util.Map;

public interface BaseDAO<T> {
	//增加
    void save(T obj)throws Exception;
	//修改
	void update(T obj)throws Exception;
	//按id删除
	void deleteById(String id)throws Exception;
	//多个id删除
	void deleteByIdS(Map<String,Object> map)throws Exception;
	//按对象查询
	List<T> getList(T obj)throws Exception; 
	
	Integer count(T obj)throws Exception; 
	
	//按对象查询
	List<T> getListMap(Map<String, Object> map)throws Exception; 
		
	Integer countMap(Map<String, Object> map)throws Exception; 
	//按条件查询对象
	T getObjById(String id)throws Exception;
	


}
