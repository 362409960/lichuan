package com.li.design.flyweight;

public class SingInfo4Pool extends SingInfo {

	private String key;

	public SingInfo4Pool(String _key) {
		this.key = _key;
	}

	public String getKey() {
		return key;
	}

	public void setKey(String key) {
		this.key = key;
	}

}
