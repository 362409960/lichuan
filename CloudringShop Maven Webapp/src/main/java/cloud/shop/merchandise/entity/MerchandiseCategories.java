package cloud.shop.merchandise.entity;

import java.util.ArrayList;
import java.util.Date;

import cloud.shop.entity.BaseModel;

public class MerchandiseCategories  extends BaseModel{
	private String id;//主键
	private String name;//分类名称
	private Date create_time;//创建时间
	private Date update_time;//修改时间
	private String metaDescription;//描述
	private String metaKeywords;//关键字
	private int orderList;//排序位置
	private String pid;//父ID
	
  
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
	public Date getCreate_time() {
		return create_time;
	}
	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}
	public Date getUpdate_time() {
		return update_time;
	}
	public void setUpdate_time(Date update_time) {
		this.update_time = update_time;
	}
	public String getMetaDescription() {
		return metaDescription;
	}
	public void setMetaDescription(String metaDescription) {
		this.metaDescription = metaDescription;
	}
	public String getMetaKeywords() {
		return metaKeywords;
	}
	public void setMetaKeywords(String metaKeywords) {
		this.metaKeywords = metaKeywords;
	}
	public int getOrderList() {
		return orderList;
	}
	public void setOrderList(int orderList) {
		this.orderList = orderList;
	}
	public String getPid() {
		return pid;
	}
	public void setPid(String pid) {
		this.pid = pid;
	}
}
