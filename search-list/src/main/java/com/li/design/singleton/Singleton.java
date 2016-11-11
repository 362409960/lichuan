package com.li.design.singleton;
//单例模式[默认无反射]
public class Singleton {

	//volatile 并发关键字，修饰的变量，线程在每次使用变量的时候，都会读取变量修改后的最的值，
	//一旦一个共享变量（类的成员变量、类的静态成员变量）被volatile修饰之后，那么就具备了两层语义：
    //保证了不同线程对这个变量进行操作时的可见性，即一个线程修改了某个变量的值，这新值对其他线程来说是立即可见的。
	//禁止进行指令重排序。
	private volatile static Singleton singleton;

	private Singleton() {

	}

	public static Singleton getSingleton() {
		if (null == singleton) {
			synchronized (Singleton.class) {
				if (null == singleton) {
					singleton = new Singleton();
				}
			}
		}
		return singleton;
	}

}
