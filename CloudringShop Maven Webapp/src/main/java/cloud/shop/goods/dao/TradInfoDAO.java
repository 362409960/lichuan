package cloud.shop.goods.dao;

import java.util.List;

import cloud.shop.goods.entity.TradInfo;

public interface TradInfoDAO {
	
	void save(TradInfo tradInfo)throws Exception;
	
	List<TradInfo> getTradInfoList(TradInfo tradInfo)throws Exception;

}
