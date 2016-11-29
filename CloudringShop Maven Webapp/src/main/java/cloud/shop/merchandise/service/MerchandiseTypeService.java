package cloud.shop.merchandise.service;

import java.util.List;

import cloud.shop.merchandise.entity.MerchandiseType;



public interface MerchandiseTypeService {
	
   public	void insertMerchandiseType(MerchandiseType merchandiseType) throws Exception;

   public void updateMerchandiseType(MerchandiseType merchandiseType) throws Exception;

   public void deleteByPkId(String id) throws Exception;
	
   public List<MerchandiseType> getMerchandiseTypeList(MerchandiseType merchandiseType) throws Exception;
	
   public int merchandiseTypeCount(MerchandiseType merchandiseType) throws Exception; 
   
   public  int isEffectivenes(MerchandiseType merchandiseType)throws Exception;
   
   public MerchandiseType selectCheckId(String id)throws Exception ;
   
   public List<MerchandiseType> getTypeList() throws Exception;
}
