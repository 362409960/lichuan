package cloud.shop.goods.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cloud.shop.goods.dao.CommercialDAO;
import cloud.shop.goods.entity.Commercial;
import cloud.shop.goods.service.CommercialService;
@Service
public class CommercialServiceImpl implements CommercialService {

	@Autowired
	private CommercialDAO commercialDAO;
	public CommercialDAO getCommercialDAO() {
		return commercialDAO;
	}

	public void setCommercialDAO(CommercialDAO commercialDAO) {
		this.commercialDAO = commercialDAO;
	}

	@Override
	public void insertCommercial(Commercial commercial) throws Exception {
		this.commercialDAO.insertCommercial(commercial);
		
	}

	@Override
	public void updateCommercial(Commercial commercial) throws Exception {
		this.commercialDAO.updateCommercial(commercial);
		
	}

	@Override
	public void deleteById(String id) throws Exception {
		this.commercialDAO.deleteById(id);
		
	}

	@Override
	public List<Commercial> getCommercialList(Commercial commercial)
			throws Exception {	
		return this.commercialDAO.getCommercialList(commercial);
	}

	@Override
	public int CommercialCount(Commercial commercial) throws Exception {
		
		return this.commercialDAO.CommercialCount(commercial);
	}

	@Override
	public Commercial selectCheckId(String id) throws Exception {
		// TODO Auto-generated method stub
		return this.commercialDAO.selectCheckId(id);
	}

	@Override
	public List<Commercial> geteCommercialList() throws Exception {
		// TODO Auto-generated method stub
		return this.commercialDAO.geteCommercialList();
	}

}
