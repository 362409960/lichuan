package cloud.app.dao;

import cloud.app.entity.ProgramDetails;

public interface ProgramDetailsDAO extends BaseDAO<ProgramDetails> {
	
	void updateByProgramId(ProgramDetails obj)throws Exception;

}
