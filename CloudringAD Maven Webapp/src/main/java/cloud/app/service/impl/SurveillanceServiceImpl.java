/**
 * 
 */
package cloud.app.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cloud.app.dao.SurveillanceDAO;
import cloud.app.entity.Surveillance;
import cloud.app.service.SurveillanceService;
import cloud.app.system.vo.TreeVO;

/**
 * @author zhoushunfang
 *
 */
@Service
public class SurveillanceServiceImpl implements SurveillanceService {

	@Autowired
	private SurveillanceDAO surveillanceDAO;
	
	
	@Override
	public void save(Surveillance obj) throws Exception {
		surveillanceDAO.insertSelective(obj);
	}

	@Override
	public void update(Surveillance obj) throws Exception {
		surveillanceDAO.updateByPrimaryKeySelective(obj);
	}

	@Override
	public void deleteById(String id) throws Exception {
		surveillanceDAO.deleteByPrimaryKey(id);
	}

	@Override
	public List<Surveillance> getList(Surveillance obj) throws Exception {
		return surveillanceDAO.getList(obj);
	}

	@Override
	public Integer count(Surveillance obj) throws Exception {
		return surveillanceDAO.count(obj);
	}

	@Override
	public Surveillance getObjById(String id) throws Exception {
		return surveillanceDAO.selectByPrimaryKey(id);
	}

	@Override
	public void deleteByIdS(Map<String, Object> map) throws Exception {
		surveillanceDAO.deleteByIdS(map);
	}

	@Override
	public List<String> getPacketList() {		
		return surveillanceDAO.getPacketList();
	}

	@Override
	public List<TreeVO> selectTree(String terminalId) throws Exception {
		return surveillanceDAO.selectTree(terminalId);
	}

}
