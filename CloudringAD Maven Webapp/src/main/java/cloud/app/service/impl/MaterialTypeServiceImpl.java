package cloud.app.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cloud.app.dao.MaterialTypeDAO;
import cloud.app.entity.MaterialType;
import cloud.app.service.MaterialTypeService;
@Service
public class MaterialTypeServiceImpl implements MaterialTypeService {
	@Autowired
	private MaterialTypeDAO materialTypeDAO;

	@Override
	public List<MaterialType> getTypeList(MaterialType obj) throws Exception {
		// TODO Auto-generated method stub
		return materialTypeDAO.getTypeList(obj);
	}

	@Override
	public List<MaterialType> getTypeTreeList(MaterialType obj)
			throws Exception {
		// TODO Auto-generated method stub
		return materialTypeDAO.getTypeTreeList(obj);
	}
	
	@Override
	public void save(MaterialType obj) throws Exception {
		// TODO Auto-generated method stub
		materialTypeDAO.save(obj);
	}

	@Override
	public void update(MaterialType obj) throws Exception {
		// TODO Auto-generated method stub
		materialTypeDAO.update(obj);
	}

	@Override
	public void deleteByIds(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		materialTypeDAO.deleteByIds(map);
	}

}
