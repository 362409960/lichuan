package cloud.app.download;

import java.io.File;
import java.util.HashMap;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

@Service
public class BreakpointsResumeUploadServiceImpl implements BreakpointsResumeUploadService {
	Logger logger = Logger.getLogger(this.getClass());
	
	
	public void upload(String filepath, String fileName) throws Exception {
		BreakpointsResumeUploadClient client = new BreakpointsResumeUploadClient(filepath);
		long start = System.currentTimeMillis();
		
		logger.info("start upload "+filepath+" .");
		//client.service();
		long end = System.currentTimeMillis();
		logger.info("end upload "+filepath+" , cost "+(end-start)/1000+" s");
		
	}

	public String getUploadRate(String filepath) throws Exception {
		return null;
	}

	public void upload(byte[] contents, String uploadPath, String fileName) throws Exception {
		String sep = System.getProperty ("file.separator");
		
		BreakpointsResumeUploadClient client = new BreakpointsResumeUploadClient(uploadPath+sep+fileName);
		long start = System.currentTimeMillis();
		
		logger.info("start upload "+uploadPath+sep+fileName+" .");
		client.service(contents, uploadPath, fileName);
		long end = System.currentTimeMillis();
		logger.info("end upload "+uploadPath+sep+fileName+" , cost "+(end-start)/1000+" s");
		
	}

	public Map<String, String> getUploadSize(byte[] contents, String uploadPath, String fileName) throws Exception {
		long length = 0;
		String rate = "";
		int total = contents.length;
		Map<String, String> map = new HashMap<String, String>();
		
		File file = new File(uploadPath);

		if(file.exists()){
			length = file.length();
		}

		rate = length*100L/total+"%";
		map.put("size", String.valueOf(length));
		map.put("rate", rate);
		
		return map;
	}

}
