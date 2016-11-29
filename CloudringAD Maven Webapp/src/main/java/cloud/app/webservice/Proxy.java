package cloud.app.webservice;

import java.io.PrintWriter;

import java.text.SimpleDateFormat;

import java.util.Calendar;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.Context;


import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;

import org.springframework.stereotype.Component;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;


import cloud.app.common.Constants;
import cloud.app.common.EsbWebExecutionContext;
import cloud.app.common.IPUtils;
import cloud.app.common.StrUtils;


 

@Component
@Path("/")
public class Proxy {
   Logger logger = Logger.getLogger(this.getClass());
   
   private SimpleDateFormat sf = new SimpleDateFormat("yyyyMMddHHmmss");   
   
	
 
	@GET
	@Path("/")
	public void excuteGet(@QueryParam(value = "param") String params, @Context HttpServletRequest request, @Context HttpServletResponse response) throws Exception {
		System.out.println("get start...");
		this.exe(params, "get", request, response);
	}

	@POST
	@Path("/")
	public void excutePost(@QueryParam(value = "param") String param,@Context HttpServletRequest request, @Context HttpServletResponse response) throws Exception {
		System.out.println("post start...");
		this.exe(param, "post", request, response);
	}

	public void exe(String param, String method, HttpServletRequest request, HttpServletResponse response ) throws Exception{		
		String no = "";
		String message = "";		
		PrintWriter out = null;
		long s = System.currentTimeMillis();
		response.setContentType("text/html;charset=utf-8"); // 指定输出内容类型和编码
		try{
			//String params = IOUtils.toString(request.getInputStream(), "utf-8");	
			String params=request.getParameter("params");
			String callback=request.getParameter("callback");
			request.setCharacterEncoding(Constants.ENCODING);
			response.setCharacterEncoding(Constants.ENCODING);
			if(StringUtils.isBlank(params) || StringUtils.isEmpty(params)){
				out.write(StrUtils.getMessage("0", "-5", "参数为空", "0"));
				out.flush();
				return;
			}

			//用alibaba的json包来处理json串
			JSONObject jsonOject = (JSONObject)JSON.parse(params);
			no = jsonOject.getString(Constants.JSON_KEY_NAME_NO);
			
			EsbWebExecutionContext ex = EsbWebExecutionContext.get();
			ex.setRequest(request);
			ex.setResponse(response);		
			if(no != null && !"".equals(no.trim())){
				switch (Integer.parseInt(no)) {
				    case 101:    //天气处理	
				    	String ip=IPUtils.getIpAddr(request);						
						String cityName=Weather.resolveIpJons(ip, "深圳");					
						message=Weather.resolveWeatherJons(cityName);			    
				    	break;				    
				default :
					break;
				}
			}else{
				message = err("false", -100);
			}

			logger.info(String.format("返回客户端信息: %1$s", message));
			long e = System.currentTimeMillis();
			long tmp = e-s;
			logger.info("执行 "+no+" 接口花费："+tmp+" 毫秒");			
			out = response.getWriter();
			
			out.write(callback+"("+message+")");
			out.flush();
			
			
			
		}catch(Exception ex){
			if("-2".equals(ex.getMessage())){
				response.getWriter().write(err("false", -2));
				response.flushBuffer();
				ex.printStackTrace();
				logger.info(ex);
				logger.debug(ex);
			}else{
				response.getWriter().write(err("false", -100));
				response.flushBuffer();
				ex.printStackTrace();
				logger.info(ex);
				logger.debug(ex);
			}
			
		}finally{
			if(out != null){
				//out.close();
			}
		} 
	}

	private String err(String no, int errno){
		return "{\"no\":"+no+", \"result\":"+errno+", \"tm\":\""+sf.format(new Date())+"\"}";
	}
	
/**
   *求时间的前一天或下一天时间
   * @param date
   * @param day
   * @return
   */
  public static Date getDate(Date date,int day){
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		calendar.add(Calendar.DAY_OF_MONTH, day);
		Date date1 = new Date(calendar.getTimeInMillis());
		return date1;
	}
  
	 
	  
	 
	
}
