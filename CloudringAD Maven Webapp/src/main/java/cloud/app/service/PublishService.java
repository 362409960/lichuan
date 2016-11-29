package cloud.app.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import cloud.app.entity.Program;
import cloud.app.entity.Publish;
import cloud.app.system.vo.SysUserVO;

public interface PublishService  extends BaseService<Publish>{
	
	public String savePublish(HttpServletRequest request,Publish publish)throws Exception;
	
	public Integer getObjByProgramId(String id)throws Exception;
	
	public void updateBatch(Map<String, Object> map)throws Exception;
	
	public List<Publish> getByDownlodPublish(Publish publish)throws Exception;
	
	public Integer countDownlodPublish(Publish publish)throws Exception;
	
	public List<Publish> getProgramListByTerminal(String terminalId);

	
	public Program  updateData(String id,Program program)throws Exception;
	
	public void createFile(Program program,String srcFile);
	
	public String createZip(String prId,String srcFile, Program program,Publish publish,SysUserVO user,String zipName) throws Exception;
}
