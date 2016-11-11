package com.li.design.order;

public class Client {

	public static void main(String[] args) {
		Invoker xiaosan = new Invoker();
		
		System.out.println("-------------客户要求增加一项需求------------");
		
		
		Command command = new AddRequirementCommand();
		
		xiaosan.setCommand(command);
		xiaosan.action();
		
		

	}

}
