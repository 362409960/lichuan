package cloud.app.common;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.MessageFormat;
import java.util.Collection;
import java.util.Map;
import java.util.UUID;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.codec.binary.Base64;
import org.apache.log4j.Logger;

import sun.misc.BASE64Decoder;

/**
 * 字符串处理类
 */
public class StringUtil {
	// private final static Log log = LogFactory.getLog(StringUtil.class);
	protected static final Logger log = Logger.getLogger(StringUtil.class);

	/**
	 * 
	 * @param str
	 *            String
	 * @return String
	 */
	public static String isoToGBK(String str) {
		if (str == null) {
			return "";
		}
		try {
			byte[] bytes = str.getBytes("iso-8859-1");
			String destStr = new String(bytes, "GBK");
			return destStr;
		} catch (Exception e) {
			log.error(e);
		}
		return "";
	}

	/**
	 * 转换指定字符串的编码
	 * 
	 * @param str
	 * @param fromEncoding
	 * @param toEncoding
	 * @return
	 */
	public static String convert(String str, String fromEncoding,
			String toEncoding) {
		if (str == null) {
			return "";
		}
		try {
			byte[] bytes = str.getBytes(fromEncoding);
			String destStr = new String(bytes, toEncoding);
			return destStr;
		} catch (Exception e) {
			log.error(e);
		}
		return "";
	}

	public static String toUnicode(java.lang.String text) {
		if (text == null)
			return "";
		char chars[] = text.toCharArray();
		java.lang.StringBuffer sb = new StringBuffer();
		int length = chars.length;
		for (int i = 0; i < length; i++) {
			int s = chars[i];
			sb.append("&#");
			sb.append(s);
			sb.append(";");
		}

		return sb.toString();
	}

	/**
	 * 检测字符串里是否有中文字符
	 * 
	 * @param str
	 * @return
	 */
	public static boolean chinese(String str) {
		if (str == null) {
			return false;
		}
		String regex = "[\u0391-\uFFE5]+";
		Pattern p = Pattern.compile(regex);
		Matcher m = p.matcher(str);
		boolean validate = m.matches();
		return validate;
	}

	/**
	 * 检测输入的邮政编码是否合法
	 * 
	 * @param code
	 * @return
	 */
	public static boolean isPostCode(String code) {
		if (code == null) {
			return false;
		}
		String regex = "[1-9]\\d{5}";
		Pattern p = Pattern.compile(regex);
		Matcher m = p.matcher(code);
		boolean validate = m.matches();
		return validate;
	}

	// /**
	// * 检测字符串是否为空，或者空字符串
	// *
	// *
	// * @param str
	// * @return
	// */
	// public static boolean isEmpty(String str) {
	// str = StringUtil.nullStringToEmptyString(str);
	// String regex = "\\s*";
	// Pattern p = Pattern.compile(regex);
	// Matcher m = p.matcher(str);
	// boolean validate = m.matches();
	// return validate;
	// }
	//
	// /**
	// * 字符串是否是"nul"字符串
	// *
	// *
	// * @param str
	// * @return
	// */
	// public static boolean isNull(String str) {
	// if (str == null && "null".equals(str) ) {
	// return true;
	// }
	// return false;
	// }

	/**
	 * 将"null"字符串或者null值转换成""
	 * 
	 * @param str
	 * @return
	 */
	public static String nullStringToEmptyString(String str) {
		if (str == null) {
			str = "";
		}
		if (str.equals("null")) {
			str = "";
		}
		return str;
	}

	/**
	 * 将"null"字符串或者null值转换成""
	 * 
	 * @param str
	 * @return
	 */
	public static String nullStringToSetString(String str) {
		if (StringUtil.isEmpty(str)) {
			str = "设置";
		}
		if (str == null) {
			str = "设置";
		}
		if (str.equals("null")) {
			str = "设置";
		}
		return str;
	}

