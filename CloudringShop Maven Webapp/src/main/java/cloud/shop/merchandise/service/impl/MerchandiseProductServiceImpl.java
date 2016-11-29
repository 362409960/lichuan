package cloud.shop.merchandise.service.impl;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cloud.shop.merchandise.dao.MerchandiseProductDAO;
import cloud.shop.merchandise.entity.MerchandiseProduct;
import cloud.shop.merchandise.service.MerchandiseProductService;


@Service
public class MerchandiseProductServiceImpl implements MerchandiseProductService {
	@Autowired
	private MerchandiseProductDAO merchandiseProductDAO;

	public MerchandiseProductDAO getMerchandiseProductDAO() {
		return merchandiseProductDAO;
	}

	public void setMerchandiseProductDAO(MerchandiseProductDAO merchandiseProductDAO) {
		this.merchandiseProductDAO = merchandiseProductDAO;
	}

	@Override
	public void insertMerchandiseProduct(MerchandiseProduct merchandiseProduct)
			throws Exception {
		merchandiseProduct.setCreate_time(new Date());
		merchandiseProduct.setUpdate_time(new Date());
		this.merchandiseProductDAO.insertMerchandiseProduct(merchandiseProduct);

	}

	@Override
	public void updateMerchandiseProduct(MerchandiseProduct merchandiseProduct)
			throws Exception {
		merchandiseProduct.setUpdate_time(new Date());
		this.merchandiseProductDAO.updateMerchandiseProduct(merchandiseProduct);

	}

	@Override
	public void deleteById(String id) throws Exception {
		this.merchandiseProductDAO.deleteById(id);

	}

	@Override
	public List<MerchandiseProduct> getMerchandiseProductList(
			MerchandiseProduct merchandiseProduct) throws Exception {		
		return this.merchandiseProductDAO.getMerchandiseProductList(merchandiseProduct);
	}

	@Override
	public int merchandiseProductCount(MerchandiseProduct merchandiseProduct)
			throws Exception {
		
		return this.merchandiseProductDAO.merchandiseProductCount(merchandiseProduct);
	}

	@Override
	public MerchandiseProduct selectCheckId(String id) throws Exception {
		// TODO Auto-generated method stub
		return this.merchandiseProductDAO.selectCheckId(id);
	}

	@Override
	public List<MerchandiseProduct> getMerchandiseProductConditionList(
			String[] condition) throws Exception {
		// TODO Auto-generated method stub
		return this.merchandiseProductDAO.getMerchandiseProductConditionList(condition);
	}

	@Override
	public List<MerchandiseProduct> getProductConditionFiveList(
			String[] condition) throws Exception {
		// TODO Auto-generated method stub
		return this.merchandiseProductDAO.getProductConditionFiveList(condition);
	}

	@Override
	public List<MerchandiseProduct> getPageGoodsList(
			Map<String,Object> params) throws Exception {
		// TODO Auto-generated method stub
		return this.merchandiseProductDAO.getPageGoodsList(params);
	}

	@Override
	public int getPageGoodsCount(String[] str) throws Exception {
		// TODO Auto-generated method stub
		return this.merchandiseProductDAO.getPageGoodsCount(str);
	}

	@Override
	public List<MerchandiseProduct> getPageGoodNamesList(
			MerchandiseProduct merchandiseProduct) throws Exception {
		// TODO Auto-generated method stub
		return this.merchandiseProductDAO.getPageGoodNamesList(merchandiseProduct);
	}

	@Override
	public int getPageGoodsNameCount(String str) throws Exception {
		// TODO Auto-generated method stub
		return this.merchandiseProductDAO.getPageGoodsNameCount(str);
	}

	@Override
	public List<MerchandiseProduct> getStartProdouctList() throws Exception {
		
		return merchandiseProductDAO.getStartProdouctList();
	}

	@Override
	public List<MerchandiseProduct> getHardwareProdouctList() throws Exception {
		
		return merchandiseProductDAO.getHardwareProdouctList();
	}

	@Override
	public List<MerchandiseProduct> getRecommendProdouctList() throws Exception {
	
		return merchandiseProductDAO.getRecommendProdouctList();
	}

	@Override
	public List<MerchandiseProduct> getCategoryIds(String keyword)
			throws Exception {
		return this.merchandiseProductDAO.getCategoryIds(keyword);
	}

}
