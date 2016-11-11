package com.li.design.factory;
//工厂方法模式
//抽象产品
public abstract class Product {
	//产品类的公共方法
	public void method1(){
		System.out.println("do something ");
	}
	//抽象方法
	public abstract void method2();

}