	/**
	 * 将"null"字符串或者null值转换成""
	 * 
	 * @param str
	 * @return
	 */
	public static String nullStringToUnknowString(String str) {
		if (str == null) {
			str = "未知";
		}
		if (str.equals("null")) {
			str = "未知";
		}
		return str;
	}

	/**
	 * 屏掉WML不支持的代码
	 * 
	 * @param str
	 * @return
	 */
	public static String wmlEncode(String str) {
		if (str == null)
			return "";
		str = str.replaceAll("&", "&amp;");
		str = str.replaceAll("<", "&lt;");
		str = str.replaceAll(">", "&gt;");
		str = str.replaceAll("'", "&apos;");
		str = str.replaceAll("\"", "&quot;");
		str = str.replaceAll("\n", "<br/>");
		str = str.replaceAll("<br>", "<br/>");
		return str;
	}

	/**
	 * 将字节转换成16进制
	 * 
	 * @param b
	 *            byte[]
	 * @return String
	 */
	public static String byte2hex(byte[] b) {
		String hs = "";
		String stmp = "";
		for (int n = 0; n < b.length; n++) {
			stmp = (java.lang.Integer.toHexString(b[n] & 0XFF));
			if (stmp.length() == 1) {
				hs = hs + "0" + stmp;
			} else {
				hs = hs + stmp;
			}
		}
		return hs.toUpperCase();
	}

	/**
	 * 是否是数字
	 * 
	 * 
	 * @param str
	 * @return
	 */
	public static boolean isNumber(String str) {
		str = StringUtil.nullStringToEmptyString(str);
		String regex = "\\d+";
		Pattern p = Pattern.compile(regex);
		Matcher m = p.matcher(str);
		boolean validate = m.matches();
		return validate;
	}

	/**
	 * 检查书的ISBN号是否合法
	 * 
	 * 
	 * @param isbn
	 * @return
	 */
	public static boolean isISBN(String isbn) {
		if (StringUtil.isEmpty(isbn)) {
			return false;
		}
		int len = isbn.length();
		if (len != 13) {
			return false;
		}
		String[] splits = isbn.split("-");
		len = splits.length;
		if (len != 4) {
			return false;
		}
		len = splits[0].length();
		if (len < 1 || len > 5) {
			return false;
		}
		len = splits[1].length();
		if (len < 2 || len > 5) {
			return false;
		}
		len = splits[2].length();
		if (len < 1 || len > 6) {
			return false;
		}
		len = splits[3].length();
		if (len != 1) {
			return false;
		}
		String realISBN = isbn.replaceAll("-", "");
		char[] numbers = realISBN.toCharArray();
		int sum = 0;
		for (int i = 10; i > 1; i--) {
			int index = 10 - i;
			int number = Integer.parseInt(String.valueOf(numbers[index]));
			sum = sum + number * i;
		}
		int code = 11 - (sum % 11);
		String codeStr = String.valueOf(code);
		if (code == 10) {
			codeStr = "X";
		}
		if (!splits[3].equals(codeStr)) {
			return false;
		}
		return true;
	}

	public static synchronized String getUUID() {
		String uuid = UUID.randomUUID().toString();
		uuid = uuid.replaceAll("-", "");
		return uuid;
	}

	// public static String substring(String str, int start, int length) {
	// int len = str.length();
	// if (len > 15) {
	// str = str.substring(start, length);
	// }
	// str = str + "......";
	// return str;
	// }

	/**
	 * Encode a string using algorithm specified in web.xml and return the
	 * resulting encrypted password. If exception, the plain credentials string
	 * is returned
	 * 
	 * @param password
	 *            Password or other credentials to use in authenticating this
	 *            username
	 * @param algorithm
	 *            Algorithm used to do the digest
	 * 
	 * @return encypted password based on the algorithm.
	 */
	public static String encodePassword(String password, String algorithm) {
		byte[] unencodedPassword = password.getBytes();

		MessageDigest md = null;

		try {
			// first create an instance, given the provider
			md = MessageDigest.getInstance(algorithm);
		} catch (Exception e) {
			log.error("Exception: " + e);

			return password;
		}

		md.reset();

		// call the update method one or more times
		// (useful when you don't know the size of your data, eg. stream)
		md.update(unencodedPassword);

		// now calculate the hash
		byte[] encodedPassword = md.digest();

		StringBuffer buf = new StringBuffer();

		for (byte anEncodedPassword : encodedPassword) {
			if ((anEncodedPassword & 0xff) < 0x10) {
				buf.append("0");
			}

			buf.append(Long.toString(anEncodedPassword & 0xff, 16));
		}

		return buf.toString();
	}

