package com.li.design.component;

import java.util.ArrayList;

public class Composite extends Componet {
	//构造容器
	private ArrayList<Componet> componetArrayList = new ArrayList<Componet>();
	
	public void add(Componet componet){
		this.componetArrayList.add(componet);
	}
	
	public void remove(Componet componet){
	  this.componetArrayList.remove(componet);
	}

	public ArrayList<Componet> getChildren(){
		return this.componetArrayList;
	}

}
