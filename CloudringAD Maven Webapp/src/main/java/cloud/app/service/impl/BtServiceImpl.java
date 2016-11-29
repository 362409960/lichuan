package cloud.app.service.impl;

import jBittorrentAPI.ConnectionManager;
import jBittorrentAPI.DownloadManager;
import jBittorrentAPI.TorrentFile;
import jBittorrentAPI.TorrentProcessor;
import jBittorrentAPI.Utils;

import java.io.File;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.net.ServerSocket;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.PostConstruct;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import cloud.app.service.BtService;

import simple.http.connect.ConnectionFactory;
import simple.http.load.MapperEngine;
import simple.http.serve.Context;
import simple.http.serve.FileContext;
import trackerBT.Constants;
 
 

@Service
public class BtServiceImpl implements BtService {
	Logger logger = Logger.getLogger(this.getClass());
	
	String configFile = "tracker_config.xml";
	String action = "";
	String rootPath = "";

	private FileOutputStream fos;
 
    @PostConstruct
    /**
     * 初始化配置文件
     * @throws Exception
     */
	public void initialize()throws Exception{
		try {
			rootPath= this.getClass().getResource("/").getFile().toString(); 
			if(logger.isDebugEnabled()){
				logger.debug(rootPath);
			}

			String[] temp = rootPath.split("webapps");
			// /home/Tomcat/webapps 这种格式
			Constants.trackerPath = temp[0]+"webapps";

			//装载配置文件
			Constants.loadConfig(rootPath+configFile);
			
			//创建文件目录
			String contextDir = Constants.configParam.get("context");
			System.out.println("创建文件目录--------------> "+contextDir);
			
			new File(contextDir).mkdirs();
			
			try {
				FileWriter fw = new FileWriter(contextDir + "Mapper.xml");
				fw.write("<?xml version=\"1.0\"?>\r\n<mapper>\r\n<lookup>\r\n"
						+ "<service name=\"file\" type=\"trackerBT.FileService\"/>\r\n"
						+ "<service name=\"tracker\" type=\"trackerBT.TrackerService\"/>\r\n"
						+ "<service name=\"upload\" type=\"trackerBT.UploadService\"/>\r\n" + "</lookup>\r\n<resolve>\r\n"
						+ "<match path=\"/*\" name=\"file\"/>\r\n" + "<match path=\"/announce*\" name=\"tracker\"/>\r\n"
						+ "<match path=\"/upload*\" name=\"upload\"/>\r\n" + "</resolve>\r\n</mapper>");
				fw.flush();
				fw.close();
			} catch (IOException ioe) {
				System.err.println("Could not create 'Mapper.xml'");
				System.exit(0);
			}
			Context context = new FileContext(new File(contextDir));
			
			try {
				MapperEngine engine = new MapperEngine(context);

				//监听listeningPort端口
				ConnectionFactory.getConnection(engine).connect(new ServerSocket(Integer.parseInt((String) Constants.get("listeningPort"))));
				logger.info("Tracker started! Listening on port " + Constants.get("listeningPort") + "\r\n\t********************************************\r\n");
			} catch (Exception e) {
				e.printStackTrace();
				System.exit(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

    /** 生成torrent属性文件:
     * @param userId       用户ID
     * @param fileName     文件名称(包含文件后缀),生成后缀为.torrent的文件
     * @param comment      种子文件描述
     * @param creator      种子创建者
     * @throws Exception
     */
 
    private String createTorrent(String userId, String fileName, String comment, String creator) throws Exception {
		try {
			TorrentProcessor tp = new TorrentProcessor();
			//设置announce地址
			tp.setAnnounceURL(Constants.configParam.get("announceurl")==null?"http://localhost:8181/announce":Constants.configParam.get("announceurl"));
			tp.setComment(comment==null?fileName:comment);
			tp.setCreationDate(new Date().getTime());
			tp.setCreator(creator==null?userId:creator);
			tp.setEncoding(Constants.DEFAULT_ENCODING);
			
			String fullPath = Constants.configParam.get("btProject")+File.separator+userId+File.separator+fileName;
			logger.info("--------------------------> "+fullPath);
			
			tp.setName(fullPath);
			tp.setPieceLength(Integer.parseInt(Constants.configParam.get("pieceLength")==null?"512":Constants.configParam.get("pieceLength")));
			
			//文件数组
			List<String> files = new ArrayList<String>();
			// /example/client1/funvideo05.wmv
			files.add(fullPath);
			try {
				tp.addFiles(files);
			} catch (Exception ex) {
				ex.printStackTrace();
			}
			tp.generatePieceHashes();
			String returnFile = fullPath+".torrent";
			
			if(logger.isDebugEnabled()){
				logger.debug("create torrent file name: "+returnFile);
			}
			fos = new FileOutputStream(returnFile);
            fos.write(tp.generateTorrent());
            
            logger.info("********************** Torrent created successfully!!! **********************");
            return returnFile;
		} catch (Exception ex) {
			ex.printStackTrace();
			return null;
		}finally{
			if(fos != null){
				fos.close();
			}
		}
	}
	
	//torrent文件发布到tracker服务器, torrentFileName就是上面方法的返回值
    private void publish(String torrentFileName, String comment)throws Exception{
		try {
			if(logger.isDebugEnabled()){
				logger.debug("start publish torrent to tracker server."+ torrentFileName);
			}

			File f = new File(torrentFileName);
			ConnectionManager.publish(torrentFileName, Constants.configParam.get("upload"), "none", "none", f.getName(), "", comment, "7");
			
			if(logger.isDebugEnabled()){
				logger.debug("end publish torrent to tracker server.");
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}
	
	//分享，第一个种子用户
    private void share(String torrentFileName, String userId)throws Exception{
		try{
 			System.out.println("222222222222222222222------------------>");
			
			TorrentProcessor tp = new TorrentProcessor();
			//example/client1/funvideo.torrent                      example/client1/
			TorrentFile t = tp.getTorrentFile(tp.parseTorrent(torrentFileName));
			
			System.out.println("3333333333333333------------------>");
			
			jBittorrentAPI.Constants.SAVEPATH = Constants.configParam.get("btProject")+File.separator+userId+File.separator;
			
			System.out.println("44444444444444444------------------>"+jBittorrentAPI.Constants.SAVEPATH);
			
			 if (t != null) {
	                DownloadManager dm = new DownloadManager(t, Utils.generateID());
	                
	                System.out.println("55555555555555555555555555------------------>");
	                dm.startListening(6881, 6889);
	                System.out.println("666666666666666666666666------------------>");
	                dm.startTrackerUpdate();
	                System.out.println("777777777777777777777777------------------>");
	                dm.blockUntilCompletion();
	                System.out.println("8888888888888888888888888------------------>");
	                dm.stopTrackerUpdate();
	                System.out.println("9999999999999999999999------------------>");
	                dm.closeTempFiles();
	                System.out.println("AAAAAAAAAAAAAAAAAAAAAAAAAAAA------------------>");
	            } else {
	            	System.err.println("Provided file is not a valid torrent file");
	                System.err.flush();
	                System.exit(1);
	            }
		}catch(Exception ex){
			ex.printStackTrace();
		}
	}

	//提供第三方调用的接口: 返回给用户的属性文件的地址
	public String btHandle(String userId, String fileName, String comment, String creator) throws Exception {
		String tempFile = "";
		try {
			System.out.println("----------------> createTorrent start...");
			tempFile = createTorrent(userId, fileName, comment, creator);
			System.out.println("----------------> createTorrent end publish start...");
			publish(tempFile, comment);
			System.out.println("----------------> publish end share start...");
			//share(tempFile, userId);
			
			final String _torrentFileName = tempFile;
			final String _userId = userId;
			
			new Thread(new Runnable(){
				public void run() {
					
					try{
						TorrentProcessor tp = new TorrentProcessor();
						//example/client1/funvideo.torrent                      example/client1/
						TorrentFile t = tp.getTorrentFile(tp.parseTorrent(_torrentFileName));
						
						jBittorrentAPI.Constants.SAVEPATH = Constants.configParam.get("btProject")+File.separator+_userId+File.separator;
						
						 if (t != null) {
				                DownloadManager dm = new DownloadManager(t, Utils.generateID());
				                System.out.println("11111111111111111111");
				                dm.startListening(6881, 6889);
				                System.out.println("222222222222222222222");
				                dm.startTrackerUpdate();
				                System.out.println("333333333333333333333");
				                dm.blockUntilCompletion();
				                System.out.println("444444444444444444444");
				                dm.stopTrackerUpdate();
				                System.out.println("5555555555555555555555");
				                dm.closeTempFiles();
				                System.out.println("66666666666666666666666");
				            } else {
				            	System.err.println("Provided file is not a valid torrent file");
				                System.err.flush();
				                System.exit(1);
				            }
					}catch(Exception ex){
						ex.printStackTrace();
					}
				}
			}).start();
			
			System.out.println("---------------------> share end....");
		} catch (Exception ex) {
			ex.printStackTrace();
			return null;
		}
		
		return tempFile;
	}
	
	
	
}
