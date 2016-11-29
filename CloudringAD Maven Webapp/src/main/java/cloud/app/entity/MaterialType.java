package cloud.app.entity;

import java.util.Date;

public class MaterialType extends BaseModel{
	private String id;
	private String pId;
	private String name;
	private String type;
	private boolean parentCheck;
	private Date createTime;
	private Date updateTime;
	
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public boolean isParentCheck() {
		return parentCheck;
	}
	public void setParentCheck(boolean parentCheck) {
		this.parentCheck = parentCheck;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getpId() {
		return pId;
	}
	public void setpId(String pId) {
		this.pId = pId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	public Date getUpdateTime() {
		return updateTime;
	}
	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}
	
}
