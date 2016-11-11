package com.li.design.intermediary;



public class MediatorStructure extends Mediator {
	
	private  HuseOwner huseOwner;
	
	private Tenant tenant;
	

	public HuseOwner getHuseOwner() {
		return huseOwner;
	}


	public void setHuseOwner(HuseOwner huseOwner) {
		this.huseOwner = huseOwner;
	}

	public Tenant getTenant() {
		return tenant;
	}



	public void setTenant(Tenant tenant) {
		this.tenant = tenant;
	}




	@Override
	public void constact(String msg, Person person) {
		if(person instanceof HuseOwner){
			huseOwner.getMsg(msg);
		}else{
			tenant.getMsg(msg);
		}

	}

}
