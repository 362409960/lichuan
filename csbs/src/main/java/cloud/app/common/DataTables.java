package cloud.app.common;

import java.io.UnsupportedEncodingException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

/**
 * datatables实体类，用于传递参数
 * 
 * @author yangtao
 *
 */
public class DataTables {
	private Integer iTotalRecords;//数据库中的结果总行数
	private Integer iTotalDisplayRecords;//搜索过滤后的总行数
	private String iDisplayStart;// 起始行数
	private String sSearch;// 搜索的字符串
	private String pageDisplayLength;// 页面大小
	private String sEcho;// 不知道干嘛的，留着就行
	private String iSortCol_0;// 需要排序的列
	private String sSortDir_0;// 排序方式
	private List<Map<String, String>> aaData;//结果集

	/**
	 * 构造方法
	 * 
	 * @param request
	 */
	public DataTables(HttpServletRequest request) {
		this.iDisplayStart = request.getParameter("iDisplayStart");
		try {
			this.sSearch = new String(request.getParameter("sSearch").getBytes("ISO-8859-1"), "utf-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		this.pageDisplayLength = request.getParameter("iDisplayLength");
		this.sEcho = request.getParameter("sEcho");
		this.iSortCol_0 = request.getParameter("iSortCol_0");
		this.sSortDir_0 = request.getParameter("sSortDir_0");
	}

	/**
	 * 构造器
	 * @param request
	 * @return
	 */
	public static DataTables createDataTables(HttpServletRequest request){
		return new DataTables(request);
	}
	
	/**
	 * @return the iDisplayStart
	 */
	public String getiDisplayStart() {
		return iDisplayStart;
	}

	/**
	 * @param iDisplayStart
	 *            the iDisplayStart to set
	 */
	public void setiDisplayStart(String iDisplayStart) {
		this.iDisplayStart = iDisplayStart;
	}

	/**
	 * @return the searchParameter
	 */
	public String getSSearch() {
		return sSearch;
	}

	/**
	 * @param searchParameter
	 *            the searchParameter to set
	 */
	public void setSSearch(String searchParameter) {
		this.sSearch = searchParameter;
	}

	/**
	 * @return the pageDisplayLength
	 */
	public String getPageDisplayLength() {
		return pageDisplayLength;
	}

	/**
	 * @param pageDisplayLength
	 *            the pageDisplayLength to set
	 */
	public void setPageDisplayLength(String pageDisplayLength) {
		this.pageDisplayLength = pageDisplayLength;
	}

	/**
	 * @return the sEcho
	 */
	public String getsEcho() {
		return sEcho;
	}

	/**
	 * @param sEcho
	 *            the sEcho to set
	 */
	public void setsEcho(String sEcho) {
		this.sEcho = sEcho;
	}

	/**
	 * @return the iSortCol_0
	 */
	public String getiSortCol_0() {
		return iSortCol_0;
	}

	/**
	 * @param iSortCol_0
	 *            the iSortCol_0 to set
	 */
	public void setiSortCol_0(String iSortCol_0) {
		this.iSortCol_0 = iSortCol_0;
	}

	/**
	 * @return the sSortDir_0
	 */
	public String getsSortDir_0() {
		return sSortDir_0;
	}

	/**
	 * @param sSortDir_0
	 *            the sSortDir_0 to set
	 */
	public void setsSortDir_0(String sSortDir_0) {
		this.sSortDir_0 = sSortDir_0;
	}

	
	/**
	 * @return the iTotalRecords
	 */
	public Integer getiTotalRecords() {
		return iTotalRecords;
	}

	/**
	 * @param iTotalRecords the iTotalRecords to set
	 */
	public void setiTotalRecords(Integer iTotalRecords) {
		this.iTotalRecords = iTotalRecords;
	}

	/**
	 * @return the iTotalDisplayRecords
	 */
	public Integer getiTotalDisplayRecords() {
		return iTotalDisplayRecords;
	}

	/**
	 * @param iTotalDisplayRecords the iTotalDisplayRecords to set
	 */
	public void setiTotalDisplayRecords(Integer iTotalDisplayRecords) {
		this.iTotalDisplayRecords = iTotalDisplayRecords;
	}

	public List<Map<String, String>> getAaData() {
		return aaData;
	}

	public void setAaData(List<Map<String, String>> aaData) {
		this.aaData = aaData;
	}
}
