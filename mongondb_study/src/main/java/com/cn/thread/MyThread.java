package com.cn.thread;

public class MyThread implements Runnable {

	@Override
	public void run() {
		System.out.println(Thread.currentThread().getName()+"正在执行");

	}

}
