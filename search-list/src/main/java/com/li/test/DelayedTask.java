package com.li.test;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.Delayed;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.TimeUnit;

public class DelayedTask implements Delayed, Runnable {

	private static int counter = 0;
	protected static List<DelayedTask> sequence = new ArrayList<DelayedTask>();
	private final int id = counter++;
	private final int delayTime;
	private final long triggerTime;

	public DelayedTask(int delayInMillis) {
		delayTime = delayInMillis;
		triggerTime = System.nanoTime() + TimeUnit.NANOSECONDS.convert(delayTime, TimeUnit.MILLISECONDS);
		sequence.add(this);
	}

	/**
	 * 相互批较排序用
	 */
	@Override
	public int compareTo(Delayed arg0) {
		DelayedTask that = (DelayedTask) arg0;
		if (triggerTime < that.triggerTime)
			return -1;
		if (triggerTime > that.triggerTime)
			return 1;
		return 0;

	}

	/**
	 * 剩余的延迟时间
	 */
	@Override
	public long getDelay(TimeUnit unit) {
		return unit.convert(triggerTime - System.nanoTime(), TimeUnit.NANOSECONDS);
	}

	/**
	 * 线程启动
	 */
	@Override
	public void run() {
		System.out.println(Thread.currentThread().getName()+"填充需要处理的业务！！！！！！！");
	}
	
	public static class EndSentinel extends DelayedTask {
        private ExecutorService exec;
        public EndSentinel(int delay, ExecutorService exec) {
            super(delay);
            this.exec = exec;
        }
        @Override
        public void run() {
            System.out.println(this + " calling shutDownNow()");
            exec.shutdownNow();
        }
    }

}
