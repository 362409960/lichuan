package cloud.app.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cloud.app.dao.ProgramDetailsDAO;
import cloud.app.entity.ProgramDetails;
import cloud.app.service.ProgramDetailsService;
@Service
public class ProgramDetailsServiceImpl implements ProgramDetailsService {
	
	@Autowired
	private ProgramDetailsDAO programDetailsDAO;

	@Override
	public void save(ProgramDetails obj) throws Exception {
		programDetailsDAO.save(obj);

	}

	@Override
	public void update(ProgramDetails obj) throws Exception {
		programDetailsDAO.update(obj);

	}

	@Override
	public void deleteById(String id) throws Exception {
		programDetailsDAO.deleteById(id);

	}

	@Override
	public List<ProgramDetails> getList(ProgramDetails obj) throws Exception {
		
		return programDetailsDAO.getList(obj);
	}

	@Override
	public Integer count(ProgramDetails obj) throws Exception {
		
		return programDetailsDAO.count(obj);
	}

	@Override
	public ProgramDetails getObjById(String id) throws Exception {
		
		return programDetailsDAO.getObjById(id);
	}

	@Override
	public void deleteByIdS(Map<String, Object> map) throws Exception {
		programDetailsDAO.deleteByIdS(map);

	}

}
