package cloud.app.vo;

import java.util.List;

public class SyncResourcesVO {
	
	String action;
	String errno;
	String tm;
	String terminalId;
	
	List<PowerProgramResourceVO>  programList;
	List<SurveillanceVO> vmIpList;
	
	
	public String getAction() {
		return action;
	}
	public void setAction(String action) {
		this.action = action;
	}
	public String getErrno() {
		return errno;
	}
	public void setErrno(String errno) {
		this.errno = errno;
	}
	public String getTm() {
		return tm;
	}
	public void setTm(String tm) {
		this.tm = tm;
	}
	public String getTerminalId() {
		return terminalId;
	}
	public void setTerminalId(String terminalId) {
		this.terminalId = terminalId;
	}
	public List<PowerProgramResourceVO> getProgramList() {
		return programList;
	}
	public void setProgramList(List<PowerProgramResourceVO> programList) {
		this.programList = programList;
	}
	public List<SurveillanceVO> getVmIpList() {
		return vmIpList;
	}
	public void setVmIpList(List<SurveillanceVO> vmIpList) {
		this.vmIpList = vmIpList;
	}
	
	
	
}
