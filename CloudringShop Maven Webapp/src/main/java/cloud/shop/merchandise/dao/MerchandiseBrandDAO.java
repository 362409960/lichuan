package cloud.shop.merchandise.dao;

import java.util.List;

import cloud.shop.merchandise.entity.MerchandiseBrand;







public interface MerchandiseBrandDAO {
	
	void insertMerchandiseBrand(MerchandiseBrand merchandiseBrand) throws Exception;

	void updateMerchandiseBrand(MerchandiseBrand merchandiseBrand) throws Exception;

	void deleteById(String id) throws Exception;
	
	List<MerchandiseBrand> getMerchandiseBrandList(MerchandiseBrand merchandiseBrand) throws Exception;
	
   int merchandiseBrandCount(MerchandiseBrand merchandiseBrand) throws Exception;
   
   int isEffectivenes(MerchandiseBrand merchandiseBrand)throws Exception;
   
   MerchandiseBrand selectCheckId(String id)throws Exception ;
   
   List<MerchandiseBrand> geteBrandList() throws Exception;

}
