package cloud.app.commodity.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cloud.app.commodity.dao.AttrProductDAO;
import cloud.app.commodity.model.AttrProduct;
import cloud.app.commodity.service.AttrProductService;
@Service
public class AttrProductServiceImpl implements AttrProductService {

	@Autowired
	private AttrProductDAO attrProductDAO;
	@Override
	public void save(AttrProduct obj) throws Exception {
		attrProductDAO.save(obj);
	}

	@Override
	public void update(AttrProduct obj) throws Exception {
		attrProductDAO.update(obj);

	}

	@Override
	public void deleteById(String id) throws Exception {
		attrProductDAO.deleteById(id);

	}

	@Override
	public List<AttrProduct> getList(AttrProduct obj) throws Exception {
		
		return attrProductDAO.getList(obj);
	}

	@Override
	public Integer count(AttrProduct obj) throws Exception {
	
		return attrProductDAO.count(obj);
	}

	@Override
	public AttrProduct getObjById(String id) throws Exception {		
		return attrProductDAO.getObjById(id);
	}

	@Override
	public void deleteByIdS(String[] ids) throws Exception {
		for(String id:ids){
			attrProductDAO.deleteById(id);
		}
		

	}

}
