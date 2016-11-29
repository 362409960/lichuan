package cloud.shop.goods.dao;

import cloud.shop.goods.entity.SmsRecord;

public interface SmsRecordDAO {
	
	void save(SmsRecord smsRecord)throws Exception;
	
	void update(SmsRecord smsRecord)throws Exception;
	
	void deleteById(String id)throws Exception;
	
	int countSmsRecord(SmsRecord smsRecord)throws Exception;
	

}
