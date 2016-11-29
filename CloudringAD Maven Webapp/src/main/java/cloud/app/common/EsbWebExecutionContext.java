package cloud.app.common;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.mina.core.session.IoSession;


public class EsbWebExecutionContext {
	Logger logger = Logger.getLogger(this.getClass());
	
	private static ThreadLocal<EsbWebExecutionContext> userData = new ThreadLocal<EsbWebExecutionContext>();
	private HttpServletRequest request;
	private HttpServletResponse response;
	private IoSession ioSession;
	
	
	public static EsbWebExecutionContext get() throws Exception {
		
		EsbWebExecutionContext ex = (EsbWebExecutionContext)userData.get();
		if(ex == null){
			ex = new EsbWebExecutionContext();
			userData.set(ex);
		}
		
		return ex;
	}
	
	public static boolean exists(){
		return (userData.get() != null);
	}
	
	public static void set(EsbWebExecutionContext ex){
		userData.set(ex);
	}

	public HttpServletRequest getRequest() {
		return request;
	}

	public void setRequest(HttpServletRequest request) {
		this.request = request;
	}

	public HttpServletResponse getResponse() {
		return response;
	}

	public void setResponse(HttpServletResponse response) {
		this.response = response;
	}

	public IoSession getIoSession() {
		return ioSession;
	}

	public void setIoSession(IoSession ioSession) {
		this.ioSession = ioSession;
	}
	
	
	
	
}
