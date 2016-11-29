package cloud.app.commodity.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cloud.app.commodity.dao.OutlineDAO;
import cloud.app.commodity.model.Outline;
import cloud.app.commodity.service.OutlineService;
@Service
public class OutlineServiceIml implements OutlineService {

	@Autowired
	private OutlineDAO outlineDAO;
	@Override
	public void save(Outline obj) throws Exception {
		outlineDAO.save(obj);

	}

	@Override
	public void update(Outline obj) throws Exception {
	outlineDAO.update(obj);

	}

	@Override
	public void deleteById(String id) throws Exception {
		outlineDAO.deleteById(id);

	}

	@Override
	public List<Outline> getList(Outline obj) throws Exception {	
		return outlineDAO.getList(obj);
	}

	@Override
	public Outline getObjById(String id) throws Exception {	
		return outlineDAO.getObjById(id);
	}

	@Override
	public Integer count(Outline obj) throws Exception {
	
		return outlineDAO.count(obj);
	}

	@Override
	public void deleteByIdS(String[] ids) throws Exception {
		for(String id:ids){
			outlineDAO.deleteById(id);
		}
		
	}

}
