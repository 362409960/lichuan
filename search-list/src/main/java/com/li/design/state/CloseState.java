package com.li.design.state;

public class CloseState extends ListState {

	@Override
	public void open() {
		super.context.setListState(Context.openState);
		super.context.getListState().open();

	}

	@Override
	public void close() {
		System.out.println("电梯门关闭。。");

	}

	@Override
	public void run() {
		super.context.setListState(Context.runState);
		super.context.getListState().run();

	}

	@Override
	public void stop() {
		super.context.setListState(Context.stopState);
		super.context.getListState().stop();

	}

}
