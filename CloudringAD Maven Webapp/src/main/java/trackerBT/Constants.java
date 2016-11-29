package trackerBT;

import java.io.*;
import java.nio.charset.*;
import java.util.*;

import org.jdom.Document;
import org.jdom.Element;
import org.jdom.filter.ElementFilter;
import org.jdom.input.SAXBuilder;

 

public class Constants {
	public static final String DEFAULT_ENCODING = "UTF-8";
	public static final String BYTE_ENCODING = "ISO-8859-1";
	public static Charset BYTE_CHARSET;
	public static Charset DEFAULT_CHARSET;

	public static String trackerPath = "";
	
	static {
		try {

			BYTE_CHARSET = Charset.forName(Constants.BYTE_ENCODING);
			DEFAULT_CHARSET = Charset.forName(Constants.DEFAULT_ENCODING);

		} catch (Throwable e) {
		}
	}

	public static final String OSName = System.getProperty("os.name");

	public static final boolean isOSX = OSName.toLowerCase().startsWith("mac os");

	public static final boolean isLinux = OSName.equalsIgnoreCase("Linux");
	public static final boolean isSolaris = OSName.equalsIgnoreCase("SunOS");
	public static final boolean isFreeBSD = OSName.equalsIgnoreCase("FreeBSD");
	public static final boolean isWindowsXP = OSName.equalsIgnoreCase("Windows XP");
	public static final boolean isWindows95 = OSName.equalsIgnoreCase("Windows 95");
	public static final boolean isWindows98 = OSName.equalsIgnoreCase("Windows 98");
	public static final boolean isWindowsME = OSName.equalsIgnoreCase("Windows ME");
	public static final boolean isWindows9598ME = isWindows95 || isWindows98 || isWindowsME;
	public static final boolean isWindows = OSName.toLowerCase().startsWith("windows");

	public static final String JAVA_VERSION = System.getProperty("java.version");

	public static Map<String, String> configParam;

	public static Object get(String param) {
		return configParam.get(param);
	}
 
	public static void loadConfig(String config) {
		System.out.println("Constants loadConfig....");
		
		String name = "";
		String value = "";

		File configFile = new File(config);
		SAXBuilder sb = new SAXBuilder();
		HashMap<String, String> params = new HashMap<String, String>();
		if (configFile.exists()){
			try {
				Document conf = sb.build(configFile);
				Element root = conf.getRootElement();
				for (Iterator<Element> it = root.getDescendants(new ElementFilter("param")); it.hasNext();) {
					Element param = (Element) it.next();
					
					name = param.getAttribute("name").getValue();
					value = param.getAttribute("value").getValue();
					//不是文件路径，不需要加上目录
					if("listeningPort".equals(name) || "servername".equals(name) || "announceurl".equals(name) || "url".equals(name) 
							|| "pieceLength".equals(name) || "upload".equals(name) ){
						params.put(name, value);
					}else{
						params.put(name, trackerPath+value);
					}
				}
				Constants.configParam = params;
			} catch (Exception e) {
				System.err.println("Error while loading parameters");
			}
		}else {
			System.err.println("No configuration file found...");
			System.exit(0);
		}
	}
	
}
