package cloud.shop.merchandise.dao;

import java.util.List;

import cloud.shop.merchandise.entity.MerchandiseCategories;


public interface MerchandiseCategoriesDAO {
	
	void insert(MerchandiseCategories merchandiseCategories) throws Exception;

	void update(MerchandiseCategories merchandiseCategories) throws Exception;

	void deleteByPkId(String id) throws Exception;
	
	List<MerchandiseCategories> getMerchandiseCategorieList(MerchandiseCategories merchandiseCategories) throws Exception;
	
   int merchandiseCategorieCount(MerchandiseCategories merchandiseCategories) throws Exception;
   
   List<MerchandiseCategories> merchandiseCategorieList(MerchandiseCategories merchandiseCategories)throws Exception;
   
    int merchandiseCategorieMaxOrderList(MerchandiseCategories merchandiseCategories)throws Exception;
   
   int isEffectivenes(MerchandiseCategories merchandiseCategories)throws Exception;
   
   MerchandiseCategories selectCheckId(String id)throws Exception ;   
   
   List<MerchandiseCategories> getCategorieList( ) throws Exception;
   //自定义条件查询,到时可以修改
   List<MerchandiseCategories> getCategorieConditionList( ) throws Exception;
   //
   List<MerchandiseCategories> selectPId(String id)throws Exception ; 
   
   List<MerchandiseCategories> selectThreePId(String id)throws Exception ; 
   
   List<MerchandiseCategories> getThreeCategorList( ) throws Exception;
   
   List<MerchandiseCategories> getSelectIdForIN(String[] condition) throws Exception;
   
   List<MerchandiseCategories> getGoodsIdFindCAIN(String[] condition) throws Exception;
}
