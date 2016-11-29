package cloud.app.entity;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class Template extends BaseModel {
	
	private String id;
	private String name;
	private Date create_date;
	private String createor;
	private Date update_date;
	private String editor;
	private String context;
  
	private String stream_left;
	private String stream_top;
	private String stream_width;
	private String stream_height;
	private String video_stream;
	private String video_url;
	private String imgae_url;
	private String videoPlace_url;
	private String context_video;
	private String resolution;

	private String user_id;
	
	private MultipartFile file;
	private String startTime;
	private String endTime;
	
	private String affiliations;
	private String pdf_url;
	private String play_time;
	private List<String> affiliationsLists=new ArrayList<String>();;
	
	

	public String getPlay_time() {
		return play_time;
	}
	public void setPlay_time(String play_time) {
		this.play_time = play_time;
	}
	public String getPdf_url() {
		return pdf_url;
	}
	public void setPdf_url(String pdf_url) {
		this.pdf_url = pdf_url;
	}
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
	public String getContext() {
		return context;
	}
	public void setContext(String context) {
		this.context = context;
	}
	public MultipartFile getFile() {
		return file;
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
	
	public String getResolution() {
		return resolution;
	}
	public void setResolution(String resolution) {
		this.resolution = resolution;
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
	public String getStream_left() {
		return stream_left;
	}
	public void setStream_left(String stream_left) {
		this.stream_left = stream_left;
	}
	public String getStream_top() {
		return stream_top;
	}
	public void setStream_top(String stream_top) {
		this.stream_top = stream_top;
	}
	public String getStream_width() {
		return stream_width;
	}
	public void setStream_width(String stream_width) {
		this.stream_width = stream_width;
	}
	public String getStream_height() {
		return stream_height;
	}
	public void setStream_height(String stream_height) {
		this.stream_height = stream_height;
	}
	public String getVideo_stream() {
		return video_stream;
	}
	public void setVideo_stream(String video_stream) {
		this.video_stream = video_stream;
	}
	public String getVideo_url() {
		return video_url;
	}
	public void setVideo_url(String video_url) {
		this.video_url = video_url;
	}
	public String getImgae_url() {
		return imgae_url;
	}
	public void setImgae_url(String imgae_url) {
		this.imgae_url = imgae_url;
	}
	public String getVideoPlace_url() {
		return videoPlace_url;
	}
	public void setVideoPlace_url(String videoPlace_url) {
		this.videoPlace_url = videoPlace_url;
	}
	public String getContext_video() {
		return context_video;
	}
	public void setContext_video(String context_video) {
		this.context_video = context_video;
	}
	

}
