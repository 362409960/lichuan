package cloud.app.common;

import java.util.HashMap;
import java.util.Map;

public class Constants {
	public final static String ENCODING = "utf-8";
	public final static String MAIN_PAGE = "www.cloudring.net";
	
	public final static int SESSION_TIME_OUT = 30*60;
	public final static String SESSION_LOGIN_USER = "session-login-user";
	public final static String SESSION_USERNAME = "username";
	
	public static final String C_STATUS_NORMAL = "0";   //正常
	public static final String C_STATUS_CANCEL = "1";   //停用
	
	public static final String C_USER_STATE_COMMON = "0";   //用户状态正常
	public static final String C_USER_STATE_STOP = "1";   //用户状态注销
	
	public final static String C_DELIMITER = ",";
	public final static String C_INIT_PASSWORD = "123456";
	
	public static final String CLOUD_FILE = "cloudfile";
	
	public static final String CLOUD_FILE_FILE = "upload_cloudfile";//
	public static final String CLOUD_ZIP_FILE = "example";//
	
	public static final String CLOUD_CALLBACK_FILE ="callback";
	public static final String CLOUD_IMAGE_FILE = "image";
	public static final String CLOUD_VIDEO_FILE = "video";
	
	public static final String UPLOAD_URL = "http://localhost:8088";
	
	public static final String PUSH_OBJECT_SEPARATED_CHAR = ",";
	public static final String DATE_TIME_FORMAT = "yyyy-MM-dd HH:mm:ss";
	
	public static final String masterSecret = "a941a44b991a3c3f01c1f28f";
	public static final String appKey = "68f41658bcfd5030b964af6e";
	
	public static final String DELIVERY_TYPE_SCHEDULED = "scheduled";
	public static final String DELIVERY_TYPE_NOW = "now";
	
	public static final String DEVICETYPE_ANDROID = "android";
	public static final String DELIVERY_TYPE_IOS = "ios";
	public static final String DELIVERY_TYPE_WINPHONE = "winphone";
	

	
	public final static int SERVER_PORT = 8889;
	
	
	
	public final static String S_SEPARATOR = "\\|";
	public final static String HEARTBEAT_PING = "ping";
	public final static String HEARTBEAT_PONG = "pong";
	
	public final static String JSON_KEY_NAME_BOXID = "boxid";
	public final static String JSON_KEY_NAME_NO = "no";
	public final static String JSON_KEY_NAME_SRCID = "srcid";
	public final static String JSON_KEY_NAME_TARGETID = "targetId";
	public final static String JSON_KEY_NAME_VAL = "val";
	public final static String JSON_KEY_NAME_DESTID = "destid";
	public final static String JSON_KEY_NAME_LIST = "list";
	
	public final static String JSON_KEY_NAME_USERID = "userId";
	public final static String JSON_KEY_NAME_ONOFF = "onOff";
	
	public final static int JSON_KEY_NAME_ONOFF_0 = 0;   //表示接收盒子发送过来的消息
	
	public final static String JSON_KEY_NAME_UID = "uId";
	public final static String JSON_KEY_NAME_DATA = "data";
	
	public final static String JSON_KEY_NAME_ERRNO = "errno";
	public static final String JSON_KEY_VALUE = "value";
	public static final String JSON_KEY_COLOR = "color";
	
	public final static String JSON_KEY_NAME_ACTION = "action";
	public final static String JSON_KEY_USERCODE = "userCode";
	public final static String JSON_KEY_PASSWORD = "password";
 
	public final static String JSON_KEY_TERMINALID = "terminalId";
	public final static String JSON_KEY_PROGRAMID = "programId";
	public final static String JSON_KEY_STARTTIME = "startTime";
	public final static String JSON_KEY_ENDTIME = "endTime";
	public final static String JSON_KEY_PROGRESS = "progress";
	
	
	//断点续传启动的线程数量
	public final static int THREAD_NUM = 5;
	//断点续传（上传）服务器的文件目录
	public final static String RECEIVE_FILE_PATH = "c:\\ckUploadFile\\";
	public final static String SEND_FILE_PATH = "c:\\ckUploadFile\\";
	public final static int DEFAULT_BIND_PORT = 10009;
	
	
	//消息推送
	public static final String C_CERTIFICATE_PATH = "E:/inc/fgecctv/ios/证书.p12";
	public static final String C_CERTIFICATE_PASSWORD = "123";
	
	
	public static final String C_END_SYMBOL = "\\r\\n";
	public static final int I_WAITING_TIME = 5000*3;    //返回数据的等待时间最大为5秒
	
	
	//定义盒子的前缀
	public static String boxPrefix = "box_";
	//定义用户的前缀
	public static String userPrefix = "user_";
	public final static String TOPIC_SEPARATOR = "/";
	
	public final static String TOPIC_OUT = "out";
	public final static String TOPIC_IN = "in";
	
	//主题
	public final static String TOPIC_SENSORDATA = "sensordata";
	public final static String TOPIC_FORWARDING = "forwarding";
	public final static String TOPIC_WEB = "web";
	public final static String TOPIC_MOBILE = "mob";
	public final static String TOPIC_TERMINAL = "terminal";
	
	public final static String TERMINAL_ONLINE_OFF = "0";
	public final static String TERMINAL_ONLINE_IN = "1";
	
	public static final String PARENT_ID = "0";   //父级菜单
	public static final String PARENT_NAME = "cloudring";
	public static final String MATERIAL_PARENT_NAME = "所有素材";
	public static final String ADMINI_ID = "0c517db57d6c4d708719b8b0362c3736";   //超级管理员编号
	
	public final static String APIKEYHEADFIELD = "apikey";
	
	public final static String MESSAGE_TYPE_IMAGES = "1";  //图片
	public final static String MESSAGE_TYPE_VIDEO = "2";   //视频
}
