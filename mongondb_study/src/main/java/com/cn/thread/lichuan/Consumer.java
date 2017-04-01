package com.cn.thread.lichuan;

import java.util.concurrent.DelayQueue;

public class Consumer implements Runnable {

	private DelayQueue<Message> queue;

	public Consumer(DelayQueue<Message> queue) {
		this.queue = queue;
	}

	@Override
	public void run() {

		while (true) {
			try {
				Message take = queue.take();
				System.out.println("消费消息：" + take.getId() + ":" + take.getBody());
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

}
