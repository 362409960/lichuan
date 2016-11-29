package cloud.app.commodity.model;

public class InvManagVO {
	private String product_no;
	private String product_name;
	private String productId;
	private Integer stock;
	private Integer lock_stock;//锁定库存，但是没有出库
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
	public String getProductId() {
		return productId;
	}
	public void setProductId(String productId) {
		this.productId = productId;
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

}
