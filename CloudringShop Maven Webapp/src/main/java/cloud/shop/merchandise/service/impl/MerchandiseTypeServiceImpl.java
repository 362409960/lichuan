package cloud.shop.merchandise.service.impl;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cloud.shop.merchandise.dao.MerchandiseTypeDAO;
import cloud.shop.merchandise.entity.MerchandiseType;
import cloud.shop.merchandise.service.MerchandiseTypeService;



@Service
public class MerchandiseTypeServiceImpl implements MerchandiseTypeService {

	@Autowired
	private MerchandiseTypeDAO merchandiseTypeDAO;
	
	
	public MerchandiseTypeDAO getMerchandiseTypeDAO() {
		return merchandiseTypeDAO;
	}

	public void setMerchandiseTypeDAO(MerchandiseTypeDAO merchandiseTypeDAO) {
		this.merchandiseTypeDAO = merchandiseTypeDAO;
	}
	
	@Override
	public void insertMerchandiseType(MerchandiseType merchandiseType)
			throws Exception {
		merchandiseType.setCreate_time(new Date());
		merchandiseType.setUpdate_time(new Date());
		Integer orderList=this.merchandiseTypeDAO.merchandiseTypeMaxOrderList(merchandiseType);
		if(0==orderList)
		{
			merchandiseType.setOrderList(1);
		}
		else
		{
			merchandiseType.setOrderList(orderList+1);
		}
		this.merchandiseTypeDAO.insertMerchandiseType(merchandiseType);
	}



	@Override
	public void updateMerchandiseType(MerchandiseType merchandiseType)
			throws Exception {
		merchandiseType.setUpdate_time(new Date());
		merchandiseTypeDAO.updateMerchandiseType(merchandiseType);
		
	}

	@Override
	public void deleteByPkId(String id) throws Exception {
		merchandiseTypeDAO.deleteByPkId(id);
		
	}

	@Override
	public List<MerchandiseType> getMerchandiseTypeList(
			MerchandiseType merchandiseType) throws Exception {
		
		return merchandiseTypeDAO.getMerchandiseTypeList(merchandiseType);
	}
	@Override
	public int merchandiseTypeCount(MerchandiseType merchandiseType)
			throws Exception {
		
		return merchandiseTypeDAO.merchandiseTypeCount(merchandiseType);
	}
	@Override
	public int isEffectivenes(MerchandiseType merchandiseType) throws Exception {
		
		return merchandiseTypeDAO.isEffectivenes(merchandiseType);
	}
	@Override
	public MerchandiseType selectCheckId(String id) throws Exception {
		
		return merchandiseTypeDAO.selectCheckId(id);
	}

	@Override
	public List<MerchandiseType> getTypeList()
			throws Exception {
		// TODO Auto-generated method stub
		return this.merchandiseTypeDAO.getTypeList();
	}

}
