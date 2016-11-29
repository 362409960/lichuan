/**
 * 
 */
package cloud.app.service;

import java.util.List;
import java.util.Map;

import cloud.app.entity.Terminal;

/**
 * @author zhoushunfang
 *
 */
public interface TerminalService extends BaseService<Terminal> {
	
	public	List<Terminal> getListAndMessage(Terminal obj)throws Exception;

	public Integer getListAndMessageCount(Terminal obj);

	public void updateByPacket(Map<String, Object> map); 
}
