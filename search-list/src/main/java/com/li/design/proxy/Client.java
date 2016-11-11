package com.li.design.proxy;

import java.lang.reflect.InvocationHandler;
import java.lang.reflect.Proxy;

public class Client {

	

	public static void main(String[] args) {
		
		 IGramPlayer iGram = new IGramPlayerImpl();
		//获得被代理类的类加载器，使得JVM能够加载并找到被代理类的内部结构，以及已实现的interface 
		 ClassLoader loader = iGram.getClass().getClassLoader();
		 //获得被代理类已实现的所有接口interface,使得动态代理类的实例  
		 Class [] interfaces = iGram.getClass().getInterfaces();
		//用被代理类的实例创建动态代理类的实例，用于真正调用处理程序  
		 InvocationHandler handler = new ProxyHanlder(iGram);

		 IGramPlayer play =  (IGramPlayer) Proxy.newProxyInstance(loader, interfaces, handler);
		 
		 play.login("李川", "43");
		 
		 play.killBoss();
		 
		 play.upgrade();

	}

}
