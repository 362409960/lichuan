package cloud.app.service.impl;

import java.io.File;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cloud.app.common.Constants;
import cloud.app.dao.ProgramDAO;
import cloud.app.dao.PublishDAO;
import cloud.app.entity.Program;
import cloud.app.entity.Publish;
import cloud.app.service.PowerResourceService;
import cloud.app.vo.PowerProgramResourceVO;

//获取开机资源
@Service
public class PowerResourceServiceImpl implements PowerResourceService {
	Logger logger = Logger.getLogger(this.getClass());
	private final String DELIMITER = ",";
	
	@Autowired
	PublishDAO publishDAO;
	@Autowired
	ProgramDAO programDAO;
	
	
	public Map<String, PowerProgramResourceVO> getProgramByTerminalId(String terminalId) throws Exception {
		List<Publish> publishList = publishDAO.getPublishByTerminalId(terminalId);
		Map<String, String> programIdMap = new HashMap<String, String>();
		Map<String, PowerProgramResourceVO> resultMap = new HashMap<String, PowerProgramResourceVO>();
		
		
		if(publishList != null && publishList.size()>0){
			for(Publish Publish : publishList){
				String programId = Publish.getProgram_id();
				String[] programIds = programId.split(DELIMITER);

				for(String id : programIds){
					if(id != null && id.trim().length()>1){
						programIdMap.put(id, id);
					}
				}
			}

			//得到该节目的最高版本号
			Iterator<Entry<String, String>> iter = programIdMap.entrySet().iterator();
			while (iter.hasNext()) {
				PowerProgramResourceVO vo = new PowerProgramResourceVO();
				
				Entry<String, String> entry = iter.next();
				Object programId = entry.getKey();
				int maxVersion = publishDAO.getMaxVersionByProgramId(programId.toString());
				
				vo.setId(programId.toString());
				vo.setVersion(maxVersion);
				
				resultMap.put(programId.toString(), vo);
			}

			//得到节目的增量和增量
			Iterator<Entry<String, PowerProgramResourceVO>> tempIter = resultMap.entrySet().iterator();
			while (tempIter.hasNext()) {
				Entry<String, PowerProgramResourceVO> tempEntry = tempIter.next();
				Object programId = tempEntry.getKey();
				
				Program program = programDAO.getUrlAndAddUrlByProgramId(programId.toString());
				if(program == null) {
					continue;
				}
				
				PowerProgramResourceVO tempVO = resultMap.get(programId.toString());
				if(StringUtils.isEmpty(program.getIncrement_address())){
					tempVO.setAddUrl("");
				}else{
					tempVO.setAddUrl(program.getIncrement_address());
				}
				
				String url = trackerBT.Constants.configParam.get("url")+File.separator +Constants.CLOUD_ZIP_FILE+File.separator+program.getUser_id()+File.separator+programId.toString()+".zip";
				tempVO.setUrl(url);
				
				resultMap.put(programId.toString(), tempVO);
			}

		}
		
		return resultMap;
	}

}
