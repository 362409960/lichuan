package com.cn.thread;

import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

public class TestCachedThreadPool {

	public static void main(String[] args) {
		// 创建可缓冲的线程池。没有大小限制
		ExecutorService executor = Executors.newCachedThreadPool();
		
		MyThread t1 = new MyThread();

		MyThread t2 = new MyThread();

		MyThread t3 = new MyThread();

		MyThread t4 = new MyThread();
		
		executor.execute(t1);
		
		executor.execute(t2);
		
		executor.execute(t3);
		
		executor.execute(t4);
		
		executor.shutdown();

	}

}
