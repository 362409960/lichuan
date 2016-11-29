package cloud.app.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cloud.app.dao.TemplateDAO;
import cloud.app.entity.Template;
import cloud.app.service.TemplateService;
@Service
public class TemplateServiceImpl implements TemplateService {
	@Autowired
	private TemplateDAO templateDAO;

	@Override
	public void save(Template obj) throws Exception {
		templateDAO.save(obj);

	}

	@Override
	public void update(Template obj) throws Exception {
		templateDAO.update(obj);
	}

	@Override
	public void deleteById(String id) throws Exception {
		templateDAO.deleteById(id);

	}

	@Override
	public List<Template> getList(Template obj) throws Exception {
		
		return templateDAO.getList(obj);
	}

	@Override
	public Integer count(Template obj) throws Exception {
		
		return templateDAO.count(obj);
	}

	@Override
	public Template getObjById(String id) throws Exception {		
		return templateDAO.getObjById(id);
	}

	@Override
	public void deleteByIdS(Map<String, Object> map) throws Exception {
		templateDAO.deleteByIdS(map);

	}

}
