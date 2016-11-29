package cloud.app.commodity.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cloud.app.commodity.dao.ProductPictureDAO;
import cloud.app.commodity.model.ProductPicture;
import cloud.app.commodity.service.ProductPictureService;
@Service
public class ProductPictureServiceImpl implements ProductPictureService {

	@Autowired
	private ProductPictureDAO productPictureDAO;
	@Override
	public void save(ProductPicture obj) throws Exception {
	productPictureDAO.save(obj);

	}

	@Override
	public void update(ProductPicture obj) throws Exception {
		productPictureDAO.update(obj);

	}

	@Override
	public void deleteById(String id) throws Exception {
		productPictureDAO.deleteById(id);

	}

	@Override
	public List<ProductPicture> getList(ProductPicture obj) throws Exception {
		
		return productPictureDAO.getList(obj);
	}

	@Override
	public ProductPicture getObjById(String id) throws Exception {
		
		return productPictureDAO.getObjById(id);
	}

	@Override
	public Integer count(ProductPicture obj) throws Exception {
		
		return productPictureDAO.count(obj);
	}

	@Override
	public void deleteByIdS(String[] ids) throws Exception {
		for(String id:ids){
			productPictureDAO.deleteById(id);
		}
		
	}

	@Override
	public List<ProductPicture> getListObjByFatherId(String id)
			throws Exception {	
		return productPictureDAO.getListObjByFatherId(id);
	}

}
