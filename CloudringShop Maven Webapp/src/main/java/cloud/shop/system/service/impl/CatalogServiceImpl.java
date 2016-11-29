package cloud.shop.system.service.impl;



import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cloud.shop.system.dao.CatalogDAO;
import cloud.shop.system.po.Catalog;
import cloud.shop.system.service.CatalogService;



@Service
public class CatalogServiceImpl implements CatalogService {

	@Autowired
	private CatalogDAO catalogDAO;
 
	public List<Catalog> selectCheck(String catalogName) throws Exception {
		return catalogDAO.selectCheck(catalogName);
	}
 
	public List<Catalog> selectCheckId(String pkId) throws Exception {
		return catalogDAO.selectCheckId(pkId);
	}

	@Override
	public List<Catalog> getCatalogList(Catalog catalog) throws Exception {
		// TODO Auto-generated method stub
		return catalogDAO.getCatalogList(catalog);
	}

	@Override
	public int catalogCount(Catalog catalog) throws Exception {
		// TODO Auto-generated method stub
		return catalogDAO.catalogCount(catalog);
	}

	@Override
	public void insertCatalog(Catalog catalog) throws Exception {
		// TODO Auto-generated method stub
		catalogDAO.insertCatalog(catalog);
	}

	@Override
	public void updateCatalog(Catalog catalog) throws Exception {
		// TODO Auto-generated method stub
		catalogDAO.updateCatalog(catalog);
	}

	@Override
	public void deleteCatalog(String pkId) throws Exception {
		// TODO Auto-generated method stub
		catalogDAO.deleteCatalog(pkId);
	}

}
