package cloud.app.common;

import javax.servlet.http.HttpServletRequest;

/**
 * 获取服务器当前URL的工具类(域名不固定，�?��必须每次都获取�?)
 * @author yangtao 130016126
 *
 */
public class PATH {
	/**
	 * 返回服务器当前的URL
	 * @param request
	 * @return
	 */
	public static String BASEPATH(HttpServletRequest request){
		//http://localhost:8080/cloud/
		return request.getScheme() + "://"+ request.getServerName() + ":" + request.getServerPort()+ request.getContextPath() + "/";//获取服务器当前的URL
	}
}
