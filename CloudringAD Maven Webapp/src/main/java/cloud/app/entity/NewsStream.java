package cloud.app.entity;

import java.util.Date;

public class NewsStream extends BaseModel {
	private String id;

	private Integer playDuration;

	private String durationType;

	private String playSpeed;

	private String message;

	private String fontColor;

	private Integer fontSize;

	private String fontFamilyname;

	private Integer fontPosition;

	private Integer fontOpacity;

	private String creatorId;

	private String creator;

	private Date createDate;

	private String terminalId;
	
	private Integer isAdd;
	
	private String startDate;
	private String endDate;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id == null ? null : id.trim();
	}

	public Integer getPlayDuration() {
		return playDuration;
	}

	public void setPlayDuration(Integer playDuration) {
		this.playDuration = playDuration;
	}

	public String getDurationType() {
		return durationType;
	}

	public void setDurationType(String durationType) {
		this.durationType = durationType == null ? null : durationType.trim();
	}

	public String getPlaySpeed() {
		return playSpeed;
	}

	public void setPlaySpeed(String playSpeed) {
		this.playSpeed = playSpeed == null ? null : playSpeed.trim();
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message == null ? null : message.trim();
	}

	public String getFontColor() {
		return fontColor;
	}

	public void setFontColor(String fontColor) {
		this.fontColor = fontColor == null ? null : fontColor.trim();
	}

	public Integer getFontSize() {
		return fontSize;
	}

	public void setFontSize(Integer fontSize) {
		this.fontSize = fontSize;
	}

	public String getFontFamilyname() {
		return fontFamilyname;
	}

	public void setFontFamilyname(String fontFamilyname) {
		this.fontFamilyname = fontFamilyname == null ? null : fontFamilyname
				.trim();
	}

	public Integer getFontPosition() {
		return fontPosition;
	}

	public void setFontPosition(Integer fontPosition) {
		this.fontPosition = fontPosition;
	}

	public Integer getFontOpacity() {
		return fontOpacity;
	}

	public void setFontOpacity(Integer fontOpacity) {
		this.fontOpacity = fontOpacity;
	}

	public String getCreatorId() {
		return creatorId;
	}

	public void setCreatorId(String creatorId) {
		this.creatorId = creatorId == null ? null : creatorId.trim();
	}

	public String getCreator() {
		return creator;
	}

	public void setCreator(String creator) {
		this.creator = creator == null ? null : creator.trim();
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public String getTerminalId() {
		return terminalId;
	}

	public void setTerminalId(String terminalId) {
		this.terminalId = terminalId == null ? null : terminalId.trim();
	}

	public String getStartDate() {
		return startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	public Integer getIsAdd() {
		return isAdd;
	}

	public void setIsAdd(Integer isAdd) {
		this.isAdd = isAdd;
	}

}