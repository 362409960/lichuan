package cloud.app.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cloud.app.common.Constants;
import cloud.app.dao.ProgramDAO;
import cloud.app.dao.ProgramDetailsDAO;
import cloud.app.entity.Program;
import cloud.app.entity.ProgramDetails;
import cloud.app.entity.Terminal;
import cloud.app.service.ProgramService;
import cloud.app.service.TerminalService;
import cloud.app.service.mqtt.impl.WebMqttClient;
import cloud.app.system.vo.SysUserVO;
@Service
public class ProgramServiceImpl implements ProgramService {
	
	Logger logger = Logger.getLogger(this.getClass());
	@Autowired
	private ProgramDAO programDAO;
	
	@Autowired
	WebMqttClient webMqttClient;
	@Autowired
	private TerminalService terminalService;
	
	@Autowired
	private ProgramDetailsDAO programDetailsDAO;

	@Override
	public void save(Program obj) throws Exception {
		programDAO.save(obj);

	}

	@Override
	public void update(Program obj) throws Exception {
		programDAO.update(obj);
	}

	@Override
	public void deleteById(String id) throws Exception {
		programDAO.deleteById(id);

	}

	@Override
	public List<Program> getList(Program obj) throws Exception {
		
		return programDAO.getList(obj);
	}

	@Override
	public Integer count(Program obj) throws Exception {
		
		return programDAO.count(obj);
	}

	@Override
	public Program getObjById(String id) throws Exception {
		
		return programDAO.getObjById(id);
	}

	@Override
	public void deleteByIdS(Map<String, Object> map) throws Exception {
		
		programDAO.deleteByIdS(map);
	}

	@Override
	public List<Program> getProgramByIdList(Map<String, Object> map)
			throws Exception {		
		return programDAO.getProgramByIdList(map);
	}

	@Override
	public List<Program> getProgramByStateList(Program program)
			throws Exception {	
		return programDAO.getProgramByStateList(program);
	}

	@Override
	public Integer countByState(Program program) throws Exception {	
		return programDAO.countByState(program);
	}
	
	@Override
	public List<Program> getDeleSonList(Program program) throws Exception {
		// TODO Auto-generated method stub
		return programDAO.getDeleSonList(program);
	}

	@Override
	public Integer countDeleSon(Program program) throws Exception {
		// TODO Auto-generated method stub
		return programDAO.countDeleSon(program);
	}
	

	@Override
	public boolean deleteTerminalId(HttpServletRequest request, String[] ids)
			throws Exception {
		SysUserVO user=(SysUserVO) request.getSession().getAttribute(Constants.SESSION_LOGIN_USER);			
		Program program=new Program();
		for(String id:ids){//更新state字段状态。
			program.setId(id);
			program.setState("2");
			program.setUpdated(new Date());
			update(program);
		}
		 Terminal terminal=new Terminal();
		 terminal.setMechanism(user.getDepartmentid());
		 terminal.setPageIndex(0);
		 terminal.setPageSize(Integer.MAX_VALUE);
		 List<Terminal> terminalList=terminalService.getList(terminal);
		 String terminalId="";//终端Id,以123,23,34记录.
		 for(Terminal t:terminalList){
			 terminalId+=t.getId()+",";
		 }
		 terminalId=terminalId.substring(0, terminalId.length()-1);
		 
		 String [] terminal_ids=terminalId.split(",");
			for(String tId:terminal_ids){
				String topic = "cloudringAd/server/web/"+tId+"/out";
				logger.info("-------------------------> "+topic);
				for(String pId:ids){//拿到节目id
					String message = "{\"action\":\"emptyProgram\",\"id\":\""+pId+"\"}";				
					logger.info("send start.--------------------------> "+message);
					webMqttClient.publish(topic,1, message.getBytes());	
					logger.info("send over.");
				}
			}
		
		return true;
	}

