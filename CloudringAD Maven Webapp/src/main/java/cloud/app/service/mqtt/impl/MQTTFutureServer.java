package cloud.app.service.mqtt.impl;

import java.io.File;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.fusesource.mqtt.client.Future;
import org.fusesource.mqtt.client.FutureConnection;
import org.fusesource.mqtt.client.MQTT;
import org.fusesource.mqtt.client.Message;
import org.fusesource.mqtt.client.QoS;
import org.fusesource.mqtt.client.Topic;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;

import cloud.app.common.Constants;
import cloud.app.common.IOStreamUtils;
import cloud.app.common.PropertiesUtils;
import cloud.app.common.StringUtil;
import cloud.app.dao.AdPlayerDAO;
import cloud.app.dao.DataGatheringDAO;
import cloud.app.dao.MessageDAO;
import cloud.app.dao.ProgramDAO;
import cloud.app.dao.SurveillanceDAO;
import cloud.app.dao.TerminalDAO;
import cloud.app.entity.AdPlayer;
import cloud.app.entity.DataGathering;
import cloud.app.entity.Program;
import cloud.app.entity.PublishTerminal;
import cloud.app.entity.Terminal;
import cloud.app.service.PowerResourceService;
import cloud.app.service.PublishTerminalService;
import cloud.app.service.TerminalService;
import cloud.app.vo.AdPlayerVO;
import cloud.app.vo.DataGatheringVO;
import cloud.app.vo.PowerProgramResourceVO;
import cloud.app.vo.SurveillanceVO;
import cloud.app.vo.SyncResourcesVO;

@Service
public class MQTTFutureServer {
    private static final Logger logger = Logger.getLogger(MQTTFutureServer.class);
    
    SimpleDateFormat sf = new SimpleDateFormat("yyyyMMddHHmmss");
    
	final static String ACTION_BINDING = "binding";
	final static String ACTION_CALLBACK_PG = "callback_pg";
	final static String ACTION_CALLBACK_AFFIX = "callback_affix";
	final static String ACTION_DOWNLOADPROGRESS = "downloadProgress";
	final static String ACTION_SYNCRESOURCES = "syncResources";
	final static String ACTION_UNBUNDLING = "unbundling";
    
    String brokerUrl = "tcp://localhost:61615";
    short KEEP_ALIVE = 30;// 低耗网络，但是又需要及时获取数据，心跳30s  
	String clientId = null;
	boolean cleanSession = true;
	String userName = null;
	String password = null;
    public  static Topic[] topics = {new Topic("cloudringAd/server/#", QoS.EXACTLY_ONCE),new Topic("cloudringAd/keepalive/#", QoS.AT_MOST_ONCE)};  
    public final  static long RECONNECTION_ATTEMPT_MAX=6;  
    public final  static long RECONNECTION_DELAY=2000;  
      
    public final static int SEND_BUFFER_SIZE=2*1024*1024;//发送最大缓冲为2M  
    
	@Resource
	AdPlayerDAO adPlayerDAO;
	@Resource
	DataGatheringDAO dataGatheringDAO;
	@Resource
	ProgramDAO programDAO;
	@Resource
	SurveillanceDAO surveillanceDAO;
	@Resource
	TerminalDAO terminalDAO;
	@Autowired
	PublishTerminalService publishTerminalService;
	@Autowired
	PowerResourceService powerResourceService;
	@Autowired
	TerminalService terminalService;
	
	MQTT mqtt = null;
	FutureConnection futureConnection = null;
	
