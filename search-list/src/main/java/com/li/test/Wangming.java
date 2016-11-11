package com.li.test;

import java.util.concurrent.Delayed;
import java.util.concurrent.TimeUnit;

public class Wangming implements Delayed {
    //用户名
	private String name;
	// 身份证
	private String id;
	// 截止时间
	private long endTime;

	public Wangming(String name, String id, long endTime) {
		this.name = name;
		this.id = id;
		this.endTime = endTime;
	}

	public String getName() {
		return this.name;
	}

	public String getId() {
		return this.id;
	}

	/**
	 * 用来判断是否到了截止时间
	 */
	@Override
	public long getDelay(TimeUnit unit) {
		return endTime - System.currentTimeMillis();
	}

	/**
	 * 相互批较排序用
	 */
	@Override
	public int compareTo(Delayed o) {
		Wangming jia = (Wangming) o;
		return endTime - jia.endTime > 0 ? 1 : 0;
	}

}