	/**
	 * 保存产品表和明细表
	 */
	@Override
	public Map<String, Object> saveProgramSonsTable(HttpServletRequest request,Program program) throws Exception {
		 SysUserVO user=(SysUserVO) request.getSession().getAttribute(Constants.SESSION_LOGIN_USER);
		 Map<String,Object> mapJson=new LinkedHashMap<String,Object>();
		 List<ProgramDetails> list=new ArrayList<ProgramDetails>();
			String pid=null;
			String sonPid=null;
			if(program.getId().isEmpty()&&"".equals(program.getId())){
				 pid=UUID.randomUUID().toString().replace("-", "");
				 program.setId(pid);		
				 program.setCreate_time(new Date());
				 program.setUser_id(user.getId());				
				 program.setAffiliations(user.getDepartmentid());
				 program.setUser_name(user.getUserCode());
				 program.setState("0");
				 program.setIs_bg_music("0");
				programDAO.save(program);			
				sonPid=UUID.randomUUID().toString().replace("-", "");
				ProgramDetails programDetails=assemblyPrgramDetailsObjects(sonPid,pid,program);			
				programDetails.setCreate_time(new Date());
				programDetails.setUpdate_time(new Date());
				programDetails.setCreater_user(user.getUserCode());
				programDetails.setUpdate_user(user.getUserCode());			
				programDetailsDAO.save(programDetails);
				list=programDetailsDAO.getList(programDetails);
			}else{
				pid=program.getId();
				sonPid=program.getSonId();
				Program program2=programDAO.getObjById(pid);
				if(program.getBagrmusic()!=null && !"".equals(program.getBagrmusic())){
					if(!program.getBagrmusic().equals(program2.getBagrmusic())){
						program.setIs_bg_music("1");
					}
				}
				program.setUpdated(new Date());	
				programDAO.update(program);
				if(program.getSonId().isEmpty()&&"".equals(program.getSonId())){
					sonPid=UUID.randomUUID().toString().replace("-", "");
					ProgramDetails programDetails=assemblyPrgramDetailsObjects(sonPid,pid,program);			
					programDetails.setCreate_time(new Date());					
					programDetails.setCreater_user(user.getUserCode());					
					programDetailsDAO.save(programDetails);
					list=programDetailsDAO.getList(programDetails);
				}else{
					ProgramDetails programDetails=assemblyPrgramDetailsObjects(sonPid,pid,program);
					ProgramDetails programDetails1=programDetailsDAO.getObjById(sonPid);
					if(!programDetails1.getContext().trim().equals(program.getContext().trim())){
						programDetails.setCont_change("1");
					}
					if(dealWithString(programDetails1.getVideo_url(),programDetails.getVideo_url())!=""){
						programDetails.setVideo_url_update(dealWithString(programDetails1.getVideo_url(),programDetails.getVideo_url()));
					}
					if(dealWithString(programDetails1.getImgae_url(),programDetails.getImgae_url())!=""){
						programDetails.setImgae_url_update(dealWithString(programDetails1.getImgae_url(),programDetails.getImgae_url()));
					}
					if(dealWithString(programDetails1.getPdf_url(),programDetails.getPdf_url())!=""){
						programDetails.setPdf_url_update(dealWithString(programDetails1.getPdf_url(),programDetails.getPdf_url()));
					}					
					programDetails.setUpdate_time(new Date());
					programDetails.setUpdate_user(user.getUserCode());			
					programDetailsDAO.update(programDetails);
					 list=programDetailsDAO.getList(programDetails);
				}
			}
			 
			 mapJson.put("id", pid);
			 mapJson.put("sonId", sonPid);
			 mapJson.put("scens", list);
		
		
		return mapJson;
	}

	
	@Override
	public Program saveProgramSonsTable(SysUserVO user, Program program)
			throws Exception {
		String pid=null;
		String sonPid=null;
		if(program.getId().isEmpty()&&"".equals(program.getId())){
			 pid=UUID.randomUUID().toString().replace("-", "");
			 program.setId(pid);		
			 program.setCreate_time(new Date());
			 program.setUser_id(user.getId());			 
			 program.setAffiliations(user.getDepartmentid());
			 program.setUser_name(user.getUserCode());
			 program.setState("0");
			 program.setIs_bg_music("0");
			programDAO.save(program);
			sonPid=UUID.randomUUID().toString().replace("-", "");
			ProgramDetails programDetails=assemblyPrgramDetailsObjects(sonPid,pid,program);			
			programDetails.setCreate_time(new Date());		
			programDetails.setCreater_user(user.getUserCode());				
			programDetailsDAO.save(programDetails);
			
		}else{
			pid=program.getId();
			sonPid=program.getSonId();
			Program program2=programDAO.getObjById(pid);
			if(program.getBagrmusic()!=null && !"".equals(program.getBagrmusic())){
				if(!program.getBagrmusic().equals(program2.getBagrmusic())){
					program.setIs_bg_music("1");
				}
			}
			program.setUpdated(new Date());	
			programDAO.update(program);
			if(program.getSonId().isEmpty()&&"".equals(program.getSonId())){
				sonPid=UUID.randomUUID().toString().replace("-", "");
				ProgramDetails programDetails=assemblyPrgramDetailsObjects(sonPid,pid,program);			
				programDetails.setCreate_time(new Date());				
				programDetails.setCreater_user(user.getUserCode());					
				programDetailsDAO.save(programDetails);
			}else{				
				ProgramDetails programDetails=assemblyPrgramDetailsObjects(sonPid,pid,program);	
				ProgramDetails programDetails1=programDetailsDAO.getObjById(sonPid);	
				if(!programDetails1.getContext().trim().equals(program.getContext().trim())){
					programDetails.setCont_change("1");
				}
				if(dealWithString(programDetails1.getVideo_url(),programDetails.getVideo_url())!=""){
					programDetails.setVideo_url_update(dealWithString(programDetails1.getVideo_url(),programDetails.getVideo_url()));
				}
				if(dealWithString(programDetails1.getImgae_url(),programDetails.getImgae_url())!=""){
					programDetails.setImgae_url_update(dealWithString(programDetails1.getImgae_url(),programDetails.getImgae_url()));
				}
				if(dealWithString(programDetails1.getPdf_url(),programDetails.getPdf_url())!=""){
					programDetails.setPdf_url_update(dealWithString(programDetails1.getPdf_url(),programDetails.getPdf_url()));
				}
				
				programDetails.setUpdate_time(new Date());
				programDetails.setUpdate_user(user.getUserCode());			
				programDetailsDAO.update(programDetails);
			}
		}
		return program;
		
	}
	
