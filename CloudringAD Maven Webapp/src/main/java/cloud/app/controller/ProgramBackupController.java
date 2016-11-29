package cloud.app.controller;

import java.io.File;
import java.io.FilenameFilter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import cloud.app.common.Constants;
import cloud.app.common.FileUtil;
import cloud.app.dao.ProgramDAO;
import cloud.app.entity.Program;
import cloud.app.entity.Publish;
import cloud.app.service.ProgramBackUpService;
import cloud.app.service.PublishService;
import cloud.app.system.vo.SysUserVO;


@Controller
@RequestMapping("/programBackup")
public class ProgramBackupController {
	
	@Autowired
	private ProgramBackUpService programBackUpService;
	@Autowired
	private PublishService publishService;
	final int kb = 1024;

	@Autowired
	private ProgramDAO programDAO;
	
	@RequestMapping(value = "/list")
	public String list(HttpServletRequest request,HttpServletResponse response, Program queryProgram)throws Exception {
		try {

			Map<String, Long> fileMap = new HashMap<String, Long>();
			List<Program> programList = new ArrayList<Program>();
	 
			SysUserVO sysUserVO = (SysUserVO) request.getSession().getAttribute(Constants.SESSION_LOGIN_USER);
			if(sysUserVO == null){
				throw new Exception("session 已过期，请重新登录.");
			}
			
			//取该用户下的所有zip包
			String path = trackerBT.Constants.configParam.get("btProject")+File.separator+sysUserVO.getId()+File.separator; 
			String downloadPath = trackerBT.Constants.configParam.get("url")+File.separator+"example"+File.separator+sysUserVO.getId()+File.separator;
			String zipPath = File.separator+"example"+File.separator+sysUserVO.getId()+File.separator;
			
			File file = new File(path);
			if(file.isDirectory() && file.exists()){
				File[] zipFiles = file.listFiles(new FileNameSelector("zip"));
				
				if(zipFiles != null && zipFiles.length > 0){
					for(File f : zipFiles){
						fileMap.put(f.getName(), f.length()/kb);
					}
				}
			}
	 
			queryProgram.setUser_id(sysUserVO.getId()); 
			queryProgram.setState("1");  //发布了的节目

			//当前页
			if(queryProgram.getPageNumber() == null || queryProgram.getPageNumber() == 0){
				queryProgram.setPageNumber(1);
			}
			//结束位置
			if(queryProgram.getPageSize() == null || queryProgram.getPageSize() == 0){
				queryProgram.setPageSize(10);
			}

			//开始位置
			queryProgram.setPageIndex((queryProgram.getPageNumber() - 1) * queryProgram.getPageSize());

			List<Program> backUpList = programBackUpService.getBackUpProgramList(queryProgram);
			if(backUpList != null && backUpList.size() > 0){
				for(Program p : backUpList){
					if(fileMap.containsKey(p.getId().concat(".zip"))){
						
						//p.setFile_url("http://120.24.46.165/example/0c517db57d6c4d708719b8b0362c3735/3b623287e4a34ef1a3cabb343dc43066.zip");
						p.setFile_url(downloadPath+p.getId().concat(".zip"));
						p.setFileSize(fileMap.get(p.getId().concat(".zip")));
						p.setZipPath(zipPath+p.getId().concat(".zip"));
						programList.add(p);
					}else{
						//重新生成压缩包
						Program program = publishService.updateData(p.getId(), p);
						//先把公共部分生成
						String srcFile = FileUtil.copyPublic(p.getId());
						publishService.createFile(program,srcFile);
						String zipName=p.getId();
						Publish publish = new Publish();
						publish.setProgram_id(p.getId());
						publish.setPageSize(10);
						publish.setPageIndex(0);

						List<Publish> entityList = publishService.getList(publish);
						Publish temp = entityList.get(0);

						String tempFile = publishService.createZip(p.getId(), srcFile, program, temp, sysUserVO, zipName);
						File tmp = new File(tempFile);
						
						program.setFile_url(downloadPath+p.getId().concat(".zip"));
						p.setZipPath(zipPath+p.getId().concat(".zip"));
						if(tmp != null){
							program.setFileSize(tmp.length()/kb);
						}

						programList.add(program);
					}
				}
			}
						
			int total = programBackUpService.getBackUpProgramTotal(queryProgram);
			Integer count=((total%queryProgram.getPageSize())==0)?total/queryProgram.getPageSize():(total/queryProgram.getPageSize()+1);//最大页数			
			queryProgram.setTotal(total);		
			queryProgram.setPageMax(count);				
			queryProgram.setRows(programList);
			
			return "page/program/program_backup_list";
		} catch (Exception e) {
			throw new Exception(e.getMessage());
		}
	};
	
	
	class FileNameSelector implements FilenameFilter {
		String extension = ".";
		
		public FileNameSelector(String fileExtends){
			extension += fileExtends;
		}
		
		public boolean accept(File dir, String name) {
			 return name.endsWith(extension);
		}
		
	}
	
	
}
