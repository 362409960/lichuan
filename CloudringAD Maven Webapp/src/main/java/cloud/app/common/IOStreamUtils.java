package cloud.app.common;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Properties;

import org.apache.log4j.Logger;


public class IOStreamUtils {
	
	private static Logger logger = Logger.getLogger(IOStreamUtils.class);
	private static SimpleDateFormat dirSf = new SimpleDateFormat("yyyyMMdd");

	/**
	 * 把图片保存到相关的文件夹下。
	 * @param data
	 * @return
	 * @throws Exception
	 */
	public static String saveInputStreamImageToFolder(String path, String fileName, byte [] data)throws Exception{
		  //String expandedName = ".jpg"; // 文件扩展名
		  
		  String uploadPath = getSaveAttachmentFilePath(path);
		  
		  //String uploadPath = "D:\\Tomcat7\\webapps\\callback\\image\\20160413\\";
		  
	        File uploadPathFile = new File(uploadPath);
	        if(!uploadPathFile.exists()){
	        	uploadPathFile.mkdirs();
	        }
	        
	      String tempFileName = StrUtils.getUUID(); // 采用UUID的方式命名保证不会重复 
	      String expandedName = ".jpg";
	      
	      String[] expandes = fileName.split("\\.");
	      expandedName = expandes[expandes.length-1];
	      
	      tempFileName += "."+expandedName;  
	      //new一个文件对象用来保存图片，默认保存当前工程根目录  
	       File imageFile = new File(uploadPath, tempFileName);
	        
	        
	        
	        //byte[] data = readInputStream(inStream); 	       
	        //创建输出流  
	        FileOutputStream outStream = new FileOutputStream(imageFile);  
	        //写入数据  
	        outStream.write(data);  
	        //关闭输出流  
	        outStream.close(); 
	        
	        String tempImageUrl = uploadPath + File.separator + tempFileName;
	        String imageUrl =  getUrl(tempImageUrl).replace("\\", "/");
	        if(logger.isDebugEnabled()){
	        	logger.debug("回调的图片地址: "+imageUrl);
	        }
	        
	        return imageUrl;
	}
	

	/**
	 * 把图片保存到相关的文件夹下。
	 * @param data
	 * @return
	 * @throws Exception
	 */
	public static String saveInputStreamImageToFolder(String fileName, byte [] data)throws Exception{
		  //String expandedName = ".jpg"; // 文件扩展名
		  
		String uploadPath = getSaveAttachmentFilePath(Constants.CLOUD_IMAGE_FILE);
		//String uploadPath = "D:\\Tomcat7\\webapps\\callback\\image\\";
		  
	        File uploadPathFile = new File(uploadPath);
	        if(!uploadPathFile.exists()){
	        	uploadPathFile.mkdir();
	        }
	        
	      // String fileName = java.util.UUID.randomUUID().toString().replace("-", ""); // 采用UUID的方式命名保证不会重复  
	      //  fileName += expandedName;  
	      //new一个文件对象用来保存图片，默认保存当前工程根目录  
	        File imageFile = new File(uploadPath, fileName);
	        
	        //byte[] data = readInputStream(inStream); 	       
	        //创建输出流  
	        FileOutputStream outStream = new FileOutputStream(imageFile);  
	        //写入数据  
	        outStream.write(data);  
	        //关闭输出流  
	        outStream.close(); 
	        
	        String tempImageUrl = uploadPath + File.separator + fileName;
	        String imageUrl =  getUrl(tempImageUrl).replace("\\", "/");
	        return imageUrl;
	}
	
	/**
	 * 视频保存到相关的文件夹下。
	 * @param inStream
	 * @return
	 * @throws Exception
	 */
	public static void saveInputStreamVideoToFolder(String fileName,byte [] data)throws Exception{
		  //String expandedName = ".jpg"; // 文件扩展名
		  String uploadPath = getSaveAttachmentFilePath(Constants.CLOUD_VIDEO_FILE);
	        File uploadPathFile = new File(uploadPath);
	        if(!uploadPathFile.exists()){
	        	uploadPathFile.mkdir();
	        }
	        
	      // String fileName = java.util.UUID.randomUUID().toString().replace("-", ""); // 采用UUID的方式命名保证不会重复  
	      //  fileName += expandedName;  
	      //new一个文件对象用来保存图片，默认保存当前工程根目录  
	        File imageFile = new File(uploadPath, fileName);
	        
	      //  byte[] data = readInputStream(inStream); 	       
	        //创建输出流  
	        FileOutputStream outStream = new FileOutputStream(imageFile);  
	        //写入数据  
	        outStream.write(data);  
	        //关闭输出流  
	        outStream.close(); 
	}
	
	
	public static byte[] readInputStream(InputStream inStream) throws Exception{  
        ByteArrayOutputStream outStream = new ByteArrayOutputStream();  
        //创建一个Buffer字符串  
        byte[] buffer = new byte[1024];  
        //每次读取的字符串长度，如果为-1，代表全部读取完毕  
        int len = 0;  
        //使用一个输入流从buffer里把数据读取出来  
        while( (len=inStream.read(buffer)) != -1 ){  
            //用输出流往buffer里写入数据，中间参数代表从哪个位置开始读，len代表读取的长度  
            outStream.write(buffer, 0, len);  
        }  
        //关闭输入流  
        inStream.close();  
        //把outStream里的数据写入内存  
        return outStream.toByteArray();  
    }  
	
	
	/**
	 * 获取附件存储路径
	 * @return
	 * @throws MalformedURLException 
	 */
	public static String getSaveAttachmentFilePath(String fileType)  {
		String tempdir;
		String nowpath;
		
		nowpath = System.getProperty("user.dir");
		tempdir = nowpath.replace("bin", "webapps");
		
		logger.info("user.dir: "+nowpath +" tempdir: "+tempdir);
		
		String dir = "";
		if(tempdir.indexOf("eclipse")>=0){
			dir = "D:\\Tomcat7\\webapps";
		}else{
			dir = tempdir;
		}

		String date = dirSf.format(new Date());
		return dir + File.separator + fileType + File.separator + date ; 
	}
	
	
	public static Properties getPropertiesFile()
	{
		InputStream inputStream = ImageUtil.class.getClassLoader().getResourceAsStream("system.properties");  
        Properties p = new Properties();  
        try {  
            p.load(inputStream);  
            inputStream.close();  
        } catch (IOException e1) {  
            e1.printStackTrace();  
        }
		return p;  
	}

	@SuppressWarnings("unused")
	private static String getUrl(final String imageUrl){
		int num = imageUrl.indexOf("webapps");
		return imageUrl.substring(num+7, imageUrl.length());
	}
}
