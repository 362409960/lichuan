package cloud.app.service;

public interface BtService {

//	public String createTorrent(String userId, String fileName, String comment, String creator)throws Exception; 
//	
//	public void publish(String torrentFileName, String comment)throws Exception;
//	
//	public void share(String torrentFileName, String userId)throws Exception;
	
	public String btHandle(String userId, String fileName, String comment, String creator)throws Exception;
}
