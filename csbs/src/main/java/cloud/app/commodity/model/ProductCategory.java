package cloud.app.commodity.model;

import java.util.Date;
import java.util.Set;

import cloud.app.entity.BaseModel;

public class ProductCategory extends BaseModel{

	
	private String id;
	private Date create_time;
	private String update_user;
	private String create_user;
	private Date update_time;
	private Integer order_value;
	private String parent_id;
	private String metaDescription;
	private String metaKeywords;
	private String category_name;
	private String brand_id;
	private String promotion;
	private String path;
	
    private String [] brandIds;//品牌数组
    private String [] promotions;//促销数组
    
    private ProductCategory parent;
    private Set<ProductCategory> chridernCategory;

    private Integer level=0;

	public Integer getLevel() {
		return level;
	}
	public void setLevel(Integer level) {
		this.level = level;
	}
	public ProductCategory getParent() {
		return parent;
	}
	public void setParent(ProductCategory parent) {
		this.parent = parent;
	}
	public Set<ProductCategory> getChridernCategory() {
		return chridernCategory;
	}
	public void setChridernCategory(Set<ProductCategory> chridernCategory) {
		this.chridernCategory = chridernCategory;
	}
	public String getPath() {
		return path;
	}
	public void setPath(String path) {
		this.path = path;
	}
	public String getPromotion() {
		return promotion;
	}
	public void setPromotion(String promotion) {
		this.promotion = promotion;
	}
	public String[] getBrandIds() {
		return brandIds;
	}
	public void setBrandIds(String[] brandIds) {
		this.brandIds = brandIds;
	}
	public String[] getPromotions() {
		return promotions;
	}
	public void setPromotions(String[] promotions) {
		this.promotions = promotions;
	}
	public String getBrand_id() {
		return brand_id;
	}
	public void setBrand_id(String brand_id) {
		this.brand_id = brand_id;
	}
	public String getCategory_name() {
		return category_name;
	}
	public void setCategory_name(String category_name) {
		this.category_name = category_name;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public Date getCreate_time() {
		return create_time;
	}
	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}
	public String getUpdate_user() {
		return update_user;
	}
	public void setUpdate_user(String update_user) {
		this.update_user = update_user;
	}
	public String getCreate_user() {
		return create_user;
	}
	public void setCreate_user(String create_user) {
		this.create_user = create_user;
	}
	public Date getUpdate_time() {
		return update_time;
	}
	public void setUpdate_time(Date update_time) {
		this.update_time = update_time;
	}
	public Integer getOrder_value() {
		return order_value;
	}
	public void setOrder_value(Integer order_value) {
		this.order_value = order_value;
	}
	public String getParent_id() {
		return parent_id;
	}
	public void setParent_id(String parent_id) {
		this.parent_id = parent_id;
	}
	public String getMetaDescription() {
		return metaDescription;
	}
	public void setMetaDescription(String metaDescription) {
		this.metaDescription = metaDescription;
	}
	public String getMetaKeywords() {
		return metaKeywords;
	}
	public void setMetaKeywords(String metaKeywords) {
		this.metaKeywords = metaKeywords;
	}
	

}
