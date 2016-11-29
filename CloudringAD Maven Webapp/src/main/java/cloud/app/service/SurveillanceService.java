/**
 * 
 */
package cloud.app.service;

import java.util.List;

import cloud.app.entity.Surveillance;
import cloud.app.system.vo.TreeVO;

/**
 * @author zhoushunfang
 *
 */
public interface SurveillanceService extends BaseService<Surveillance>{
	
	public List<String> getPacketList();
	
	List<TreeVO> selectTree(String terminalId)throws Exception;
	
}
