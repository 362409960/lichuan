package cloud.app.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import net.sf.json.JSONObject;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;




import cloud.app.vo.Progress;



/**
 * 
 * 功能描述： 获取上传文件进度controller
 *
 */
@Controller
@RequestMapping("/file")
public class ProgressController {
	Logger logger = Logger.getLogger(this.getClass());

	@RequestMapping(value = "/progress")	
	public void progress(HttpServletRequest request,HttpServletResponse response) {
		Progress status = (Progress) request.getSession().getAttribute("upload_ps");
		JSONObject jsonObject = new JSONObject();
		if(status==null){
			jsonObject.put("json", "{}");  
		}else{
			 JSONObject json = JSONObject.fromObject(status);
		}
	    PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			logger.debug(e);
		}	
		out.print(net.sf.json.JSONArray.fromObject(status));
		out.flush();
		out.close();
	}
	

}