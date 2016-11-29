package cloud.shop.goods.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cloud.shop.goods.dao.TradInfoDAO;
import cloud.shop.goods.entity.TradInfo;
import cloud.shop.goods.service.TradInfoService;
@Service
public class TradInfoServiceImpl implements TradInfoService {
    @Autowired  
	private TradInfoDAO tradInfoDAO;
	@Override
	public void save(TradInfo tradInfo) throws Exception {
		this.tradInfoDAO.save(tradInfo);

	}

	@Override
	public List<TradInfo> getTradInfoList(TradInfo tradInfo) throws Exception {		
		return this.getTradInfoList(tradInfo);
	}

}
