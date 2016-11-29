/**
 * 
 */
package cloud.app.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cloud.app.dao.DataGatheringDAO;
import cloud.app.entity.DataGathering;
import cloud.app.service.DataGatheringService;

/**
 * @author zhoushunfang
 *
 */
@Service
public class DataGatheringServiceImpl implements DataGatheringService {

	@Autowired
	private DataGatheringDAO dataGatheringDAO;
	
	@Override
	public void save(DataGathering obj) throws Exception {
		// TODO Auto-generated method stub

	}

	@Override
	public void update(DataGathering obj) throws Exception {
		// TODO Auto-generated method stub

	}

	@Override
	public void deleteById(String id) throws Exception {
		// TODO Auto-generated method stub

	}

	@Override
	public List<DataGathering> getList(DataGathering obj) throws Exception {
		return dataGatheringDAO.getList(obj);
	}

	@Override
	public Integer count(DataGathering obj) throws Exception {
		return dataGatheringDAO.count(obj);
	}

	@Override
	public DataGathering getObjById(String id) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void deleteByIdS(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub

	}

}