	@PostConstruct
	public void initialize() throws Exception{
		//创建MQTT对象
		mqtt = new MQTT();  
            try {
            	brokerUrl = PropertiesUtils.getInstance().getValue("brokerUrl");
    			clientId = PropertiesUtils.getInstance().getValue("clientId");
    			userName = PropertiesUtils.getInstance().getValue("userName");
    			password = PropertiesUtils.getInstance().getValue("password");
            	
            	//设置mqtt broker的ip和端口  
                mqtt.setHost(brokerUrl);
                mqtt.setUserName(userName);
                mqtt.setPassword(password);
                //连接前清空会话信息  
                mqtt.setCleanSession(cleanSession);  
                //设置重新连接的次数  
                mqtt.setReconnectAttemptsMax(RECONNECTION_ATTEMPT_MAX);  
                //设置重连的间隔时间  
                mqtt.setReconnectDelay(RECONNECTION_DELAY);  
                //设置心跳时间  
                mqtt.setKeepAlive(KEEP_ALIVE);  
                //设置缓冲的大小  
                mqtt.setSendBufferSize(SEND_BUFFER_SIZE);
                mqtt.setClientId(clientId);
                  
                //获取mqtt的连接对象BlockingConnection  
                futureConnection = mqtt.futureConnection();  
                futureConnection.connect();  
                futureConnection.subscribe(topics); 

                new Thread(new Runnable(){
					public void run() {
						while(true){
							try {
			                    Future<Message> futrueMessage = futureConnection.receive();  
			                    Message message =futrueMessage.await();
 
			                    if(message != null){

		        					if(logger.isDebugEnabled()){
		        						logger.debug(" -------------- MQTTFutureServer message: "+new String(message.getPayload(), Constants.ENCODING)+"  "+message.getTopic());
		        					}
				                    
				                    //根据主题转发
				        			String[] topics = message.getTopic().split(Constants.TOPIC_SEPARATOR);
				        			
				        			if(topics.length > 2 ){
					        			String tempTopic = null;
					        			
					        			if(futureConnection != null && futureConnection.isConnected()){
				        					if(logger.isDebugEnabled()){
				        						logger.debug("----------------futureConnection is not null ------------futureConnection.isConnected() "+futureConnection.isConnected());
				        					}
					        			}else{
					        				futureConnection = mqtt.futureConnection();
					        				futureConnection.connect();
					        				
				        					if(logger.isDebugEnabled()){
				        						logger.debug("----------------futureConnection is null ------------futureConnection.isConnected() "+futureConnection.isConnected());
				        					}
					        			}
					        			
					        			
					        			if("server".equals(topics[1])){
					        				//web发给mqtt服务器的数据
					        				if(Constants.TOPIC_WEB.equals(topics[2])){
					        					tempTopic = "cloudringAd/client/terminal/"+topics[3]+"/in";
					        					if(logger.isDebugEnabled()){
					        						logger.debug("----------------web发给mqtt服务器的数据: "+tempTopic +" -----------------");
					        					}
					        					futureConnection.publish(tempTopic, message.getPayload(), QoS.EXACTLY_ONCE, false);
					        					if(logger.isDebugEnabled()){
					        						logger.debug("----------------web发给mqtt服务器的数据完成-----------------");
					        					}
					        				}
					        				
					        				//终端发给mqtt服务器的数据
					        				else if(Constants.TOPIC_TERMINAL.equals(topics[2])){
					        					String info = new String(message.getPayload(), Constants.ENCODING);
					        					if(StringUtil.isEmpty(info)){
					        						if(logger.isDebugEnabled()){
						        						logger.debug("----------------心跳包 跳过-----------------");
						        					}
					        					}

					        					//临时处理 cloudringAd/server/terminal/cf35f2f26996a2c4
					        					else if("心跳包".equals(info)){
					        						if(logger.isDebugEnabled()){
						        						logger.debug("----------------心跳包 处理-----------------");
						        					}
					        						/**
						        					Terminal terminal = new Terminal();
						        					terminal.setId(topics[3]);
						        					terminal.setStatus(Constants.TERMINAL_ONLINE_IN);
						        					terminal.setModifyDate(new Date());

						        					terminalService.update(terminal);
					        						*/
					        					}
					        					
					        					else{
						        					//用alibaba的json包来处理json串
						        					JSONObject jsonOject = (JSONObject)JSON.parse(info);
						        					String action = jsonOject.getString(Constants.JSON_KEY_NAME_ACTION);
						        					
						        					//信息回传(节目信息)
						        					if(action != null && ACTION_CALLBACK_PG.equals(action.trim())){
						        						AdPlayerVO  vo = JSON.parseObject(info, AdPlayerVO.class);
						        						AdPlayer entity = new AdPlayer();
						        						
						        						entity.setId(StringUtil.getUUID());
						        						entity.setAdId(vo.getAdId());
						        						Program po = programDAO.getObjById(vo.getAdId());
						        						if(po == null){
						        							continue;
						        						}
						        						entity.setAdName(po.getProgram_name());
						        						if(vo.getStartTime() != null){
						        							entity.setStartTime(sf.parse(vo.getStartTime()));
						        						}
						        						if(vo.getEndTime() != null){
						        							entity.setEndTime(sf.parse(vo.getEndTime()));
						        						}
						        						entity.setCreatedate(new Date());
						        						entity.setTerminalId(vo.getTerminalId());
						        						
						        						adPlayerDAO.insert(entity);
						        					}//信息回传(附件)
						        					else if(action != null && ACTION_CALLBACK_AFFIX.equals(action.trim())){
						        						DataGatheringVO  dataGatheringVO = JSON.parseObject(info, DataGatheringVO.class);
						        						String imageUrl = null;
						        						if(dataGatheringVO != null){
						        							if(Constants.MESSAGE_TYPE_IMAGES.equals(dataGatheringVO.getType()) 
						        									|| Constants.MESSAGE_TYPE_VIDEO.equals(dataGatheringVO.getType())){
						        								//生成附件
						        								byte[] hexBytes = hexStr2Str(dataGatheringVO.getContent());
						        								String path = Constants.CLOUD_CALLBACK_FILE+File.separator+Constants.CLOUD_IMAGE_FILE;
						        								imageUrl = IOStreamUtils.saveInputStreamImageToFolder(path, dataGatheringVO.getName(), hexBytes);
						        								
						        								if(logger.isDebugEnabled()){
						        									logger.debug("图片生成地址： "+imageUrl);
						        								}
						        								
						        								dataGatheringVO.setContent(imageUrl);
						        							}
						        							
						        							DataGathering dataGathering = new DataGathering();
						        							dataGathering.setId(StringUtil.getUUID());
						        							
						        							if(imageUrl != null){
						        								dataGathering.setContent(imageUrl);
						        							}else{
						        								dataGathering.setContent(dataGatheringVO.getContent());
						        							}

						        							dataGathering.setCreateDate(new Date());
						        							dataGathering.setTerminalId(dataGatheringVO.getTerminalId());
						        							dataGathering.setIp(dataGatheringVO.getIp());
						        							dataGathering.setType(dataGatheringVO.getType());
						        							dataGathering.setName(dataGatheringVO.getName());
						        							//DataGathering.setAlias(null);
						        							
						        							dataGatheringDAO.insert(dataGathering);
						        						}
						        					}
						        					
						        					//下载进度回传
						        					else if(action != null && ACTION_DOWNLOADPROGRESS.equals(action.trim())){
						        						PublishTerminal pt = new PublishTerminal();
						        						pt.setTermianl_id(jsonOject.getString(Constants.JSON_KEY_TERMINALID));
						        						pt.setProgram_id(jsonOject.getString(Constants.JSON_KEY_PROGRAMID));
						 
						        						/**
						        						PublishTerminal publishTerminal = publishTerminalService.getByTerminalId(pt);
						        						String starTime = jsonOject.getString(Constants.JSON_KEY_STARTTIME);
						        						if("".equals(starTime) || starTime == null){
						        							if(publishTerminal.getReception_time()==null){
						        								Date now=new Date();
						        								publishTerminal.setReception_time(now);
						        							}
						        						}else{
						        							publishTerminal.setReception_time(sf.parse(starTime));
						        						}
						        						String endTime=jsonOject.getString(Constants.JSON_KEY_ENDTIME);
						        						if(endTime == null || "".equals(endTime)){
						        							publishTerminal.setComplete_time(null);
						        						}else{
						        							publishTerminal.setComplete_time(sf.parse(endTime));
						        						}
						        						*/
						        						
						        						pt.setProgress(jsonOject.getString(Constants.JSON_KEY_PROGRESS));
						        					   publishTerminalService.update(pt);
						        					}
						        					
						        					//终端重置
						        					else if(action != null && ACTION_UNBUNDLING.equals(action.trim())){
						        						String userCode = jsonOject.getString(Constants.JSON_KEY_USERCODE);
						        						String password = jsonOject.getString(Constants.JSON_KEY_PASSWORD);
						        						String terminalId = jsonOject.getString(Constants.JSON_KEY_TERMINALID);
						        						String errno = "0";
						        						
						        						Map<String, String> map = new HashMap<String, String>();
						        						map.put("userCode", userCode);
						        						map.put("password", password);
						        						map.put("terminalId", terminalId);
						        						Terminal terminal = terminalDAO.queryTerminalByUser(map);
						        						if(terminal == null){
						        							//返回错误提示
						        							errno = "用户代码或者密码错误.";
						        						}else{
						        							//返回正确提示,解除绑定
						        							terminalDAO.deleteById(terminal.getId());
						        						}
						        						
						        						String backJson = "{\"action\":\"unbundling\",\"errno\":\""+errno+"\",\"tm\":\""+sf.format(new Date())+"\"}";
						        						
						        						//发送mqtt消息
						        						tempTopic = "cloudringAd/client/terminal/"+terminalId+"/in";
						        						futureConnection.publish(tempTopic, backJson.getBytes(), QoS.EXACTLY_ONCE, false);
						        					}
						        					
						        					
						        					//开机同步资源
						        					else if(action != null && ACTION_SYNCRESOURCES.equals(action.trim())){
						        						String terminalId = jsonOject.getString(Constants.JSON_KEY_TERMINALID);
						        						
						        						List<SurveillanceVO> surveillanceList = surveillanceDAO.getSurveillanceListByTerminalId(terminalId);
						        						
						        						Map<String, PowerProgramResourceVO> map = powerResourceService.getProgramByTerminalId(terminalId);
						        						Collection<PowerProgramResourceVO> valueCollection = map.values();
						        						List<PowerProgramResourceVO> programList = new ArrayList<PowerProgramResourceVO>(valueCollection);
						        						
						        						SyncResourcesVO syncResourcesVO = new SyncResourcesVO();
						        						syncResourcesVO.setAction(ACTION_SYNCRESOURCES);
						        						syncResourcesVO.setTerminalId(terminalId);
						        						syncResourcesVO.setErrno("0");
						        						syncResourcesVO.setTm(sf.format(new Date()));
						        						syncResourcesVO.setVmIpList(surveillanceList);
						        						syncResourcesVO.setProgramList(programList);
						        						
						        						String syncResourcesJson = JSONObject.toJSONString(syncResourcesVO);
						        						
						        						//发送mqtt消息
						        						tempTopic = "cloudringAd/client/terminal/"+terminalId+"/in";
						        						futureConnection.publish(tempTopic, syncResourcesJson.getBytes(), QoS.AT_LEAST_ONCE, false);
						        					}
						        					
					        					}
					        				}
					        				else if(topics.length == 3 && "keepalive".equals(topics[1])){
					        					//心跳，主要维持用户是否在线的状态 cloudringAd/keepalive/#
					        					Terminal terminal = new Terminal();
					        					terminal.setId(topics[2]);
					        					terminal.setStatus(Constants.TERMINAL_ONLINE_IN);
					        					terminal.setModifyDate(new Date());

					        					terminalService.update(terminal);
					        				}	
					        			}	
				        			}
			                    }
							} catch (Exception ex) {
								ex.printStackTrace();
							}
						}
					}
                }).start();
                 
            } catch (Exception e) {  
                // TODO Auto-generated catch block  
                e.printStackTrace();  
            }finally{  
                  
            }  
        }
	
	
	private AdPlayer getAdPlayer(AdPlayerVO vo) throws ParseException{
		AdPlayer po = new AdPlayer();
		
		po.setId(StringUtil.getUUID());
		po.setAdId(vo.getAdId());
		po.setStartTime(sf.parse(vo.getStartTime()));
		po.setEndTime(sf.parse(vo.getEndTime()));
		
		
		return null;
	}
	
      
  	/** 
  	 *  
  	 * 十六进制转换二进制
  	 */
  	public static byte[] hexStr2Str(String hexStr) {  
  	    String str = "0123456789ABCDEF";  
  	    char[] hexs = hexStr.toCharArray();  
  	    byte[] bytes = new byte[hexStr.length() / 2];  
  	    int n;  
  	    for (int i = 0; i < bytes.length; i++) {  
  	        n = str.indexOf(hexs[2 * i]) * 16;  
  	        n += str.indexOf(hexs[2 * i + 1]);  
  	        bytes[i] = (byte) (n & 0xff);  
  	    }  
  	    return bytes;  
  	}
 
	public MQTT getMqtt() {
		return mqtt;
	}

	public void setMqtt(MQTT mqtt) {
		this.mqtt = mqtt;
	}  
      
}
