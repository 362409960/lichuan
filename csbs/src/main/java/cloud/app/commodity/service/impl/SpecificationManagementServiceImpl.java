package cloud.app.commodity.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cloud.app.commodity.dao.SpecificationManagementDAO;
import cloud.app.commodity.model.SpecificationManagement;
import cloud.app.commodity.service.SpecificationManagementService;
@Service
public class SpecificationManagementServiceImpl implements
		SpecificationManagementService {

	@Autowired
	private SpecificationManagementDAO specificationManagementDAO;
	@Override
	public void save(SpecificationManagement obj) throws Exception {
		specificationManagementDAO.save(obj);

	}

	@Override
	public void update(SpecificationManagement obj) throws Exception {
		specificationManagementDAO.update(obj);

	}

	@Override
	public void deleteById(String id) throws Exception {
		specificationManagementDAO.deleteById(id);

	}

	@Override
	public List<SpecificationManagement> getList(SpecificationManagement obj)
			throws Exception {
		
		return specificationManagementDAO.getList(obj);
	}

	@Override
	public SpecificationManagement getObjById(String id) throws Exception {
		
		return specificationManagementDAO.getObjById(id);
	}

	@Override
	public Integer count(SpecificationManagement obj) throws Exception {
		
		return specificationManagementDAO.count(obj);
	}

	@Override
	public void deleteByIdS(String[] ids) throws Exception {
		for(String id:ids){
			specificationManagementDAO.deleteById(id);
		}
		
	}

}
