package cloud.shop.goods.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cloud.shop.goods.dao.RegionDAO;
import cloud.shop.goods.entity.Region;
import cloud.shop.goods.service.RegionService;

@Service
public class RegionServiceImpl implements RegionService {

	@Autowired
	private RegionDAO regionDAO;
	@Override
	public void save(Region region) throws Exception {
		this.regionDAO.save(region);

	}

	@Override
	public void deleteById(String id) throws Exception {
		this.regionDAO.deleteById(id);

	}

	@Override
	public void update(Region region) throws Exception {
		this.regionDAO.update(region);
	}

	@Override
	public List<Region> getRegionList(Region region) throws Exception {
		// TODO Auto-generated method stub
		return this.regionDAO.getRegionList(region);
	}

	@Override
	public List<Region> getRegionIdList(String id) throws Exception {
		// TODO Auto-generated method stub
		return this.regionDAO.getRegionIdList(id);
	}

	@Override
	public Region getRegionConData(Region region) throws Exception {
		// TODO Auto-generated method stub
		return this.regionDAO.getRegionConData(region);
	}

}
