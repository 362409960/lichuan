package cloud.shop.goods.service;

import java.util.List;

import cloud.shop.goods.entity.Commercial;

public interface CommercialService {
	
	public void insertCommercial(Commercial commercial) throws Exception;

	public void updateCommercial(Commercial commercial) throws Exception;

	public void deleteById(String id) throws Exception;
	
	public List<Commercial> getCommercialList(Commercial commercial) throws Exception;
	
	public int CommercialCount(Commercial commercial) throws Exception; 
   
	public Commercial selectCheckId(String id)throws Exception ;
   
	public List<Commercial> geteCommercialList() throws Exception;

}
