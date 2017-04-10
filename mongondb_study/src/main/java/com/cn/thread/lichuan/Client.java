package com.cn.thread.lichuan;

import java.util.Enumeration;

public class Client {

	public static void main(String[] args) {
		LinkQueue<String> queue = new LinkQueue<>();
		queue.addQueue("a");
		queue.addQueue("b");
		queue.addQueue("c");
       // System.out.println(stack.peek());
  
		
        
    	queue.poll();
		
       
       // System.out.println(queue.search("a"));
	}
	
	
	

}
