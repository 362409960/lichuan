package cloud.app.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cloud.app.dao.MaterialDAO;
import cloud.app.entity.Material;
import cloud.app.service.MaterialService;
@Service
public class MaterialServiceImpl implements MaterialService {
	@Autowired
	private MaterialDAO materialDAO;

	@Override
	public void save(Material obj) throws Exception {
	 materialDAO.save(obj);

	}

	@Override
	public void update(Material obj) throws Exception {
		materialDAO.update(obj);

	}

	@Override
	public void deleteById(String id) throws Exception {
		materialDAO.deleteById(id);

	}

	@Override
	public List<Material> getList(Material obj) throws Exception {	
		Map<String, Object> params = setParams(obj);
		return materialDAO.getListMap(params);
	}

	@Override
	public Integer count(Material obj) throws Exception {	
		Map<String, Object> params = setParams(obj);
		return materialDAO.countMap(params);
	}
	
	public Map<String, Object> setParams(Material obj){
		Map<String, Object> params = new HashMap<String, Object>();
		
		String [] material_type = obj.getMaterial_type().split(",");
		String [] department_id = obj.getDepartment_id().split(",");
		params.put("material_type", material_type);
		params.put("department_id", department_id);
		params.put("name", obj.getName());
		params.put("startTime", obj.getStartTime());
	    params.put("endTime", obj.getEndTime());
	    params.put("pageIndex", obj.getPageIndex());
	    params.put("pageSize", obj.getPageSize());
	    
		return params;
	}

	@Override
	public Material getObjById(String id) throws Exception {		
		return materialDAO.getObjById(id);
	}

	@Override
	public void deleteByIdS(Map<String, Object> map) throws Exception {
		materialDAO.deleteByIdS(map);

	}

	@Override
	public List<Material> getListByUrl(Map<String, Object> map)
			throws Exception {
		
		return materialDAO.getListByUrl(map);
	}
	
}
