package cloud.shop.merchandise.service.impl;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cloud.shop.merchandise.dao.MerchandiseBrandDAO;
import cloud.shop.merchandise.entity.MerchandiseBrand;
import cloud.shop.merchandise.service.MerchandiseBrandService;




@Service
public class MerchandiseBrandServiceImpl implements MerchandiseBrandService {

	@Autowired
	private MerchandiseBrandDAO merchandiseBrandDAO;
	
	@Override
	public void insertMerchandiseBrand(MerchandiseBrand merchandiseBrand)
			throws Exception {
		merchandiseBrand.setCreate_time(new Date());
		merchandiseBrand.setUpdate_time(new Date());
		this.merchandiseBrandDAO.insertMerchandiseBrand(merchandiseBrand);

	}

	@Override
	public void updateMerchandiseBrand(MerchandiseBrand merchandiseBrand)
			throws Exception {
		merchandiseBrand.setUpdate_time(new Date());
		this.merchandiseBrandDAO.updateMerchandiseBrand(merchandiseBrand);

	}

	@Override
	public void deleteById(String id) throws Exception {
		this.merchandiseBrandDAO.deleteById(id);
	}

	@Override
	public List<MerchandiseBrand> getMerchandiseBrandList(
			MerchandiseBrand merchandiseBrand) throws Exception {
		
		return this.merchandiseBrandDAO.getMerchandiseBrandList(merchandiseBrand);
	}

	@Override
	public int merchandiseBrandCount(MerchandiseBrand merchandiseBrand)
			throws Exception {
		// TODO Auto-generated method stub
		return this.merchandiseBrandDAO.merchandiseBrandCount(merchandiseBrand);
	}

	@Override
	public int isEffectivenes(MerchandiseBrand merchandiseBrand)
			throws Exception {
		
		return this.merchandiseBrandDAO.isEffectivenes(merchandiseBrand);
	}

	@Override
	public MerchandiseBrand selectCheckId(String id) throws Exception {		
		return this.merchandiseBrandDAO.selectCheckId(id);
	}

	@Override
	public List<MerchandiseBrand> geteBrandList(
			) throws Exception {
		// TODO Auto-generated method stub
		return this.merchandiseBrandDAO.geteBrandList();
	}

}
