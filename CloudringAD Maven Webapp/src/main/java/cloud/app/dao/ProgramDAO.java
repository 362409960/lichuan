package cloud.app.dao;



import java.util.List;
import java.util.Map;

import cloud.app.entity.Program;

public interface ProgramDAO  extends BaseDAO<Program>{
	
	//查询id为多个的值。
	List<Program> getProgramByIdList(Map<String,Object> map)throws Exception;
	
	List<Program> getProgramByStateList(Program program)throws Exception;
	
	Integer countByState(Program program)throws Exception;

	//查询不存在当前对象里面id的所有值。
	List<Program> getListIsNotId(Program program)throws Exception;
	//统计不存在当前对象里面id的所有值。
	Integer countIsNotId(Program program)throws Exception;
	
	Integer updateCountUpdate(String id)throws Exception;

	Program getUrlAndAddUrlByProgramId(String string);
   

	List<Program> getDeleSonList(Program program)throws Exception;
	
	Integer countDeleSon(Program program)throws Exception;

	List<Program> getBackUpProgramList(Program program) throws Exception;

	Integer getBackUpProgramTotal(Program program) throws Exception;
	
}
