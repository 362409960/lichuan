package cloud.app.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cloud.app.dao.TemplateBackGroundDAO;
import cloud.app.entity.TemplateBackGround;
import cloud.app.service.TemplateBackGroundService;
@Service
public class TemplateBackGroundServiceImpl implements TemplateBackGroundService {

	@Autowired
	private TemplateBackGroundDAO templateBackGroundDAO;
	
	@Override
	public void save(TemplateBackGround obj) throws Exception {
		templateBackGroundDAO.save(obj);

	}

	@Override
	public void update(TemplateBackGround obj) throws Exception {
		templateBackGroundDAO.update(obj);

	}

	@Override
	public void deleteById(String id) throws Exception {
		templateBackGroundDAO.deleteById(id);

	}

	@Override
	public List<TemplateBackGround> getList(TemplateBackGround obj)
			throws Exception {
		// TODO Auto-generated method stub
		return templateBackGroundDAO.getList(obj);
	}

	@Override
	public Integer count(TemplateBackGround obj) throws Exception {
		// TODO Auto-generated method stub
		return templateBackGroundDAO.count(obj);
	}

	@Override
	public TemplateBackGround getObjById(String id) throws Exception {
		// TODO Auto-generated method stub
		return templateBackGroundDAO.getObjById(id);
	}

	@Override
	public void deleteByIdS(Map<String, Object> map) throws Exception {
		templateBackGroundDAO.deleteByIdS(map);

	}

}
