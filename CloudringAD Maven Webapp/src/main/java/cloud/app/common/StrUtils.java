package cloud.app.common;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.imageio.ImageIO;

import org.apache.commons.configuration.Configuration;
import org.apache.commons.configuration.ConfigurationException;
import org.apache.commons.configuration.PropertiesConfiguration;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.math.NumberUtils;

public class StrUtils {
	private static final SimpleDateFormat sf = new SimpleDateFormat("yyyyMMddHHmmss");
	private static final SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
	
	private static Configuration config = null;
	
	public static synchronized Configuration getConfiguration(){
		if(config == null){
			try {
				config = new PropertiesConfiguration("utils.properties");
			} catch (ConfigurationException e) {
				e.printStackTrace();
			}
		}

		return config;
	}
	
	public static String getValue(String key){
		return StrUtils.getConfiguration().getString(key, "");
	}
	 
	
	public static String convertDateToString(Date date) {
		return sf.format(date);
	}
	
	public static String getMessage(String no, String errno, String errmsg, String sid){
		return "{\"no\":\""+no+"\",\"errno\":\""+errno+"\",\"errmsg\":\""+errmsg+"\",\"sid\":\""+sid+"\"}";
	}
	public static String getMessage(String no, String errno){
		return "{\"no\":\""+no+"\",\"errno\":\""+errno+"\"}";
	}
	
	/**
	 * 获得左边正确的汉字
	 * 
	 * @param source
	 *            原始字符串
	 * @param maxByteLen
	 *            截取的字节数
	 * @param flag
	 *            表示处理汉字的方式。1表示遇到半个汉字时补全，-1表示遇到半个汉字时舍
	 */
	public static String leftStr(String source, int maxByteLen, int flag) {
		if (source == null || maxByteLen <= 0) {
			return "";
		}
		byte[] bStr = source.getBytes();
		if (maxByteLen >= bStr.length)
			return source;
		String cStr = new String(bStr, maxByteLen - 1, 2);
		if (cStr.length() == 1 && source.contains(cStr)) {
			maxByteLen += flag;
		}
		return new String(bStr, 0, maxByteLen);
	}

	/**
	 * 补齐开始日期到秒.使其格式为YYYY-MM-DD HH24:MI:SS
	 * 
	 * @param ksrq
	 * @return String
	 */
	public static String KsrqString(String ksrq) {
		String newKsrq = "";
		// 形参字符串长度
		Integer Stringlength = ksrq.trim().length();
		switch (Stringlength) {
		case 10:
			newKsrq = ksrq + " 00:00:00";
			break;
		case 13:
			newKsrq = ksrq + ":00:00";
			break;
		case 16:
			newKsrq = ksrq + ":00";
			break;
		default:
			newKsrq = ksrq;
			break;
		}
		return newKsrq;
	}

	/**
	 * 补齐结束日期到秒.使其格式为YYYY-MM-DD HH24:MI:SS
	 * 
	 * @param ksrq
	 * @return String
	 */
	public static String JsrqString(String jsrq) {
		String newJsrq = "";
		// 形参字符串长度
		Integer Stringlength = jsrq.trim().length();
		switch (Stringlength) {
		case 10:
			newJsrq = jsrq + " 23:59:59";
			break;
		case 13:
			newJsrq = jsrq + ":59:59";
			break;
		case 16:
			newJsrq = jsrq + ":59";
			break;
		default:
			newJsrq = jsrq;
			break;
		}
		return newJsrq;
	}

	// 返回中文的首字母
	public static String getPinYinHeadChar(String str) {
		return "";
	}

	/**
	 * 是否全部是汉字
	 */
	public static boolean isChinese(String s) {
		Pattern p1 = Pattern.compile("^[\u4e00-\u9fa5]+$");
		Matcher m1 = p1.matcher(s);
		return m1.find();
	}

