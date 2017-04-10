package com.cn.thread.lichuan;


/**
 * @param  链式存储
 * @author lichuan
 *
 * @param <E>
 */
public class LinkStack<E> {
	
	//栈的节点
	private class Node<E>{
		E e;
		Node<E> next;	
		public Node(){}
		public Node(E e,Node next){
			this.e = e;
			this.next = next;
			
		}
	}
	//栈顶元素
	private Node<E> top;
	//当前栈大小
	private int size;
	
	public LinkStack(){
		top = null;
	}
	//当前栈大小
	public int length(){
		return size;
	}
	//判空
	public boolean empty(){
		return size == 0;
	}
	//入栈：让top指向新创建的元素，新元素的next引用指向原来的栈顶元素
	public boolean push(E e){
		top = new Node<E>(e, top);
		size ++ ;
		return true;
	}
	//查看栈顶元素但不删除
	public Node<E> peek(){
		if (empty()){
			throw new RuntimeException("空栈异常！");
		} else{
			return top;
		}
	}
	//出栈
	public Node<E> pop(){
		if (empty()){
			throw new RuntimeException("空栈异常！");
		} else{
			Node<E> node = top;
			top = node.next;
			node.next = null;
			size--;
			return node;
		}
	}

}
