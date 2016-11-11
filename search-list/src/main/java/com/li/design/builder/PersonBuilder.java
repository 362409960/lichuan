package com.li.design.builder;
/**
 * 人对象的构造接口 
 * @author lichuan
 *
 */
public interface PersonBuilder {
	//创建产品的不同部分，创建人的头
	void bulidHead();
	//创建产品的不同部分，创建人的身体
	void bulidBody();
	//创建产品的不同部分，创建人的脚
	void bulidFoot();
	//建造产品【人】
	Person bulidPerson();

}
