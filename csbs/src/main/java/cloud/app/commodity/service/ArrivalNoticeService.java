package cloud.app.commodity.service;



import cloud.app.service.BaseService;
import cloud.app.commodity.model.ArrivalNotice;

public interface ArrivalNoticeService extends BaseService<ArrivalNotice> {
	
	
	public boolean sendMailANdUpdate(String ids[])throws Exception;

}
