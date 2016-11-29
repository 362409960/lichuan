package cloud.app.download;


import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.DataInputStream;  
import java.io.DataOutputStream;  
import java.io.File;  
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.RandomAccessFile;
import java.net.Socket;  
import java.util.ArrayList;
import java.util.Random;
import java.util.Vector;  
import java.util.concurrent.ExecutorService;  
import java.util.concurrent.Executors;

import cloud.app.common.Constants;

  
public class BreakpointsResumeUploadClient {
	//socket 多线程网络传输多个文件
	private static ArrayList<String> fileList = new ArrayList<String>();  
 
	//要传送的文件路径
    public BreakpointsResumeUploadClient(String filePath){  
        getFilePath(filePath);  
    }
	
    /** 
     * 带参数的构造器，用户设定需要传送文件的文件夹
     * @param filePath 
    public BreakpointsResumeUploadClient(String filePath){  
        getFilePath(filePath);  
    }
    */ 

    /** 
     * 不带参数的构造器。使用默认的传送文件的文件夹  
    public BreakpointsResumeUploadClient(){  
        getFilePath(sendFilePath);  
    }
    */ 
      
/*    public void service(){  
        ExecutorService executorService = Executors.newCachedThreadPool();  
        Vector<Integer> vector = getRandom(fileList.size());  
        for(Integer integer : vector){  
            String filePath = fileList.get(integer.intValue());  
            executorService.execute(sendFile(filePath));  
        }  
    } */ 
    
    
    public void service(byte[] contents, String uploadPath, String fileName){  
        ExecutorService executorService = Executors.newCachedThreadPool();  
        executorService.execute(sendFile(contents, uploadPath, fileName)); 
    } 
    
    //update huangxc 20151110
    private void getFilePath(String dirPath){
    	fileList.add(dirPath);
    }
    
    /* 不需要递归所有的子目录，现在修改为只要传一个目录的路径
    private void getFilePath(String dirPath){  
        File dir = new File(dirPath);  
        File[] files = dir.listFiles();  
        if(files == null){  
            return;  
        }
        for(int i = 0; i < files.length; i++){  
            if(files[i].isDirectory()){  
                getFilePath(files[i].getAbsolutePath());  
            }  
            else {  
                fileList.add(files[i].getAbsolutePath());  
            }  
        }  
    }  
    */  
    private Vector<Integer> getRandom(int size){  
        Vector<Integer> v = new Vector<Integer>();  
        Random r = new Random();  
        boolean b = true;  
        while(b){  
            int i = r.nextInt(size);  
            if(!v.contains(i))  
                v.add(i);  
            if(v.size() == size)  
                b = false;  
        }  
        return v;  
    }      
      
    
    
    
    
    
    private static Runnable sendFile(final byte[] bytes, final String filePath, final String fileName){  
        return new Runnable(){  
              
            private Socket socket = null;  
            private String ip ="localhost";  
            private int port = Constants.DEFAULT_BIND_PORT;
            public void run() {
                System.out.println("开始发送文件:" + filePath);  
                File file = new File(filePath); 
                                
                if(createConnection()){  
                    int bufferSize = 8192;  
                    byte[] buf = new byte[bufferSize];  
                    try {  
                        DataOutputStream dos = new DataOutputStream(socket.getOutputStream()); 
                        DataInputStream dis = new DataInputStream(socket.getInputStream());
                        
                        //发送文件路径（包含文件名称）
                        dos.writeUTF(filePath);  
                        dos.flush();
                        dos.writeLong(file.length());  
                        dos.flush();  
                          
                        //是否存在文件：如果存在返回的是字节数，没有就返回noexsits
                        String isexists = dis.readUTF();
                        //上传文件的总字节数
                        int total = bytes.length;
                    	//定义开始位置
                        int start = 0;
                    	//定义每次上传的结束位置
                        int end = 0;
                    	int num = 0;
                    	long numlth =0;
                    	
                        if("noexsits".equals(isexists)){
                        	System.out.println("文件["+file.getName()+"]直接传输!");
                        	while( !(start>=total-1)){
                        		start = end;
                        		end += bufferSize;
                        		if(end >= total-1){
                        			end = total -1;
                        		}
                        		num = end -start;
                        		System.out.println("num: "+num);

                        		System.arraycopy(bytes, start, buf, 0, num);
                        		dos.write(buf,0,num);
                        		dos.flush();
                        		numlth+=end-start;
                        		System.out.println("文件["+fileName+"]已传送"+numlth*100L/total+"%");
                        	}
                        	dos.flush();
                        	this.socket.shutdownOutput();
                        	String record = dis.readUTF();
                        	System.out.println("文件["+file.getName()+"]传输结束1:"+record);
                        }else{
                        	System.out.println("读取服务器端["+file.getName()+"]文件长度!");
                        	long initLength = Long.parseLong(isexists);
                        	RandomAccessFile raf = new RandomAccessFile(filePath,"r");
                        	raf.skipBytes((int)initLength);
                        	
                        	end = (int)initLength;
                        	while( !(start>=total-1)){
                        		start = end;
                        		end += bufferSize;
                        		if(end >= total-1){
                        			end = total -1;
                        		}
                        		num = end -start;
                        		System.out.println("num: "+num);
                        		System.arraycopy(bytes, start, buf, 0, num);
                        		
                        		dos.write(buf,0,num);
                        		dos.flush();
                        		initLength += num;
                        		System.out.println("文件["+file.getName()+"]已传送"+initLength*100L/total+"%");
                        	}
                        	dos.flush();
                        	raf.close();
                        	this.socket.shutdownOutput();
                        	String record = dis.readUTF();
                        	System.out.println("文件["+file.getName()+"]传输结束2:"+record);
                        }
 
                       dos.close();  
                       dis.close();
                       socket.close();  
                       System.out.println("文件 " + filePath + "传输完成!");  
                    } catch (Exception e) {  
                        e.printStackTrace();  
                    }  
                }  
            }  
              
            private boolean createConnection() {  
                try {  
                    socket = new Socket(ip, port);  
                    System.out.println("连接服务器成功！");  
                    return true;  
                } catch (Exception e) {  
                    System.out.println("连接服务器失败！");  
                    return false;  
                }   
            }  
              
        };  
    }
    
    
    
    
    
