package cloud.app.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cloud.app.dao.NewsStreamDAO;
import cloud.app.entity.NewsStream;
import cloud.app.service.NewsStreamService;

@Service
public class NewsStreamServiceImpl implements NewsStreamService {

	@Autowired
	private NewsStreamDAO newsStreamDAO;

	@Override
	public void save(NewsStream obj) throws Exception {
		newsStreamDAO.insertSelective(obj);
	}

	@Override
	public void update(NewsStream obj) throws Exception {
		newsStreamDAO.updateByPrimaryKeySelective(obj);
	}

	@Override
	public void deleteById(String id) throws Exception {
		newsStreamDAO.deleteByPrimaryKey(id);
	}

	@Override
	public List<NewsStream> getList(NewsStream obj) throws Exception {
		return newsStreamDAO.getList(obj);
	}

	@Override
	public Integer count(NewsStream obj) throws Exception {
		return newsStreamDAO.count(obj);
	}

	@Override
	public NewsStream getObjById(String id) throws Exception {
		return newsStreamDAO.selectByPrimaryKey(id);
	}

	@Override
	public void deleteByIdS(Map<String, Object> map) throws Exception {
		newsStreamDAO.deleteByIdS(map);
	}

}
