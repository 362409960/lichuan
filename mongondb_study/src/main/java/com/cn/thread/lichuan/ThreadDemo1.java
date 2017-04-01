package com.cn.thread.lichuan;
/**
 * 
 * @author lichuan
 *
 */
public class ThreadDemo1 implements Runnable {

	private String name;

	public ThreadDemo1(String name) {
		this.name = name;
	}

	@Override
	public void run() {
		for (int i = 0; i < 5; i++) {
			System.out.println(name + "运行：" + i);
			try {
				Thread.sleep((int) (Math.random() * 10));
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
	
	public static void main(String[] args) {
	  new Thread(new ThreadDemo1("C")).start();
	  new Thread(new ThreadDemo1("D")).start();
		
	}

}
