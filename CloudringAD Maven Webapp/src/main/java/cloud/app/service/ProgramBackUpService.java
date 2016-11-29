package cloud.app.service;

import java.util.List;

import cloud.app.entity.Program;

public interface ProgramBackUpService {
	
	List<Program> getBackUpProgramList(Program program) throws Exception;
	
	Integer getBackUpProgramTotal(Program program)throws Exception;
}
