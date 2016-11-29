package cloud.app.commodity.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cloud.app.commodity.dao.InvManagDAO;
import cloud.app.commodity.model.InvManag;
import cloud.app.commodity.service.InvManagService;
@Service
public class InvManagServiceImpl implements InvManagService {

	@Autowired
	private InvManagDAO invManagDAO;

	@Override
	public void save(InvManag obj) throws Exception {
		invManagDAO.save(obj);
		
	}

	@Override
	public void update(InvManag obj) throws Exception {
		invManagDAO.update(obj);
		
	}

	@Override
	public void deleteById(String id) throws Exception {
		invManagDAO.deleteById(id);
		
	}

	@Override
	public List<InvManag> getList(InvManag obj) throws Exception {
	
		return invManagDAO.getList(obj);
	}

	@Override
	public InvManag getObjById(String id) throws Exception {		
		return invManagDAO.getObjById(id);
	}

	@Override
	public Integer count(InvManag obj) throws Exception {
	
		return invManagDAO.count(obj);
	}

	@Override
	public void deleteByIdS(String[] ids) throws Exception {
		
		for(String id:ids){
			invManagDAO.deleteById(id);
		}
	}

	@Override
	public InvManag getProductById(String id) throws Exception {		
		return invManagDAO.getProductById(id);
	}

	
	
}
