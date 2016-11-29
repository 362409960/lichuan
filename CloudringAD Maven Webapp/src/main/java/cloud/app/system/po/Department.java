package cloud.app.system.po;

import java.util.Date;
import java.util.List;

public class Department {
	
	private String id;
	private String pid;//父id
	private String name;//名称
	private String remark;//备注
	private String dist_server;//所属服务器
	private String create_user;
	private Date create_time;
	private String update_user;
	private Date update_time;
	private String sate;//状态
	private boolean parentCheck;
	private String parentName;
	private boolean isChecked;//是否选中
	List<Department> subMenuList;
	
	public String getParentName() {
		return parentName;
	}
	public void setParentName(String parentName) {
		this.parentName = parentName;
	}
	public boolean isChecked() {
		return isChecked;
	}
	public void setChecked(boolean isChecked) {
		this.isChecked = isChecked;
	}
	public boolean isParentCheck() {
		return parentCheck;
	}
	public void setParentCheck(boolean parentCheck) {
		this.parentCheck = parentCheck;
	}
	public List<Department> getSubMenuList() {
		return subMenuList;
	}
	public void setSubMenuList(List<Department> subMenuList) {
		this.subMenuList = subMenuList;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPid() {
		return pid;
	}
	public void setPid(String pid) {
		this.pid = pid;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public String getDist_server() {
		return dist_server;
	}
	public void setDist_server(String dist_server) {
		this.dist_server = dist_server;
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
	public String getSate() {
		return sate;
	}
	public void setSate(String sate) {
		this.sate = sate;
	}
	
	
}
