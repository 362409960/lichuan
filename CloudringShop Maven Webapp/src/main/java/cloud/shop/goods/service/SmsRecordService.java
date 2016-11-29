package cloud.shop.goods.service;

import cloud.shop.goods.entity.SmsRecord;

public interface SmsRecordService {
	
	public void save(SmsRecord smsRecord)throws Exception;
	
	public void update(SmsRecord smsRecord)throws Exception;
	
	public void deleteById(String id)throws Exception;
	
	public int countSmsRecord(SmsRecord smsRecord)throws Exception;

}
