/**
 * 
 */
package cloud.app.entity;

import java.util.Date;

/**
 * @author zhoushunfang
 * 
 */
public class FirnwareFile {

	private String fileName;
	private String fileSize;
	private int isFile;
	private String absolutePath;
	private String parentPath;
	private Date fileUpdateTime;
	private String fileSuffixname;

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getFileSize() {
		return fileSize;
	}

	public void setFileSize(String fileSize) {
		this.fileSize = fileSize;
	}

	public String getAbsolutePath() {
		return absolutePath;
	}

	public void setAbsolutePath(String absolutePath) {
		this.absolutePath = absolutePath;
	}

	public String getParentPath() {
		return parentPath;
	}

	public void setParentPath(String parentPath) {
		this.parentPath = parentPath;
	}

	public Date getFileUpdateTime() {
		return fileUpdateTime;
	}

	public void setFileUpdateTime(Date fileUpdateTime) {
		this.fileUpdateTime = fileUpdateTime;
	}

	public String getFileSuffixname() {
		return fileSuffixname;
	}

	public void setFileSuffixname(String fileSuffixname) {
		this.fileSuffixname = fileSuffixname;
	}

	public int getIsFile() {
		return isFile;
	}

	public void setIsFile(int isFile) {
		this.isFile = isFile;
	}

	
}
