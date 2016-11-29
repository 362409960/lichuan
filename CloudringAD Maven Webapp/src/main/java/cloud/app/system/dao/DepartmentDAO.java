package cloud.app.system.dao;

import java.util.List;

import cloud.app.system.po.Department;

public interface DepartmentDAO {
	
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
	
	public List<Department> queryChildrenDepartmentInfo(String name)throws Exception;
}
