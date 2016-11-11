package com.li.design.visitor;

public interface IVisitor {
	
	public void visit(CommonEmployee commonEmployee);
	
	public void visit(Manager manager);
	


}
