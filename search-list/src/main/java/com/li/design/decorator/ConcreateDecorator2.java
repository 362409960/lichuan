package com.li.design.decorator;
//具体装饰角色
public class ConcreateDecorator2 extends Decorator {

	public ConcreateDecorator2(Component component) {
		super(component);
		
	}
	
	private void method2(){
		System.out.println("method1 修饰");
	}
	@Override
	public void operate(){
		super.operate();
		this.method2();
	}

}
