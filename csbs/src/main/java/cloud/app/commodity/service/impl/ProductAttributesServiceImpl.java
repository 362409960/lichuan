package cloud.app.commodity.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cloud.app.commodity.dao.ProductAttributesDAO;
import cloud.app.commodity.model.ProductAttributes;
import cloud.app.commodity.service.ProductAttributesService;
@Service
public class ProductAttributesServiceImpl implements ProductAttributesService {

	@Autowired
	private ProductAttributesDAO productAttributesDAO;
	@Override
	public void save(ProductAttributes obj) throws Exception {
		productAttributesDAO.save(obj);
		
	}

	@Override
	public void update(ProductAttributes obj) throws Exception {
		productAttributesDAO.update(obj);
		
	}

	@Override
	public void deleteById(String id) throws Exception {
		productAttributesDAO.deleteById(id);
		
	}

	@Override
	public List<ProductAttributes> getList(ProductAttributes obj)
			throws Exception {
	
		return productAttributesDAO.getList(obj);
	}

	@Override
	public ProductAttributes getObjById(String id) throws Exception {		
		return productAttributesDAO.getObjById(id);
	}

	@Override
	public Integer count(ProductAttributes obj) throws Exception {		
		return productAttributesDAO.count(obj);
	}

	@Override
	public void deleteByIdS(String[] ids) throws Exception {
		for(String id:ids){
			productAttributesDAO.deleteById(id);
		}
		
	}

}
