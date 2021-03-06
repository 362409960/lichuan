package cloud.app.commodity.model;

import java.math.BigDecimal;


import org.springframework.web.multipart.MultipartFile;

public class ProductVO {
	
   private String id;
	public String getId() {
	return id;
}
public void setId(String id) {
	this.id = id;
}
	private String update_user;
	private String create_user;
	

	private String product_no;//货号
	private String product_name;//商品名称
	private String chtitle;//副标题
	private String productcategory_id;//商品分类
	private String brand_id;//品牌
	private String productType_id;//类型
	private BigDecimal sale_price;//销售价
	private BigDecimal cost;//成本价;
	private BigDecimal price;//市场价;
	private Integer points_swarded;//赠送积分
	private Integer redeem_point;//兑换积分
	private Integer stock;//
	
	private Integer isBest;//精品
	private Integer isHost;//热销
	private Integer isNew;//最新
	private Integer isLogistics;//是否需要物流
	private Integer isMarketable;//是否需要上架
	
	private String picture;//图片
	
	private String description;//介绍
	private String metaDescription;//页面描述:
	private String metaKeywords;//页面关键词
	private String remark;//备注
	private String searchKeyword;//搜索关键词
	private String pageTitle;//页面标题
	
	
	private MultipartFile file;
	
	private ProductPicture [] productImages;

	//
	private String attr_name;
	private String group_name;
	private String parameter_group_id;
	private String attributeId;
	
	
	
	
	
	public BigDecimal getSale_price() {
		return sale_price;
	}
	public void setSale_price(BigDecimal sale_price) {
		this.sale_price = sale_price;
	}
	public BigDecimal getCost() {
		return cost;
	}
	public void setCost(BigDecimal cost) {
		this.cost = cost;
	}
	public BigDecimal getPrice() {
		return price;
	}
	public void setPrice(BigDecimal price) {
		this.price = price;
	}
	public Integer getPoints_swarded() {
		return points_swarded;
	}
	public void setPoints_swarded(Integer points_swarded) {
		this.points_swarded = points_swarded;
	}
	public Integer getStock() {
		return stock;
	}
	public void setStock(Integer stock) {
		this.stock = stock;
	}
	public String getAttr_name() {
		return attr_name;
	}
	public void setAttr_name(String attr_name) {
		this.attr_name = attr_name;
	}
	public String getGroup_name() {
		return group_name;
	}
	public void setGroup_name(String group_name) {
		this.group_name = group_name;
	}
	public String getParameter_group_id() {
		return parameter_group_id;
	}
	public void setParameter_group_id(String parameter_group_id) {
		this.parameter_group_id = parameter_group_id;
	}
	public String getAttributeId() {
		return attributeId;
	}
	public void setAttributeId(String attributeId) {
		this.attributeId = attributeId;
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
	
	public String getProduct_no() {
		return product_no;
	}
	public void setProduct_no(String product_no) {
		this.product_no = product_no;
	}
	public String getProduct_name() {
		return product_name;
	}
	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}
	public String getChtitle() {
		return chtitle;
	}
	public void setChtitle(String chtitle) {
		this.chtitle = chtitle;
	}
	public String getProductcategory_id() {
		return productcategory_id;
	}
	public void setProductcategory_id(String productcategory_id) {
		this.productcategory_id = productcategory_id;
	}
	public String getBrand_id() {
		return brand_id;
	}
	public void setBrand_id(String brand_id) {
		this.brand_id = brand_id;
	}
	public String getProductType_id() {
		return productType_id;
	}
	public void setProductType_id(String productType_id) {
		this.productType_id = productType_id;
	}
	
	public Integer getRedeem_point() {
		return redeem_point;
	}
	public void setRedeem_point(Integer redeem_point) {
		this.redeem_point = redeem_point;
	}
	
	public Integer getIsBest() {
		return isBest;
	}
	public void setIsBest(Integer isBest) {
		this.isBest = isBest;
	}
	public Integer getIsHost() {
		return isHost;
	}
	public void setIsHost(Integer isHost) {
		this.isHost = isHost;
	}
	public Integer getIsNew() {
		return isNew;
	}
	public void setIsNew(Integer isNew) {
		this.isNew = isNew;
	}
	public Integer getIsLogistics() {
		return isLogistics;
	}
	public void setIsLogistics(Integer isLogistics) {
		this.isLogistics = isLogistics;
	}
	public Integer getIsMarketable() {
		return isMarketable;
	}
	public void setIsMarketable(Integer isMarketable) {
		this.isMarketable = isMarketable;
	}
	public String getPicture() {
		return picture;
	}
	public void setPicture(String picture) {
		this.picture = picture;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
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
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public String getSearchKeyword() {
		return searchKeyword;
	}
	public void setSearchKeyword(String searchKeyword) {
		this.searchKeyword = searchKeyword;
	}
	public String getPageTitle() {
		return pageTitle;
	}
	public void setPageTitle(String pageTitle) {
		this.pageTitle = pageTitle;
	}
	public MultipartFile getFile() {
		return file;
	}
	public void setFile(MultipartFile file) {
		this.file = file;
	}
	public ProductPicture[] getProductImages() {
		return productImages;
	}
	public void setProductImages(ProductPicture[] productImages) {
		this.productImages = productImages;
	}
	
	

}
