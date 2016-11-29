package cloud.app.system.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import cloud.app.system.po.Department;

public interface DepartmentService {
	
	public List<Department> getDepartmentByName(String name)throws Exception;
	
	public Department getDepartmentById(String id)throws Exception;
	
	public List<Department> getDepartmentList(Department department)throws Exception;
	
	public List<Department> getDepartmentListNodeById(String id)throws Exception;
	
	public List<Department> getDepartmentByPid(String pid)throws Exception;
	
	public int departmentCount()throws Exception;
	
	public Department getDepartmentParentName();
	
	public void insertDepartment(Department department)throws Exception;
	
	public void updateDepartment(Department department)throws Exception;
	
	public void deleteDepartment(String id)throws Exception;
	
	public void deleteDepartmentByPid(String id)throws Exception;

	/**
	 * 获取机构及下属ID
	 * @param request
	 * @return
	 * @throws Exception
	 */
	public List<String> getDepartmentIds(HttpServletRequest request) throws Exception;
}
