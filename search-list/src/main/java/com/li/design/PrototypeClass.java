package com.li.design;

public class PrototypeClass implements Cloneable {
	
	@Override
	public PrototypeClass clone(){
		PrototypeClass prototypeClass = null;
		try {
			prototypeClass = (PrototypeClass) super.clone();
		} catch (CloneNotSupportedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return prototypeClass;
		
	}

}

