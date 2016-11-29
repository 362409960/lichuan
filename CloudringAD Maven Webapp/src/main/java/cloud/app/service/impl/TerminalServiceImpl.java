/**
 * 
 */
package cloud.app.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cloud.app.dao.TerminalDAO;
import cloud.app.entity.Terminal;
import cloud.app.service.TerminalService;

/**
 * @author zhoushunfang
 * 
 */
@Service
public class TerminalServiceImpl implements TerminalService {

	@Autowired
	private TerminalDAO terminalDAO;

	@Override
	public void save(Terminal obj) throws Exception {
		terminalDAO.insertSelective(obj);
	}

	@Override
	public void update(Terminal obj) throws Exception {
		terminalDAO.updateByPrimaryKeySelective(obj);
	}

	@Override
	public void deleteById(String id) throws Exception {
		terminalDAO.deleteByPrimaryKey(id);
	}

	@Override
	public List<Terminal> getList(Terminal obj) throws Exception {
		return terminalDAO.getList(obj);
	}

	@Override
	public Integer count(Terminal obj) throws Exception {
		return terminalDAO.count(obj);
	}

	@Override
	public Terminal getObjById(String id) throws Exception {
		return terminalDAO.selectByPrimaryKey(id);
	}

	@Override
	public void deleteByIdS(Map<String, Object> map) throws Exception {
		terminalDAO.deleteByIdS(map);
	}

	@Override
	public List<Terminal> getListAndMessage(Terminal obj) throws Exception {
		return terminalDAO.getListAndMessage(obj);
	}

	@Override
	public Integer getListAndMessageCount(Terminal obj) {
		return terminalDAO.getListAndMessageCount(obj);
	}

	@Override
	public void updateByPacket(Map<String, Object> map) {
		terminalDAO.updateByPacket(map);
	}

}
