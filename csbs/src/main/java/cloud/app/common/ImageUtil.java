package cloud.app.common;

import java.awt.Graphics;
import java.awt.Image;
import java.awt.Rectangle;
import java.awt.image.BufferedImage;
import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.StringTokenizer;

import javax.imageio.ImageIO;
import javax.imageio.ImageReadParam;
import javax.imageio.ImageReader;
import javax.imageio.stream.ImageInputStream;
import org.apache.log4j.Logger;

import com.sun.image.codec.jpeg.JPEGCodec;
import com.sun.image.codec.jpeg.JPEGImageEncoder;

public class ImageUtil {
	private static Logger logger = Logger.getLogger(ImageUtil.class);
	private static SimpleDateFormat dirSf = new SimpleDateFormat("yyyyMMdd");

	public static void createDir(String path){
		String fg = File.separator;
		String osname = System.getProperty("os.name");
 
		StringTokenizer st = new StringTokenizer(path, fg);
		StringBuilder sb = new StringBuilder();
 
		if (osname.compareToIgnoreCase("linux")==0){
			sb.append(File.separator);
		}

	    while(st.hasMoreTokens()){
	    	sb.append(st.nextToken());
	    	File file = new File(sb.toString());
	    	if (!file.exists()){
	    		file.mkdir();
	    	}
	    	sb.append(File.separator);
	    }
	}
	
	
	public static String getWebappsPath(){
		String userDir = System.getProperty("user.dir");
		String tmp = userDir.replace("bin", "webapps");
		
		String dir = "";
		if(tmp.indexOf("eclipse")>=0){
			dir = tmp.replace("E:\\eclipse\\", "E:\\apache-tomcat-6.0.41\\webapps\\");
		}else{
			dir = tmp;
		}
		
		return dir;
	}

	/**
	 *  返回 路径
	 * @param filepath
	 * @return
	 */
	public static String path(String filePath){
		String s=filePath.substring(filePath.indexOf("cxfile")-1, filePath.length());
		
		//BgsysUtil bg= new BgsysUtil();
		//String p=bg.getValue("url");
		//return p+s;
		
		return s;
	}
	
	/**
	 * 获取附件存储路径
	 * @return
	 * @throws MalformedURLException 
	 */
	public static String getSaveAttachmentFilePath_xx(String fileType)  {
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
		return "upload"+ File.separator + fileType+File.separator+date ; 
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
		return dir + File.separator + fileType + File.separator + "upload" +File.separator+date ; 
	}
	
	public BufferedImage getWidthAndHeight(String filePath) throws FileNotFoundException, IOException{
        File picture = new File(filePath);  
        BufferedImage sourceImg =ImageIO.read(new FileInputStream(picture));        
        return sourceImg;
	}
	
	public static void reBuildImage(File srcImageFile,String dstImageFileName, int width, int height) throws Exception {
        FileOutputStream fileOutputStream = null;
        JPEGImageEncoder encoder = null;
        BufferedImage tagImage = null;
        Image srcImage = null;
        try{
            srcImage = ImageIO.read(srcImageFile);        	
            int srcWidth = srcImage.getWidth(null);//原图片宽度
            int srcHeight = srcImage.getHeight(null);//原图片高度
            int dstMaxSize = height;//目标缩略图的最大宽度/高度，宽度与高度将按比例缩写
            int dstWidth = width;//缩略图宽度
            int dstHeight = height;//缩略图高度
            float scale = 0;
            //计算缩略图的宽和高
            if(srcWidth>dstMaxSize){
                dstWidth = dstMaxSize;
                scale = (float)srcWidth/(float)dstMaxSize;
                dstHeight = Math.round((float)srcHeight/scale);
            }
            srcHeight = dstHeight;
            if(srcHeight>dstMaxSize){
                dstHeight = dstMaxSize;
                scale = (float)srcHeight/(float)dstMaxSize;
                dstWidth = Math.round((float)dstWidth/scale);
            }
            //生成缩略图
            tagImage = new BufferedImage(dstWidth,dstHeight,BufferedImage.TYPE_INT_RGB);
            tagImage.getGraphics().drawImage(srcImage,0,0,dstWidth,dstHeight,null);
            fileOutputStream = new FileOutputStream(dstImageFileName);
            encoder = JPEGCodec.createJPEGEncoder(fileOutputStream);
            encoder.encode(tagImage);
            fileOutputStream.close();
            fileOutputStream = null;
        }finally{
            if(fileOutputStream!=null){
                try{
                    fileOutputStream.close();
                }catch(Exception e){
                }
                fileOutputStream = null;
            }
            encoder = null;
            tagImage = null;
            srcImage = null;
            System.gc();
        }
    }
	
