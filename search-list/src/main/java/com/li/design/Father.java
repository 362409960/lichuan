package com.li.design;

import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

public class Father {
	
	public Collection<Object> doSomething(Map<String, Object>  map){
		System.out.println("父类被执行");
		return map.values();
	}

}
