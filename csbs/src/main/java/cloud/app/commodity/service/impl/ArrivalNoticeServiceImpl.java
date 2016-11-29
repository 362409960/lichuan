package cloud.app.commodity.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cloud.app.commodity.dao.ArrivalNoticeDAO;
import cloud.app.commodity.model.ArrivalNotice;
import cloud.app.commodity.service.ArrivalNoticeService;
import cloud.app.common.SendMail;
import cloud.app.entity.Mail;

@Service
public class ArrivalNoticeServiceImpl implements ArrivalNoticeService {

	@Autowired
	private ArrivalNoticeDAO arrivalNoticeDAO;

	@Override
	public void save(ArrivalNotice obj) throws Exception {
		this.arrivalNoticeDAO.save(obj);
		
	}

	@Override
	public void update(ArrivalNotice obj) throws Exception {
		this.arrivalNoticeDAO.update(obj);
		
	}

	@Override
	public void deleteById(String id) throws Exception {
		this.deleteById(id);
		
	}

	@Override
	public List<ArrivalNotice> getList(ArrivalNotice obj) throws Exception {
		
		return this.arrivalNoticeDAO.getList(obj);
	}

	@Override
	public ArrivalNotice getObjById(String id) throws Exception {
		
		return this.arrivalNoticeDAO.getObjById(id);
	}

	@Override
	public Integer count(ArrivalNotice obj) throws Exception {		
		return this.arrivalNoticeDAO.count(obj);
	}

	@Override
	public void deleteByIdS(String[] ids) throws Exception {
		for(String id:ids){
			arrivalNoticeDAO.deleteById(id);
		}
		
	}

	@Override
	public boolean sendMailANdUpdate(String[] ids) throws Exception {
		boolean flag=false;
		for(String id:ids){
			ArrivalNotice arn=getObjById(id);
			Mail mail=new Mail();
			mail.setTo(arn.getEmail().split(","));
			mail.setBody("您收藏的商品"+arn.getProduct_name()+"已经有货了，可以购买了。网址：http://www.cloudring.net/");
			mail.setSuject("您收藏的商品"+arn.getProduct_name()+"已经有货了");
			SendMail send=SendMail.getInstance();
			send.send(mail);
			arn.setSend("1");
			update(arn);
			flag=true;
		}
		return flag;
	}



}
