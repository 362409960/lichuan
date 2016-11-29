package cloud.shop.goods.entity;
//地址表
public class Region {
	
	private String id;
	private String name;
	private String code;
	private String parent_id;
	private Integer orderlist;
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
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	
	public String getParent_id() {
		return parent_id;
	}
	public void setParent_id(String parent_id) {
		this.parent_id = parent_id;
	}
	public Integer getOrderlist() {
		return orderlist;
	}
	public void setOrderlist(Integer orderlist) {
		this.orderlist = orderlist;
	}
	

}
