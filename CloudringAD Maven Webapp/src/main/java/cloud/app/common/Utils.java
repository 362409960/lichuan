package cloud.app.common;

import javax.servlet.http.HttpServletRequest;

import cloud.app.system.vo.SysUserVO;

public class Utils {
    public static String getUserIdbySession(HttpServletRequest request)throws Exception{
    	Object obj = request.getSession().getAttribute(Constants.SESSION_LOGIN_USER);
    	if(obj ==null){
    		throw new Exception("session 已经过期，请重新登录.");
    	}
    	
    	SysUserVO user = (SysUserVO)obj;
    	return user.getId();
    }
    
    public static SysUserVO getUserbySession(HttpServletRequest request)throws Exception{
    	Object obj = request.getSession().getAttribute(Constants.SESSION_LOGIN_USER);
    	if(obj ==null){
    		throw new Exception("session 已经过期，请重新登录.");
    	}
    	
    	SysUserVO user = (SysUserVO)obj;
    	return user;
    }
}
