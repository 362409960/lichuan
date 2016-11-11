package com.li.design;

public class Hummer2Model extends HummerModel {

	@Override
	protected void start() {
		System.out.println("悍马12启动");

	}

	@Override
	protected void stop() {
		System.out.println("悍马12停止");

	}

	@Override
	protected void alarm() {
		System.out.println("悍马12喇叭");

	}

	@Override
	protected void engineBoom() {
		System.out.println("悍马12引擎");

	}

}
