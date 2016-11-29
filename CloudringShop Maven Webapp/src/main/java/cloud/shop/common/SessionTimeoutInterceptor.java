package cloud.shop.common;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;




//session认证
public class SessionTimeoutInterceptor implements HandlerInterceptor {
	public String[] allowUrls;
	
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		//该方法将在Controller处理之前进行调用
		String requestUrl = request.getRequestURI().replace(request.getContextPath(), "");		
		 if(null != allowUrls && allowUrls.length>=1){
			 for(String url : allowUrls) {
				 if(requestUrl.contains(url)) {
					 return true;
				 }
			 }
		 }
		
		 Object obj = (Object) request.getSession().getAttribute(Constants.SESSION_LOGIN_USER);
		 Object obj1 = (Object) request.getSession().getAttribute(Constants.SESSION_LOGIN_USER_GOODS);
		 if(obj != null || obj1 !=null){
			 return true;
		 }else{
			// 未登录  跳转到登录页面   
			// throw new SessionTimeoutException();//返回到配置文件中定义的路径
			 String path = request.getContextPath();
			 response.sendRedirect(path+"/tologin.jsp"); 
			 return false;
		 }
	}

	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
		//这个方法中对Controller 处理之后的ModelAndView 对象进行操作
	}

	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
		//该方法将在整个请求结束之后，也就是在DispatcherServlet 渲染了对应的视图之后执行。这个方法的主要作用是用于进行资源清理工作的。
	}

	public String[] getAllowUrls() {
		return allowUrls;
	}

	public void setAllowUrls(String[] allowUrls) {
		this.allowUrls = allowUrls;
	}

}