	/**
	 * Encode a string using Base64 encoding. Used when storing passwords as
	 * cookies.
	 * 
	 * This is weak encoding in that anyone can use the decodeString routine to
	 * reverse the encoding.
	 * 
	 * @param str
	 * @return String
	 */
	public static String encodeString(String str) {
		Base64 encoder = new Base64();
		return String.valueOf(encoder.encode(str.getBytes())).trim();
	}

	public static void main(String... args) {
		String isbn = "0-393-04002-X";
		boolean result = StringUtil.isISBN(isbn);
		System.out.println(result);
	}

	/** 空字符串。 */
	public static final String EMPTY_STRING = "";

	/**
	 * 比较两个字符串（大小写敏感）。
	 * 
	 * <pre>
	 * StringUtil.equals(null, null)   = true
	 * StringUtil.equals(null, &quot;abc&quot;)  = false
	 * StringUtil.equals(&quot;abc&quot;, null)  = false
	 * StringUtil.equals(&quot;abc&quot;, &quot;abc&quot;) = true
	 * StringUtil.equals(&quot;abc&quot;, &quot;ABC&quot;) = false
	 * </pre>
	 * 
	 * @param str1
	 *            要比较的字符串1
	 * @param str2
	 *            要比较的字符串2
	 * 
	 * @return 如果两个字符串相同，或者都是<code>null</code>，则返回<code>true</code>
	 */
	public static boolean equals(String str1, String str2) {
		if (str1 == null) {
			return str2 == null;
		}

		return str1.equals(str2);
	}

	/**
	 * 比较两个字符串（大小写不敏感）。
	 * 
	 * <pre>
	 * StringUtil.equalsIgnoreCase(null, null)   = true
	 * StringUtil.equalsIgnoreCase(null, &quot;abc&quot;)  = false
	 * StringUtil.equalsIgnoreCase(&quot;abc&quot;, null)  = false
	 * StringUtil.equalsIgnoreCase(&quot;abc&quot;, &quot;abc&quot;) = true
	 * StringUtil.equalsIgnoreCase(&quot;abc&quot;, &quot;ABC&quot;) = true
	 * </pre>
	 * 
	 * @param str1
	 *            要比较的字符串1
	 * @param str2
	 *            要比较的字符串2
	 * 
	 * @return 如果两个字符串相同，或者都是<code>null</code>，则返回<code>true</code>
	 */
	public static boolean equalsIgnoreCase(String str1, String str2) {
		if (str1 == null) {
			return str2 == null;
		}

		return str1.equalsIgnoreCase(str2);
	}

	/**
	 * 检查字符串是否是空白：<code>null</code>、空字符串<code>""</code>或只有空白字符。
	 * 
	 * <pre>
	 * StringUtil.isBlank(null)      = true
	 * StringUtil.isBlank(&quot;&quot;)        = true
	 * StringUtil.isBlank(&quot; &quot;)       = true
	 * StringUtil.isBlank(&quot;bob&quot;)     = false
	 * StringUtil.isBlank(&quot;  bob  &quot;) = false
	 * </pre>
	 * 
	 * @param str
	 *            要检查的字符串
	 * 
	 * @return 如果为空白, 则返回<code>true</code>
	 */
	public static boolean isBlank(String str) {
		int length;

		if ((str == null) || ((length = str.length()) == 0)) {
			return true;
		}

		for (int i = 0; i < length; i++) {
			if (!Character.isWhitespace(str.charAt(i))) {
				return false;
			}
		}

		return true;
	}

