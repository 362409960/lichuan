package com.li.design.memento;

/**
 * 备忘录管理员角色
 * 
 * @author lichuan
 *
 */
public class Caretaker {

	private Memento memeno;

	public Memento getMemeno() {
		return memeno;
	}

	public void setMemeno(Memento memeno) {
		this.memeno = memeno;
	}

}