	/**
	 * 压缩后的高度
	 * @param srcImageFile 原图
	 * @param dstImageFileName 目标图片
	 * @param width 目标图片的宽度
	 * @param height 目标图片的高度
	 * @throws Exception
	 */
	public static void makeSmallImage(File srcImageFile, String dstImageFileName, int width, int height) throws Exception {

		try{
			File tempFile = new File(srcImageFile.getName());
			
			ImageUtil.readUsingImageReader(srcImageFile, tempFile);
			ImageUtil.reBuildImage(tempFile, dstImageFileName, width, height);

			tempFile.delete();            
		}catch(Exception ex){
			ex.printStackTrace();
		}
	}

	/**
	 * 压缩后的高度
	 * @param src 原图
	 * @param dest 目标图片
	 * @param w 目标图片的宽度
	 * @param h 目标图片的高度
	 * @throws Exception
	 */
	public static void makeSmallImage_1(File srcImageFile, String dstImageFileName, int w, int h) throws Exception {
		Image srcImage = null;
		BufferedImage  tempDestImage = null;  //临时截取的图片缓存图
		int cutLength = 0;
		
		try{
			srcImage = ImageIO.read(srcImageFile);
            int srcWidth = srcImage.getWidth(null);//原图片宽度
            int srcHeight = srcImage.getHeight(null);//原图片高度
            int tempSize = srcWidth;
            int tempX = 0;
            int tempY = 0;
            //如果高>宽，那么截取高度，形成一个正方形,上下截取的高度为 (srcHeight - srcWidth)/2
            if(srcHeight > srcWidth){
            	cutLength = (srcHeight - srcWidth)/2;
            	tempY = cutLength;
            }else if(srcHeight<srcWidth){
            	cutLength = (srcWidth - srcHeight)/2;
            	tempSize = srcHeight;
            	tempX = cutLength;
            }
            
            tempDestImage = new BufferedImage(tempSize, tempSize, BufferedImage.TYPE_INT_RGB);
            Graphics graphics = tempDestImage.getGraphics();
            graphics.drawImage(srcImage, tempX, tempY, tempSize, tempSize, null);
            
            File tempFile = new File(srcImageFile.getName());
            ImageIO.write(tempDestImage, "jpg", tempFile); 
            
            ImageUtil.reBuildImage(tempFile, dstImageFileName, w, h);
            
            tempFile.delete();
            
		}catch(Exception ex){
			ex.printStackTrace();
		}finally{
			tempDestImage = null;
            srcImage = null;
            System.gc();
		}
	}
	
	
    /**
     * 生成缩略图
     * @param srcImageFile 源图片文件的File实例      File file = new File("文件名");
     * @param dstImageFileName 待生成的缩略图片完整路径(生成的格式为：image/jpeg);200 *200
     * @throws Exception
     */
    public static void makeSmallImage_old(File srcImageFile,String dstImageFileName) throws Exception {
        FileOutputStream fileOutputStream = null;
        JPEGImageEncoder encoder = null;
        BufferedImage tagImage = null;
        Image srcImage = null;
        try{
            srcImage = ImageIO.read(srcImageFile);
            int srcWidth = srcImage.getWidth(null);//原图片宽度
            int srcHeight = srcImage.getHeight(null);//原图片高度
            int dstMaxSize = 200;//目标缩略图的最大宽度/高度，宽度与高度将按比例缩写
            int dstWidth = srcWidth;//缩略图宽度
            int dstHeight = srcHeight;//缩略图高度
            float scale = 0;
            //计算缩略图的宽和高
            if(srcWidth>dstMaxSize){
                dstWidth = dstMaxSize;
                scale = (float)srcWidth/(float)dstMaxSize;
                dstHeight = Math.round((float)srcHeight/scale);
            }
            srcHeight = dstHeight;
            if(srcHeight>dstMaxSize){
                dstHeight = dstMaxSize;
                scale = (float)srcHeight/(float)dstMaxSize;
                dstWidth = Math.round((float)dstWidth/scale);
            }
            //生成缩略图
            tagImage = new BufferedImage(dstWidth,dstHeight,BufferedImage.TYPE_INT_RGB);
            tagImage.getGraphics().drawImage(srcImage,0,0,dstWidth,dstHeight,null);
            fileOutputStream = new FileOutputStream(dstImageFileName);
            encoder = JPEGCodec.createJPEGEncoder(fileOutputStream);
            encoder.encode(tagImage);
            fileOutputStream.close();
            fileOutputStream = null;
        }finally{
            if(fileOutputStream!=null){
                try{
                    fileOutputStream.close();
                }catch(Exception e){
                }
                fileOutputStream = null;
            }
            encoder = null;
            tagImage = null;
            srcImage = null;
            System.gc();
        }
    }
    
    
    //压缩图片为一个正方形(取最小的边)
	public static void readUsingImageReader(File src, File dest) throws Exception {
		ImageReader reader = null;
		BufferedImage bi = null;
		try{
			int cutLength = 0;
			
			// 取得图片读入器
			Iterator<ImageReader> readers = ImageIO.getImageReadersByFormatName("jpg");
			reader = (ImageReader) readers.next();
			// 取得图片读入流
			InputStream source = new FileInputStream(src);
			ImageInputStream iis = ImageIO.createImageInputStream(source);
			reader.setInput(iis, true);

			int srcWidth = reader.getWidth(0);
			int srcHeight = reader.getHeight(0);
			int tempSize = srcWidth;
			int startX = 0;
			int startY = 0;
	        //如果高>宽，那么截取高度，形成一个正方形,上下截取的高度为 (srcHeight - srcWidth)/2
	        if(srcHeight > srcWidth){
	            cutLength = (srcHeight - srcWidth)/2;
	            startY = cutLength;
	        }else if(srcHeight<srcWidth){
	            cutLength = (srcWidth - srcHeight)/2;
	            tempSize = srcHeight;
	            startX = cutLength;
	        }
	        
			// 图片参数
			ImageReadParam param = reader.getDefaultReadParam();
			Rectangle rect = new Rectangle(startX, startY, tempSize, tempSize);
			param.setSourceRegion(rect);

			bi = reader.read(0, param);
			ImageIO.write(bi, "jpg", dest);
		}catch(Exception ex){
			ex.printStackTrace();
		}finally{
			reader = null;
			bi = null;
		}
		

	}

	public static byte[] readFile(String filename) throws Exception{
		BufferedInputStream bufferedInputStream = null;
		
		try{
		    File file =new File(filename);
		    if(filename==null || filename.equals(""))
		    {
		      throw new NullPointerException("无效的文件路径");
		    }
		    long len = file.length();
		    byte[] bytes = new byte[(int)len];

		    bufferedInputStream = new BufferedInputStream(new FileInputStream(file));
		    int r = bufferedInputStream.read( bytes );
		    if (r != len)
		      throw new IOException("读取文件不正确");
		    
		    return bytes;
		}catch(Exception ex){
			throw new Exception("读取文件不正确");
		}finally{
			if(bufferedInputStream != null){
			    bufferedInputStream.close();
			}
		}
		
	}

    
    
}