	/**
	 * 检查字符串是否不是空白：<code>null</code>、空字符串<code>""</code>或只有空白字符。
	 * 
	 * <pre>
	 * StringUtil.isBlank(null)      = false
	 * StringUtil.isBlank(&quot;&quot;)        = false
	 * StringUtil.isBlank(&quot; &quot;)       = false
	 * StringUtil.isBlank(&quot;bob&quot;)     = true
	 * StringUtil.isBlank(&quot;  bob  &quot;) = true
	 * </pre>
	 * 
	 * @param str
	 *            要检查的字符串
	 * 
	 * @return 如果为空白, 则返回<code>true</code>
	 */
	public static boolean isNotBlank(String str) {
		int length;

		if ((str == null) || ((length = str.length()) == 0)) {
			return false;
		}

		for (int i = 0; i < length; i++) {
			if (!Character.isWhitespace(str.charAt(i))) {
				return true;
			}
		}

		return false;
	}

	/**
	 * 检查字符串是否为<code>null</code>或空字符串<code>""</code>。
	 * 
	 * <pre>
	 * StringUtil.isEmpty(null)      = true
	 * StringUtil.isEmpty(&quot;&quot;)        = true
	 * StringUtil.isEmpty(&quot; &quot;)       = false
	 * StringUtil.isEmpty(&quot;bob&quot;)     = false
	 * StringUtil.isEmpty(&quot;  bob  &quot;) = false
	 * </pre>
	 * 
	 * @param str
	 *            要检查的字符串
	 * 
	 * @return 如果为空, 则返回<code>true</code>
	 */
	public static boolean isEmpty(String str) {
		return ((str == null) || (str.length() == 0));
	}

	/**
	 * 检查字符串是否不是<code>null</code>和空字符串<code>""</code>。
	 * 
	 * <pre>
	 * StringUtil.isEmpty(null)      = false
	 * StringUtil.isEmpty(&quot;&quot;)        = false
	 * StringUtil.isEmpty(&quot; &quot;)       = true
	 * StringUtil.isEmpty(&quot;bob&quot;)     = true
	 * StringUtil.isEmpty(&quot;  bob  &quot;) = true
	 * </pre>
	 * 
	 * @param str
	 *            要检查的字符串
	 * 
	 * @return 如果不为空, 则返回<code>true</code>
	 */
	public static boolean isNotEmpty(String str) {
		return ((str != null) && (str.length() > 0));
	}

	/**
	 * 在字符串中查找指定字符串，并返回第一个匹配的索引值。如果字符串为<code>null</code>或未找到，则返回<code>-1</code>。
	 * 
	 * <pre>
	 * StringUtil.indexOf(null, *)          = -1
	 * StringUtil.indexOf(*, null)          = -1
	 * StringUtil.indexOf(&quot;&quot;, &quot;&quot;)           = 0
	 * StringUtil.indexOf(&quot;aabaabaa&quot;, &quot;a&quot;)  = 0
	 * StringUtil.indexOf(&quot;aabaabaa&quot;, &quot;b&quot;)  = 2
	 * StringUtil.indexOf(&quot;aabaabaa&quot;, &quot;ab&quot;) = 1
	 * StringUtil.indexOf(&quot;aabaabaa&quot;, &quot;&quot;)   = 0
	 * </pre>
	 * 
	 * @param str
	 *            要扫描的字符串
	 * @param searchStr
	 *            要查找的字符串
	 * 
	 * @return 第一个匹配的索引值。如果字符串为<code>null</code>或未找到，则返回<code>-1</code>
	 */
	public static int indexOf(String str, String searchStr) {
		if ((str == null) || (searchStr == null)) {
			return -1;
		}

		return str.indexOf(searchStr);
	}

