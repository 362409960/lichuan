package cloud.app.commodity.model;

import java.util.Date;

import cloud.app.entity.BaseModel;

//库存管理
public class InvManag  extends BaseModel{
	private String id;
	private String product_no;
	private String product_name;
	private Date create_time;
	private Date update_time;
	private String create_user;
	private String update_user;
	private String type;
	private Integer inQuantity;
	private Integer outQuantity;
	private Integer stock;
	private String remark;
	private String productId;
	private String stockId;
	
	private Integer lock_stock;//锁定库存，但是没有出库
	
	

	private String stringAsc;
	
	
	
	public String getStockId() {
		return stockId;
	}

	public void setStockId(String stockId) {
		this.stockId = stockId;
	}

	public String getProductId() {
		return productId;
	}

	public void setProductId(String productId) {
		this.productId = productId;
	}

	public Integer getLock_stock() {
		return lock_stock;
	}

	public void setLock_stock(Integer lock_stock) {
		this.lock_stock = lock_stock;
	}

	public String getStringAsc() {
		return stringAsc;
	}

	public void setStringAsc(String stringAsc) {
		this.stringAsc = stringAsc;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
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

	public String getCreate_user() {
		return create_user;
	}

	public void setCreate_user(String create_user) {
		this.create_user = create_user;
	}

	public String getUpdate_user() {
		return update_user;
	}

	public void setUpdate_user(String update_user) {
		this.update_user = update_user;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	

	public Integer getStock() {
		return stock;
	}

	public void setStock(Integer stock) {
		this.stock = stock;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public Integer getInQuantity() {
		return inQuantity;
	}

	public void setInQuantity(Integer inQuantity) {
		this.inQuantity = inQuantity;
	}

	public Integer getOutQuantity() {
		return outQuantity;
	}

	public void setOutQuantity(Integer outQuantity) {
		this.outQuantity = outQuantity;
	}

}
