package cloud.app.commodity.model;

import java.util.Date;

public class ParametersGroup {
	
	private String id;
	private String product_id;
	private String name;
	private String parameter_group_id;
	private Date create_date;
	private Date modify_date;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getProduct_id() {
		return product_id;
	}
	public void setProduct_id(String product_id) {
		this.product_id = product_id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getParameter_group_id() {
		return parameter_group_id;
	}
	public void setParameter_group_id(String parameter_group_id) {
		this.parameter_group_id = parameter_group_id;
	}
	public Date getCreate_date() {
		return create_date;
	}
	public void setCreate_date(Date create_date) {
		this.create_date = create_date;
	}
	public Date getModify_date() {
		return modify_date;
	}
	public void setModify_date(Date modify_date) {
		this.modify_date = modify_date;
	}
	
	

}
