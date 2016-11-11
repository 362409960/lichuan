package com.li.design.builder;
/**
 * Person对象的整体构造器 
 * @author lichuan
 *
 */
public class PersonDirector {
	
	public Person constructPerson(PersonBuilder pb){
		pb.bulidHead();
		pb.bulidBody();
		pb.bulidFoot();;
		return pb.bulidPerson();
	}

}
