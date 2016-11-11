package com.li.design;
//导演
public class Director {
	
	private Builder builder = new ConcreateProduct();
	
	public Product getAProduct(){
		builder.setPart();
		return builder.bulidProduct();
	}

}
