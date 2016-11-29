package cloud.shop.system.vo;



import java.util.Date;

import cloud.shop.entity.BaseModel;



public class RoleVO extends BaseModel {
	private String id;
	private String role_name;
	private String create_user;
	private Date create_time;
	private String update_user;
	private Date update_time;
	private String role_key;
	private String is_del;
	private boolean is_checked;
	
	public boolean isIs_checked() {
		return is_checked;
	}
	public void setIs_checked(boolean is_checked) {
		this.is_checked = is_checked;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getRole_name() {
		return role_name;
	}
	public void setRole_name(String role_name) {
		this.role_name = role_name;
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
	public String getRole_key() {
		return role_key;
	}
	public void setRole_key(String role_key) {
		this.role_key = role_key;
	}
	public String getIs_del() {
		return is_del;
	}
	public void setIs_del(String is_del) {
		this.is_del = is_del;
	}
}
