package cloud.app.service.impl;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.jdom.Document;
import org.jdom.Element;
import org.jdom.JDOMException;
import org.jdom.output.Format;
import org.jdom.output.XMLOutputter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cloud.app.common.Constants;
import cloud.app.common.FileUtil;
import cloud.app.common.PropertiesUtils;
import cloud.app.common.ZipUtil;
import cloud.app.dao.MaterialDAO;
import cloud.app.dao.ProgramDAO;
import cloud.app.dao.ProgramDetailsDAO;
import cloud.app.dao.PublishDAO;
import cloud.app.dao.PublishTerminalDAO;
import cloud.app.dao.TerminalDAO;
import cloud.app.entity.Material;
import cloud.app.entity.Program;
import cloud.app.entity.ProgramDetails;
import cloud.app.entity.Publish;
import cloud.app.entity.PublishTerminal;
import cloud.app.service.BtService;
import cloud.app.service.PublishService;
import cloud.app.service.mqtt.impl.WebMqttClient;
import cloud.app.system.vo.SysUserVO;

@Service
public class PublishServiceImpl implements PublishService {
	Logger logger = Logger.getLogger(this.getClass());

	private static SimpleDateFormat dsf = new SimpleDateFormat("yyMMddHHmmss");
	private static SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

	@Autowired
	private TerminalDAO terminalDAO;
	@Autowired
	private PublishTerminalDAO publishTerminalDAO;
	@Autowired
	private PublishDAO publishDAO;
	@Autowired
	private ProgramDAO programDAO;
	@Autowired
	private BtService btService;
	@Autowired
	WebMqttClient webMqttClient;

	@Autowired
	private ProgramDetailsDAO programDetailsDAO;
	@Autowired
	private MaterialDAO materialDAO;

	@Override
	public void save(Publish obj) throws Exception {
		publishDAO.save(obj);

	}

	@Override
	public void update(Publish obj) throws Exception {
		publishDAO.update(obj);

	}

	@Override
	public void deleteById(String id) throws Exception {
		publishDAO.deleteById(id);

	}

	@Override
	public List<Publish> getList(Publish obj) throws Exception {

		return publishDAO.getList(obj);
	}

	@Override
	public Integer count(Publish obj) throws Exception {

		return publishDAO.count(obj);
	}

	@Override
	public Publish getObjById(String id) throws Exception {

		return publishDAO.getObjById(id);
	}

	@Override
	public void deleteByIdS(Map<String, Object> map) throws Exception {
		publishDAO.deleteByIdS(map);
	}

	@Override
	public Integer getObjByProgramId(String id) throws Exception {
		return publishDAO.getObjByProgramId(id);
	}

	@Override
	public void updateBatch(Map<String, Object> map) throws Exception {
		publishDAO.updateBatch(map);

	}

	@Override
	public List<Publish> getByDownlodPublish(Publish publish) throws Exception {
		// TODO Auto-generated method stub
		return publishDAO.getByDownlodPublish(publish);
	}

	@Override
	public Integer countDownlodPublish(Publish publish) throws Exception {
		// TODO Auto-generated method stub
		return publishDAO.countDownlodPublish(publish);
	}

	@Override
	public List<Publish> getProgramListByTerminal(String terminalId) {
		return publishDAO.getProgramListByTerminal(terminalId);
	}

