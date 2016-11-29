package cloud.shop.merchandise.entity;

import java.math.BigDecimal;
import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

import cloud.shop.entity.BaseModel;

public class MerchandiseProduct extends BaseModel {
   private String id;
   private Date create_time;
   private Date update_time;
   private String description;
   private Integer isBest;
   private Integer isHost;
   private Integer isNew;
   private Integer isMarketable;
   private BigDecimal marketPrice ;
   private BigDecimal price;
   
   private String productImageListStore;//商品图片路径存储
   private String productEntiretyImageListStore;//商品整体图片路径存储
   private String productDetailImageListStore;//商品细节图片路径存储
   private String productAssemblyImageListStore;//商品配件图片路径存储
   //对应的springmvc file上传文件
   private MultipartFile productImageListStoreFile;
   private MultipartFile productEntiretyImageListStoreFile;
   private MultipartFile productDetailImageListStoreFile;
   private MultipartFile productAssemblyImageListStoreFile;
   
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
public Date getUpdate_time() {
	return update_time;
}
public void setUpdate_time(Date update_time) {
	this.update_time = update_time;
}
public String getDescription() {
	return description;
}
public void setDescription(String description) {
	this.description = description;
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
public Integer getIsMarketable() {
	return isMarketable;
}
public void setIsMarketable(Integer isMarketable) {
	this.isMarketable = isMarketable;
}
public BigDecimal getMarketPrice() {
	return marketPrice;
}
public void setMarketPrice(BigDecimal marketPrice) {
	this.marketPrice = marketPrice;
}
public BigDecimal getPrice() {
	return price;
}
public void setPrice(BigDecimal price) {
	this.price = price;
}
public String getProductImageListStore() {
	return productImageListStore;
}
public void setProductImageListStore(String productImageListStore) {
	this.productImageListStore = productImageListStore;
}
public String getProductEntiretyImageListStore() {
	return productEntiretyImageListStore;
}
public void setProductEntiretyImageListStore(
		String productEntiretyImageListStore) {
	this.productEntiretyImageListStore = productEntiretyImageListStore;
}
public String getProductDetailImageListStore() {
	return productDetailImageListStore;
}
public void setProductDetailImageListStore(String productDetailImageListStore) {
	this.productDetailImageListStore = productDetailImageListStore;
}
public String getProductAssemblyImageListStore() {
	return productAssemblyImageListStore;
}
public void setProductAssemblyImageListStore(
		String productAssemblyImageListStore) {
	this.productAssemblyImageListStore = productAssemblyImageListStore;
}
public MultipartFile getProductImageListStoreFile() {
	return productImageListStoreFile;
}
public void setProductImageListStoreFile(MultipartFile productImageListStoreFile) {
	this.productImageListStoreFile = productImageListStoreFile;
}
public MultipartFile getProductEntiretyImageListStoreFile() {
	return productEntiretyImageListStoreFile;
}
public void setProductEntiretyImageListStoreFile(
		MultipartFile productEntiretyImageListStoreFile) {
	this.productEntiretyImageListStoreFile = productEntiretyImageListStoreFile;
}
public MultipartFile getProductDetailImageListStoreFile() {
	return productDetailImageListStoreFile;
}
public void setProductDetailImageListStoreFile(
		MultipartFile productDetailImageListStoreFile) {
	this.productDetailImageListStoreFile = productDetailImageListStoreFile;
}
public MultipartFile getProductAssemblyImageListStoreFile() {
	return productAssemblyImageListStoreFile;
}
public void setProductAssemblyImageListStoreFile(
		MultipartFile productAssemblyImageListStoreFile) {
	this.productAssemblyImageListStoreFile = productAssemblyImageListStoreFile;
}
public String getMetaDescription() {
	return metaDescription;
}
public void setMetaDescription(String metaDescription) {
	this.metaDescription = metaDescription;
}
public String getTitle() {
	return title;
}
public void setTitle(String title) {
	this.title = title;
}
public String getChtitle() {
	return chtitle;
}
public void setChtitle(String chtitle) {
	this.chtitle = chtitle;
}
public String getName() {
	return name;
}
public void setName(String name) {
	this.name = name;
}
public String getProductSn() {
	return productSn;
}
public void setProductSn(String productSn) {
	this.productSn = productSn;
}
public String getBrand_id() {
	return brand_id;
}
public void setBrand_id(String brand_id) {
	this.brand_id = brand_id;
}
public String getProductcategory_id() {
	return productcategory_id;
}
public void setProductcategory_id(String productcategory_id) {
	this.productcategory_id = productcategory_id;
}
public String getProductType_id() {
	return productType_id;
}
public void setProductType_id(String productType_id) {
	this.productType_id = productType_id;
}
   private String metaDescription;
   private String metaKeywords;
   public String getMetaKeywords() {
	return metaKeywords;
}
public void setMetaKeywords(String metaKeywords) {
	this.metaKeywords = metaKeywords;
}
   private String title;
   private String chtitle;
   private String name;
   private String productSn;
   private String brand_id;
   private String productcategory_id;
   private String productType_id;
   
   private Integer maxPage;
   
   private String product_parameters;


public String getProduct_parameters() {
	return product_parameters;
}
public void setProduct_parameters(String product_parameters) {
	this.product_parameters = product_parameters;
}
public Integer getMaxPage() {
	return maxPage;
}
public void setMaxPage(Integer maxPage) {
	this.maxPage = maxPage;
}
}
