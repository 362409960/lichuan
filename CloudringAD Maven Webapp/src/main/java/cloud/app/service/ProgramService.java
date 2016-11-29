package cloud.app.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import cloud.app.entity.Program;
import cloud.app.system.vo.SysUserVO;

public interface ProgramService extends BaseService<Program> {
	
	
	public List<Program> getProgramByIdList(Map<String,Object> map)throws Exception;
	
	public List<Program> getProgramByStateList(Program program)throws Exception;
	
	public Integer countByState(Program program)throws Exception;
	
	public boolean deleteTerminalId(HttpServletRequest request,String [] ids)throws Exception;

	//返回map类型
	public Map<String,Object> saveProgramSonsTable(HttpServletRequest request,Program program)throws Exception;
	
	//不需要返回
	public Program saveProgramSonsTable(SysUserVO user,Program program)throws Exception;
	
	public List<Program> getDeleSonList(Program program)throws Exception;
	
	public Integer countDeleSon(Program program)throws Exception;
	
	
	
}
