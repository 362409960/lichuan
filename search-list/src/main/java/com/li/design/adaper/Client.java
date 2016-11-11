package com.li.design.adaper;

public class Client {

	public static void main(String[] args) {
		Target target = new ConcreateTarget();
		
		target.request();
		
		Target target2 = new Adapter();
		target2.request();

	}

}
