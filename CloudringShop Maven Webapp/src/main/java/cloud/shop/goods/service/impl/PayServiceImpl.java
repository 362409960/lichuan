package cloud.shop.goods.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cloud.shop.goods.dao.PayDAO;
import cloud.shop.goods.entity.Pay;
import cloud.shop.goods.service.PayService;
@Service
public class PayServiceImpl implements PayService {

	@Autowired
	private PayDAO payDAO;
	@Override
	public void save(Pay pay) throws Exception {
		this.payDAO.save(pay);

	}

	@Override
	public void deleteById(String id) throws Exception {
		this.payDAO.deleteById(id);

	}

	@Override
	public void update(Pay pay) throws Exception {
		this.payDAO.update(pay);

	}

	@Override
	public List<Pay> getPayList(Pay pay) throws Exception {
		// TODO Auto-generated method stub
		return this.payDAO.getPayList(pay);
	}

}
