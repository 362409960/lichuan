package cloud.shop.merchandise.service;

import java.util.List;

import cloud.shop.merchandise.entity.MerchandiseBrand;





public interface MerchandiseBrandService {
	
   public	void insertMerchandiseBrand(MerchandiseBrand merchandiseBrand) throws Exception;

   public void updateMerchandiseBrand(MerchandiseBrand merchandiseBrand) throws Exception;

   public void deleteById(String id) throws Exception;
	
   public List<MerchandiseBrand> getMerchandiseBrandList(MerchandiseBrand merchandiseBrand) throws Exception;
	
   public  int merchandiseBrandCount(MerchandiseBrand merchandiseBrand) throws Exception;
   
   public int isEffectivenes(MerchandiseBrand merchandiseBrand)throws Exception;
   
   public MerchandiseBrand selectCheckId(String id)throws Exception ;
   
   public List<MerchandiseBrand> geteBrandList() throws Exception;

}