	/**
	 * 
	 * @param id
	 * @param pid
	 * @param program
	 * @return
	 */
	private ProgramDetails assemblyPrgramDetailsObjects(String id,String pid,Program program){
		ProgramDetails programDetails=new ProgramDetails();
		programDetails.setId(id);
		programDetails.setProgramId(pid);
		programDetails.setContext(program.getContext());
		programDetails.setContext_video(program.getContext_video());
		programDetails.setImgae_url(program.getImgae_url());
		programDetails.setPlay_time(program.getPlay_time());
		programDetails.setScenes(program.getScenes());
		if("".equals(program.getBagrmusic())){
			programDetails.setIs_b_music(0);
		}else{
			programDetails.setIs_b_music(1);
		}
		programDetails.setStream_height(program.getStream_height());
		programDetails.setStream_left(program.getStream_left());
		programDetails.setStream_top(program.getStream_top());
		programDetails.setStream_width(program.getStream_width());
		programDetails.setVideo_stream(program.getVideo_stream());
		programDetails.setVideo_url(program.getVideo_url());
		programDetails.setVideoPlace_url(program.getVideoPlace_url());
		programDetails.setPdf_url(program.getPdf_url());
		programDetails.setBackground_picture(program.getBackground_picture());
		return programDetails;
		
	}


	//处理字符串
	private static String dealWithString(String oldstr, String newstr) {
		String createNewString = "";
		if(oldstr!=null && newstr !=null){
			String[] rep1 = oldstr.split(",");
			String[] rep2 = newstr.split(",");
			String[] rep3 = arrContrast(rep2, rep1);		
			if (rep3.length > 0) {
				for (String str : rep3) {
					createNewString += str + ",";
				}
				createNewString = createNewString.substring(0,
						createNewString.length() - 1);
			}
		}

		return createNewString;
	}

	// 处理数组字符
	private static String[] arrContrast(String[] arr1, String[] arr2) {
		List<String> list = new LinkedList<String>();
		for (String str : arr1) { // 处理第一个数组,list里面的值为1,2,3,4
			if (!list.contains(str)) {
				list.add(str);
			}
		}
		for (String str : arr2) { // 如果第二个数组存在和第一个数组相同的值，就删除
			if (list.contains(str)) {
				list.remove(str);
			}
		}
		String[] result = {}; // 创建空数组
		return list.toArray(result); // List to Array
	}

	
	

}
