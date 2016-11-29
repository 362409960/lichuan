package cloud.app.download;

import java.util.Map;

public interface BreakpointsResumeUploadService { 
	
	public void upload(String filepath, String fileName) throws Exception;
	
	public String getUploadRate(String filepath) throws Exception;
	
	//断点续传（上传）
	public void upload(byte[] contents, String uploadPath, String fileName) throws Exception;
	//获取断点续传的字节数
	public Map<String, String> getUploadSize(byte[] contents, String uploadPath, String fileName) throws Exception;
}
