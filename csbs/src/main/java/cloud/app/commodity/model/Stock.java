package cloud.app.commodity.model;

import java.util.Date;

import cloud.app.entity.BaseModel;

public class Stock extends BaseModel{
	private String id;
	private Date create_time;
	private Date update_time;
	private String create_user;
	private String update_user;
	private Integer stock;
	private Integer lock_stock;//锁定库存，但是没有出库
	private String productId;
	
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
	public Integer getStock() {
		return stock;
	}
	public void setStock(Integer stock) {
		this.stock = stock;
	}
	public Integer getLock_stock() {
		return lock_stock;
	}
	public void setLock_stock(Integer lock_stock) {
		this.lock_stock = lock_stock;
	}
	public String getProductId() {
		return productId;
	}
	public void setProductId(String productId) {
		this.productId = productId;
	}
	

}
