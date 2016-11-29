package cloud.shop.exception;

public class SessionTimeoutException extends Exception {
	private static final long serialVersionUID = 1L;

    public SessionTimeoutException(){  
          
    }  
      
    public SessionTimeoutException(Throwable cause){  
        super(cause);  
    }  
      
    public SessionTimeoutException(String message){  
        super(message);  
    }  
}
