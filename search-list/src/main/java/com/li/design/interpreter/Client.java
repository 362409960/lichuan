package com.li.design.interpreter;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.HashMap;

public class Client {

	public static void main(String[] args) throws Exception {
		String expStr = getExpStr();

		HashMap<String, Integer> var = getValue(expStr);
		Calculator cal = new Calculator(expStr);

		System.out.println("运算结果为：" + expStr + "=" + cal.run(var));

	}

	public static String getExpStr() throws Exception {
		System.out.println("请输入表达式：");
		return new BufferedReader(new InputStreamReader(System.in)).readLine();
	}

	public static HashMap<String, Integer> getValue(String exprStr) throws Exception {
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		for (char ch : exprStr.toCharArray()) {
			if (ch != '+' && ch != '-') {
				if (!map.containsKey(String.valueOf(ch))) {
					String in = new BufferedReader(new InputStreamReader(System.in)).readLine();
					map.put(String.valueOf(ch), Integer.valueOf(in));
				}
			}
		}
		return map;
	}

}
