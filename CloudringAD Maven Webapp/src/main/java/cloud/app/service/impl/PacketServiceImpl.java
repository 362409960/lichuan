/**
 * 
 */
package cloud.app.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cloud.app.dao.PacketDAO;
import cloud.app.entity.Packet;
import cloud.app.service.PacketService;
import cloud.app.system.vo.TreeVO;

/**
 * @author zhoushunfang
 * 
 */
@Service
public class PacketServiceImpl implements PacketService {

	@Autowired
	private PacketDAO packetDAO;
	
	@Override
	public void save(Packet obj) throws Exception {
		packetDAO.insertSelective(obj);
	}

	@Override
	public void update(Packet obj) throws Exception {
		packetDAO.updateByPrimaryKeySelective(obj);
	}

	@Override
	public void deleteById(String id) throws Exception {
		packetDAO.deleteById(id);
	}

	@Override
	public List<Packet> getList(Packet obj) throws Exception {
		return packetDAO.getList(obj);
	}

	@Override
	public Integer count(Packet obj) throws Exception {
		return null;
	}

	@Override
	public Packet getObjById(String id) throws Exception {
		return null;
	}

	@Override
	public void deleteByIdS(Map<String, Object> map) throws Exception {
		packetDAO.deleteByIdS(map);
	}

	@Override
	public List<TreeVO> queryPacketList(List<String> mechanisms) throws Exception { 
		return packetDAO.selectTree(mechanisms);
	}

	@Override
	public void deleteTree(String id) throws Exception {
		packetDAO.deleteTree(id);
	}

}
