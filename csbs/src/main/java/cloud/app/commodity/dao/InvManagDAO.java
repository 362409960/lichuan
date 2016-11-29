package cloud.app.commodity.dao;


import cloud.app.dao.BaseDAO;
import cloud.app.commodity.model.InvManag;

public interface InvManagDAO extends BaseDAO<InvManag> {
	
	InvManag getProductById(String id)throws Exception;

}
