package com.li.design.state;

public class StopState extends ListState {

	@Override
	public void open() {
		super.context.setListState(Context.openState);
		super.context.getListState().open();

	}

	@Override
	public void close() {
		// TODO Auto-generated method stub

	}

	@Override
	public void run() {
		super.context.setListState(Context.runState);
		super.context.getListState().run();

	}

	@Override
	public void stop() {
		System.out.println("电梯停止了。。。");

	}

}
