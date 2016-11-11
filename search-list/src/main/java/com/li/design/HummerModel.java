package com.li.design;
//模板方法模式例子
public abstract class HummerModel {
	
	//启动
	protected abstract void start();
	//停止
	protected abstract void stop();
	//喇叭声
	protected abstract void alarm();
	//引擎声
	protected abstract void engineBoom();
	
	final public void run(){
		this.start();
		
		this.engineBoom();
		
		this.alarm();
		
		this.stop();
	}

}
