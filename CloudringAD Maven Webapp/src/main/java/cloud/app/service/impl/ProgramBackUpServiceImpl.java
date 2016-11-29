package cloud.app.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cloud.app.dao.ProgramDAO;
import cloud.app.entity.Program;
import cloud.app.service.ProgramBackUpService;

@Service
public class ProgramBackUpServiceImpl implements ProgramBackUpService {
	
	@Autowired
	ProgramDAO programDAO;
	
	public List<Program> getBackUpProgramList(Program program) throws Exception {
		return programDAO.getBackUpProgramList(program);
	}

	public Integer getBackUpProgramTotal(Program program) throws Exception {
		return programDAO.getBackUpProgramTotal(program);
	}

	
	
}
