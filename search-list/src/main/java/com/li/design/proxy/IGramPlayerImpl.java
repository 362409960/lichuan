package com.li.design.proxy;

public class IGramPlayerImpl implements IGramPlayer {

	@Override
	public void login(String username, String password) {
		System.out.println("登录"+username +",密码是："+password);

	}

	@Override
	public void killBoss() {
		System.out.println("杀死boss，爆料一地的装备");

	}

	@Override
	public void upgrade() {
		System.out.println("哥们不错，有升了一级");

	}

}
