package com.li.design.face;

public class Client {

	public static void main(String[] args) {
		Facade facade = new Facade();
		String context = "Hello,It's me,do you know who I am? ";
		String address = "Happy Road No.666";
		facade.sendLetter(context, address);

	}

}
