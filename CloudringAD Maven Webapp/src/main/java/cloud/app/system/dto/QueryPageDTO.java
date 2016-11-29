package cloud.app.system.dto;

import java.io.Serializable;

public class QueryPageDTO implements Serializable {
	private static final long serialVersionUID = 1L;

	// 当前页
	int currPage = 1;
	// 每页数量
	int pageSize = 10;

	// 起始位置
	int beginIndex = 1;
	// 终止位置
	int endIndex = 10;

	int allCount = 0;

	public int getBeginIndex() {
		return beginIndex;
	}

	public void setBeginIndex(int beginIndex) {
		this.beginIndex = beginIndex;
	}

	public int getEndIndex() {
		return endIndex;
	}

	public void setEndIndex(int endIndex) {
		this.endIndex = endIndex;
	}

	public int getAllCount() {
		return allCount;
	}

	public void setAllCount(int allCount) {
		this.allCount = allCount;
	}

	public int getCurrPage() {
		return currPage;
	}

	public void setCurrPage(int currPage) {
		this.currPage = currPage;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

}
