package cloud.app.entity;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import cloud.app.entity.BaseModel;

public class Program extends BaseModel{
	
	private String id;
	private String user_id;
	private String program_name;	
	private String scenes;
	private String play_time;
	private Date updated;
	private String resolution;
	private String affiliations;
	private String context;
	private String file_url;
	private String program_type;	
	private String bagrmusic;
	private String view_time;
	private Date create_time;	
	private String update_user;
	private String user_name;
	private String state;
	
	private String stream_left;
	private String stream_top;
	private String stream_width;
	private String stream_height;
	private String video_stream;
	private String video_url;
	private String imgae_url;
	private String videoPlace_url;
	private String context_video;
	
	private String  sonId;//子表id
	
	private String pdf_url;

	
	private String is_bg_music;
	
	private String increment_address;
	
	private String background_picture;
	
	private long fileSize = 0L;
	private String zipPath;
	
	
	private List<String> departmentidList=new ArrayList<String>();
	

	public String getBackground_picture() {
		return background_picture;
	}

	public void setBackground_picture(String background_picture) {
		this.background_picture = background_picture;
	}

	public List<String> getDepartmentidList() {
		return departmentidList;
	}

	public void setDepartmentidList(List<String> departmentidList) {
		this.departmentidList = departmentidList;
	}

	public String getIncrement_address() {
		return increment_address;
	}

	public void setIncrement_address(String increment_address) {
		this.increment_address = increment_address;
	}

	public String getIs_bg_music() {
		return is_bg_music;
	}

	public void setIs_bg_music(String is_bg_music) {
		this.is_bg_music = is_bg_music;
	}

	public String getPdf_url() {
		return pdf_url;
	}

	public void setPdf_url(String pdf_url) {
		this.pdf_url = pdf_url;
	}



	public String getSonId() {
		return sonId;
	}

	public void setSonId(String sonId) {
		this.sonId = sonId;
	}

	public String getContext_video() {
		return context_video;
	}

	public void setContext_video(String context_video) {
		this.context_video = context_video;
	}

	public String getVideoPlace_url() {
		return videoPlace_url;
	}

	public void setVideoPlace_url(String videoPlace_url) {
		this.videoPlace_url = videoPlace_url;
	}

	private MultipartFile file;
	
	private String startTime;
	private String endTime;
	
	


	





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

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getUser_name() {
		return user_name;
	}

	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}

	public String getPlay_time() {
		return play_time;
	}

	public void setPlay_time(String play_time) {
		this.play_time = play_time;
	}

	

	public String getUpdate_user() {
		return update_user;
	}

	public void setUpdate_user(String update_user) {
		this.update_user = update_user;
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

	public Date getCreate_time() {
		return create_time;
	}

	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public String getProgram_name() {
		return program_name;
	}

	public void setProgram_name(String program_name) {
		this.program_name = program_name;
	}



	public String getScenes() {
		return scenes;
	}

	public void setScenes(String scenes) {
		this.scenes = scenes;
	}

	

	public Date getUpdated() {
		return updated;
	}

	public void setUpdated(Date updated) {
		this.updated = updated;
	}

	public String getResolution() {
		return resolution;
	}

	public void setResolution(String resolution) {
		this.resolution = resolution;
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

	public String getFile_url() {
		return file_url;
	}

	public void setFile_url(String file_url) {
		this.file_url = file_url;
	}

	public String getProgram_type() {
		return program_type;
	}

	public void setProgram_type(String program_type) {
		this.program_type = program_type;
	}

	

	public String getBagrmusic() {
		return bagrmusic;
	}

	public void setBagrmusic(String bagrmusic) {
		this.bagrmusic = bagrmusic;
	}

	
	

	public String getView_time() {
		return view_time;
	}

	public void setView_time(String view_time) {
		this.view_time = view_time;
	}

	public MultipartFile getFile() {
		return file;
	}

	public void setFile(MultipartFile file) {
		this.file = file;
	}

	public long getFileSize() {
		return fileSize;
	}

	public void setFileSize(long fileSize) {
		this.fileSize = fileSize;
	}

	public String getZipPath() {
		return zipPath;
	}

	public void setZipPath(String zipPath) {
		this.zipPath = zipPath;
	}
	
	

}
