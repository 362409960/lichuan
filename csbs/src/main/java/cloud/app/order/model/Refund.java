package cloud.app.order.model;

import java.math.BigDecimal;
import java.util.Date;

public class Refund {
    private String id;

    private Date createdate;

    private Date modifydate;

    private String bankname;

    private String bankaccount;

    private String operator;

    private BigDecimal payer;

    private String paymentconfigname;

    private String refundsn;

    private Integer refundtype;

    private BigDecimal totalamount;

    private String paymentconfigId;

    private String orderId;

    private String memo;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id == null ? null : id.trim();
    }

    public Date getCreatedate() {
        return createdate;
    }

    public void setCreatedate(Date createdate) {
        this.createdate = createdate;
    }

    public Date getModifydate() {
        return modifydate;
    }

    public void setModifydate(Date modifydate) {
        this.modifydate = modifydate;
    }

    public String getBankname() {
        return bankname;
    }

    public void setBankname(String bankname) {
        this.bankname = bankname == null ? null : bankname.trim();
    }

    public String getBankaccount() {
        return bankaccount;
    }

    public void setBankaccount(String bankaccount) {
        this.bankaccount = bankaccount == null ? null : bankaccount.trim();
    }

    public String getOperator() {
        return operator;
    }

    public void setOperator(String operator) {
        this.operator = operator == null ? null : operator.trim();
    }

    public BigDecimal getPayer() {
        return payer;
    }

    public void setPayer(BigDecimal payer) {
        this.payer = payer;
    }

    public String getPaymentconfigname() {
        return paymentconfigname;
    }

    public void setPaymentconfigname(String paymentconfigname) {
        this.paymentconfigname = paymentconfigname == null ? null : paymentconfigname.trim();
    }

    public String getRefundsn() {
        return refundsn;
    }

    public void setRefundsn(String refundsn) {
        this.refundsn = refundsn == null ? null : refundsn.trim();
    }

    public Integer getRefundtype() {
        return refundtype;
    }

    public void setRefundtype(Integer refundtype) {
        this.refundtype = refundtype;
    }

    public BigDecimal getTotalamount() {
        return totalamount;
    }

    public void setTotalamount(BigDecimal totalamount) {
        this.totalamount = totalamount;
    }

    public String getPaymentconfigId() {
        return paymentconfigId;
    }

    public void setPaymentconfigId(String paymentconfigId) {
        this.paymentconfigId = paymentconfigId == null ? null : paymentconfigId.trim();
    }

    public String getOrderId() {
        return orderId;
    }

    public void setOrderId(String orderId) {
        this.orderId = orderId == null ? null : orderId.trim();
    }

    public String getMemo() {
        return memo;
    }

    public void setMemo(String memo) {
        this.memo = memo == null ? null : memo.trim();
    }
}