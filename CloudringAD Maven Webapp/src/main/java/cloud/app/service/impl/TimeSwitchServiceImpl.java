/**
 * 
 */
package cloud.app.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cloud.app.dao.TimeSwitchDAO;
import cloud.app.entity.TimeSwitch;
import cloud.app.service.TimeSwitchService;

/**
 * @author zhoushunfang
 * 
 */
@Service
public class TimeSwitchServiceImpl implements TimeSwitchService {
	
	@Autowired
	private TimeSwitchDAO timeSwitchDAO;
	
	@Override
	public void save(TimeSwitch obj) throws Exception {
		timeSwitchDAO.insertSelective(obj);
	}

	@Override
	public void update(TimeSwitch obj) throws Exception {
		timeSwitchDAO.updateByPrimaryKeySelective(obj);
	}

	@Override
	public void deleteById(String id) throws Exception {
		timeSwitchDAO.deleteByPrimaryKey(id);
	}

	@Override
	public List<TimeSwitch> getList(TimeSwitch obj) throws Exception {
		return timeSwitchDAO.getList(obj);
	}

	@Override
	public Integer count(TimeSwitch obj) throws Exception {
		return null;
	}

	@Override
	public TimeSwitch getObjById(String id) throws Exception {
		return null;
	}

	@Override
	public void deleteByIdS(Map<String, Object> map) throws Exception {
		timeSwitchDAO.deleteByIdS(map);
	}

}
