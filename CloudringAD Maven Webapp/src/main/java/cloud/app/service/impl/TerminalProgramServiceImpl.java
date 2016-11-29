/**
 * 
 */
package cloud.app.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cloud.app.dao.AdPlayerDAO;
import cloud.app.entity.AdPlayer;
import cloud.app.service.TerminalProgramService;

/**
 * @author zhoushunfang
 *
 */
@Service
public class TerminalProgramServiceImpl implements TerminalProgramService {

	@Autowired
	private AdPlayerDAO adPlayerDAO;
	
	@Override
	public void save(AdPlayer obj) throws Exception {
		// TODO Auto-generated method stub

	}

	@Override
	public void update(AdPlayer obj) throws Exception {
		// TODO Auto-generated method stub

	}

	@Override
	public void deleteById(String id) throws Exception {
		// TODO Auto-generated method stub

	}

	@Override
	public List<AdPlayer> getList(AdPlayer obj) throws Exception {
		return adPlayerDAO.getList(obj);
	}

	@Override
	public Integer count(AdPlayer obj) throws Exception {
		return adPlayerDAO.count(obj);
	}

	@Override
	public AdPlayer getObjById(String id) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void deleteByIdS(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub

	}

}
