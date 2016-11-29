package cloud.shop.merchandise.entity;

import java.util.Date;

import cloud.shop.entity.BaseModel;

public class MerchandiseType extends BaseModel {
	private String id;
	private String name;
	private Date create_time;
	private Date update_time;
	private String productTypeSN;
	private String isSignDisplay;
	private int orderList;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
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

	public String getProductTypeSN() {
		return productTypeSN;
	}

	public void setProductTypeSN(String productTypeSN) {
		this.productTypeSN = productTypeSN;
	}

	public String getIsSignDisplay() {
		return isSignDisplay;
	}

	public void setIsSignDisplay(String isSignDisplay) {
		this.isSignDisplay = isSignDisplay;
	}

	public int getOrderList() {
		return orderList;
	}

	public void setOrderList(int orderList) {
		this.orderList = orderList;
	}

}
