package com.cn.thread;


import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

public class TestSingleThreadExecutor {
	
      public static void main(String[] args) {
    	  //创建线程数为1的线程池，
    	  ExecutorService pool  =  Executors.newSingleThreadExecutor();
    	  
    	   MyThread t1 = new  MyThread();    
    	   
    	   MyThread t2 = new  MyThread();   
    	   
    	   MyThread t3 = new  MyThread();    
    	   
    	   MyThread t4 = new  MyThread();    
    	   
    	   
    	   pool.execute(t1);
    	   
    	   pool.execute(t2);
    	   
    	   pool.execute(t3);
    	   
    	   pool.execute(t4);
    	   
    	   
    	   pool.shutdown();
		
	}

}
