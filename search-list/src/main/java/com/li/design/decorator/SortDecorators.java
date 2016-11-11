package com.li.design.decorator;

public class SortDecorators  extends Decorators{

	public SortDecorators(SchoolReport schoolReport) {
		super(schoolReport);
		
	}
	
	private  void reportSort(){
		System.out.println("我是排名第38名。。");
	} 
	@Override
	public void report(){
		super.report();
		this.reportSort();
	}

}
