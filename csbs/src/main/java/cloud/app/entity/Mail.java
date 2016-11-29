package cloud.app.entity;

public class Mail {
	
	@SuppressWarnings("unused")
	private String mailServerPort = "25";//服务器口
	
	private String from; //发送人
	
	private String [] to;//接收人
	
	private String [] copy;//抄送人
	
	private String suject;//主题
	
	private String body;//内容
	
	private String username;
	
	private String password;
	
	private String host;//服务器
	
	private String[] attachFileNames;

	public String getFrom() {
		return from;
	}

	public void setFrom(String from) {
		this.from = from;
	}

	public String[] getTo() {
		return to;
	}

	public void setTo(String[] to) {
		this.to = to;
	}

	public String[] getCopy() {
		return copy;
	}

	public void setCopy(String[] copy) {
		this.copy = copy;
	}

	public String getSuject() {
		return suject;
	}

	public void setSuject(String suject) {
		this.suject = suject;
	}

	public String getBody() {
		return body;
	}

	public void setBody(String body) {
		this.body = body;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getHost() {
		return host;
	}

	public void setHost(String host) {
		this.host = host;
	}

	public String[] getAttachFileNames() {
		return attachFileNames;
	}

	public void setAttachFileNames(String[] attachFileNames) {
		this.attachFileNames = attachFileNames;
	}
	

}
