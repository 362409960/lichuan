package com.li.design.intermediary;

public class Tenant extends Person {

	Tenant(String name, Mediator mediator) {
		super(name, mediator);		
	}
	
	public void getMsg(String msg){
		System.out.println("我是租客，需要租房！"+msg);
	}
	public void msg(String message){
        mediator.constact(message, this);
    }

}
