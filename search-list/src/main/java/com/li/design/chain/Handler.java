package com.li.design.chain;


//责任链模式
public abstract class Handler {
	
	public final static int FATHER_LEVEL_REQUEST = 1;
	
	public final static int HUSBAND_LEVEL_REQUEST = 2;
	
	public final static int SON_LEVEL_REQUEST = 3;
	//下一个责任人
	private Handler nextHandler;
	
	private int level = 0;
	
	public Handler(int _level){
		this.level = _level;
	}
	

	public void setNextHandler(Handler nextHandler) {
		this.nextHandler = nextHandler;
	}

	public final void handlerMsg(IWomen women){
		if(women.getType() == this.level){
			this.response(women);
		}else{
			if(this.nextHandler != null){
				//递归
				this.nextHandler.handlerMsg(women);
			}else{
				System.out.println("----没地方请示了，按不同意处理---\n");
			}
		}
	}

	//有请求当然就有回应
    protected abstract void response(IWomen women);

}