    private static Runnable sendFile(final String filePath){  
        return new Runnable(){  
              
            private Socket socket = null;  
            private String ip ="localhost";  
            private int port = Constants.DEFAULT_BIND_PORT;
            public void run() {  
                System.out.println("开始发送文件:" + filePath);  
                File file = new File(filePath); 
                                
                if(createConnection1()){  
                    int bufferSize = 8192;  
                    byte[] buf = new byte[bufferSize];  
                    try {  
                        DataInputStream fis = new DataInputStream(new BufferedInputStream(new FileInputStream(filePath)));  
                        DataOutputStream dos = new DataOutputStream(socket.getOutputStream()); 
                        
                        DataInputStream dis = new DataInputStream(socket.getInputStream());
                          
                        dos.writeUTF(file.getName());  
                        dos.flush();  
                        dos.writeLong(file.length());  
                        dos.flush();  
                          
                        String marklength= dis.readUTF();
                        if("noexsits".equals(marklength)){
                        	System.out.println("文件["+file.getName()+"]直接传输!");
                        	int num = 0;
                        	long numlth =0;
                        	while((num=fis.read(buf))!=-1){
                        		dos.write(buf,0,num);
                        		dos.flush();
                        		numlth+=num;
                        		System.out.println("文件["+file.getName()+"]已传送"+numlth*100L/file.length()+"%");
                        	}
                        	dos.flush();
                        	this.socket.shutdownOutput();
                        	String record = dis.readUTF();
                        	System.out.println("文件["+file.getName()+"]传输结束1:"+record);
                        }else{
                        	System.out.println("读取服务器端["+file.getName()+"]文件长度!");
                        	long serlth = Long.parseLong(marklength);
                        	RandomAccessFile raf = new RandomAccessFile(filePath,"r");
                        	raf.skipBytes((int)serlth);
                        	int serstart =0;
                        	
                        	while((serstart=raf.read(buf))!=-1){
                        		dos.write(buf,0,serstart);
                        		dos.flush();
                        		serlth+=serstart;
                        		System.out.println("文件["+file.getName()+"]已传送"+serlth*100L/file.length()+"%");
                        	}
                        	dos.flush();
                        	raf.close();
                        	this.socket.shutdownOutput();
                        	String record = dis.readUTF();
                        	System.out.println("文件["+file.getName()+"]传输结束2:"+record);
                        }
                       
                       fis.close();  
                       dos.close();  
                       dis.close();
                       socket.close();  
                       System.out.println("文件 " + filePath + "传输完成!");  
                    } catch (Exception e) {  
                        e.printStackTrace();  
                    }  
                }  
            }  
              
            private boolean createConnection1() {  
                try {  
                    socket = new Socket(ip, port);  
                    System.out.println("连接服务器成功！");  
                    return true;  
                } catch (Exception e) {  
                    System.out.println("连接服务器失败！");  
                    return false;  
                }   
            }  
              
        };  
    }  
      
    public static void main(String[] args){  
        //new BreakpointsResumeUploadClient("c:\\temp\\aaa.rar").service();  
    }
}
