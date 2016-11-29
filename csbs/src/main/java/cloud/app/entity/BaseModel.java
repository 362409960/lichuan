package cloud.app.entity;

import java.util.List;

public class BaseModel {
	private Integer pageSize;//页大小
	private Integer pageIndex;//当前页
	private Integer pageMax;//最大页	
	private Integer total;//总页数
	
	public Integer getPageMax() {
		return pageMax;
	}
	public void setPageMax(Integer pageMax) {
		this.pageMax = pageMax;
	}
	private List<?> rows;
	
	public List<?> getRows() {
		return rows;
	}
	public void setRows(List<?> rows) {
		this.rows = rows;
	}
	public Integer getTotal() {
		return total;
	}
	public void setTotal(Integer total) {
		this.total = total;
	}
	public Integer getPageSize() {
		return pageSize;
	}
	public void setPageSize(Integer pageSize) {
		this.pageSize = pageSize;
	}
	public Integer getPageIndex() {
		return pageIndex;
	}
	public void setPageIndex(Integer pageIndex) {
		this.pageIndex = pageIndex;
	}
}
