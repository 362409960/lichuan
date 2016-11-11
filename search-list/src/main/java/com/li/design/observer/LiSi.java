package com.li.design.observer;

public class LiSi implements Observer {

	@Override
	public void update(String context) {
		System.out.println("李斯：观察到韩非子活动，开始向老板汇报了。。。");
		this.reportToKing(context);
		System.out.println("汇报结束\n");
	}

	
	private void reportToKing(String text){
		System.out.println("sdfsd sdf "+text);
	}
}
