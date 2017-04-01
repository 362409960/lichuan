package com.cn.thread.lichuan;

public class ThreadDemo extends Thread {

	private String pName;

	public ThreadDemo(String name) {
		this.pName = name;
	}

	public void run() {
		for (int i = 0; i < 5; i++) {
			System.out.println(pName + "运行：" + i);
			try {
				sleep((int) (Math.random() * 10));
			} catch (Exception e) {
                e.printStackTrace();
			}
		}
	}
	
	public static void main(String[] args) {
		ThreadDemo t1 = new ThreadDemo("A");
		ThreadDemo t2 = new ThreadDemo("B");
		t1.start();
		t2.start();
		
	}

}
