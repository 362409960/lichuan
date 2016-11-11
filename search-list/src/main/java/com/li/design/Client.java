package com.li.design;

import java.util.HashMap;

public class Client {

	public static void main(String[] args) {
		invoker();

	}
	
	public static void invoker(){
		//Father f = new Father();
		Son s = new Son();
		HashMap<String, Object> map = new HashMap<String, Object>();
		s.doSomething(map);
	}

}
