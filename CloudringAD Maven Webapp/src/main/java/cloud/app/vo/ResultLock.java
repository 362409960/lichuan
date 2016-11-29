package cloud.app.vo;

public class ResultLock {
	private String id;
	private Object message;
	
	public ResultLock(String id) {
		super();
		this.id = id;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public Object getMessage() {
		return message;
	}

	public void setMessage(Object message) {
		this.message = message;
	}
	
	
	
}
