package cloud.app.commodity.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cloud.app.commodity.dao.ProductCategoryDAO;
import cloud.app.commodity.model.ProductCategory;
import cloud.app.commodity.service.ProductCategoryService;
@Service
public class ProductCategoryServiceImpl  implements ProductCategoryService{
	private String PATH_SET=",";
	@Autowired
	private ProductCategoryDAO productCategoryDAO;
	@Override
	public void save(ProductCategory obj) throws Exception {
		productCategoryDAO.save(obj);
		
	}

	@Override
	public void update(ProductCategory obj) throws Exception {
		productCategoryDAO.update(obj);
		
	}

	@Override
	public void deleteById(String id) throws Exception {
	productCategoryDAO.deleteById(id);
		
	}

	@Override
	public List<ProductCategory> getList(ProductCategory obj) throws Exception {
		List<ProductCategory> allProductCategoryList = productCategoryDAO.getList(obj);
		return recursivProductCategoryTreeList(allProductCategoryList, null, null);
	}
	
	
	// 递归父类排序分类树
	private List<ProductCategory> recursivProductCategoryTreeList(List<ProductCategory> allProductCategoryList, ProductCategory p, List<ProductCategory> temp) {
		if (temp == null) {
			temp = new ArrayList<ProductCategory>();
		}
		for (ProductCategory productCategory : allProductCategoryList) {
			ProductCategory parent = productCategory.getParent();
			if ((p == null && parent == null) || (productCategory != null && parent == p)) {
				productCategory.setLevel(productCategory.getPath().split(PATH_SET).length-1);
				temp.add(productCategory);
				if (productCategory.getChridernCategory() != null && productCategory.getChridernCategory().size() > 0) {
					recursivProductCategoryTreeList(allProductCategoryList, productCategory, temp);
				}
			}
		}
		return temp;
	}

	@Override
	public ProductCategory getObjById(String id) throws Exception {
		
		return productCategoryDAO.getObjById(id);
	}

	@Override
	public Integer count(ProductCategory obj) throws Exception {
	
		return productCategoryDAO.count(obj);
	}

	@Override
	public void deleteByIdS(String[] ids) throws Exception {
		for(String id:ids){
			productCategoryDAO.deleteById(id);
		}
		
	}

	@Override
	public List<ProductCategory> selectPId(String id) throws Exception {		
		return productCategoryDAO.selectPId(id);
	}

	@Override
	public Integer checkName(String name) throws Exception {
		
		return productCategoryDAO.checkName(name);
	}

}
