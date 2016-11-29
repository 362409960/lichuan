package cloud.app.dao;

import java.util.List;

public interface BaseDAO<T> {
	
     void save(T obj)throws Exception;
	
	void update(T obj)throws Exception;
	
	void deleteById(String id)throws Exception;
	
	List<T> getList(T obj)throws Exception; 
	
	Integer count(T obj)throws Exception; 
	
	T getObjById(String id)throws Exception;
	//有父类的才需要，其他不用。
	List<T> getListObjByFatherId(String id)throws Exception;


}
