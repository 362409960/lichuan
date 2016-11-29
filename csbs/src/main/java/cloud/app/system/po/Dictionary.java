package cloud.app.system.po;

import java.util.Date;

import cloud.app.entity.BaseModel;

public class Dictionary extends BaseModel {
	private String pkid;
	private String catalog_id;
	private String dic_code;
	private String dic_value;
	private String show_index;
	private String note;
	private String create_user;
	private Date create_time;
	private String update_user;
	private Date update_time;
	private String state;
	
	public String getPkid() {
		return pkid;
	}
	public void setPkid(String pkid) {
		this.pkid = pkid;
	}
	public String getCatalog_id() {
		return catalog_id;
	}
	public void setCatalog_id(String catalog_id) {
		this.catalog_id = catalog_id;
	}
	public String getDic_code() {
		return dic_code;
	}
	public void setDic_code(String dic_code) {
		this.dic_code = dic_code;
	}
	public String getDic_value() {
		return dic_value;
	}
	public void setDic_value(String dic_value) {
		this.dic_value = dic_value;
	}
	public String getShow_index() {
		return show_index;
	}
	public void setShow_index(String show_index) {
		this.show_index = show_index;
	}
	public String getNote() {
		return note;
	}
	public void setNote(String note) {
		this.note = note;
	}
	public String getCreate_user() {
		return create_user;
	}
	public void setCreate_user(String create_user) {
		this.create_user = create_user;
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
	public Date getUpdate_time() {
		return update_time;
	}
	public void setUpdate_time(Date update_time) {
		this.update_time = update_time;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	  
	  
	  
}
