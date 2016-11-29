package cloud.shop.goods.vo;

import java.math.BigDecimal;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;

import cloud.shop.goods.entity.OrdersDetail;

public class OrdersVO {
	
	private String oid;
	public List<OrdersDetail> getOrdlist() {
		return ordlist;
	}
	public void setOrdlist(List<OrdersDetail> ordlist) {
		this.ordlist = ordlist;
	}
	private List<OrdersDetail> ordlist=new LinkedList<OrdersDetail>();
	private Date creatDate;
	public String getOid() {
		return oid;
	}
	public void setOid(String oid) {
		this.oid = oid;
	}
	
	
	public Date getCreatDate() {
		return creatDate;
	}
	public void setCreatDate(Date creatDate) {
		this.creatDate = creatDate;
	}
	public String getReceiver() {
		return receiver;
	}
	public void setReceiver(String receiver) {
		this.receiver = receiver;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public BigDecimal getAmount() {
		return amount;
	}
	public void setAmount(BigDecimal amount) {
		this.amount = amount;
	}
	private String receiver;
	private String status;
	private BigDecimal amount;

}
