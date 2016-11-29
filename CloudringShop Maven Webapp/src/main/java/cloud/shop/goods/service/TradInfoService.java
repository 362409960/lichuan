package cloud.shop.goods.service;

import java.util.List;

import cloud.shop.goods.entity.TradInfo;

public interface TradInfoService {
	
	public void save(TradInfo tradInfo)throws Exception;
	
	public List<TradInfo> getTradInfoList(TradInfo tradInfo)throws Exception;

}
