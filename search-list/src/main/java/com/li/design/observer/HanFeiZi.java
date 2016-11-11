package com.li.design.observer;

import java.util.ArrayList;
//观察者实现类
public class HanFeiZi implements Observable, IHanFeizi {
	
	private ArrayList<Observer> observerList = new ArrayList<Observer>();

	@Override
	public void haveBreakfast() {
		System.out.println("韩非子：开始吃饭。。。");
		this.notifyObserver("韩非子在吃饭");

	}

	@Override
	public void havaFun() {
		System.out.println("韩非子：开始娱乐。。。");
		this.notifyObserver("韩非子在娱乐");

	}

	@Override
	public void addObserver(Observer observer) {
		this.observerList.add(observer);

	}

	@Override
	public void deleteObserver(Observer observer) {
		this.observerList.remove(observer);

	}

	@Override
	public void notifyObserver(String context) {
		for(Observer observer : observerList){
			observer.update(context);
		}
	}

}
