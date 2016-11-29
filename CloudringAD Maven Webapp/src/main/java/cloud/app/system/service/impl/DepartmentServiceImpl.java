package cloud.app.system.service.impl;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cloud.app.common.Constants;
import cloud.app.system.dao.DepartmentDAO;
import cloud.app.system.po.Department;
import cloud.app.system.service.DepartmentService;
import cloud.app.system.vo.SysUserVO;

@Service
public class DepartmentServiceImpl implements DepartmentService {
	
	@Autowired
	private DepartmentDAO departmentDAO;

	@Override
	public Department getDepartmentById(String id) throws Exception {
		// TODO Auto-generated method stub
		return departmentDAO.getDepartmentById(id);
	}

	@Override
	public List<Department> getDepartmentList(Department department)
			throws Exception {
		// TODO Auto-generated method stub
		return departmentDAO.getDepartmentList(department);
	}

	@Override
	public void insertDepartment(Department department) throws Exception {
		// TODO Auto-generated method stub
		departmentDAO.insertDepartment(department);
	}

	@Override
	public void updateDepartment(Department department) throws Exception {
		// TODO Auto-generated method stub
		departmentDAO.updateDepartment(department);
	}

	@Override
	public void deleteDepartment(String id) throws Exception {
		// TODO Auto-generated method stub
		departmentDAO.deleteDepartmentByPid(id);//删除子节点
		departmentDAO.deleteDepartment(id);
	}

	@Override
	public List<Department> getDepartmentByPid(String pid) throws Exception {
		// TODO Auto-generated method stub
		return departmentDAO.getDepartmentByPid(pid);
	}

	@Override
	public List<Department> getDepartmentListNodeById(String id)
			throws Exception {
		// TODO Auto-generated method stub
		return departmentDAO.getDepartmentListNodeById(id);
	}

	@Override
	public Department getDepartmentParentName() {
		// TODO Auto-generated method stub
		return departmentDAO.getDepartmentParentName();
	}

	@Override
	public int departmentCount() throws Exception {
		// TODO Auto-generated method stub
		return departmentDAO.departmentCount();
	}

	@Override
	public List<Department> getDepartmentByName(String name) throws Exception {
		// TODO Auto-generated method stub
		return departmentDAO.getDepartmentByName(name);
	}

	@Override
	public void deleteDepartmentByPid(String id) throws Exception {
		// TODO Auto-generated method stub
		departmentDAO.deleteDepartmentByPid(id);
	}
	
	/**
	 * 获取机构及下属ID
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@Override
	public List<String> getDepartmentIds(HttpServletRequest request) throws Exception
	{
		List<String> listMenuId = new ArrayList<String>();
		SysUserVO user=(SysUserVO) request.getSession().getAttribute(Constants.SESSION_LOGIN_USER);
		List<Department> departs = departmentDAO.queryChildrenDepartmentInfo(user.getDepartmentid());
		for (Department department : departs) {
			listMenuId.add(department.getId());
		}
		
		return listMenuId;
	}
	
	/**
	 * 获取机构ID
	 * @param request
	 * @return
	 * @throws Exception
	 
	@Override
	public List<String> getDepartmentIds(HttpServletRequest request) throws Exception
	{
		List<String> listMenuId = new ArrayList<String>();
		SysUserVO user=(SysUserVO) request.getSession().getAttribute(Constants.SESSION_LOGIN_USER);
		Department depart_id = departmentDAO.getDepartmentById(user.getDepartmentid());
		if(depart_id!=null){
			listMenuId.add(depart_id.getId());
		}
		
		Department depart_pid = departmentDAO.getDepartmentById(depart_id.getPid());
		if(depart_pid!=null){
			listMenuId.add(depart_pid.getId());
			if(depart_pid.getPid()!="0"){
				Department depart_pid1 = departmentDAO.getDepartmentById(depart_id.getPid());
				if(depart_pid1!=null){
					listMenuId.add(depart_pid1.getId());
				}
			}
		}
		
		List<Department> depart_pids = departmentDAO.getDepartmentListNodeById(depart_id.getId());
		for (Department department : depart_pids) {
			listMenuId.add(department.getId());
		}
		
		return listMenuId;
	}*/
	
}
