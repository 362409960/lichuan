package com.li.design.memento;

public class Originator1 {

	private String state = "";

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public IMemento createMemento() {
		return new Memento(this.state);
	}

	public void restoreMemento(IMemento _memento) {
		this.setState(((Memento) _memento).getState());
	}

	private class Memento implements IMemento {
		private String state = "";

		public Memento(String _state) {
			this.state = _state;
		}

		public String getState() {
			return state;
		}

		public void setState(String state) {
			this.state = state;
		}

	}

}
