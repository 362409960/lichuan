package cloud.app.commodity.model;

import java.util.Date;

import cloud.app.entity.BaseModel;

public class ProductAttributes extends BaseModel{
	private String id;
	private Date create_time;
	private String update_user;
	private String create_user;
	private Date update_time;
	private String productCategoryId;
	private Integer order_value;
    private String att_options;
    private String attr_name;
    private String stringAsc;	
	private String [] options;
    
	public String getAttr_name() {
		return attr_name;
	}
	public void setAttr_name(String attr_name) {
		this.attr_name = attr_name;
	}
	public String getStringAsc() {
		return stringAsc;
	}
	public void setStringAsc(String stringAsc) {
		this.stringAsc = stringAsc;
	}
	public String[] getOptions() {
		return options;
	}
	public void setOptions(String[] options) {
		this.options = options;
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
	public String getUpdate_user() {
		return update_user;
	}
	public void setUpdate_user(String update_user) {
		this.update_user = update_user;
	}
	public String getCreate_user() {
		return create_user;
	}
	public void setCreate_user(String create_user) {
		this.create_user = create_user;
	}
	public Date getUpdate_time() {
		return update_time;
	}
	public void setUpdate_time(Date update_time) {
		this.update_time = update_time;
	}
	public String getProductCategoryId() {
		return productCategoryId;
	}
	public void setProductCategoryId(String productCategoryId) {
		this.productCategoryId = productCategoryId;
	}
	public Integer getOrder_value() {
		return order_value;
	}
	public void setOrder_value(Integer order_value) {
		this.order_value = order_value;
	}
	public String getAtt_options() {
		return att_options;
	}
	public void setAtt_options(String att_options) {
		this.att_options = att_options;
	}
    
    
}
