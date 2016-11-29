package cloud.app.entity;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;



public class Publish  extends BaseModel{
	
	private String id;
	private String publish_type;
	private String user_id;
	private String program_id;
	private String affiliations;
	private String publish_user;
	private Date expiration;
	private Date create_time;
	private Date publish_time;
	private String state;
	private String program_name;
	private String task_id;

	
	private String termainId;
	private String timePublic;
	private String expirationTime;

	private String playMode;//播放方式
	private Integer isEngross;
	private String scheduledPublish;
	private String modeContent;//播放内容，一般是时间设定，比如星期一、星期二的开始和结束时间
	
	private String termianl_id;
	private String startTime;
	private String endTime;
	private Integer version;
	private String state_del;

	
	private List<TimeVO> timeVOlist=new ArrayList<TimeVO>();
	
	private List<String> departmentidList=new ArrayList<String>();
	
	
	
	public String getState_del() {
		return state_del;
	}
	public void setState_del(String state_del) {
		this.state_del = state_del;
	}
	public String getTermianl_id() {
		return termianl_id;
	}
	public void setTermianl_id(String termianl_id) {
		this.termianl_id = termianl_id;
	}
	public List<String> getDepartmentidList() {
		return departmentidList;
	}
	public void setDepartmentidList(List<String> departmentidList) {
		this.departmentidList = departmentidList;
	}
	public Integer getVersion() {
		return version;
	}
	public void setVersion(Integer version) {
		this.version = version;
	}
	public List<TimeVO> getTimeVOlist() {
		return timeVOlist;
	}
	public void setTimeVOlist(List<TimeVO> timeVOlist) {
		this.timeVOlist = timeVOlist;
	}
	public String getScheduledPublish() {
		return scheduledPublish;
	}
	public void setScheduledPublish(String scheduledPublish) {
		this.scheduledPublish = scheduledPublish;
	}
	public Integer getIsEngross() {
		return isEngross;
	}
	public void setIsEngross(Integer isEngross) {
		this.isEngross = isEngross;
	}
	
	
	public String getPlayMode() {
		return playMode;
	}
	public void setPlayMode(String playMode) {
		this.playMode = playMode;
	}
	public String getModeContent() {
		return modeContent;
	}
	public void setModeContent(String modeContent) {
		this.modeContent = modeContent;
	}
	public String getExpirationTime() {
		return expirationTime;
	}
	public void setExpirationTime(String expirationTime) {
		this.expirationTime = expirationTime;
	}
	
	public String getTermainId() {
		return termainId;
	}
	public void setTermainId(String termainId) {
		this.termainId = termainId;
	}
	public String getTimePublic() {
		return timePublic;
	}
	public void setTimePublic(String timePublic) {
		this.timePublic = timePublic;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	
	public String getPublish_type() {
		return publish_type;
	}
	public void setPublish_type(String publish_type) {
		this.publish_type = publish_type;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getProgram_id() {
		return program_id;
	}
	public void setProgram_id(String program_id) {
		this.program_id = program_id;
	}
	public String getAffiliations() {
		return affiliations;
	}
	public void setAffiliations(String affiliations) {
		this.affiliations = affiliations;
	}
	public String getPublish_user() {
		return publish_user;
	}
	public void setPublish_user(String publish_user) {
		this.publish_user = publish_user;
	}
	
	public Date getExpiration() {
		return expiration;
	}
	public void setExpiration(Date expiration) {
		this.expiration = expiration;
	}
	public Date getCreate_time() {
		return create_time;
	}
	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}
	public Date getPublish_time() {
		return publish_time;
	}
	public void setPublish_time(Date publish_time) {
		this.publish_time = publish_time;
	}

	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getProgram_name() {
		return program_name;
	}
	public void setProgram_name(String program_name) {
		this.program_name = program_name;
	}
	public String getTask_id() {
		return task_id;
	}
	public void setTask_id(String task_id) {
		this.task_id = task_id;
	}
	public String getStartTime() {
		return startTime;
	}
	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}
	public String getEndTime() {
		return endTime;
	}
	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}
	
	

}
