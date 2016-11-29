package cloud.shop.merchandise.dao;

import java.util.List;

import cloud.shop.merchandise.entity.MerchandiseType;





public interface MerchandiseTypeDAO {
	
	void insertMerchandiseType(MerchandiseType merchandiseType) throws Exception;

	void updateMerchandiseType(MerchandiseType merchandiseType) throws Exception;

	void deleteByPkId(String id) throws Exception;
	
	List<MerchandiseType> getMerchandiseTypeList(MerchandiseType merchandiseType) throws Exception;
	
   int merchandiseTypeCount(MerchandiseType merchandiseType) throws Exception;
   
   int merchandiseTypeMaxOrderList(MerchandiseType merchandiseType)throws Exception;
   
   int isEffectivenes(MerchandiseType merchandiseType)throws Exception;
   
   MerchandiseType selectCheckId(String id)throws Exception ;
   
   List<MerchandiseType> getTypeList() throws Exception;

}
