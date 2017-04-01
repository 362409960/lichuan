package com.cn.thread.lichuan;

import java.util.Enumeration;

public class Client {

	public static void main(String[] args) {
		Stack<String> stack = new Stack<>();
        stack.push("a");
        stack.push("b");
        stack.push("c");
       // System.out.println(stack.peek());
   stack.pop();
      
        System.out.println(stack.search("b"));
        
        while(!stack.empty()){
        	stack.pop();
        }
        System.out.println(stack.search("a"));
	}
	
	
	

}
