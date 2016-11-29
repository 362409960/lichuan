package cloud.app.commodity.model;

import java.util.Date;

import cloud.app.entity.BaseModel;

public class ArrivalNotice  extends BaseModel{
	private String id;
	private String product_name;
	private String member;
	private String phone;
	private String email;
	private Date create_time;
	private String send;
	private String isMarketable;
	private String isOutOfStock;
	private Date update_time;
	
	private String stringAsc;
	

	public String getMember() {
		return member;
	}

	public void setMember(String member) {
		this.member = member;
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

	public String getProduct_name() {
		return product_name;
	}

	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}

	

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public Date getCreate_time() {
		return create_time;
	}

	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}

	public String getSend() {
		return send;
	}

	public void setSend(String send) {
		this.send = send;
	}

	public Date getUpdate_time() {
		return update_time;
	}

	public void setUpdate_time(Date update_time) {
		this.update_time = update_time;
	}

	public String getIsMarketable() {
		return isMarketable;
	}

	public void setIsMarketable(String isMarketable) {
		this.isMarketable = isMarketable;
	}

	public String getIsOutOfStock() {
		return isOutOfStock;
	}

	public void setIsOutOfStock(String isOutOfStock) {
		this.isOutOfStock = isOutOfStock;
	}

}
