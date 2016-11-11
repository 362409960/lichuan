package com.li.design.bridge;

public class Client {

	public static void main(String[] args) {
		House house = new House();
		System.out.println("-----房地产公司是这样运行的-----");
		
		HouseCorp houseCorp = new HouseCorp(house);
		
		houseCorp.doMoney();
		
		System.out.println("\n");
		
		System.out.println("----山寨公司是这样运行的-----");
		ShanZhaiCorp shan = new ShanZhaiCorp(new IPod());
		shan.doMoney();

	}

}
