package cloud.shop.goods.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cloud.shop.goods.dao.SmsRecordDAO;
import cloud.shop.goods.entity.SmsRecord;
import cloud.shop.goods.service.SmsRecordService;
@Service
public class SmsRecordServiceImpl implements SmsRecordService {

	@Autowired
	private SmsRecordDAO smsRecordDAO;
	@Override
	public void save(SmsRecord smsRecord) throws Exception {
		this.smsRecordDAO.save(smsRecord);

	}

	@Override
	public void update(SmsRecord smsRecord) throws Exception {
		this.smsRecordDAO.update(smsRecord);

	}

	@Override
	public void deleteById(String id) throws Exception {
		this.smsRecordDAO.deleteById(id);

	}

	@Override
	public int countSmsRecord(SmsRecord smsRecord) throws Exception {
		
		return this.smsRecordDAO.countSmsRecord(smsRecord);
	}

}
