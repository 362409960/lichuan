package cloud.app.common;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.jasig.cas.client.util.AssertionHolder;
import org.jasig.cas.client.validation.Assertion;

public class LoginUserFilter implements Filter {

	@Override
	public void destroy() {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest) request;
		HttpSession session = req.getSession();
	
        //如果session中没有用户信息，则填充用户信息  
        if (session.getAttribute("username") == null) {  
            //从Cas服务器获取登录账户的用户名  
            Assertion assertion = AssertionHolder.getAssertion();  
            if(assertion != null){
            	  String userName = assertion.getPrincipal().getName(); 
             
                  try { 
                      session.setAttribute("username", userName);
                  } catch (Exception e) {  
                      e.printStackTrace();  
                  }  
            }
          
        }  
        chain.doFilter(request, response);
}

	@Override
	public void init(FilterConfig arg0) throws ServletException {
		// TODO Auto-generated method stub
		
	}
	
}
