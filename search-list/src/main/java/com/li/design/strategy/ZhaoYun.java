package com.li.design.strategy;

public class ZhaoYun {

	public static void main(String[] args) {
		Context context;
		
		System.out.println("----刚到吴国的时候拆第一个----");
		context = new Context(new BackDoor());		
		context.operate();
		
		System.out.println("\n");
		
		System.out.println("----刘备乐不思蜀了，拆第二个了----");
		context = new Context(new GivenGreeLight());		
		context.operate();
		
		System.out.println("\n");
		
		System.out.println("----孙权的小兵追来了，咋办？拆第三个----");
		context = new Context(new BlockEnemy());		
		context.operate();
		
		System.out.println("\n");

	}

}
