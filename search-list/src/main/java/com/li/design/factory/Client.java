package com.li.design.factory;

public class Client {

	public static void main(String[] args) {
		Creator creator = new ConcreateCreator();
		
		Product product = creator.createProduct(ConcreateProduct1.class);
		
		product.method1();
		
		product.method2();
		
       Product product1 = creator.createProduct(ConcreateProduct2.class);
		
		product1.method1();
		
		product1.method2();

	}

}
