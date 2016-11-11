package com.li.design.decorator;

public class Client {
	public static void main(String[] args) {
		Component component = new ConcreteComponent();
		
		component = new ConcreateDecorator1(component);
		
		component = new ConcreateDecorator2(component);
		
		component.operate();
	}

}
