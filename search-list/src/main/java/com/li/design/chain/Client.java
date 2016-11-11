package com.li.design.chain;

import java.util.ArrayList;
import java.util.Random;

public class Client {

	public static void main(String[] args) {
		Random rand = new Random();
		
		ArrayList<IWomen> arryList = new ArrayList<IWomen>();
		for(int i = 1 ; i < 4 ; i++){
			arryList.add(new Women(rand.nextInt(4), "我要出去逛街"));
		}
		
		Handler father = new Father();
		Handler husband = new Husband();
		Handler son = new Son();
		father.setNextHandler(husband);
		husband.setNextHandler(son);
		for (IWomen iWomen : arryList) {
			father.handlerMsg(iWomen);
		}

	}

}
