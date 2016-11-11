package com.li.design.interpreter;

import java.util.HashMap;

/**
 * 抽象表达式类
 * @author lichuan
 *
 */
public abstract class Expression {
	
	public abstract int interpreter(HashMap<String,Integer> var);

}
