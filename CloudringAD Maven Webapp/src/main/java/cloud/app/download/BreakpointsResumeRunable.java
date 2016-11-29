package cloud.app.download;

import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.URL;

import org.apache.log4j.Logger;

/**
 * 断点续传主线程
 * @author huangxc
 */
public class BreakpointsResumeRunable implements Runnable {
	Logger logger = Logger.getLogger(this.getClass());
	
	//扩展信息bean
	TransportBean transportBean;
	//开始位置
	long[] startPosition;
	//结束位置
	long[] endPosition;
	//子线程对象
	ChildrenDownloadRunable[] childRunable;
	//文件的长度
	long fileLength;
	//是否第一次下载
	boolean isFisrtDownload = true;
	//是否暂停
	boolean isStop = false;
	//文件下信息
	File file;
	//文件下载的临时信息
	File tempFileName;
	//输出到文件的输出流
	DataOutputStream output;
	//当前下载总量
	public long currentLength = 0;
	
	//构造方法
	public BreakpointsResumeRunable(TransportBean transportBean){
		try {
			 this.transportBean = transportBean;
			 this.tempFileName = new File(transportBean.getFileDir()+File.separator+transportBean.getFileName()+".info");
			 
			 logger.info("create a temp file, name is: "+this.tempFileName);
			 
			 if(this.tempFileName.exists()){
				 this.isFisrtDownload = false;

				 readInfo();
			 }else{
				 startPosition = new long[transportBean.getCount()];
				 endPosition   = new long[transportBean.getCount()];  
			 }
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	
	public void run() {
		//第一次下载
		if(this.isFisrtDownload){
			fileLength = this.getFileLength();
			if(fileLength==-1){                       
                System.err.println("文件长度为止");
            }else if(fileLength==-2){  
                System.err.println("不能访问文件");  
            }else{  
            	 System.out.println("文件的长度:"+fileLength);  
                 
                 //循环划分 每个线程要下载的文件的开始位置  
                 for (int i = 0; i < startPosition.length; i++) {  
                     startPosition[i]=(long)(i*(fileLength/startPosition.length));  
                 }  
                 //循环划分每个线程要下载的文件的结束位置  
                 for (int i = 0; i < endPosition.length-1; i++) {  
                     endPosition[i]=startPosition[i+1];  
                 }  
                 //设置最后一个 线程的下载 结束位置 文件的的长度   
                 endPosition[endPosition.length-1]=fileLength;  
            }
		}
		
		//创建 子线程数量的数组  
		childRunable = new ChildrenDownloadRunable[startPosition.length];  
		for (int i = 0; i < startPosition.length; i++) {
			try {
				childRunable[i]=new ChildrenDownloadRunable(transportBean.getWebAddr(), transportBean.getFileDir()+File.separator+transportBean.getFileName(), startPosition[i], endPosition[i], i);
	            logger.info("线程"+(i+1)+",的开始位置="+startPosition[i]+",结束位置="+endPosition[i]);  
	            new Thread(childRunable[i]).start();
			} catch (IOException e) {
				e.printStackTrace();
			}  
		}
		
		boolean breakWhile=false;
		while (!isStop) {
            savePosition();       
            breakWhile=true;  
            for (int i = 0; i < startPosition.length; i++) {//循环实现下载文件  
                if(!childRunable[i].downLoadOver){  
                    breakWhile=false;  
                    break;  
                }  
            }  
            if(breakWhile)  
                break;  
              
        }  
        System.err.println("文件下载结束!"); 
	}

	public long getDownloadFileSize(){
		File file = new File(transportBean.getFileDir()+File.separator+transportBean.getFileName());
		if(!file.exists()){
			return this.currentLength = 0;
		}else{
			return this.currentLength = file.length();
		}
	}
	
	private void savePosition() {
		try {
			output = new DataOutputStream(new FileOutputStream(tempFileName));
			output.writeInt(startPosition.length);
			for (int i = 0; i < startPosition.length; i++) {
				output.writeLong(childRunable[i].startPosition);
				output.writeLong(childRunable[i].endPosition);
			}
			output.close();
		} catch (Exception e) {
			System.out.println("保存下载信息出错:" + e.getMessage());
		}
	}


	//获取文件的总长度
    private long getFileLength() {
        int fileLength=-1;  
        try {  
            URL url=new URL(transportBean.getWebAddr());     //根据网址传入网址创建URL对象  
            //打开连接对象  
            HttpURLConnection httpConnection=(HttpURLConnection)url.openConnection();  
            //设置描述发出HTTP请求的终端信息  
            httpConnection.setRequestProperty("User-Agent","Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 5.2; Trident/4.0; .NET CLR 1.1.4322; .NET CLR 2.0.50727; .NET CLR 3.0.04506.30; .NET CLR 3.0.4506.2152; .NET CLR 3.5.30729)");  
            int responseCode=httpConnection.getResponseCode();   
            //表示不能访问文件  
            if(responseCode>=400){
                return -2;  
            }  
            String head;  
            for (int i = 1; ; i++) {  
                head=httpConnection.getHeaderFieldKey(i); //获取文件头部信息  
                if(head !=null){  
                    if(head.equals("Content-Length")){  //根据头部信息获取文件长度  
                        fileLength=Integer.parseInt(httpConnection.getHeaderField(head));  
                        break;  
                    }  
                }else{  
                    break;  
                }  
            }
        } catch (Exception e) {  
            System.out.println("获取文件长度出错:"+e.getMessage());  
        }  
        logger.info("文件长度"+fileLength);  
        return fileLength; 
	}


	//读取文件指针位置  
    private void readInfo(){  
        try {  
            //创建数据输出流  
            DataInputStream input=new DataInputStream(new FileInputStream(this.tempFileName));  
            int count=input.readInt();                     //读取分成的线程下载个数  
            startPosition=new long[count];                  //设置开始线程  
            endPosition=new long[count];                    //设置结束线程  
            for (int i = 0; i < startPosition.length; i++) {  
                startPosition[i]=input.readLong();          //读取每个线程的开始位置  
                endPosition[i]=input.readLong();            //读取每个线程的结束位置  
            }  
            input.close();  
        } catch (Exception e) {  
            System.out.println("读取文件指针位置出错:"+e.getMessage());  
        }  
    }  
	
}
