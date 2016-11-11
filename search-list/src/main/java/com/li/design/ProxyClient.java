package com.li.design;

import java.lang.reflect.InvocationHandler;
import java.lang.reflect.Proxy;
import java.text.SimpleDateFormat;
import java.util.Date;



public class ProxyClient {

	public static void main(String[] args) {
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
		
		
		IGamePlay play = new GamePlay("李四");
		
 		InvocationHandler handler = new GamePlayIH(play);
		
		System.out.println("开始时间是：" + sf.format(new Date()));
		
		ClassLoader cl = play.getClass().getClassLoader();
		
		IGamePlay proxy = (IGamePlay) Proxy.newProxyInstance(cl, new Class[]{IGamePlay.class}, handler);
		
		proxy.login("zhangsan", "password");
		
		proxy.killBoss();
		
		proxy.upgrade();
		
		
		System.out.println("结束时间是：" + sf.format(new Date()));

	}

}
