package cloud.app.entity;

public class TempTimeSwitch {
	private String id;
	private String iscycling;
	private String week;
	private String powerHour;
	private String powerMinute;
	private String shutdownHour;
	private String shutdownMinute;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getIscycling() {
		return iscycling;
	}

	public void setIscycling(String iscycling) {
		this.iscycling = iscycling;
	}

	public String getWeek() {
		return week;
	}

	public void setWeek(String week) {
		this.week = week;
	}

	public String getPowerHour() {
		return powerHour;
	}

	public void setPowerHour(String powerHour) {
		this.powerHour = powerHour;
	}

	public String getPowerMinute() {
		return powerMinute;
	}

	public void setPowerMinute(String powerMinute) {
		this.powerMinute = powerMinute;
	}

	public String getShutdownHour() {
		return shutdownHour;
	}

	public void setShutdownHour(String shutdownHour) {
		this.shutdownHour = shutdownHour;
	}

	public String getShutdownMinute() {
		return shutdownMinute;
	}

	public void setShutdownMinute(String shutdownMinute) {
		this.shutdownMinute = shutdownMinute;
	}

}
