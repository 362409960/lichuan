package cloud.app.common;

import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.ProgressListener;

public class FileUploadProgressListener implements ProgressListener {
	private HttpSession session;  
	
	public FileUploadProgressListener(HttpSession session) {  
	    this.session = session;  
	}  
	
	    //pBytesRead  已经上传的大小  
	     //pContentLength   文件总大小  
	 @Override  
	 public void update(long pBytesRead, long pContentLength, int pItems) {  
//	     System.out.println((double)pBytesRead/pContentLength);  
	     session.setAttribute("progress", (double)pBytesRead/pContentLength); 

	 } 


}