	/**
	 * 逻辑处理数据
	 */
	@Override
	public String savePublish(HttpServletRequest request, Publish publish) throws Exception {
		SysUserVO user = (SysUserVO) request.getSession().getAttribute(Constants.SESSION_LOGIN_USER);
		String terminalId = publish.getTermainId();// 终端Id,以123,23,34记录.
		// 先生成临时文件，后保存后删除临时文件。
		String programId = publish.getProgram_id();
		String[] programIds = publish.getProgram_id().split(",");
		for (String prId : programIds) {
			Integer version = publishDAO.getObjByProgramId(prId);
			Integer iscount = programDAO.updateCountUpdate(prId);
			if (iscount > 0) {
				version = version + 1;
			}
			if (version == 0) {
				version = 1;
			}
			publish.setVersion(version);
			Program program = programDAO.getObjById(prId);
			program = updateData(prId, program);
			// 先把公共部分生成
			String srcFile = FileUtil.copyPublic(prId);
			//
			createFile(program, srcFile);
			String zipName = prId;
			String zipFileName = createZip(prId, srcFile, program, publish, user, zipName);

			//
			// 生成bt文件
			// String bitFile=btService.btHandle(user.getId(), zipFileName,
			// zipFileName, user.getUserCode());
			// 换成http开头的。
			// String
			// bif=trackerBT.Constants.configParam.get("url")+File.separator
			// +bitFile.split("webapps")[1];
			String bif = trackerBT.Constants.configParam.get("url") + File.separator + "example" + File.separator
					+ user.getId() + File.separator + zipFileName;

			String bifUpdateFile = "";
			String bifUpdate = "";
			// 判断是否有更新的

			if (iscount > 0) {
				program = updateAllData(prId, program);
				// 先把公共部分生成
				String srcFiles = FileUtil.copyUpdatePublic(prId);
				//
				createFile(program, srcFiles);

				program = updateData(prId, program);
				String zipUpdateName = prId + "_" + dsf.format(new Date());
				String zipUpdateFileName = createZip(prId, srcFile, program, publish, user, zipUpdateName);

				// bifUpdateFile=btService.btHandle(user.getId(),
				// zipUpdateFileName, zipUpdateFileName, user.getUserCode());
				// bifUpdate=trackerBT.Constants.configParam.get("url")+File.separator
				// +bifUpdateFile.split("webapps")[1];

				bifUpdate = trackerBT.Constants.configParam.get("url") + File.separator + "example" + File.separator
						+ user.getId() + File.separator + zipUpdateFileName;

				ProgramDetails pds = new ProgramDetails();
				pds.setProgramId(prId);
				pds.setImgae_url_update(null);
				pds.setVideo_url_update(null);
				pds.setPdf_url_update(null);
				pds.setCont_change(null);
				programDetailsDAO.updateByProgramId(pds);
			} else {
				bifUpdate = program.getIncrement_address();
			}
			if (version == 0) {
				version = 1;
			}
			publish.setVersion(version);
			// 把bt文件发布到终端调用mqtt,把在线的terminalId拿出来发送
			String[] terminal_ids = terminalId.split(",");
			for (String id : terminal_ids) {
				String topic = "cloudringAd/server/web/" + id + "/out";
				logger.info("-------------------------> " + topic);
				String message = "{\"action\":\"publish\",\"url\":\"" + bif + "\",\"id\":\"" + programId
						+ "\",\"addUrl\":\"" + bifUpdate + "\",\"version\":" + version + "}";

				logger.info("send start.--------------------------> " + message);
				webMqttClient.publish(topic, 1, message.getBytes());
				logger.info("send over.");
			}
			// 返回成功，则状态为已审批1，如果返回失败，则审批中0，保存数据库
			// 先把制作表里面的状态改成1，改成发布信息

			Program p = new Program();
			p.setId(prId);
			p.setState("1");
			p.setIs_bg_music("0");
			p.setIncrement_address(bifUpdate);
			programDAO.update(p);

		}

		String id = UUID.randomUUID().toString().replace("-", "");
		Date now = new Date();
		String taskId = "PB" + dsf.format(now);
		publish.setId(id);
		publish.setUser_id(user.getId());
		publish.setCreate_time(new Date());
		publish.setPublish_time(new Date());
		publish.setAffiliations(user.getDepartmentid());
		publish.setPublish_user(user.getUserCode());
		publish.setTask_id(taskId);
		publish.setExpiration(sf.parse(publish.getExpirationTime() + ":00"));
		publish.setTermianl_id(terminalId);
		// 返回成功，则状态为已审批1，如果返回失败，则审批中0
		publish.setState("1");

		publishDAO.save(publish);

		// 字表记录
		PublishTerminal p = new PublishTerminal();
		String[] tId = terminalId.split(",");
		for (int i = 0; i < tId.length; i++) {
			p.setId(UUID.randomUUID().toString().replace("-", ""));
			p.setProgram(publish.getProgram_name());
			p.setUser_id(user.getId());
			p.setPublish_id(id);
			p.setTermianl_id(tId[i]);
			p.setState("0");
			p.setProgram_id(programId);
			publishTerminalDAO.save(p);
		}

		// 把id返回
		return id;
	}

