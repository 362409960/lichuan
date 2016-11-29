package cloud.shop.system.dao;



import java.util.List;

import cloud.shop.system.po.Catalog;




public interface CatalogDAO {

	List<Catalog> selectCheckId(String pkId)throws Exception ;

	List<Catalog> selectCheck(String catalogName)throws Exception ;

	public abstract List<Catalog> getCatalogList(Catalog catalog) throws Exception;
	
	public abstract int catalogCount(Catalog catalog) throws Exception;
	
	public abstract void insertCatalog(Catalog catalog) throws Exception;

	public abstract void updateCatalog(Catalog catalog) throws Exception;

	public abstract void deleteCatalog(String pkId) throws Exception;
}
