package cloud.app.commodity.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cloud.app.commodity.dao.ProductDAO;
import cloud.app.commodity.model.Product;
import cloud.app.commodity.model.ProductVO;
import cloud.app.commodity.service.ProductService;
@Service
public class ProductServiceImpl implements ProductService {

	@Autowired
	private ProductDAO productDAO;
	@Override
	public void save(Product obj) throws Exception {
		productDAO.save(obj);

	}

	@Override
	public void update(Product obj) throws Exception {
		productDAO.update(obj);

	}

	@Override
	public void deleteById(String id) throws Exception {
		productDAO.deleteById(id);

	}

	@Override
	public List<Product> getList(Product obj) throws Exception {
		
		return productDAO.getList(obj);
	}

	@Override
	public Product getObjById(String id) throws Exception {
	
		return productDAO.getObjById(id);
	}

	@Override
	public Integer count(Product obj) throws Exception {
	
		return productDAO.count(obj);
	}

	@Override
	public void deleteByIdS(String[] ids) throws Exception {
		for(String id:ids){
			productDAO.deleteById(id);
		}
		
	}

	@Override
	public List<Product> getObjByName(String name) throws Exception {		
		return productDAO.getObjByName(name);
	}

	@Override
	public void saveVO(ProductVO productVO) throws Exception {
		
		productDAO.saveVO(productVO);
	}

	@Override
	public void updateVO(ProductVO productVO) throws Exception {
		
		productDAO.updateVO(productVO);
	}

	

}
