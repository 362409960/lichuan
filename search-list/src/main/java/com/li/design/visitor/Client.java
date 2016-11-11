package com.li.design.visitor;

import java.util.ArrayList;
import java.util.List;

public class Client {

	public static void main(String[] args) {
		for(Employee emp : mockEmployee()){
			emp.accept(new Visitor());
		}

	}
	
	public static List<Employee> mockEmployee(){
		List<Employee> empList = new ArrayList<Employee>();
		
		return empList;
	}

}
