package cloud.app.commodity.service;

import java.util.List;


import cloud.app.commodity.model.ProductPicture;
import cloud.app.service.BaseService;

public interface ProductPictureService  extends BaseService<ProductPicture>{
	
	public List<ProductPicture> getListObjByFatherId(String id)throws Exception;

}
