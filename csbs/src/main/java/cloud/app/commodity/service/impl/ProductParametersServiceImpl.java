package cloud.app.commodity.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cloud.app.commodity.dao.ProductParametersDAO;
import cloud.app.commodity.model.ProductParameters;
import cloud.app.commodity.service.ProductParametersService;
@Service
public class ProductParametersServiceImpl implements ProductParametersService {

	@Autowired
	private ProductParametersDAO productParametersDAO;
	@Override
	public void save(ProductParameters obj) throws Exception {
		productParametersDAO.save(obj);

	}

	@Override
	public void update(ProductParameters obj) throws Exception {
		productParametersDAO.update(obj);

	}

	@Override
	public void deleteById(String id) throws Exception {
		productParametersDAO.deleteById(id);

	}

	@Override
	public List<ProductParameters> getList(ProductParameters obj)
			throws Exception {
		
		return productParametersDAO.getList(obj);
	}

	@Override
	public ProductParameters getObjById(String id) throws Exception {
	
		return productParametersDAO.getObjById(id);
	}

	@Override
	public Integer count(ProductParameters obj) throws Exception {
		
		return productParametersDAO.count(obj);
	}

	@Override
	public void deleteByIdS(String[] ids) throws Exception {
		for(String id:ids){
			productParametersDAO.deleteById(id);
		}
		
	}

}
