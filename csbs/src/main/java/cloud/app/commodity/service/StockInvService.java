package cloud.app.commodity.service;

import cloud.app.commodity.model.InvManag;

public interface StockInvService {
	
	public void save(InvManag inv)throws Exception;
	
	public void update(InvManag inv)throws Exception;

}
