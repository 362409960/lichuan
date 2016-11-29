package cloud.shop.controller;

import java.io.File;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import cloud.shop.common.Constants;
import cloud.shop.common.ImageUtil;

@Controller
@RequestMapping("/ck")
public class CkeditorUploadController {
	Logger logger = Logger.getLogger(this.getClass());
	
	@RequestMapping(value = "/upload.do") 
    public String upload(@RequestParam(value = "upload", required = false) MultipartFile file, HttpServletRequest request, HttpServletResponse response) throws Exception {
		 response.setContentType("text/html;charset=UTF-8");
		 response.setHeader("X-Frame-Options", "SAMEORIGIN");
        PrintWriter out = response.getWriter();
        String uploadContentType = file.getContentType();
        
        // CKEditor提交的很重要的一个参数  
        String callback = request.getParameter("CKEditorFuncNum");  
        String expandedName = ""; // 文件扩展名
        
        if (uploadContentType.equals("image/pjpeg") || uploadContentType.equals("image/jpeg")) {  
            // IE6上传jpg图片的headimageContentType是image/pjpeg，而IE9以及火狐上传的jpg图片是image/jpeg  
            expandedName = ".jpg";  
        } else if (uploadContentType.equals("image/png") || uploadContentType.equals("image/x-png")) {  
            // IE6上传的png图片的headimageContentType是"image/x-png"  
            expandedName = ".png";  
        } else if (uploadContentType.equals("image/gif")) {  
            expandedName = ".gif";  
        } else if (uploadContentType.equals("image/bmp")) {  
            expandedName = ".bmp";  
        } else {  
            out.println("<script type=\"text/javascript\">");  
            out.println("window.parent.CKEDITOR.tools.callFunction(" + callback  
                    + ",'','文件格式不正确（必须为.jpg/.gif/.bmp/.png文件）');");  
            out.println("</script>");
            out.flush();
            return null;
        }

        //cloudfile
        String uploadPath = ImageUtil.getSaveAttachmentFilePath(Constants.CLOUD_FILE);
        File uploadPathFile = new File(uploadPath);
        if(!uploadPathFile.exists()){
        	uploadPathFile.mkdir();
        }
        
        String fileName = java.util.UUID.randomUUID().toString().replace("-", ""); // 采用UUID的方式命名保证不会重复  
        fileName += expandedName;  
        File targetFile = new File(uploadPath, fileName);
        
        //保存  
        file.transferTo(targetFile);  
        
        //回传地址
        String tempImageUrl = uploadPath + File.separator + fileName;
        logger.info("回传地址前: "+tempImageUrl);

        String imageUrl =  this.getUrl(tempImageUrl).replace("\\", "/");

        logger.info("回传地址后: "+imageUrl); 
        
        logger.info(callback+"     "+imageUrl);
        
        // 返回“图像”选项卡并显示图片  
        out.println("<script type=\"text/javascript\">");  
        out.println("window.parent.CKEDITOR.tools.callFunction(" + callback  
                + ",'" + imageUrl + "','')"); // 相对路径用于显示图片  
        out.println("</script>");
        out.flush();
        return null;
    }
	
	private String getUrl(String imageUrl){
		int num = imageUrl.indexOf("webapps");
		return imageUrl.substring(num+7, imageUrl.length());
	}
	
}
