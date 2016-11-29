package cloud.app.common;

 
import java.security.SecureRandom;

import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.DESKeySpec;

 
public class ThreeDes {
	/** 加密、解密key. */  
    //private static final String PASSWORD_CRYPT_KEY = "!@#$cloudringbox!@#$";  
    /** 加密算法,可用 DES,DESede,Blowfish. */  
    private final static String ALGORITHM = "DES";  
    
    public static void main(String[] args) throws Exception { 
    	
    	String temp = "[{\"Monday\":\"00:00:00-23:59:59\"},{\"Tuesday\":\"00:00:00-23:59:59\"},{\"Wednesday\":\"00:00:00-23:59:59\"},{\"Thursday\":\"00:00:00-23:59:59\"},{\"Friday\":\"00:00:00-23:59:59\"},{\"Saturday\":\"00:00:00-23:59:59\"},{\"Sunday\":\"00:00:00-23:59:59\"}]";
    	
    	
    	
    	
    	
    	
    	
    	
    	
    	
    	
    	
    	
    	String cryptKey = "!@#$cloudringbox!@#$";
    	
        //String md5Password = "huangxc";  
//        
//    	String md5Password = "{\"action\":\"binding\",\"id\":\"293b1e6ea6524386ae25509708535549\",\"name\":\"厨房1\",\"ip\":\"192.168.1.101\",\"mac\":\"3c:df:bd:92:48:e3|3c:df:bd:92:48:e3\",\"address\":\"兰光科技801\",\"firmware\":\"A199V100R001C92B130\",\"reolution\":\"720*1280\",\"version\":\"3.8.2\",\"createDate\":\"2016-03-28 12:14:12\",\"volume\":21,\"userCode\":\"admin\",\"password\":\"e10adc3949ba59abbe56e057f20f883e\"}";
//    	
//        
//        String str = ThreeDes.encrypt(md5Password, cryptKey);  
//        System.out.println("加密后的数据: " + str);  
//        str = ThreeDes.decrypt(str, cryptKey);  
//        System.out.println("解密后的数据: " + str);  
//        
//        
        
    	
    	String jm = "469AB9907DD93DC76E87AFE790FD9E605E150916ABFF2D72181D53736D1756173D195FDBC9BC01789AF96126A7C6A479A3AB530E98DAF238FE5979165C755D80F5ACFE6CEE4EECC72B0009C199AF2D0F6704352B54109BC9F1A2CD2CA333256DDE97B14038FD55598E0A469698DD03FD74EF60C08DEDF7963897B6366349317B7240B5A73009FDED59551AFD73E92117BC0498535F4E05614510489E830E3961BD3C4966BAF9264C143117C7DDB06097ECDA6447FA56FFA2559DF0923C2ECCBC12CC4F3CB67D4B15B4DF3BA0D7C7900399B3A4FA8349EF762A601208ED87A8681C6343DB667BBD835B056A62590AF2D10E496943066F16C802F8922F760E82BE9D80C0E868FE6858AB2AA488C7E7D29812CB91341DBCCB9FA0DA692BCF4E0A49DB6E881605CEA21D6052DE173590EB01AB072659A508A2BC72242CAA26BEEED54FFC37E0619D8654E23EDCEA01E9C9F74A659994BA2604443EDF5793CC68B9BE62F6F5B869767183";
    	String t = ThreeDes.decrypt(jm, cryptKey, "utf-8");
    	System.out.println(t);
    }  
      
    /** 
     * 对数据进行DES加密. 
     * @param data 待进行DES加密的数据 
     * @param cryptKey 加密解密的key
     * @return 返回经过DES加密后的数据 
     * @throws Exception 
     * @author <a href="mailto:xiexingxing1121@126.com" mce_href="mailto:xiexingxing1121@126.com">AmigoXie</a> 
     * Creation date: 2007-7-31 - 下午12:06:24 
     */  
    public final static String decrypt(String data, String cryptKey, String encoding) throws Exception {  
        return new String(decrypt(hex2byte(data.getBytes()), cryptKey.getBytes()), encoding);  
    }

