package com.li.design.decorator;

public class Father {

	public static void main(String[] args) {
		SchoolReport sr;
		
		sr = new  FouthGradeSchoolReport();
		
		sr = new HighScoreDecorators(sr);
		
		sr = new SortDecorators(sr);
		
		sr.report();
		
		sr.sign("张三");

	}

}
