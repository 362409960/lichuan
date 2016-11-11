package com.li.design.state;

public class Client {

	public static void main(String[] args) {
		Context context = new Context();
		context.setListState(new CloseState());
		context.open();
		context.close();
		context.run();
		context.stop();

	}

}