	/**
	 * 生成xml
	 * 
	 * @param file
	 * @param program
	 * @param html
	 * @throws IOException
	 * @throws JDOMException
	 */
	private static void BuildXMLDoc(String file, Program program, List<ProgramDetails> pdList, Publish publish)
			throws IOException, JDOMException {
		Element root = new Element("Resources");
		Document Doc = new Document(root);

		Element elements = new Element("Type");
		elements.setAttribute("value", "Program");
		root.addContent(elements);

		Element elementsId = new Element("ID");
		elementsId.setAttribute("value", program.getId());
		root.addContent(elementsId);

		Element elementsEditorVersion = new Element("EditorVersion");
		elementsEditorVersion.setAttribute("value", "2.0");
		root.addContent(elementsEditorVersion);

		Element elementsCode = new Element("Code");
		elementsCode.setAttribute("value", program.getId());
		root.addContent(elementsCode);

		Element elementsName = new Element("Name");
		elementsName.setAttribute("value", "webpage");
		root.addContent(elementsName);

		Element elementsProgramType = new Element("ProgramType");
		elementsProgramType.setAttribute("value", program.getResolution());
		root.addContent(elementsProgramType);

		// 图片
		if (!"".equals(program.getImgae_url()) && program.getImgae_url() != null) {
			String[] img = program.getImgae_url().split(",");
			Element elementsImageList = new Element("ImageList");
			for (int i = 0; i < img.length; i++) {
				Element image = new Element("Image");
				image.setAttribute("value", img[i].replaceAll("/upload_cloudfile/upload/", ""));
				image.setAttribute("name", img[i].replaceAll("/upload_cloudfile/upload/image/", ""));
				elementsImageList.addContent(image);
			}
			root.addContent(elementsImageList);
		}
		// 视频
		if (!"".equals(program.getVideo_url()) && program.getVideo_url() != null) {
			String[] vid = program.getVideo_url().split(",");
			Element elementsVideoList = new Element("VideoList");
			for (int i = 0; i < vid.length; i++) {
				Element video = new Element("Video");
				video.setAttribute("value", vid[i].replaceAll("/upload_cloudfile/upload/", ""));
				video.setAttribute("name", vid[i].replaceAll("/upload_cloudfile/upload/video/", ""));
				elementsVideoList.addContent(video);
			}
			root.addContent(elementsVideoList);
		}

		// pdf
		if (!"".equals(program.getPdf_url()) && program.getPdf_url() != null) {
			String[] vid = program.getPdf_url().split(",");
			Element elementsPDFList = new Element("PDFList");
			for (int i = 0; i < vid.length; i++) {
				Element pdf = new Element("Pdf");
				pdf.setAttribute("value", vid[i].replaceAll("/upload_cloudfile/upload/", ""));
				pdf.setAttribute("name", vid[i].replaceAll("/upload_cloudfile/upload/doc/", ""));
				elementsPDFList.addContent(pdf);
			}
			root.addContent(elementsPDFList);
		}

		// 视频流
		if (!"".equals(program.getVideoPlace_url()) && program.getVideoPlace_url() != null) {
			Element videoMonitorList = new Element("VideoMonitorList");
			for (ProgramDetails pd : pdList) {
				if (!"".equals(pd.getVideoPlace_url()) && pd.getVideoPlace_url() != null) {
					String[] top = pd.getStream_top().split(",");
					String[] width = pd.getStream_width().split(",");
					String[] left = pd.getStream_left().split(",");
					String[] heigth = pd.getStream_height().split(",");
					String[] ip = pd.getVideo_stream().split("#");
					for (int i = 0; i < top.length; i++) {
						Element place = new Element("Place");
						place.setAttribute("url",
								pd.getVideoPlace_url().replaceAll("/CloudringAD/images/sys", "SceneImages"));
						place.setAttribute("top", top[i]);
						place.setAttribute("height", heigth[i]);
						place.setAttribute("width", width[i]);
						place.setAttribute("left", left[i]);
						place.setAttribute("ip", ip[i]);
						place.setAttribute("view", pd.getId() + ".html");
						videoMonitorList.addContent(place);
					}
				}
			}
			root.addContent(videoMonitorList);
		}
		// 背景音乐
		if (!"".equals(program.getBagrmusic()) && program.getBagrmusic() != null) {
			Element musicMonitorList = new Element("BackgroundMusicList");
			Element place = new Element("Music");
			place.setAttribute("value", "music" + File.separator + program.getBagrmusic());
			place.setAttribute("name", program.getBagrmusic());
			musicMonitorList.addContent(place);
			root.addContent(musicMonitorList);
		}

		Element systemProperties = new Element("SystemProperties");
		Element place = new Element("properties");
		if (publish.getIsEngross() != null) {
			place.setAttribute("isEngross", "独占");
		}

		if (!"".equals(publish.getScheduledPublish())) {
			place.setAttribute("scheduledPublish", publish.getScheduledPublish());
		}
		place.setAttribute("playMode", publish.getPlayMode());
		place.setAttribute("modeContent", publish.getModeContent());
		systemProperties.addContent(place);
		root.addContent(systemProperties);

		Element elementsSceneList = new Element("SceneList");
		Integer i = 1;
		for (ProgramDetails pd : pdList) {
			Element scene = new Element("Scene");
			Element url = new Element("url");
			url.setText(pd.getId() + ".html");
			scene.addContent(url);
			Element stayTime = new Element("StayTime");
			stayTime.setText(pd.getPlay_time());
			scene.addContent(stayTime);
			Element backgroundMusic = new Element("BackgroundMusic");
			if (pd.getIs_b_music().equals("0")) {
				backgroundMusic.setText("false");
			} else {
				backgroundMusic.setText("true");
			}
			scene.addContent(backgroundMusic);
			Element playOrder = new Element("PlayOrder");
			playOrder.setText(i.toString());
			scene.addContent(playOrder);
			Element itemName = new Element("ItemName");
			itemName.setText(pd.getScenes());
			scene.addContent(itemName);
			elementsSceneList.addContent(scene);
			i++;
		}
		root.addContent(elementsSceneList);

		Element elementsVersionType = new Element("Version");
		elementsVersionType.setAttribute("value", String.valueOf(publish.getVersion()));
		root.addContent(elementsVersionType);

		Format format = Format.getPrettyFormat();
		format.setEncoding("utf-8");
		XMLOutputter XMLOut = new XMLOutputter(format);
		File f = new File(file);
		if (f.exists()) {
			f.delete();
		}
		FileOutputStream outStream = new FileOutputStream(file);
		XMLOut.output(Doc, outStream);
		outStream.close();

	}

