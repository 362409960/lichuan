package cloud.app.download;

public class TestDownload {

	public static void main(String[] args) throws Exception {
		String url = "http://www.newasp.net/apps/down.php?tid=69126&id=47031&sid=35";
		String fileDir = "c://temp";
		String fileName = "eclipse.rar"; 
		
		BreakpointsResumeService service = new BreakpointsResumeService();
		service.BreakpointsResumeDownload(url, fileDir, fileName, 5);
	}

}
