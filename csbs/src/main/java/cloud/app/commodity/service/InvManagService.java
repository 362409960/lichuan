package cloud.app.commodity.service;


import cloud.app.service.BaseService;
import cloud.app.commodity.model.InvManag;

public interface InvManagService  extends BaseService<InvManag> {
	
	public InvManag getProductById(String id)throws Exception;


}
