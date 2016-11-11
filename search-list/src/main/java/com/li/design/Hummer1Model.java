package com.li.design;

public class Hummer1Model extends HummerModel {

	@Override
	protected void start() {
		System.out.println("悍马启动");
	}

	@Override
	protected void stop() {
		System.out.println("悍马停止");

	}

	@Override
	protected void alarm() {
		System.out.println("悍马喇叭");

	}

	@Override
	protected void engineBoom() {
		System.out.println("悍马引擎");

	}

}
