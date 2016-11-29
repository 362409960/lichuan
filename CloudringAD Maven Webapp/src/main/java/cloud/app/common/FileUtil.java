package cloud.app.common;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintStream;
import java.text.SimpleDateFormat;
import java.util.Date;

public class FileUtil {
	

	/**
	 *
	 * @return
	 * @throws MalformedURLException 
	 */
	public static String getFilePath(String fileName)  {
		String tempdir;
		String nowpath;
		nowpath = System.getProperty("user.dir");
		tempdir = nowpath.replace("bin", "webapps");
		String dir = "";
		if(tempdir.indexOf("eclipse")>=0){
			dir = "D:\\Tomcat7\\webapps";
		}else{
			dir = tempdir;
		}
		return dir + File.separator +"CloudringAD"+File.separator+ fileName; 
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
		String strURL=Thread.currentThread().getContextClassLoader().getResource("").toString();
		String system=PropertiesUtils.getInstance().getValue("system");
		String osname = System.getProperty("os.name");
		
		if (osname.compareToIgnoreCase("linux")==0){
			strURL = strURL.substring(strURL.indexOf( "/" ) ,strURL.lastIndexOf( "/"+system )).replace("/", File.separator);
		}else
		{
			strURL = strURL.substring(strURL.indexOf( "/" ) + 1,strURL.lastIndexOf( "/"+system )).replace("/", File.separator);
		}
		
		
		String dir = "";
		if(tempdir.indexOf("eclipse")>=0){
			dir = "D:\\Tomcat7\\webapps";
		}else{
			dir = strURL;
		}
	
		return dir + File.separator + fileType + File.separator + "upload"  ; 
	}
	
	
	/**
	 * 获取附件存储路径
	 * @return
	 * @throws MalformedURLException 
	 */
	public static String getZipFilePath(String fileType,String userId)  {
		String tempdir;
		String nowpath;
		
		nowpath = System.getProperty("user.dir");
		tempdir = nowpath.replace("bin", "webapps");
		
		String dir = "";
		if(tempdir.indexOf("eclipse")>=0){
			dir = "D:\\Tomcat7\\webapps";
		}else{
			dir = tempdir;
		}
	
		return dir + File.separator + fileType + File.separator +userId  ; 
	}
	//生成一个文件来保存服务端需要保持的东西。
	
