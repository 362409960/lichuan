package com.li.design;

import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

public class Son extends Father {

	public Collection<Object> doSomething(HashMap<String, Object> map){
		System.out.println("子类被执行");
		return map.values();
	}


}
