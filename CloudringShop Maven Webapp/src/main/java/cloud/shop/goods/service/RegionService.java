package cloud.shop.goods.service;

import java.util.List;

import cloud.shop.goods.entity.Region;

public interface RegionService {
	
	public void save(Region region) throws Exception;
	
	public void deleteById(String id) throws Exception;

	public void update(Region region) throws Exception;
	
	public List<Region> getRegionList(Region region) throws Exception;
	
	public List<Region> getRegionIdList(String id) throws Exception;
	
	public Region getRegionConData(Region region)throws Exception;

}