	public static void createFolder(String file) {
			File f = new File(file);
			if (!f.exists()) {
				f.mkdirs();
			}
		}
	//生成一文件
	public static void createFile(String dirFile, String srcFile) {
		 File f=new File(dirFile);
		 if(!f.exists()){
			 try {
				f.createNewFile();
			} catch (IOException e) {				
				e.printStackTrace();
			}
		 }
		 try {
			FileInputStream is=new FileInputStream(srcFile);
			FileOutputStream os=new FileOutputStream(f);
			byte[] buff=new byte[2048];
			int len=0;
			try {
				while((len=is.read(buff))!=-1){					
					os.write(buff,0,len);
				}
				
			} catch (IOException e) {				
				e.printStackTrace();
			}
			finally{
				try {
					is.close();
				} catch (IOException e) {					
					e.printStackTrace();
				}
				try {
					os.close();
				} catch (IOException e) {					
					e.printStackTrace();
				}
			}
		} catch (FileNotFoundException e) {		
			e.printStackTrace();
		}
	}
	/**
	 * 
	 * @param originDirectory 源路径File实例
	 * @param targetDirectory 目标路径File实例
	 */
	public static void copy(String originDirectory, String targetDirectory) {
		File origindirectory = new File(originDirectory); // 源路径File实例
		File targetdirectory = new File(targetDirectory); // 目标路径File实例
		if (!origindirectory.isDirectory() || !targetdirectory.isDirectory()) { // 判断是不是正确的路径
			System.out.println("不是正确的目录！");
			return;
		}
		File[] fileList = origindirectory.listFiles(); // 目录中的所有文件
		for (File file : fileList) {
			if (!file.isFile()) // 判断是不是文件
				continue;
			System.out.println(file.getName());
			try {
				FileInputStream fin = new FileInputStream(file);
				BufferedInputStream bin = new BufferedInputStream(fin);
				PrintStream pout = new PrintStream(
						targetdirectory.getAbsolutePath() + "/"
								+ file.getName());
				BufferedOutputStream bout = new BufferedOutputStream(pout);
				int total = bin.available(); // 文件的总大小
				int percent = total / 100; // 文件总量的百分之一
				int count;
				while ((count = bin.available()) != 0) {
					int c = bin.read(); // 从输入流中读一个字节
					bout.write((char) c); // 将字节（字符）写到输出流中

					if (((total - count) % percent) == 0) {
						double d = (double) (total - count) / total; // 必须强制转换成double
						System.out.println(Math.round(d * 100) + "%"); // 输出百分比进度
					}
				}
				bout.close();
				pout.close();
				bin.close();
				fin.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		System.out.println("End");
	}

	/**
	 * 返回最上文件路径
	 * @param fileName
	 */
	public static String copyPublic(String fileName){
		//js
		String srcFileJs=FileUtil.getFilePath("js"+File.separator+"sys");
		String folderJs=FileUtil.getSaveAttachmentFilePath(Constants.CLOUD_FILE_FILE)+File.separator+fileName+File.separator+"js";
		FileUtil.createFolder(folderJs);
		FileUtil.copy(srcFileJs, folderJs);
		FileUtil.createFolder(folderJs+File.separator+"clock");
		FileUtil.copy(srcFileJs+File.separator+"clock", folderJs+File.separator+"clock");
		//css
		String srcFilecss=FileUtil.getFilePath("css"+File.separator+"sys");
		String folderCss=FileUtil.getSaveAttachmentFilePath(Constants.CLOUD_FILE_FILE)+File.separator+fileName+File.separator+"css";
		FileUtil.createFolder(folderCss);
		FileUtil.copy(srcFilecss, folderCss);
		//layer
		String srcFileLay=FileUtil.getFilePath("css"+File.separator+"sys");
		String folderLay=FileUtil.getSaveAttachmentFilePath(Constants.CLOUD_FILE_FILE)+File.separator+fileName+File.separator+"layer";
		FileUtil.createFolder(folderLay);
		FileUtil.copy(srcFileLay, folderLay);
		//以下是根据数据库判断是否需要生产，这里就自动生成了
		//Images		
		String folderImages=FileUtil.getSaveAttachmentFilePath(Constants.CLOUD_FILE_FILE)+File.separator+fileName+File.separator+"Images";
		FileUtil.createFolder(folderImages);
		//Video
		String folderVideo=FileUtil.getSaveAttachmentFilePath(Constants.CLOUD_FILE_FILE)+File.separator+fileName+File.separator+"Video";
		FileUtil.createFolder(folderVideo);
		//SceneImages
		String folderSceneImages=FileUtil.getSaveAttachmentFilePath(Constants.CLOUD_FILE_FILE)+File.separator+fileName+File.separator+"SceneImages";
		FileUtil.createFolder(folderSceneImages);
		//music
		String folderMusic=FileUtil.getSaveAttachmentFilePath(Constants.CLOUD_FILE_FILE)+File.separator+fileName+File.separator+"Music";
		FileUtil.createFolder(folderMusic);
		//word
		String folderWord=FileUtil.getSaveAttachmentFilePath(Constants.CLOUD_FILE_FILE)+File.separator+fileName+File.separator+"Doc";
		FileUtil.createFolder(folderWord);
		
		return FileUtil.getSaveAttachmentFilePath(Constants.CLOUD_FILE_FILE)+File.separator+fileName;
	}
	
	/**
	 * 返回最上文件路径
	 * @param fileName
	 */
	public static String copyUpdatePublic(String fileName){		
		//以下是根据数据库判断是否需要生产，这里就自动生成了
		//Images		
		String folderImages=FileUtil.getSaveAttachmentFilePath(Constants.CLOUD_FILE_FILE)+File.separator+fileName+File.separator+"Images";
		FileUtil.createFolder(folderImages);
		//Video
		String folderVideo=FileUtil.getSaveAttachmentFilePath(Constants.CLOUD_FILE_FILE)+File.separator+fileName+File.separator+"Video";
		FileUtil.createFolder(folderVideo);		
		//music
		String folderMusic=FileUtil.getSaveAttachmentFilePath(Constants.CLOUD_FILE_FILE)+File.separator+fileName+File.separator+"Music";
		FileUtil.createFolder(folderMusic);
		//word
		String folderWord=FileUtil.getSaveAttachmentFilePath(Constants.CLOUD_FILE_FILE)+File.separator+fileName+File.separator+"Doc";
		FileUtil.createFolder(folderWord);
		
		return FileUtil.getSaveAttachmentFilePath(Constants.CLOUD_FILE_FILE)+File.separator+fileName;
	}
}
