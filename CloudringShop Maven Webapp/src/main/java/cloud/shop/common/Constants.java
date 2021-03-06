package cloud.shop.common;

public class Constants {
	public final static String ENCODING = "utf-8";
	public final static int SESSION_TIME_OUT = 30*60;
	public final static String SESSION_LOGIN_USER = "session-login-user";
	//电子商城前台登录
	public final static String SESSION_LOGIN_USER_GOODS = "session-login-user_goods";
	
	public static final String C_STATUS_NORMAL = "0";   //正常
	public static final String C_STATUS_CANCEL = "1";   //停用
	
	public static final String C_USER_STATE_COMMON = "0";   //用户状态正常
	public static final String C_USER_STATE_STOP = "1";   //用户状态注销
	
	public final static String C_DELIMITER = ",";
	public final static String C_INIT_PASSWORD = "111111";
	
	public static final String CLOUD_FILE = "cloudfile_cloudringshop";
	public static final String CLOUD_SHOP_FILE = "upload_cloudringshop";
	
	public static final String UPLOAD_URL = "http://localhost:8088";
	
	public static final String WAIT_FOR_PAY  = "1";//等待付款
	public static final String ALREADY_PAY = "2";//已付款
	public static final String CANCELLED = "3";//已取消
	public static final String EXPIRED = "4";//已过期
	

	
	public static final String PARENT_ID = "0";   //父级菜单
	
	public static final String PARENT_NAME = "cloudring";   //父级菜单名字
	
	public static final String ADMINI_ID = "0c517db57d6c4d708719b8b0362c3736";   //超级管理员编号
	

}