	/**
	 * 生成html5
	 * 
	 * @param fileName
	 * @param program
	 * @throws IOException
	 */
	private static void createHtml(String fileName, Program program, ProgramDetails p) throws IOException {
		File myFile = new File(fileName);
		if (myFile.exists()) {
			myFile.delete();
		}
		myFile.createNewFile();

		StringBuffer buff = new StringBuffer();
		buff.append("<!DOCTYPE><html><head>");
		buff.append("<meta content=\"text/html; charset=utf-8\" http-equiv=Content-Type>");
		// css
		buff.append("<link rel=\"stylesheet\" type=\"text/css\" href=\"css/common.css\">");
		buff.append("<link rel=\"stylesheet\" type=\"text/css\" href=\"css/main.css\">");
		buff.append("<link rel=\"stylesheet\" type=\"text/css\" href=\"css/editor.css\">");
		buff.append("<link rel=\"stylesheet\" type=\"text/css\" href=\"css/default.css\">");
		buff.append("<link rel=\"stylesheet\" type=\"text/css\" href=\"css/jquery.cxcolor.css\">");
		buff.append("<link rel=\"stylesheet\" type=\"text/css\" href=\"css/jquery.contextmenu.css\">");
		buff.append("<link rel=\"stylesheet\" type=\"text/css\" href=\"css/music.css\">");
		buff.append("<link rel=\"stylesheet\" type=\"text/css\" href=\"css/TweenMax.css\">");
		// js
		buff.append("<script type=\"text/javascript\" src=\"js/jquery.js\"></script>");
		buff.append("<script type=\"text/javascript\" src=\"js/jquery-ui.js\"></script>");
		buff.append(
				"<style>.div{width:100%;height:100%;}.ui-widget-content{border:none}iframe { height: 100%;width: 100%;}img{width:100%;height:100%}video{width:100%;height:100%}.clock > img{width:auto; height:auto}");
		buff.append("</style></head><body>");
		// 从中判断出图片地址，视频地址。
		String context = p.getContext();
		buff.append(context.replaceAll("/upload_cloudfile/upload/image", "Images")
				.replaceAll("/upload_cloudfile/upload/video", "Video")
				.replaceAll("/CloudringAD/images/sys", "SceneImages").replaceAll("/upload_cloudfile/upload/doc", "Doc")
				.replaceAll(PropertiesUtils.getInstance().getValue("background-image")
						+ "/upload_cloudfile/upload/bgpicture", "Images"));
		if (!"".equals(program.getBagrmusic()) && program.getBagrmusic() != null) {
			buff.append(
					"<div id=\"lanren\"><div id=\"audio-btn\" class=\"on\" onclick=\"lanren.changeClass(this,'media')\">");
			buff.append(" <audio loop=\"loop\" src=\""
					+ program.getBagrmusic().replaceAll("/upload_cloudfile/upload/music", "Music")
					+ "\" id=\"media\" preload=\"preload\"></audio></div></div>");
			buff.append("<script type=\"text/javascript\" src=\"js/music.js\"></script>");
		}

		buff.append("<script type=\"text/javascript\" src=\"js/video.js\"></script>");
		buff.append("<script type=\"text/javascript\" src=\"js/jquery.cycle.js\"></script>");
		buff.append("<script type=\"text/javascript\" src=\"js/delaunay.js\"></script>");
		buff.append("<script type=\"text/javascript\" src=\"js/TweenMax.js\"></script>");
		buff.append("<script type=\"text/javascript\" src=\"js/picture.js\"></script>");
		buff.append("<script type=\"text/javascript\" src=\"js/weather.js\"></script>");
		buff.append("<script type=\"text/javascript\" src=\"js/clock2.js\">");
		buff.append("</script><script type=\"text/javascript\" src=\"js/jqueryRorate.js\">");
		buff.append("</script><script type=\"text/javascript\" src=\"js/clock1.js\"></script>");
		buff.append("</script><script type=\"text/javascript\" src=\"js/clock_word.js\"></script>");
		buff.append("</script><script type=\"text/javascript\" src=\"js/jquery.media.js\"></script>");
		buff.append(
				"<script type=\"text/javascript\">$(function(){$('a.media').media({width:800, height:600}); });</script>");
		buff.append("</body></html>");

		OutputStreamWriter write = new OutputStreamWriter(new FileOutputStream(myFile), "UTF-8");
		BufferedWriter writer = new BufferedWriter(write);
		writer.write(buff.toString());
		writer.close();
	}

