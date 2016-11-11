package com.li.design.interpreter;

import java.util.HashMap;
import java.util.Stack;

/**
 * 解析器封装类
 * 
 * @author lichuan
 *
 */
public class Calculator {
	private Expression expression;

	public Calculator(String expStr) {
		Stack<Expression> stack = new Stack<Expression>();

		char[] charArray = expStr.toCharArray();
		Expression left = null;
		Expression right = null;
		for (int i = 0; i < charArray.length; i++) {
			switch (charArray[i]) {
			case '+':
				left = stack.pop();
				right = new VarExpression(String.valueOf(charArray[++i]));
				stack.push(new AddExpression(left, right));
				break;
			case '-':
				left = stack.pop();
				right = new VarExpression(String.valueOf(charArray[++i]));
				stack.push(new SubExpression(left, right));
				break;

			default:
				stack.push(new VarExpression(String.valueOf(charArray[i])));
			}
		}
	}

	public int run(HashMap<String, Integer> var) {
		return this.expression.interpreter(var);
	}

}
