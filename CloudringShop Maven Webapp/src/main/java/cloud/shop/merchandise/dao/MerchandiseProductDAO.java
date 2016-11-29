package cloud.shop.merchandise.dao;

import java.util.List;
import java.util.Map;

import cloud.shop.merchandise.entity.MerchandiseProduct;

public interface MerchandiseProductDAO {
	
	void insertMerchandiseProduct(MerchandiseProduct merchandiseProduct) throws Exception;

	void updateMerchandiseProduct(MerchandiseProduct merchandiseProduct) throws Exception;

	void deleteById(String id) throws Exception;
	
	List<MerchandiseProduct> getMerchandiseProductList(MerchandiseProduct merchandiseProduct) throws Exception;
	
   int merchandiseProductCount(MerchandiseProduct merchandiseProduct) throws Exception;
   
   MerchandiseProduct selectCheckId(String id)throws Exception ;
   
   List<MerchandiseProduct> getMerchandiseProductConditionList(String[] condition) throws Exception;

   List<MerchandiseProduct> getProductConditionFiveList(String[] condition) throws Exception;
   
   List<MerchandiseProduct> getPageGoodsList(Map<String,Object> params)throws Exception;
   
   int getPageGoodsCount(String[] str) throws Exception;
   
   List<MerchandiseProduct> getPageGoodNamesList(MerchandiseProduct merchandiseProduct)throws Exception;
   
   int getPageGoodsNameCount(String str) throws Exception;
   //明星产品
   List<MerchandiseProduct> getStartProdouctList()throws Exception;
   //硬件
   List<MerchandiseProduct> getHardwareProdouctList()throws Exception;
   //Recommend 推荐
   List<MerchandiseProduct> getRecommendProdouctList()throws Exception;
   
   List<MerchandiseProduct> getCategoryIds(String keyword)throws Exception;
}
