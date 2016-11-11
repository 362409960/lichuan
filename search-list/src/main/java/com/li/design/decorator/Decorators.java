package com.li.design.decorator;

public class Decorators extends SchoolReport {
	
	private SchoolReport schoolReport;
	
	public Decorators(SchoolReport schoolReport){
		this.schoolReport = schoolReport;
	}

	@Override
	public void report() {
		this.schoolReport.report();

	}

	@Override
	public void sign(String name) {
		this.schoolReport.sign(name);

	}

}
