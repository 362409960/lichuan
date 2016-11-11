package com.li.design.state;

public class RunState extends ListState {

	@Override
	public void open() {
		// TODO Auto-generated method stub

	}

	@Override
	public void close() {
		// TODO Auto-generated method stub

	}

	@Override
	public void run() {
		System.out.println("电梯上下运行...");

	}

	@Override
	public void stop() {
		super.context.setListState(Context.stopState);
		super.context.getListState().stop();

	}

}
