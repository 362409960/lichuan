package com.li.design.face;

/**
 * 门面处理类
 * 
 * @author lichuan
 *
 */
public class Facade {

	private ILetterProcess letterProcess;
	private Police letterPolice;

	public Facade() {
		this.letterProcess = new ILetterProcessImpl();
		this.letterPolice = new Police();
	}

	public void sendLetter(String context, String address) {
		letterProcess.writeContext(context);
		letterProcess.fillEnvelope(address);
		letterPolice.checkLetter(letterProcess);
		letterProcess.letterInotoEnvelope();
		letterProcess.sendLetter();
	}

}
