/**
 * 
 */
package cloud.app.service;

import java.util.List;

import cloud.app.entity.Packet;
import cloud.app.system.vo.TreeVO;

/**
 * @author zhoushunfang
 *
 */
public interface PacketService extends BaseService<Packet>{

	List<TreeVO> queryPacketList(List<String> mechanisms)throws Exception;

	void deleteTree(String id)throws Exception;
	
}
