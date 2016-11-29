package cloud.app.commodity.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cloud.app.commodity.dao.BrandDAO;
import cloud.app.commodity.model.Brand;
import cloud.app.commodity.service.BrandService;

@Service
public class BrandServiceImpl implements BrandService {
	@Autowired
	private BrandDAO brandDAO;

	@Override
	public void save(Brand obj) throws Exception {
	brandDAO.save(obj);
		
	}

	@Override
	public void update(Brand obj) throws Exception {
		brandDAO.update(obj);
		
	}

	@Override
	public void deleteById(String id) throws Exception {
		brandDAO.deleteById(id);
		
	}

	@Override
	public List<Brand> getList(Brand obj) throws Exception {	
		return brandDAO.getList(obj);
	}

	@Override
	public Brand getObjById(String id) throws Exception {		
		return brandDAO.getObjById(id);
	}

	@Override
	public Integer count(Brand obj) throws Exception {
	
		return brandDAO.count(obj);
	}

	@Override
	public void deleteByIdS(String[] ids) throws Exception {
		for(String id:ids){
			brandDAO.deleteById(id);
		}
	}

	@Override
	public List<Brand> getAll() throws Exception {
		
		return brandDAO.getAll();
	}

	

	

}
