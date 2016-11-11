package com.li.design.decorator;
//具体装饰角色
public class ConcreateDecorator1 extends Decorator {


	
	public ConcreateDecorator1(Component component) {
		super(component);
		// TODO Auto-generated constructor stub
	}

	private void method1(){
	    System.out.println("method1 修饰");	
	}
	@Override
	public void operate(){
		this.method1();
		super.operate();
	}

}
