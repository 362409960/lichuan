package com.li.design.builder;
/**
 * 男人的构建者
 * @author lichuan
 *
 */
public class ManBuilder implements PersonBuilder {
	
	private Person person = new Man();

	@Override
	public void bulidHead() {
		person.setHead("创建男人的头");

	}

	@Override
	public void bulidBody() {
		person.setBody("创建男人的身体");

	}

	@Override
	public void bulidFoot() {
		person.setFoot("创建男人的脚");

	}

	@Override
	public Person bulidPerson() {	
		return person;
	}

}
