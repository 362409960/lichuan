package com.li.design.intermediary;

public class HuseOwner extends Person {

	HuseOwner(String name, Mediator mediator) {
		super(name, mediator);		
	}
	
	public void getMsg(String msg){
		System.out.println("我是房主，我有房主，需要出租"+msg);
	}
	public void msg(String message){
        mediator.constact(message, this);
    }

}
