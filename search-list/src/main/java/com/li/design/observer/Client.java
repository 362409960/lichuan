package com.li.design.observer;

public class Client {

	public static void main(String[] args) {
		Observer lisi = new LiSi();
		HanFeiZi han = new HanFeiZi();
		han.addObserver(lisi);
		han.haveBreakfast();
		
		han.havaFun();

	}

}
