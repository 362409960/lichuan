package cloud.shop.goods.entity;
//支付方式
public class Pay {
	private String id;
	private String name;
	private String pay_type;
	private Integer order_by;
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
	public String getPay_type() {
		return pay_type;
	}
	public void setPay_type(String pay_type) {
		this.pay_type = pay_type;
	}
	public Integer getOrder_by() {
		return order_by;
	}
	public void setOrder_by(Integer order_by) {
		this.order_by = order_by;
	}
	

}
