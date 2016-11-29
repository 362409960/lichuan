package cloud.app.commodity.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cloud.app.commodity.dao.StockDAO;
import cloud.app.commodity.model.Stock;
import cloud.app.commodity.service.StockService;
@Service
public class StockServiceImpl implements StockService {
	@Autowired
	private StockDAO stockDAO;

	@Override
	public void save(Stock obj) throws Exception {
		stockDAO.save(obj);

	}

	@Override
	public void update(Stock obj) throws Exception {
		stockDAO.update(obj);

	}

	@Override
	public void deleteById(String id) throws Exception {
		stockDAO.deleteById(id);

	}

	@Override
	public List<Stock> getList(Stock obj) throws Exception {
	
		return stockDAO.getList(obj);
	}

	@Override
	public Integer count(Stock obj) throws Exception {
		
		return stockDAO.count(obj);
	}

	@Override
	public Stock getObjById(String id) throws Exception {
		
		return stockDAO.getObjById(id);
	}

	@Override
	public void deleteByIdS(String[] ids) throws Exception {
		for(String id:ids){
			stockDAO.deleteById(id);
		}

	}

}
