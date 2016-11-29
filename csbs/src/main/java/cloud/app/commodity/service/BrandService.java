package cloud.app.commodity.service;

import java.util.List;

import cloud.app.service.BaseService;
import cloud.app.commodity.model.Brand;

public interface BrandService extends BaseService<Brand> {
	
	public List<Brand> getAll()throws Exception;

}
