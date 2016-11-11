package com.li.design;

public class ConcreateProduct extends Builder {
	
	private Product product = new Product();

	@Override
	public void setPart() {
		

	}

	@Override
	public Product bulidProduct() {
		
		return product;
	}

}
