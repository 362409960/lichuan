package com.cn.thread.lichuan;
/**
 * @param 顺序栈
 * @author lichuan
 *
 * @param <E>
 */
public class Stack<E> {

	private Object[] data = null;
	// 栈的容量
	private int maxSize = 0;
	// 栈顶指针
	private int top = -1;

	// 初始化栈
	public Stack() {
		this(10);
	}

	public Stack(int initialSize) {
		if (initialSize >= 0) {
			this.maxSize = initialSize;
			data = new Object[initialSize];
			top = -1;
		} else {
			throw new RuntimeException("初始化大小不能小于0：" + initialSize);
		}
	}

	// 判断栈是否为空
	public boolean empty() {
		return top == -1 ? true : false;
	}

	// 进栈,第一个元素top=0；
	public boolean push(E e) {
		if (top == maxSize - 1) {
			throw new RuntimeException("栈已满，无法将元素入栈！");
		} else {
			data[++top] = e;
			return true;
		}
	}

	// 拿到栈的最顶的元素
	public E peek() {
		if (top == -1) {
			throw new RuntimeException("栈为空！");
		} else {
			return (E) data[top];
		}
	}

	// 出栈
	public E pop() {
		if (top == -1) {
			throw new RuntimeException("栈为空！");
		} else {
			return (E) data[top--];
		}
	}
	 //返回对象在堆栈中的位置，以 1 为基数
	public int search(E e) {		
		while (top != -1) {
			if (peek() != e) {
				top--;
			} else {
				break;
			}
		}
		int result = top + 1;
		return result;
	}

}