	// 删除文件夹下面所有和文件夹
	public static boolean deleteDir(File dir) {
		if (dir.isDirectory()) {
			String[] children = dir.list();
			for (int i = 0; i < children.length; i++) {
				boolean success = deleteDir(new File(dir, children[i]));
				if (!success) {
					return false;
				}
			}
		}
		// 目录此时为空，可以删除
		return dir.delete();
	}

	/**
	 * 主包数据
	 * 
	 * @param id
	 * @param program
	 * @return
	 * @throws Exception
	 */
	public Program updateData(String id, Program program) throws Exception {
		//
		ProgramDetails programDetails = new ProgramDetails();
		programDetails.setProgramId(id);
		List<ProgramDetails> programDetailsList = programDetailsDAO.getList(programDetails);
		String img = "";
		String video = "";
		String vidoePlac = "";
		String pdf = "";
		String bgpri = "";
		for (ProgramDetails p : programDetailsList) {
			if (p.getImgae_url() != null && !p.getImgae_url().equals("")) {
				img += p.getImgae_url() + ",";
			}
			if (p.getVideo_url() != null && !p.getVideo_url().equals("")) {
				video += p.getVideo_url() + ",";
			}
			if (p.getVideoPlace_url() != null && !p.getVideoPlace_url().equals("")) {
				vidoePlac = p.getVideoPlace_url();
			}
			if (p.getPdf_url() != null && !p.getPdf_url().equals("")) {
				pdf = p.getPdf_url();
			}
			if (p.getBackground_picture() != null && !p.getBackground_picture().equals("")) {
				bgpri = p.getBackground_picture();
			}

		}
		if (null != program.getBagrmusic() && !program.getBagrmusic().equals("")) {
			Material material = materialDAO.getObjById(program.getBagrmusic());
			program.setBagrmusic(material.getFile_path());
		}
		if (!"".equals(video)) {
			program.setVideo_url(video.substring(0, video.length() - 1));
		}
		if (!"".equals(img)) {
			program.setImgae_url(img.substring(0, img.length() - 1));
		}
		if (!"".equals(vidoePlac)) {
			program.setVideoPlace_url(vidoePlac);
		}
		if (!"".equals(pdf)) {
			program.setPdf_url(pdf);
		}
		if (!"".equals(bgpri)) {
			program.setBackground_picture(bgpri);
		}
		return program;

	}

