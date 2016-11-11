package com.li.design.state;

public class OpenState extends ListState {

	@Override
	public void open() {
		System.out.println("电梯门开启。。");

	}

	@Override
	public void close() {
		//更新状态
		super.context.setListState(Context.closeState);
		//动作委托为CloseState来执行
		super.context.getListState().close();

	}

	@Override
	public void run() {
		// TODO Auto-generated method stub

	}

	@Override
	public void stop() {
		// TODO Auto-generated method stub

	}

}
