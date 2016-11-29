package cloud.shop.goods.entity;

import java.math.BigDecimal;
import java.util.Date;

import cloud.shop.entity.BaseModel;

//订单
public class Orders extends BaseModel {
	private String id;
	private Date create_time;
	private Date update_time;
	private String status;
	private String pay_by;//支付方式
	private String delivery_method;//配送方式
	private BigDecimal price;
	private BigDecimal shipment;
	private BigDecimal order_amount;
	private BigDecimal amounts_payable;
	private Integer integration;//积分
	private String receiver;
	private String tel;
	private String zip_code;
	private String address;
	private String oid;
	private String account_id;
	private String memo;
	private String receiver_id;

	public String getReceiver_id() {
		return receiver_id;
	}

	public void setReceiver_id(String receiver_id) {
		this.receiver_id = receiver_id;
	}

	public String getMemo() {
		return memo;
	}

	public void setMemo(String memo) {
		this.memo = memo;
	}

	public String getOid() {
		return oid;
	}

	public void setOid(String oid) {
		this.oid = oid;
	}

	public String getAccount_id() {
		return account_id;
	}

	public void setAccount_id(String account_id) {
		this.account_id = account_id;
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

	public Date getUpdate_time() {
		return update_time;
	}

	public void setUpdate_time(Date update_time) {
		this.update_time = update_time;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getPay_by() {
		return pay_by;
	}

	public void setPay_by(String pay_by) {
		this.pay_by = pay_by;
	}

	public String getDelivery_method() {
		return delivery_method;
	}

	public void setDelivery_method(String delivery_method) {
		this.delivery_method = delivery_method;
	}

	public BigDecimal getPrice() {
		return price;
	}

	public void setPrice(BigDecimal price) {
		this.price = price;
	}

	public BigDecimal getShipment() {
		return shipment;
	}

	public void setShipment(BigDecimal shipment) {
		this.shipment = shipment;
	}

	public BigDecimal getOrder_amount() {
		return order_amount;
	}

	public void setOrder_amount(BigDecimal order_amount) {
		this.order_amount = order_amount;
	}

	public BigDecimal getAmounts_payable() {
		return amounts_payable;
	}

	public void setAmounts_payable(BigDecimal amounts_payable) {
		this.amounts_payable = amounts_payable;
	}

	public Integer getIntegration() {
		return integration;
	}

	public void setIntegration(Integer integration) {
		this.integration = integration;
	}

	

	public String getReceiver() {
		return receiver;
	}

	public void setReceiver(String receiver) {
		this.receiver = receiver;
	}

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public String getZip_code() {
		return zip_code;
	}

	public void setZip_code(String zip_code) {
		this.zip_code = zip_code;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

}
