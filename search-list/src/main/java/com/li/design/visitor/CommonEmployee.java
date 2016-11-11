package com.li.design.visitor;

public class CommonEmployee extends Employee {
	
	private String job;

	public String getJob() {
		return job;
	}

	public void setJob(String job) {
		this.job = job;
	}

	@Override
	public void accept(IVisitor vistior) {
		vistior.visit(this);

	}

}
