package com.li.design.observer;
//被观察者接口
public interface Observable {

	//添加观察者
	public void addObserver(Observer observer);
	//删除观察者
	public void deleteObserver(Observer observer);
	//通知所有观察者
	public void notifyObserver(String context);
}
