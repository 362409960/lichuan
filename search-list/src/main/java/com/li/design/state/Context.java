package com.li.design.state;

public class Context {

	public final static OpenState openState = new OpenState();

	public final static CloseState closeState = new CloseState();

	public final static RunState runState = new RunState();

	public final static StopState stopState = new StopState();

	private ListState listState;

	public ListState getListState() {
		return listState;
	}

	public void setListState(ListState listState) {
		this.listState = listState;
		this.listState.setContext(this);
	}

	public void open() {
		this.listState.open();
	}

	public void close() {
		this.listState.close();
	}

	public void run() {
		this.listState.run();
	}

	public void stop() {
		this.listState.stop();
	}

}
