package cloud.app.entity;


public class TimeSwitch{
	private String id;

    private String terminalId;

    private String week;

    private String powerMinute;

    private String powerHour;

    private String shutdownHour;

    private String shutdownMinute;

    private String iscycling;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id == null ? null : id.trim();
    }

    public String getTerminalId() {
        return terminalId;
    }

    public void setTerminalId(String terminalId) {
        this.terminalId = terminalId == null ? null : terminalId.trim();
    }

    public String getWeek() {
        return week;
    }

    public void setWeek(String week) {
        this.week = week;
    }

    public String getPowerMinute() {
        return powerMinute;
    }

    public void setPowerMinute(String powerMinute) {
        this.powerMinute = powerMinute == null ? null : powerMinute.trim();
    }

    public String getpowerHour() {
        return powerHour;
    }

    public void setpowerHour(String powerHour) {
        this.powerHour = powerHour == null ? null : powerHour.trim();
    }

    public String getshutdownHour() {
        return shutdownHour;
    }

    public void setshutdownHour(String shutdownHour) {
        this.shutdownHour = shutdownHour == null ? null : shutdownHour.trim();
    }

    public String getShutdownMinute() {
        return shutdownMinute;
    }

    public void setShutdownMinute(String shutdownMinute) {
        this.shutdownMinute = shutdownMinute == null ? null : shutdownMinute.trim();
    }

    public String getIscycling() {
        return iscycling;
    }

    public void setIscycling(String iscycling) {
        this.iscycling = iscycling == null ? null : iscycling.trim();
    }
}