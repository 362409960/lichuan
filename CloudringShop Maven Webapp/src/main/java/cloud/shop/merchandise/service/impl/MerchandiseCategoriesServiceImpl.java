package cloud.shop.merchandise.service.impl;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cloud.shop.merchandise.dao.MerchandiseCategoriesDAO;
import cloud.shop.merchandise.entity.MerchandiseCategories;
import cloud.shop.merchandise.service.MerchandiseCategoriesService;

@Service
public class MerchandiseCategoriesServiceImpl implements
		MerchandiseCategoriesService {
	@Autowired
	private MerchandiseCategoriesDAO merchandiseCategoriesDAO;

	@Override
	public void insert(MerchandiseCategories merchandiseCategories)
			throws Exception {
		merchandiseCategories.setCreate_time(new Date());
		merchandiseCategories.setUpdate_time(new Date());
		List<MerchandiseCategories> list=this.merchandiseCategoriesDAO.merchandiseCategorieList(merchandiseCategories);		
		MerchandiseCategories me=list.get(0);		
		if(null== me.getId())
		{
			int order=this.merchandiseCategoriesDAO.merchandiseCategorieMaxOrderList(merchandiseCategories);
			merchandiseCategories.setOrderList(order+1);
		}
		else
		{
		   merchandiseCategories.setOrderList(me.getOrderList());
		}
		this.merchandiseCategoriesDAO.insert(merchandiseCategories);
	}

	@Override
	public void update(MerchandiseCategories merchandiseCategories)
			throws Exception {
		merchandiseCategories.setUpdate_time(new Date());
		this.merchandiseCategoriesDAO.update(merchandiseCategories);
	}

	@Override
	public void deleteByPkId(String id) throws Exception {
		this.merchandiseCategoriesDAO.deleteByPkId(id);
	}

	@Override
	public List<MerchandiseCategories> getMerchandiseCategorieList(
			MerchandiseCategories merchandiseCategories) throws Exception {

		return this.merchandiseCategoriesDAO
				.getMerchandiseCategorieList(merchandiseCategories);
	}

	@Override
	public int merchandiseCategorieCount(
			MerchandiseCategories merchandiseCategories) throws Exception {

		return this.merchandiseCategoriesDAO
				.merchandiseCategorieCount(merchandiseCategories);
	}

	@Override
	public int isEffectivenes(MerchandiseCategories merchandiseCategories)
			throws Exception {
		
		return this.merchandiseCategoriesDAO.isEffectivenes(merchandiseCategories);
	}

	@Override
	public MerchandiseCategories selectCheckId(String id) throws Exception {		
		return this.merchandiseCategoriesDAO.selectCheckId(id);
	}

	@Override
	public List<MerchandiseCategories> getCategorieList(
			) throws Exception {
		// TODO Auto-generated method stub
		return this.merchandiseCategoriesDAO.getCategorieList();
	}

	@Override
	public List<MerchandiseCategories> getCategorieConditionList()
			throws Exception {
		
		return this.merchandiseCategoriesDAO.getCategorieConditionList();
	}

	@Override
	public List<MerchandiseCategories> selectPId(String id) throws Exception {
		// TODO Auto-generated method stub
		return this.merchandiseCategoriesDAO.selectPId(id);
	}

	@Override
	public List<MerchandiseCategories> selectThreePId(String id)
			throws Exception {
		// TODO Auto-generated method stub
		return this.merchandiseCategoriesDAO.selectThreePId(id);
	}

	@Override
	public List<MerchandiseCategories> getThreeCategorList() throws Exception {
		// TODO Auto-generated method stub
		return this.merchandiseCategoriesDAO.getThreeCategorList();
	}

	@Override
	public List<MerchandiseCategories> getSelectIdForIN(String[] condition)
			throws Exception {
		// TODO Auto-generated method stub
		return this.merchandiseCategoriesDAO.getSelectIdForIN(condition);
	}

	@Override
	public List<MerchandiseCategories> getGoodsIdFindCAIN(String[] condition)
			throws Exception {
		// TODO Auto-generated method stub
		return this.merchandiseCategoriesDAO.getGoodsIdFindCAIN(condition);
	}

	

}