	/**
	 * 是否汉字
	 * 
	 * @param c
	 * @return
	 */
	public static boolean isChinese(char c) {
		return (c + "").matches("[\u4E00-\u9FA5]");
	}

	/**
	 * 将中文转换成拼音
	 * 
	 * @param zhongwen
	 * @return
	 */
	public static String mhPingying(String zhongwen) {
		return null;
	}

	/*
	 * 替换XML中不能有的特殊字符
	 */
	public static String toXmlFormat(String s) {
		// &lt; < 小于号
		// &gt; > 大于号
		// &amp; & 和,与
		// &apos; ' 单引号
		// &quot; " 双引号
		s = Replace(s, "&", "&amp;");
		s = Replace(s, "<", "&lt;");
		s = Replace(s, ">", "&gt;");
		s = Replace(s, "'", "&apos;");
		s = Replace(s, "\\\"", "&quot;");
		return s;
	}

	/**
	 * 判断字符串是否全数字
	 * 
	 * @param validString
	 * @return
	 */
	public static boolean isDigit(String validString) {
		if (validString == null)
			return false;
		byte[] tempbyte = validString.getBytes();
		for (int i = 0; i < validString.length(); i++) {
			// by=tempbyte[i];
			if ((tempbyte[i] < 48) || (tempbyte[i] > 57)) {
				return false;
			}
		}
		return true;
	}

	/**
	 * 
	 * @param source
	 * @param oldString
	 * @param newString
	 * @return
	 */
	public static String Replace(String source, String oldString, String newString) {
		if (source == null)
			return null;
		StringBuffer output = new StringBuffer();
		int lengOfsource = source.length();
		int lengOfold = oldString.length();
		int posStart = 0;
		int pos;
		while ((pos = source.indexOf(oldString, posStart)) >= 0) {
			output.append(source.substring(posStart, pos));
			output.append(newString);
			posStart = pos + lengOfold;
		}
		if (posStart < lengOfsource) {
			output.append(source.substring(posStart));
		}
		return output.toString();
	}

	/**
	 * 将传入的以','的字符串分解成SQL语句中的IN（'',''）能查询的语句；
	 * 
	 * @param source
	 *            原始字符串
	 * @return '','' 字符串
	 */
	public static String getStringToSqlIn(String source) {
		String stmp = "";
		if (StringUtils.isBlank(source)) {
			return source;
		}
		try {
			source = source.replaceAll("，", ",");
			source = source.replaceAll(",", ",");
			source = source.replaceAll("，", ",");
			source = source.replaceAll("，", ",");
			stmp = source + ",";
			String[] str = stmp.split(",");
			for (int i = 0; i < str.length; i++) {
				if (i == 0) {
					stmp = "'" + str[i].trim() + "'";
				} else {
					stmp = stmp + ",'" + str[i].trim() + "'";
				}
			}
		} catch (Exception e) {
			return source;
		}
		return stmp;
	}

	/**
	 * 
	 * @param s
	 * @return
	 */
	public static String toHtml(String s) {
		s = Replace(s, "&", "&amp;");
		s = Replace(s, "<", "&lt;");
		s = Replace(s, ">", "&gt;");
		s = Replace(s, "\t", "&nbsp;&nbsp;&nbsp;&nbsp;");
		s = Replace(s, "\r\n", "\n");
		// s = Replace(s,"\"","'");
		s = Replace(s, "\n", "<br>");
		s = Replace(s, "  ", "&nbsp;&nbsp;");
		// s = Replace(s,"","'");
		s = Replace(s, "'", "&#39;");
		s = Replace(s, "\\", "&#92;");
		return s;
	}

	public static String replaceHz(String source, String des) {
		if (StringUtils.isNotBlank(source)) {
			String regEx = "[\\W]";
			Pattern pat = Pattern.compile(regEx, Pattern.CASE_INSENSITIVE);
			Matcher mat = pat.matcher(source);
			String s = mat.replaceAll(des);
			return s;
		}
		return "";
	}

