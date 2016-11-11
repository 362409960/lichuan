package com.li.design.intermediary;

public class Client {

	public static void main(String[] args) {
		MediatorStructure mediator = new MediatorStructure();

		// 房主和租房者只需要知道中介机构即可
		HuseOwner houseOwner = new HuseOwner("张三", mediator);
		Tenant tenant = new Tenant("李四", mediator);

		// 中介结构要知道房主和租房者
		mediator.setHuseOwner(houseOwner);
		mediator.setTenant(tenant);

		tenant.msg("听说你那里有三室的房主出租.....");
		houseOwner.msg("是的!请问你需要租吗?");

	}

}
