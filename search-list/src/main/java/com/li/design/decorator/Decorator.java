package com.li.design.decorator;
//装饰角色
public class Decorator extends Component {
	
	private Component component;
	
	public Decorator(Component component){
		this.component = component;
	}

	@Override
	public void operate() {
		this.component.operate();

	}

}
