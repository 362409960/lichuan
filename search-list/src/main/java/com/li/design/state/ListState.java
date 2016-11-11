package com.li.design.state;
/**
 * 抽象电梯状态
 * @author lichuan
 *
 */
public abstract class ListState {
	
	protected Context context;

	public Context getContext() {
		return context;
	}

	public void setContext(Context context) {
		this.context = context;
	}
	
	public abstract void open();
	
	public abstract void close();
	
	public abstract void run();
	
	public abstract void stop();
	


}
