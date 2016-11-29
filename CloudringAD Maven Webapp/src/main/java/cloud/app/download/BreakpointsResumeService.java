package cloud.app.download;

import org.apache.log4j.Logger;


//断点续传入口
public class BreakpointsResumeService {
	Logger logger = Logger.getLogger(this.getClass());
	BreakpointsResumeRunable runable = null;
	
	public BreakpointsResumeService(){
		
	}

	//断点续传下载
	public void BreakpointsResumeDownload(String webAddr,String fileDir,String fileName,int count){
		TransportBean transportBean = new TransportBean(webAddr, fileDir, fileName, count);
		runable = new BreakpointsResumeRunable(transportBean);
		
		runable.run();
	}

	//获取断点续传下载实时大小
	public long getDownloadFileSize(String webAddr,String fileDir,String fileName,int count)throws Exception{
		TransportBean transportBean = new TransportBean(webAddr, fileDir, fileName, count);
		runable = new BreakpointsResumeRunable(transportBean);
		
		return runable.getDownloadFileSize();
	}
	
	
	
	
	
	
	
}