    /** 
     * 对用DES加密过的数据进行解密. 
     * @param data DES加密数据 
     * @param cryptKey 加密解密的key
     * @return 返回解密后的数据 
     * @throws Exception 
     * @author <a href="mailto:xiexingxing1121@126.com" mce_href="mailto:xiexingxing1121@126.com">AmigoXie</a> 
     * Creation date: 2007-7-31 - 下午12:07:54 
     */  
    public final static String encrypt(String data, String cryptKey) throws Exception  {  
        return byte2hex(encrypt(data.getBytes(), cryptKey.getBytes()));  
    }  
      
    /** 
     * 用指定的key对数据进行DES加密. 
     * @param data 待加密的数据 
     * @param key DES加密的key 
     * @return 返回DES加密后的数据 
     * @throws Exception 
     * @author <a href="mailto:xiexingxing1121@126.com" mce_href="mailto:xiexingxing1121@126.com">AmigoXie</a> 
     * Creation date: 2007-7-31 - 下午12:09:03 
     */  
    private static byte[] encrypt(byte[] data, byte[] key) throws Exception {  
        // DES算法要求有一个可信任的随机数源  
        SecureRandom sr = new SecureRandom();  
        // 从原始密匙数据创建DESKeySpec对象  
        DESKeySpec dks = new DESKeySpec(key);  
        // 创建一个密匙工厂，然后用它把DESKeySpec转换成  
        // 一个SecretKey对象  
        SecretKeyFactory keyFactory = SecretKeyFactory.getInstance(ALGORITHM);  
        SecretKey securekey = keyFactory.generateSecret(dks);  
        // Cipher对象实际完成加密操作  
        Cipher cipher = Cipher.getInstance(ALGORITHM);  
        // 用密匙初始化Cipher对象  
        cipher.init(Cipher.ENCRYPT_MODE, securekey, sr);  
        // 现在，获取数据并加密  
        // 正式执行加密操作  
        return cipher.doFinal(data);  
    }  
    /** 
     * 用指定的key对数据进行DES解密. 
     * @param data 待解密的数据 
     * @param key DES解密的key 
     * @return 返回DES解密后的数据 
     * @throws Exception 
     * @author <a href="mailto:xiexingxing1121@126.com" mce_href="mailto:xiexingxing1121@126.com">AmigoXie</a> 
     * Creation date: 2007-7-31 - 下午12:10:34 
     */  
    private static byte[] decrypt(byte[] data, byte[] key) throws Exception {  
        // DES算法要求有一个可信任的随机数源  
        SecureRandom sr = new SecureRandom();  
        // 从原始密匙数据创建一个DESKeySpec对象  
        DESKeySpec dks = new DESKeySpec(key);  
        // 创建一个密匙工厂，然后用它把DESKeySpec对象转换成  
        // 一个SecretKey对象  
        SecretKeyFactory keyFactory = SecretKeyFactory.getInstance(ALGORITHM);  
        SecretKey securekey = keyFactory.generateSecret(dks);  
        // Cipher对象实际完成解密操作  
        Cipher cipher = Cipher.getInstance(ALGORITHM);  
        // 用密匙初始化Cipher对象  
        cipher.init(Cipher.DECRYPT_MODE, securekey, sr);  
        // 现在，获取数据并解密  
        // 正式执行解密操作  
        return cipher.doFinal(data);  
    }  
    public static byte[] hex2byte(byte[] b) {  
        if ((b.length % 2) != 0)  
            throw new IllegalArgumentException("长度不是偶数");  
        byte[] b2 = new byte[b.length / 2];  
        for (int n = 0; n < b.length; n += 2) {  
            String item = new String(b, n, 2);  
            b2[n / 2] = (byte) Integer.parseInt(item, 16);  
        }  
        return b2;  
    }  
    public static String byte2hex(byte[] b) {  
        String hs = "";  
        String stmp = "";  
        for (int n = 0; n < b.length; n++) {  
            stmp = (java.lang.Integer.toHexString(b[n] & 0XFF));  
            if (stmp.length() == 1)  
                hs = hs + "0" + stmp;  
            else  
                hs = hs + stmp;  
        }  
        return hs.toUpperCase();  
    }}