	/**
	 * 
	 * 补充子包数据
	 * 
	 * @param id
	 * @param program
	 * @return
	 * @throws Exception
	 */
	public Program updateAllData(String id, Program program) throws Exception {
		ProgramDetails programDetails = new ProgramDetails();
		programDetails.setProgramId(id);
		List<ProgramDetails> programDetailsList = programDetailsDAO.getList(programDetails);
		String img = "";
		String video = "";
		String pdf = "";
		String bgpri = "";
		for (ProgramDetails p : programDetailsList) {
			if (p.getImgae_url_update() != null && !p.getImgae_url_update().equals("")) {
				img += p.getImgae_url_update() + ",";
			}
			if (p.getVideo_url_update() != null && !p.getVideo_url_update().equals("")) {
				video += p.getVideo_url_update() + ",";
			}
			if (p.getPdf_url() != null && !p.getPdf_url().equals("")) {
				pdf = p.getPdf_url();
			}
			if (p.getBackground_picture() != null && !p.getBackground_picture().equals("")) {
				bgpri = p.getBackground_picture();
			}
		}
		if (program.getIs_bg_music().equals("1")) {
			Material material = materialDAO.getObjById(program.getBagrmusic());
			program.setBagrmusic(material.getFile_path());
		}
		if (!"".equals(video)) {
			program.setVideo_url(video.substring(0, video.length() - 1));
		} else {
			program.setVideo_url(null);
		}
		if (!"".equals(img)) {
			program.setImgae_url(img.substring(0, img.length() - 1));
		} else {
			program.setImgae_url(null);
		}
		if (!"".equals(pdf)) {
			program.setPdf_url(pdf);
		} else {
			program.setPdf_url(null);
		}
		if (!"".equals(bgpri)) {
			program.setBackground_picture(bgpri);
		}
		return program;

	}

