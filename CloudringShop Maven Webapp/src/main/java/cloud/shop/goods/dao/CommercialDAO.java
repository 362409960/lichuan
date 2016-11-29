package cloud.shop.goods.dao;

import java.util.List;

import cloud.shop.goods.entity.Commercial;


public interface CommercialDAO {
	
	void insertCommercial(Commercial commercial) throws Exception;

	void updateCommercial(Commercial commercial) throws Exception;

	void deleteById(String id) throws Exception;
	
	List<Commercial> getCommercialList(Commercial commercial) throws Exception;
	
   int CommercialCount(Commercial commercial) throws Exception; 
   
   Commercial selectCheckId(String id)throws Exception ;
   
   List<Commercial> geteCommercialList() throws Exception;

}
