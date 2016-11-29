package cloud.shop.goods.dao;

import java.util.List;

import cloud.shop.goods.entity.Region;


public interface RegionDAO {
	
	void save(Region region) throws Exception;
	
	void deleteById(String id) throws Exception;

	void update(Region region) throws Exception;
	
	List<Region> getRegionList(Region region) throws Exception;
	
	List<Region> getRegionIdList(String id) throws Exception;
	
	Region getRegionConData(Region region)throws Exception;
	

}
