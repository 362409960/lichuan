package com.cn.thread.lichuan;

public class JoinTest implements Runnable {

	private static int a = 0;

	@Override
	public void run() {
		for (int k = 0; k < 5; k++) {
                a = a + 1;
		}
	}
	
	public static void main(String[] args) throws InterruptedException {
		Runnable r = new JoinTest();
		Thread t = new Thread(r);
		t.start();
		t.join();
		System.out.println(a);
	}

}