	/**
	 * 在字符串中查找指定字符串，并返回第一个匹配的索引值。如果字符串为<code>null</code>或未找到，则返回<code>-1</code>。
	 * 
	 * <pre>
	 * StringUtil.indexOf(null, *, *)          = -1
	 * StringUtil.indexOf(*, null, *)          = -1
	 * StringUtil.indexOf(&quot;&quot;, &quot;&quot;, 0)           = 0
	 * StringUtil.indexOf(&quot;aabaabaa&quot;, &quot;a&quot;, 0)  = 0
	 * StringUtil.indexOf(&quot;aabaabaa&quot;, &quot;b&quot;, 0)  = 2
	 * StringUtil.indexOf(&quot;aabaabaa&quot;, &quot;ab&quot;, 0) = 1
	 * StringUtil.indexOf(&quot;aabaabaa&quot;, &quot;b&quot;, 3)  = 5
	 * StringUtil.indexOf(&quot;aabaabaa&quot;, &quot;b&quot;, 9)  = -1
	 * StringUtil.indexOf(&quot;aabaabaa&quot;, &quot;b&quot;, -1) = 2
	 * StringUtil.indexOf(&quot;aabaabaa&quot;, &quot;&quot;, 2)   = 2
	 * StringUtil.indexOf(&quot;abc&quot;, &quot;&quot;, 9)        = 3
	 * </pre>
	 * 
	 * @param str
	 *            要扫描的字符串
	 * @param searchStr
	 *            要查找的字符串
	 * @param startPos
	 *            开始搜索的索引值，如果小于0，则看作0
	 * 
	 * @return 第一个匹配的索引值。如果字符串为<code>null</code>或未找到，则返回<code>-1</code>
	 */
	public static int indexOf(String str, String searchStr, int startPos) {
		if ((str == null) || (searchStr == null)) {
			return -1;
		}

		// JDK1.3及以下版本的bug：不能正确处理下面的情况
		if ((searchStr.length() == 0) && (startPos >= str.length())) {
			return str.length();
		}

		return str.indexOf(searchStr, startPos);
	}

	/**
	 * 取指定字符串的子串。
	 * 
	 * <p>
	 * 负的索引代表从尾部开始计算。如果字符串为<code>null</code>，则返回<code>null</code>。
	 * 
	 * <pre>
	 * StringUtil.substring(null, *, *)    = null
	 * StringUtil.substring(&quot;&quot;, * ,  *)    = &quot;&quot;;
	 * StringUtil.substring(&quot;abc&quot;, 0, 2)   = &quot;ab&quot;
	 * StringUtil.substring(&quot;abc&quot;, 2, 0)   = &quot;&quot;
	 * StringUtil.substring(&quot;abc&quot;, 2, 4)   = &quot;c&quot;
	 * StringUtil.substring(&quot;abc&quot;, 4, 6)   = &quot;&quot;
	 * StringUtil.substring(&quot;abc&quot;, 2, 2)   = &quot;&quot;
	 * StringUtil.substring(&quot;abc&quot;, -2, -1) = &quot;b&quot;
	 * StringUtil.substring(&quot;abc&quot;, -4, 2)  = &quot;ab&quot;
	 * </pre>
	 * 
	 * </p>
	 * 
	 * @param str
	 *            字符串
	 * @param start
	 *            起始索引，如果为负数，表示从尾部计算
	 * @param end
	 *            结束索引（不含），如果为负数，表示从尾部计算
	 * 
	 * @return 子串，如果原始串为<code>null</code>，则返回<code>null</code>
	 */
	public static String substring(String str, int start, int end) {
		if (str == null) {
			return null;
		}

		if (end < 0) {
			end = str.length() + end;
		}

		if (start < 0) {
			start = str.length() + start;
		}

		if (end > str.length()) {
			end = str.length();
		}

		if (start > end) {
			return EMPTY_STRING;
		}

		if (start < 0) {
			start = 0;
		}

		if (end < 0) {
			end = 0;
		}

		return str.substring(start, end);
	}

