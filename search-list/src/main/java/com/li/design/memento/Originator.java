package com.li.design.memento;

/**
 * 发起角色
 * 
 * @author lichuan
 *
 */
public class Originator implements Cloneable {
	
	private Originator backup;

	private String state = "";

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	// 创建一个备忘录
	public void createMemento() {
		this.backup =  this.clone();
	}

	// 恢复一个备忘录
	public void restoreMemento() {
		this.setState(this.backup.getState());
	}

	// 克隆当前对象
	@Override
	protected Originator clone() {
		try {
			return (Originator) super.clone();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;

	}

}
