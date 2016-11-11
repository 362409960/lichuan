package com.li.design.order;
//命名者
public abstract class Command {
	
	RequirementGroup rg = new RequirementGroup();
	
	PageGroup pg = new PageGroup();
	
	CodeGroup cg = new CodeGroup();
	
	public abstract void execute();

}