	/**
	 * 检查字符串中是否包含指定的字符串。如果字符串为<code>null</code>，将返回<code>false</code>。
	 * 
	 * <pre>
	 * StringUtil.contains(null, *)     = false
	 * StringUtil.contains(*, null)     = false
	 * StringUtil.contains(&quot;&quot;, &quot;&quot;)      = true
	 * StringUtil.contains(&quot;abc&quot;, &quot;&quot;)   = true
	 * StringUtil.contains(&quot;abc&quot;, &quot;a&quot;)  = true
	 * StringUtil.contains(&quot;abc&quot;, &quot;z&quot;)  = false
	 * </pre>
	 * 
	 * @param str
	 *            要扫描的字符串
	 * @param searchStr
	 *            要查找的字符串
	 * 
	 * @return 如果找到，则返回<code>true</code>
	 */
	public static boolean contains(String str, String searchStr) {
		if ((str == null) || (searchStr == null)) {
			return false;
		}

		return str.indexOf(searchStr) >= 0;
	}

	/**
	 * <p>
	 * Checks if the String contains only unicode digits. A decimal point is not
	 * a unicode digit and returns false.
	 * </p>
	 * 
	 * <p>
	 * <code>null</code> will return <code>false</code>. An empty String
	 * ("") will return <code>true</code>.
	 * </p>
	 * 
	 * <pre>
	 * StringUtils.isNumeric(null)   = false
	 * StringUtils.isNumeric(&quot;&quot;)     = true
	 * StringUtils.isNumeric(&quot;  &quot;)   = false
	 * StringUtils.isNumeric(&quot;123&quot;)  = true
	 * StringUtils.isNumeric(&quot;12 3&quot;) = false
	 * StringUtils.isNumeric(&quot;ab2c&quot;) = false
	 * StringUtils.isNumeric(&quot;12-3&quot;) = false
	 * StringUtils.isNumeric(&quot;12.3&quot;) = false
	 * </pre>
	 * 
	 * @param str
	 *            the String to check, may be null
	 * @return <code>true</code> if only contains digits, and is non-null
	 */
	public static boolean isNumeric(String str) {
		if (str == null) {
			return false;
		}
		int sz = str.length();
		for (int i = 0; i < sz; i++) {
			if (Character.isDigit(str.charAt(i)) == false) {
				return false;
			}
		}
		return true;
	}

	public static void testEncode(String s) {
		try {
			System.out.println("String : " + s);
			System.out.println("Result 1: "
					+ new String(s.getBytes("utf-8"), "gbk"));
			System.out.println("Result 2: "
					+ new String(s.getBytes("utf-8"), "iso8859-1"));
			System.out.println("Result 3: " + new String(s.getBytes("utf-8")));

			System.out.println("Result 4: "
					+ new String(s.getBytes("iso8859-1"), "gbk"));
			System.out.println("Result 5: "
					+ new String(s.getBytes("iso8859-1"), "utf-8"));
			System.out.println("Result 6: "
					+ new String(s.getBytes("iso8859-1")));

			System.out.println("Result 7: "
					+ new String(s.getBytes("gbk"), "iso8859-1"));
			System.out.println("Result 8: "
					+ new String(s.getBytes("gbk"), "utf-8"));
			System.out.println("Result 9: " + new String(s.getBytes("gbk")));

		} catch (Exception e) {
			log.error(e);
		}
	}

	/**
	 * 单引号(')，分号(;) 和 注释符号(--)的语句给替换掉
	 * 
	 * @return
	 */
	public static String TransactSQLInjection(String str) {

		return str.replaceAll(".*([';]+|(--)+).*", " ");

	}

	/**
	 * 去除字符串中的空格、回车、换行符、制表符
	 * 
	 * @param sourceStr
	 * @return
	 */
	public static String replaceString(String sourceStr) {
		Pattern p = Pattern.compile("\\s*|\t|\r|\n");
		Matcher m = p.matcher(sourceStr);
		String after = m.replaceAll("");
		return after;
	}

	/**
	 * 判断一个字符串Str是否为空 return true if it is supplied with an empty, zero length,
	 * or whitespace-only string. documented
	 * 
	 * @param str
	 * @return
	 */
	public static boolean isEmptyString(String str) {
		return (str == null) || (str.trim().length() == 0);
	}

