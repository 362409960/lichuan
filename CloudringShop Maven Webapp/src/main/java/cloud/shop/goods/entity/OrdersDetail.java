package cloud.shop.goods.entity;

import java.math.BigDecimal;
//订单子表
public class OrdersDetail  {
	private String id;
	private String order_info_id;
	private String name;
	private BigDecimal price;
	private  Integer quantity;
	private String goods_url;
	private String goods_id;
	private BigDecimal subtotal;
	public BigDecimal getSubtotal() {
		return subtotal;
	}
	public void setSubtotal(BigDecimal subtotal) {
		this.subtotal = subtotal;
	}
	public String getGoods_id() {
		return goods_id;
	}
	public void setGoods_id(String goods_id) {
		this.goods_id = goods_id;
	}
	private String oid;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getOrder_info_id() {
		return order_info_id;
	}
	public void setOrder_info_id(String order_info_id) {
		this.order_info_id = order_info_id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public BigDecimal getPrice() {
		return price;
	}
	public void setPrice(BigDecimal price) {
		this.price = price;
	}
	public Integer getQuantity() {
		return quantity;
	}
	public void setQuantity(Integer quantity) {
		this.quantity = quantity;
	}
	public String getGoods_url() {
		return goods_url;
	}
	public void setGoods_url(String goods_url) {
		this.goods_url = goods_url;
	}
	public String getOid() {
		return oid;
	}
	public void setOid(String oid) {
		this.oid = oid;
	}

}
