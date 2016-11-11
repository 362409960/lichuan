package com.li.design.flyweight;

import java.util.HashMap;

public class SignInfoFactory {

	private static HashMap<String, SingInfo> pool = new HashMap<String, SingInfo>();

	@Deprecated
	public static SingInfo SingInfo() {
		return new SingInfo();
	}

	public static SingInfo getSingInfo(String key) {
		SingInfo singInfo = null;
		if(!pool.containsKey(key)){
			System.out.println(key +"------建立对象，并放置到池中");
			singInfo = new SingInfo4Pool(key);
			pool.put(key, singInfo);
		}else{
			singInfo = pool.get(key);
			System.out.println(key+"---直接从池中取得");
		}
		
		return singInfo;

	}

}
