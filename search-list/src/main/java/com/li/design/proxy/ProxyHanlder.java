package com.li.design.proxy;

import java.lang.reflect.InvocationHandler;
import java.lang.reflect.Method;
/**
 * 动态代理，必须实现接口InvocationHandler
 * @author lichuan
 *
 */
public class ProxyHanlder implements InvocationHandler {
	
	//被代理的实例
	Object obj = null;
	
	 //我要代理谁
	public ProxyHanlder(Object _obj){
		this.obj = _obj;
	}
	 //调用被代理的方法
	@Override
	public Object invoke(Object proxy, Method method, Object[] arg) throws Throwable {
		doBefore();
		Object result = method.invoke(this.obj, arg);
		doAfter();
		return result;
	}

	private void doBefore() {
		System.out.println("before method invoke");
	}

	private void doAfter() {
		System.out.println("after method invoke");
	}

}
