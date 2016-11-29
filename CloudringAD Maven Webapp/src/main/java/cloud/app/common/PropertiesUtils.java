package cloud.app.common;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;


public class PropertiesUtils {
	
	public static PropertiesUtils instance = null;
	static Properties prop;
	
	public PropertiesUtils() {
		prop = new Properties();
		try {
			InputStream in = new FileInputStream(getClass().getClassLoader()
					.getResource("system.properties").getPath());

			prop.load(in);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public static PropertiesUtils getInstance(){
		if(instance == null){
			synchronized (PropertiesUtils.class) {
				PropertiesUtils temp = instance;
				if(temp == null){
					instance = new PropertiesUtils();
				}
			}
		}
		
		return instance;
	}
	
	
	
	public String getValue(String key){
		try {
			if(instance != null){
				return prop.getProperty(key);
			}	
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return null;
	}
	
	
	
}
