package com.li.design.decorator;

public class HighScoreDecorators extends Decorators {

	public HighScoreDecorators(SchoolReport schoolReport) {
		super(schoolReport);
		
	}
	
	private void reportHighScore(){
		System.out.println("这次考试语文最高是75，数学是78，自然是80");
	}
	@Override
	public void report(){
		this.reportHighScore();
		super.report();
	}

}
