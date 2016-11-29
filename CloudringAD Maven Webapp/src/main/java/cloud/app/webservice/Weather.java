package cloud.app.webservice;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.Calendar;

import org.apache.log4j.Logger;




import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;

public class Weather {
	 static Logger logger = Logger.getLogger(Weather.class);
	
	public static String request(String httpUrl, String httpArg) {
	    BufferedReader reader = null;
	    String result = null;
	    StringBuffer sbf = new StringBuffer();
	    httpUrl = httpUrl + "?" + httpArg;
	   
	    try {
	        URL url = new URL(httpUrl);
	        HttpURLConnection connection = (HttpURLConnection) url
	                .openConnection();
	        connection.setRequestMethod("GET");			      
	        connection.connect();
	        InputStream is = connection.getInputStream();
	        reader = new BufferedReader(new InputStreamReader(is, "UTF-8"));
	        String strRead = null;
	        while ((strRead = reader.readLine()) != null) {
	            sbf.append(strRead);
	            sbf.append("\r\n");
	        }
	        reader.close();
	        result = sbf.toString();
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return result;
	}
     
	/**
	 * 通过ip判断城市，
	 * @param ip
	 * @param searchCity
	 * @return
	 */
	public static String resolveIpJons(String ip,String searchCity){
		String httpUrl="http://api.map.baidu.com/location/ip";
		 String httpArg="ip="+ip+"&ak=7ts3piTEH83SwFWfgdVG7hbIlyx31oPG";
		 String jsonResult = request(httpUrl, httpArg);
		 JSONObject jsonOject = (JSONObject)JSON.parse(jsonResult);	
		 String content = jsonOject.getString("content");
		 String city=null;
		 if(null==content){
			 city=searchCity;
		 }else{
			 JSONObject jsonOject1 = (JSONObject)JSON.parse(content);	
			 String address_detail=jsonOject1.getString("address_detail");
			 JSONObject json = (JSONObject)JSON.parse(address_detail);
			 city=json.getString("city");
			 if("".equals(city)){
				 city=searchCity;
			 }else{
				 city=city.substring(0, city.length()-1);//例如深圳市，后面的市去掉，变成深圳
			 }
		 }
		 
		return city;
	}
	/**
	 * 通过城市判断天气,以json格式返回
	 * @param city
	 * @return
	 */
	public static String resolveWeatherJons(String city){
		 String httpUrl="http://api.map.baidu.com/telematics/v3/weather"; 
		 String httpArg=null;
		try {
			httpArg = "location="+URLEncoder.encode(city, "utf-8")+"&output=json&ak=7ts3piTEH83SwFWfgdVG7hbIlyx31oPG";
		} catch (UnsupportedEncodingException e) {			
			logger.debug(e);
		}
		 String jsonResult = request(httpUrl, httpArg);
		 JSONObject jsonOject = (JSONObject)JSON.parse(jsonResult);
	    JSONArray results=jsonOject.getJSONArray("results"); 	  
        JSONObject results0=results.getJSONObject(0);  
        String location = results0.getString("currentCity");//城市
        JSONArray weather_data = results0.getJSONArray("weather_data");
        JSONObject results1=weather_data.getJSONObject(0);  
        String dayPictureUrl = results1.getString("dayPictureUrl");//白天天气图片
        String nightPictureUrl = results1.getString("nightPictureUrl");//晚上天气图片
        String url=null;
        if(getDateIsDayOfNight()==true){
        	url=dayPictureUrl;
        }else{
        	url=nightPictureUrl;
        }
        String weather = results1.getString("weather");//天气
        String temperature = results1.getString("temperature");//温度区间
        return "{\"no\":\"101\",\"weather\":\""+weather+"\",\"temperature\":\""+temperature+"\",\"location\":\""+location+"\",\"url\":\""+url+"\"}";
	}
	
	public static boolean getDateIsDayOfNight() {
		Calendar cal = Calendar.getInstance();
		int hour = cal.get(Calendar.HOUR_OF_DAY);
		if (hour >= 6 && hour < 18) {
			return true;
		} else {
			return false;
		}
	}

}