	/**
	 * ip转换为数字
	 * 
	 * @param ip
	 * @return
	 */
	public static long Ip2num(String ip) {
		long ip2l = 0;
		if (StringUtils.isNotBlank(ip)) {
			String[] ips = ip.split("\\.");
			if (ips.length == 4) {
				ip2l += NumberUtils.toLong(ips[0]) * Math.pow(256, 3);
				ip2l += NumberUtils.toLong(ips[1]) * Math.pow(256, 2);
				ip2l += NumberUtils.toLong(ips[2]) * Math.pow(256, 1);
				ip2l += NumberUtils.toLong(ips[3]);
			}
		}
		return ip2l;
	}

	
	
	/**
	 * 去String空格
	 */
	public static String clearNullString(String string){
		if (StringUtils.isNotBlank(string)) {
			String[] strings = string.split(",");
			String string2 = "";
			for(String string3:strings){
				string2 += string3.trim()+",";
			}
			return string2.substring(0,string2.length()-1);
		}
		return "";
	}
	
	/**
	 * 替换String
	 * @param string 要替换的String
	 * @param oldString
	 * 				要替换的字符
	 * @param newString
	 * 				替换后的字符
	 * @return
	 */
	public static String replaceString(String string,String oldString,String newString){
		String strString = "";
		if (StringUtils.isNotBlank(string)) {
			strString = string.replace(oldString, newString);
			if ("1900-01-01 00:00:00".equals(strString) || "0001-01-01 00:00:00".equals(strString)) {
				return "";
			}
		}
		return strString;
	}
	
	/**
	 * 验证手机号
	 * @param str
	 * @return
	 */
	public static boolean isPhone(String str){
		if(StringUtils.isBlank(str)){
			return false;
		}
		String regExp = "^[1]([35874]{1})[0-9]{9}$";  
		
		//String regExp = "^[1]([3][0-9]{1}|59|58|88|89|86)[0-9]{8}$";  
		Pattern p = Pattern.compile(regExp);  
		Matcher m = p.matcher(str);  
		return m.find();
	}
	
	/**
	 * 验证E_MAIL
	 * @param str
	 * @return
	 */
	public static boolean isEmail(String str){
		if(StringUtils.isBlank(str)){
			return false;
		}
		String regExp = "\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*";
		Pattern p = Pattern.compile(regExp);  
		Matcher m = p.matcher(str);  
		return m.find();
	}
	
	/**
	 * 去除字符串末尾指定字符
	 * @param str
	 * @param restr
	 * @return
	 */
	public static String replaceRight(String str,String restr){
		while (str!=null&&str.length()>0&&str.substring(str.length()-1, str.length()).equals(restr)) {
			str = str.substring(0,str.length()-1);
		}
		return str;
	}

	public static String getUUID(){
		return UUID.randomUUID().toString().replace("-", "");
	}
	/**
	 * 字符串转换成date
	 * @param str
	 * @return
	 */
	public static Date StrToDate(String str) {	  
	   Date date = null;
	   try {
		   if(str.length()>8){
			   date = sf.parse(str);  
		   }else{
			   date = sdf.parse(str);
		   }
	    
	   } catch (ParseException e) {
	    e.printStackTrace();
	   }
	   return date;
		}
	
    public static void main(String[] args) throws FileNotFoundException, IOException {  
    	
    	String user = StrUtils.getValue("user");
    	System.out.println(user);
    	
    	/**
        File picture = new File("E:/apache-tomcat-6.0.41/webapps/cxfile/upload/IMG_20140918_153136.jpg");  
        BufferedImage sourceImg =ImageIO.read(new FileInputStream(picture));   
        System.out.println(String.format("%.1f",picture.length()/1024.0));  
        System.out.println(sourceImg.getWidth());  
        System.out.println(sourceImg.getHeight()); 
        */
    }  
}
