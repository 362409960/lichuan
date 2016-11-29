package cloud.shop.merchandise.service;


import java.util.List;

import cloud.shop.merchandise.entity.MerchandiseCategories;

public interface MerchandiseCategoriesService {
	public void insert(MerchandiseCategories merchandiseCategories)
			throws Exception;

	public void update(MerchandiseCategories merchandiseCategories)
			throws Exception;

	public void deleteByPkId(String id) throws Exception;
	
	public List<MerchandiseCategories> getMerchandiseCategorieList(MerchandiseCategories merchandiseCategories) throws Exception;
	
	public int merchandiseCategorieCount(MerchandiseCategories merchandiseCategories) throws Exception;
	
	public int isEffectivenes(MerchandiseCategories merchandiseCategories)throws Exception;
	
	public  MerchandiseCategories selectCheckId(String id)throws Exception ;
	
	public List<MerchandiseCategories> getCategorieList() throws Exception;
	
	public List<MerchandiseCategories> getCategorieConditionList( ) throws Exception;
	
	public List<MerchandiseCategories> selectPId(String id)throws Exception ; 
	
	public  List<MerchandiseCategories> selectThreePId(String id)throws Exception ; 
	
	public List<MerchandiseCategories> getThreeCategorList( ) throws Exception;

	public List<MerchandiseCategories> getSelectIdForIN(String[] condition) throws Exception;
	
	public List<MerchandiseCategories> getGoodsIdFindCAIN(String[] condition) throws Exception;
}
