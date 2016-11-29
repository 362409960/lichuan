package cloud.shop.merchandise.entity;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

import cloud.shop.entity.BaseModel;

public class MerchandiseBrand extends BaseModel {
	private String id;
	private String name;
	private String logo;
	private String url;
	private Date create_time;
	private String create_user;

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

	public String getLogo() {
		return logo;
	}

	public void setLogo(String logo) {
		this.logo = logo;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public Date getCreate_time() {
		return create_time;
	}

	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}

	public String getCreate_user() {
		return create_user;
	}

	public void setCreate_user(String create_user) {
		this.create_user = create_user;
	}

	public Date getUpdate_time() {
		return update_time;
	}

	public void setUpdate_time(Date update_time) {
		this.update_time = update_time;
	}

	public String getUpdate_user() {
		return update_user;
	}

	public void setUpdate_user(String update_user) {
		this.update_user = update_user;
	}

	public MultipartFile getLogoPhoto() {
		return logoPhoto;
	}

	public void setLogoPhoto(MultipartFile logoPhoto) {
		this.logoPhoto = logoPhoto;
	}

	private Date update_time;
	private String update_user;
	private MultipartFile logoPhoto;//上传图片

}
