package cloud.app.download;


public class TransportBean {
	private String webAddr;             //下载地址  
	private String fileDir;             //下载到指定的目录  
	private String fileName;            //下载后文件的新名字  
	private int count;                  //文件分几个线程下载, 默认为 5个
	
	//默认的构造方法
    public TransportBean() {                   
        this("","","",5);  
    }
    //带参数的构造方法  
    public TransportBean(String webAddr, String fileDir, String fileName, int count) {  
        this.webAddr = webAddr;  
        this.fileDir = fileDir;  
        this.fileName = fileName;  
        this.count = count;  
    }

	public String getWebAddr() {
		return webAddr;
	}
	public void setWebAddr(String webAddr) {
		this.webAddr = webAddr;
	}
	public String getFileDir() {
		return fileDir;
	}
	public void setFileDir(String fileDir) {
		this.fileDir = fileDir;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
    
    
}
