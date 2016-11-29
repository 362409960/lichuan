package cloud.app.entity;

import java.util.Date;



public class PublishTerminal  extends BaseModel{
	
	private String id;
	private String publish_id;
	private String termianl_id;
	private String program;
	private String user_id;
	private String state;
	private Date reception_time;
	private Date complete_time;
	private String progress;
	private String program_id;
	
	private String termianl_name;
	private String del_state;
	private String task_name;
	
	
	
	
	
	public String getTask_name() {
		return task_name;
	}
	public void setTask_name(String task_name) {
		this.task_name = task_name;
	}
	public String getDel_state() {
		return del_state;
	}
	public void setDel_state(String del_state) {
		this.del_state = del_state;
	}
	public String getTermianl_name() {
		return termianl_name;
	}
	public void setTermianl_name(String termianl_name) {
		this.termianl_name = termianl_name;
	}
	public Date getReception_time() {
		return reception_time;
	}
	public void setReception_time(Date reception_time) {
		this.reception_time = reception_time;
	}
	public Date getComplete_time() {
		return complete_time;
	}
	public void setComplete_time(Date complete_time) {
		this.complete_time = complete_time;
	}
	public String getProgram_id() {
		return program_id;
	}
	public void setProgram_id(String program_id) {
		this.program_id = program_id;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	
	public String getProgress() {
		return progress;
	}
	public void setProgress(String progress) {
		this.progress = progress;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPublish_id() {
		return publish_id;
	}
	public void setPublish_id(String publish_id) {
		this.publish_id = publish_id;
	}
	public String getTermianl_id() {
		return termianl_id;
	}
	public void setTermianl_id(String termianl_id) {
		this.termianl_id = termianl_id;
	}
	public String getProgram() {
		return program;
	}
	public void setProgram(String program) {
		this.program = program;
	}
	
	

}
