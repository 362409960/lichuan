package com.li.design.factory;
//具体工厂
public class ConcreateCreator extends Creator {

	@Override
	public <T extends Product> T createProduct(Class<T> c) {
		Product prodcut = null;
		try {
			//使用反射得到产品
			prodcut = (Product) Class.forName(c.getName()).newInstance();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return (T) prodcut;
	}

}
