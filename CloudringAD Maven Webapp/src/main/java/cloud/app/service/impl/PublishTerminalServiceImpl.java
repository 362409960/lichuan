package cloud.app.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cloud.app.dao.PublishTerminalDAO;
import cloud.app.entity.PublishTerminal;
import cloud.app.service.PublishTerminalService;
@Service
public class PublishTerminalServiceImpl implements PublishTerminalService {
	@Autowired
	private PublishTerminalDAO publishTerminalDAO;

	@Override
	public void save(PublishTerminal obj) throws Exception {
		// TODO Auto-generated method stub
		publishTerminalDAO.save(obj);

	}

	@Override
	public void update(PublishTerminal obj) throws Exception {
	publishTerminalDAO.update(obj);

	}

	@Override
	public void deleteById(String id) throws Exception {
		 publishTerminalDAO.deleteById(id);

	}

	@Override
	public List<PublishTerminal> getList(PublishTerminal obj) throws Exception {
		// TODO Auto-generated method stub
		return publishTerminalDAO.getList(obj);
	}

	@Override
	public Integer count(PublishTerminal obj) throws Exception {
		// TODO Auto-generated method stub
		return publishTerminalDAO.count(obj);
	}

	@Override
	public PublishTerminal getObjById(String id) throws Exception {
		// TODO Auto-generated method stub
		return publishTerminalDAO.getObjById(id);
	}

	@Override
	public void deleteByIdS(Map<String, Object> map) throws Exception {
		publishTerminalDAO.deleteByIdS(map);

	}

	@Override
	public void updateBatch(Map<String, Object> map) throws Exception {
		publishTerminalDAO.updateBatch(map);
		
	}

	@Override
	public PublishTerminal getByTerminalId(PublishTerminal publishTerminal)
			throws Exception {
		
		return publishTerminalDAO.getByTerminalId(publishTerminal);
	}

}
