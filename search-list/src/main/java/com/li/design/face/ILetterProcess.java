package com.li.design.face;
/**
 * 写信过程接口
 * @author lichuan
 *
 */
public interface ILetterProcess {
	//写信内容
	public void writeContext(String context);
	//写信封
	public void fillEnvelope(String address);
	//把信放在信封里面
	public void letterInotoEnvelope();
	//邮递
	public void sendLetter();

}
