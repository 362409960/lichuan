package cloud.app.system.service;

import java.util.List;

import cloud.app.system.po.Catalog;

public interface CatalogService {
	
	public abstract List<Catalog> selectCheck(String catalogName) throws Exception;

	public abstract List<Catalog> selectCheckId(String pkId) throws Exception;
	
	public abstract List<Catalog> getCatalogList(Catalog catalog) throws Exception;
	
	public abstract int catalogCount(Catalog catalog) throws Exception;
	
	public abstract void insertCatalog(Catalog catalog) throws Exception;

	public abstract void updateCatalog(Catalog catalog) throws Exception;

	public abstract void deleteCatalog(String pkId) throws Exception;
}
