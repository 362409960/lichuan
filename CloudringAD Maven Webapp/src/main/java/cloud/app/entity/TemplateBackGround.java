package cloud.app.entity;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class TemplateBackGround extends BaseModel {
	
	private String id;
	private String name;
	private Date create_date;
	private String createor;
	private Date update_date;
	private String editor;
	private String physical_path;
	private String virtual_path;
	private String resolution;	
	private String user_id;
	private String remark;
	private MultipartFile file;
	private String startTime;
	private String endTime;
	
	private String affiliations;
	
	private List<String> affiliationsLists=new ArrayList<String>();
	
	
	
	public List<String> getAffiliationsLists() {
		return affiliationsLists;
	}
	public void setAffiliationsLists(List<String> affiliationsLists) {
		this.affiliationsLists = affiliationsLists;
	}
	public String getAffiliations() {
		return affiliations;
	}
	public void setAffiliations(String affiliations) {
		this.affiliations = affiliations;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Date getCreate_date() {
		return create_date;
	}
	public void setCreate_date(Date create_date) {
		this.create_date = create_date;
	}
	public String getCreateor() {
		return createor;
	}
	public void setCreateor(String createor) {
		this.createor = createor;
	}
	public Date getUpdate_date() {
		return update_date;
	}
	public void setUpdate_date(Date update_date) {
		this.update_date = update_date;
	}
	public String getEditor() {
		return editor;
	}
	public void setEditor(String editor) {
		this.editor = editor;
	}
	public String getPhysical_path() {
		return physical_path;
	}
	public void setPhysical_path(String physical_path) {
		this.physical_path = physical_path;
	}
	public String getVirtual_path() {
		return virtual_path;
	}
	public void setVirtual_path(String virtual_path) {
		this.virtual_path = virtual_path;
	}
	public String getResolution() {
		return resolution;
	}
	public void setResolution(String resolution) {
		this.resolution = resolution;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public MultipartFile getFile() {
		return file;
	}
	public void setFile(MultipartFile file) {
		this.file = file;
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
