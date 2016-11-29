package cloud.app.system.po;

import java.util.Date;
import java.util.List;

public class STMenu {
	private String id;
	private String name;
	private String pid;
	private String parentName;
	private String url;
	private Integer show_index;
	private String note;
	private String create_user;
	private Date create_time;
	private String update_user;
	private Date update_time;
	private String menuImgUrl;
	private boolean isChecked;//是否选中
	List<STMenu> subMenuList;
	
	public boolean getIsChecked() {
		return isChecked;
	}
	public void setIsChecked(boolean isChecked) {
		this.isChecked = isChecked;
	}
	public String getMenuImgUrl() {
		return menuImgUrl;
	}
	public void setMenuImgUrl(String menuImgUrl) {
		this.menuImgUrl = menuImgUrl;
	}
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
	public String getPid() {
		return pid;
	}
	public void setPid(String pid) {
		this.pid = pid;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public Integer getShow_index() {
		return show_index;
	}
	public void setShow_index(Integer show_index) {
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
	public List<STMenu> getSubMenuList() {
		return subMenuList;
	}
	public void setSubMenuList(List<STMenu> subMenuList) {
		this.subMenuList = subMenuList;
	}
	public String getParentName() {
		return parentName;
	}
	public void setParentName(String parentName) {
		this.parentName = parentName;
	}
 

}