	/**
	 * 将String数组转换成Integer数组
	 * 
	 * @param s
	 * @return
	 */
	public static Integer[] convertToIntegerArray(String[] s) {
		Integer[] num = new Integer[s.length];
		for (int i = 0; i < s.length; i++) {
			num[i] = new Integer(s[i]);
		}
		return num;
	}

	/**
	 * 将字符串数组转换成字符串
	 * 
	 * @param str
	 * @return
	 */
	public static String arrayToString(String[] str) {
		if (str == null)
			return "";
		StringBuffer sb = new StringBuffer();
		for (int i = 0; i < str.length; i++) {
			sb.append(str[i]);
			sb.append(", ");
		}
		return sb.toString();
	}

	// 判断字符串是否存在于指定的字符串数组中
	public static boolean isExist(String str, String[] array) {
		boolean result = false;
		if (array == null)
			return result;

		for (int i = 0; i < array.length; i++) {
			if (str.equals(array[i]))
				result = true;
		}
		return result;
	}

	/**
	 * 右对齐填充字符
	 * 
	 * @param data
	 * @param length
	 * @param fill
	 * @return
	 */
	public static String rightAlign(String data, int length, String fill) {
		for (int i = data.length(); i < length; i++) {
			data = fill + data;
		}
		return data;
	}

	/**
	 * 左对齐填充字符
	 * 
	 * @param data
	 * @param length
	 * @param fill
	 * @return
	 */
	public static String leftAlign(String data, int length, String fill) {
		for (int i = data.length(); i < length; i++) {
			data = data + fill;
		}
		return data;
	}

	public static String getBASE64(String s) {
		if (s == null) {
			return null;
		}
		try {
			return (new sun.misc.BASE64Encoder()).encode(s.getBytes("UTF-8"));
		} catch (Exception ex) {
			return null;
		}
	}

	/**
	 * 解码方法, 把一个BASE64编码的字符串解码为编码前的字符串
	 * 
	 * @param in
	 *            需要解码的BASE64编码的字符串
	 * @return 解码后的字节数组, 若解码失败(该字符串不是BASE64编码)则返回null
	 */
	public static String decode(String in) {
		String s = null;
		try {
			byte[] arrB = new BASE64Decoder().decodeBuffer(in);
			s = new String(arrB, "UTF-8");
		} catch (Exception ex) {
			s = null;
		}
		return s;
	}

	/**
	 * MD5转换
	 * 
	 * @param plainText
	 * 
	 * @return MD5字符串
	 */
	public static String toMD5(String plainText)
			throws NoSuchAlgorithmException {

		MessageDigest messageDigest = MessageDigest.getInstance("MD5");
		messageDigest.update(plainText.getBytes());
		byte by[] = messageDigest.digest();

		StringBuffer buf = new StringBuffer();
		int val;
		for (int i = 0; i < by.length; i++) {
			val = by[i];
			if (val < 0) {
				val += 256;
			} else if (val < 16) {
				buf.append("0");
			}
			buf.append(Integer.toHexString(val));
		}
		return buf.toString();
	}

	public static String substituteParams(String msgtext, Object params[]) {
		if (params == null || msgtext == null) {
			return msgtext;
		}
		MessageFormat mf = new MessageFormat(msgtext);
		return mf.format(params);
	}
	
	@SuppressWarnings("rawtypes")
	public static boolean isNullOrEmpty(Object obj) {
		if (obj == null)
			return true;

		if (obj instanceof CharSequence)
			return ((CharSequence) obj).length() == 0;

		if (obj instanceof Collection)
			return ((Collection) obj).isEmpty();

		if (obj instanceof Map)
			return ((Map) obj).isEmpty();

		if (obj instanceof Object[]) {
			Object[] object = (Object[]) obj;
			if (object.length == 0) {
				return true;
			}
			boolean empty = true;
			for (int i = 0; i < object.length; i++) {
				if (!isNullOrEmpty(object[i])) {
					empty = false;
					break;
				}
			}
			return empty;
		}
		return false;
	}
}