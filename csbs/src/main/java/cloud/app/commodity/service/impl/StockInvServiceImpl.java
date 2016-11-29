package cloud.app.commodity.service.impl;

import java.util.Date;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cloud.app.commodity.dao.InvManagDAO;
import cloud.app.commodity.dao.StockDAO;
import cloud.app.commodity.model.InvManag;
import cloud.app.commodity.model.Stock;
import cloud.app.commodity.service.StockInvService;
@Service
public class StockInvServiceImpl implements StockInvService {
	
	@Autowired
	private StockDAO stockDAO;
	
	@Autowired
	private InvManagDAO invManagDAO;

	@Override
	public void save(InvManag inv) throws Exception {
		Stock stock=new Stock();
		String id=UUID.randomUUID().toString().replace("-", "");
		stock.setId(id);
		stock.setCreate_time(new Date());
		stock.setUpdate_time(new Date());
		stock.setCreate_user(inv.getCreate_user());
		stock.setUpdate_user(inv.getUpdate_user());
		stock.setStock(inv.getStock());
		stock.setLock_stock(inv.getLock_stock());
		stock.setProductId(inv.getProductId());
		inv.setStockId(id);		
	     stockDAO.save(stock);
	     invManagDAO.save(inv);

	}

	@Override
	public void update(InvManag inv) throws Exception {
		Stock stock=stockDAO.getObjById(inv.getProductId());
		stock.setStock(inv.getStock());
		stock.setUpdate_user(inv.getUpdate_user());
		stockDAO.update(stock);	
		inv.setProductId(stock.getId());
		inv.setStockId(stock.getId());
		invManagDAO.save(inv);

	}

}
