package cloud.app.commodity.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cloud.app.commodity.dao.ParametersGroupDAO;
import cloud.app.commodity.model.ParametersGroup;
import cloud.app.commodity.service.ParametersGroupService;
@Service
public class ParametersGroupServiceImpl implements ParametersGroupService {

	@Autowired
	private ParametersGroupDAO parametersGroupDAO;
	@Override
	public void save(ParametersGroup obj) throws Exception {
		parametersGroupDAO.save(obj);

	}

	@Override
	public void update(ParametersGroup obj) throws Exception {
		parametersGroupDAO.update(obj);

	}

	@Override
	public void deleteById(String id) throws Exception {
		parametersGroupDAO.deleteById(id);

	}

	@Override
	public List<ParametersGroup> getList(ParametersGroup obj) throws Exception {
		
		return parametersGroupDAO.getList(obj);
	}

	@Override
	public Integer count(ParametersGroup obj) throws Exception {
		
		return parametersGroupDAO.count(obj);
	}

	@Override
	public ParametersGroup getObjById(String id) throws Exception {
		// TODO Auto-generated method stub
		return parametersGroupDAO.getObjById(id);
	}

	@Override
	public void deleteByIdS(String[] ids) throws Exception {
	for(String id:ids){
		parametersGroupDAO.deleteById(id);
	}

	}

}
