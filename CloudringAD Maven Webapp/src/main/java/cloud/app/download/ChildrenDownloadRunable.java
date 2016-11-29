package cloud.app.download;

import java.io.IOException;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.URL;

import org.apache.log4j.Logger;


/**
 * 下载类的子线程
 */
public class ChildrenDownloadRunable implements Runnable {
	Logger logger = Logger.getLogger(this.getClass());
	
    String webAddr;                     //网址  
    long startPosition;                 //开始位置  
    long endPosition;                   //结束位置  
    int threadID;                       //线程编号  
    boolean downLoadOver = false;       //下载结束  
    boolean isStopGet = false;          //是否停止请求  
    StorageFile storageFile = null;     //存储文件的类  
	
    public ChildrenDownloadRunable(String surl, String sname, long startPosition, long endPosition, int threadID) throws IOException {  
        this.webAddr = surl;  
        this.startPosition = startPosition;  
        this.endPosition = endPosition;  
        this.threadID = threadID;  
        this.storageFile = new StorageFile(sname, startPosition);  
    }  
    
    //实现线程的方法
	public void run() {
		while (startPosition < endPosition && !isStopGet) {
			try {
				 URL url=new URL(webAddr);       //根据网络资源创建URL对象  
				 HttpURLConnection httpConnection=(HttpURLConnection)url.openConnection(); //创建 打开的连接对象  
	             //设置描述发出的HTTP请求的终端的信息  
				 httpConnection.setRequestProperty("User-Agent","Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 5.2; Trident/4.0; .NET CLR 1.1.4322; .NET CLR 2.0.50727; .NET CLR 3.0.04506.30; .NET CLR 3.0.4506.2152; .NET CLR 3.5.30729)");  
				 httpConnection.setRequestProperty("Connection", "Keep-Alive");
	             httpConnection.setRequestProperty("Range", "bytes=" + startPosition + "-" + endPosition);
	             httpConnection.setRequestProperty("Charset", "UTF-8");
	             httpConnection.setRequestProperty("Accept-Language", "zh-CN"); 
 
	             //获取 网络资源的输入流  
	             InputStream input = httpConnection.getInputStream();  
	             
	             byte[] b = new byte[1024];  
	             int nRead;

	             //循环将文件下载制定目录  
	             while ((nRead=input.read(b, 0, 1024))>0 && startPosition < endPosition && !isStopGet) {  
	             	startPosition += storageFile.write(b, 0, nRead); //调用方法将内容写入文件
	             }
	             
	             logger.info("线程\t"+(threadID+1)+"\t结束....");  
	             downLoadOver=true;
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

}
