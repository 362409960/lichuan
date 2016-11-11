package com.li.design;

public class HummerClient {
	public static void main(String[] args) {
		HummerModel h1 = new Hummer1Model();
		HummerModel h2 = new Hummer2Model();
		h1.run();
		h2.run();
	}

}
