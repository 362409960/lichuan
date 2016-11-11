package com.li.design.memento;

public class Client {

	public static void main(String[] args) {

     Originator originator = new Originator();
     
     Caretaker caretaer = new Caretaker();
     //创建一个备忘录
  //   caretaer.setMemeno(originator.createMemento());
     //恢复一个备忘录
    // originator.restoreMemento(caretaer.getMemeno());
     
     //建立初始状态
     originator.setState("初始状态。。。");
     System.out.println("初始状态是："+originator.getState());
     
     //建立备份
     
     originator.createMemento();
     
     //修改状态
     originator.setState("修改状态。。。");     
     System.out.println("修改状态是："+originator.getState());
     
     //还原状态
     
     originator.restoreMemento();
     System.out.println("恢复后的状态是："+originator.getState());
     
	}

}