	/**
	 * 
	 * @param program
	 * @param srcFile
	 */
	public void createFile(Program program, String srcFile) {
		// 添加物理地址，即tomcat下面的地址。
		String binPath = System.getProperty("user.dir");
		String tempdir = binPath.replace("bin", "webapps");
		// 判断图片和视频是否有，把图片copy到需要打包的文件里面
		if (!"".equals(program.getImgae_url()) && program.getImgae_url() != null) {
			String[] img = program.getImgae_url().split(",");
			String createSrc = srcFile + File.separator + "Images" + File.separator;
			String dirFile = null;
			for (int i = 0; i < img.length; i++) {
				dirFile = createSrc + img[i].replace("/upload_cloudfile/upload/image/", "");
				FileUtil.createFile(dirFile, tempdir + img[i]);
			}
		}
		// 判断视频是否有，把图片copy到需要打包的文件里面
		if (!"".equals(program.getVideo_url()) && program.getVideo_url() != null) {
			String[] img = program.getVideo_url().split(",");
			String createSrc = srcFile + File.separator + "Video" + File.separator;
			String dirFile = null;
			for (int i = 0; i < img.length; i++) {
				dirFile = createSrc + img[i].replace("/upload_cloudfile/upload/video/", "");
				FileUtil.createFile(dirFile, tempdir + img[i]);
			}
		}
		// 判断视频监控是否有，把图片copy到需要打包的文件里面
		if (!"".equals(program.getVideoPlace_url()) && program.getVideoPlace_url() != null) {
			String createSrc = srcFile + File.separator + "SceneImages" + File.separator;
			String dirFile = createSrc + program.getVideoPlace_url().replace("/CloudringAD/images/sys/", "");
			FileUtil.createFile(dirFile, tempdir + program.getVideoPlace_url());
		}

		// 判断背景音乐是否有，把图片copy到需要打包的文件里面
		if (!"".equals(program.getBagrmusic()) && program.getBagrmusic() != null) {
			String createSrc = srcFile + File.separator + "Music" + File.separator;
			String dirFile = createSrc + program.getBagrmusic().replace("/upload_cloudfile/upload/music/", "");
			FileUtil.createFile(dirFile, tempdir + program.getVideoPlace_url());

		}

		// 判断视频是否有，把pdf copy到需要打包的文件里面
		if (!"".equals(program.getPdf_url()) && program.getPdf_url() != null) {
			String[] img = program.getPdf_url().split(",");
			String createSrc = srcFile + File.separator + "Doc" + File.separator;
			String dirFile = null;
			for (int i = 0; i < img.length; i++) {
				dirFile = createSrc + img[i].replace("/upload_cloudfile/upload/doc/", "");
				FileUtil.createFile(dirFile, tempdir + img[i]);
			}
		}

		// 判断背景图片是否有
		if (!"".equals(program.getBackground_picture()) && program.getBackground_picture() != null) {
			String createSrc = srcFile + File.separator + "Images" + File.separator;
			String dirFile = createSrc
					+ program.getBackground_picture().replace("/upload_cloudfile/upload/bgpicture/", "");
			FileUtil.createFile(dirFile, tempdir + program.getBackground_picture());
		}

	}

	/**
	 * 把生成zip的公共部分提出来
	 * 
	 * @param prId
	 * @param srcFile
	 * @param program
	 * @param publish
	 * @param user
	 * @return
	 * @throws Exception
	 */
	public String createZip(String prId, String srcFile, Program program, Publish publish, SysUserVO user,
			String zipName) throws Exception {
		ProgramDetails programDetails = new ProgramDetails();
		programDetails.setProgramId(prId);
		List<ProgramDetails> pdList = programDetailsDAO.getList(programDetails);
		// 生成xml
		String xmlFile = srcFile + File.separator + "resource.xml";

		BuildXMLDoc(xmlFile, program, pdList, publish);
		for (ProgramDetails p : pdList) {
			// 生成html5
			createHtml(srcFile + File.separator + p.getId() + ".html", program, p);
		}
		// 保存到zip,
		String zipPath = FileUtil.getZipFilePath(Constants.CLOUD_ZIP_FILE, user.getId());
		String dir = srcFile;
		String zipFileName = zipName + ".zip";
		String fileName = zipPath + File.separator + zipFileName;// zip包的地址。
		File f = new File(fileName);
		if (f.exists()) {
			f.delete();
		}
		ZipUtil.zip(dir, zipPath, zipFileName);
		// 删除临时文件夹
		deleteDir(new File(dir));
		return zipFileName;
	}

}
