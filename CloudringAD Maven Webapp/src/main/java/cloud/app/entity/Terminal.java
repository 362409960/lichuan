package cloud.app.entity;

import java.util.Date;
import java.util.List;

public class Terminal extends BaseModel {
	private String id;

	private String name;

	private String ip;

	private String status;

	private String mechanism;

	private String mechanismName;

	private String packet;

	private String mac;

	private String address;

	private String firmware;

	private Double online;

	private String remark;

	private String reolution;

	private String version;

	private Date modifyDate;

	private Date createDate;

	private Double downSpeedLimit;

	private Integer volume;

	private List<Surveillance> surveillances;
	
	private List<String> ids;
	
	private List<String> departmentIds;
	
	private List<String> packets;
	
	
	private String startDate;
	private String endDate;
	private String message;

	private String packetName;
	private String userId;

	
	
	public List<String> getDepartmentIds() {
		return departmentIds;
	}

	public void setDepartmentIds(List<String> departmentIds) {
		this.departmentIds = departmentIds;
	}

	public List<String> getPackets() {
		return packets;
	}

	public void setPackets(List<String> packets) {
		this.packets = packets;
	}

	public List<Surveillance> getSurveillances() {
		return surveillances;
	}

	public void setSurveillances(List<Surveillance> surveillances) {
		this.surveillances = surveillances;
	}

	public String getPacketName() {
		return packetName;
	}

	public void setPacketName(String packetName) {
		this.packetName = packetName;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
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

	public List<String> getIds() {
		return ids;
	}

	public void setIds(List<String> ids) {
		this.ids = ids;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id == null ? null : id.trim();
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name == null ? null : name.trim();
	}

	public String getIp() {
		return ip;
	}

	public void setIp(String ip) {
		this.ip = ip == null ? null : ip.trim();
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status == null ? null : status.trim();
	}

	public String getMechanism() {
		return mechanism;
	}

	public void setMechanism(String mechanism) {
		this.mechanism = mechanism == null ? null : mechanism.trim();
	}

	public String getPacket() {
		return packet;
	}

	public void setPacket(String packet) {
		this.packet = packet == null ? null : packet.trim();
	}

	public String getMac() {
		return mac;
	}

	public void setMac(String mac) {
		this.mac = mac == null ? null : mac.trim();
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address == null ? null : address.trim();
	}

	public String getFirmware() {
		return firmware;
	}

	public void setFirmware(String firmware) {
		this.firmware = firmware == null ? null : firmware.trim();
	}

	public Double getOnline() {
		return online;
	}

	public void setOnline(Double online) {
		this.online = online;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark == null ? null : remark.trim();
	}

	public String getReolution() {
		return reolution;
	}

	public void setReolution(String reolution) {
		this.reolution = reolution == null ? null : reolution.trim();
	}

	public String getVersion() {
		return version;
	}

	public void setVersion(String version) {
		this.version = version == null ? null : version.trim();
	}

	public Date getModifyDate() {
		return modifyDate;
	}

	public void setModifyDate(Date modifyDate) {
		this.modifyDate = modifyDate;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public Double getDownSpeedLimit() {
		return downSpeedLimit;
	}

	public void setDownSpeedLimit(Double downSpeedLimit) {
		this.downSpeedLimit = downSpeedLimit;
	}

	public Integer getVolume() {
		return volume;
	}

	public void setVolume(Integer volume) {
		this.volume = volume;
	}

	public String getMechanismName() {
		return mechanismName;
	}

	public void setMechanismName(String mechanismName) {
		this.mechanismName = mechanismName;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

}