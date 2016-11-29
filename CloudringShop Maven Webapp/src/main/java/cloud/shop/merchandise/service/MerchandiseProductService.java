package cloud.shop.merchandise.service;

import java.util.List;
import java.util.Map;

import cloud.shop.merchandise.entity.MerchandiseProduct;



public interface MerchandiseProductService {
	
  public void insertMerchandiseProduct(MerchandiseProduct merchandiseProduct) throws Exception;

  public void updateMerchandiseProduct(MerchandiseProduct merchandiseProduct) throws Exception;

  public void deleteById(String id) throws Exception;
	
  public List<MerchandiseProduct> getMerchandiseProductList(MerchandiseProduct merchandiseProduct) throws Exception;
	
  public int merchandiseProductCount(MerchandiseProduct merchandiseProduct) throws Exception;
  
  public MerchandiseProduct selectCheckId(String id)throws Exception ;

  public List<MerchandiseProduct> getMerchandiseProductConditionList(String[] condition) throws Exception;
  
  public List<MerchandiseProduct> getProductConditionFiveList(String[] condition) throws Exception;
  
 public List<MerchandiseProduct> getPageGoodsList(Map<String,Object> params)throws Exception;
  
 public int getPageGoodsCount(String[] str) throws Exception;
 
 public List<MerchandiseProduct> getPageGoodNamesList(MerchandiseProduct merchandiseProduct)throws Exception;
 
 public int getPageGoodsNameCount(String str) throws Exception;
 
 public List<MerchandiseProduct> getStartProdouctList()throws Exception;
 
 public List<MerchandiseProduct> getHardwareProdouctList()throws Exception;
 
 public List<MerchandiseProduct> getRecommendProdouctList()throws Exception;
 
public List<MerchandiseProduct> getCategoryIds(String keyword)throws Exception;
}
