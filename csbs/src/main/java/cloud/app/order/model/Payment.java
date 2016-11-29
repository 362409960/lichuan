package cloud.app.order.model;

import java.math.BigDecimal;
import java.util.Date;

public class Payment {
    private String id;

    private Date createdate;

    private Date modifydate;

    private String paymentsn;

    private Integer paymenttype;

    private String paymentconfigId;

    private String paymentconfigname;

    private String bankname;

    private String bankaccount;

    private BigDecimal totalamount;

    private BigDecimal paymentfee;

    private String payer;

    private String operator;

    private Integer paymentstatus;

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

    public String getPaymentsn() {
        return paymentsn;
    }

    public void setPaymentsn(String paymentsn) {
        this.paymentsn = paymentsn == null ? null : paymentsn.trim();
    }

    public Integer getPaymenttype() {
        return paymenttype;
    }

    public void setPaymenttype(Integer paymenttype) {
        this.paymenttype = paymenttype;
    }

    public String getPaymentconfigId() {
        return paymentconfigId;
    }

    public void setPaymentconfigId(String paymentconfigId) {
        this.paymentconfigId = paymentconfigId == null ? null : paymentconfigId.trim();
    }

    public String getPaymentconfigname() {
        return paymentconfigname;
    }

    public void setPaymentconfigname(String paymentconfigname) {
        this.paymentconfigname = paymentconfigname == null ? null : paymentconfigname.trim();
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

    public BigDecimal getTotalamount() {
        return totalamount;
    }

    public void setTotalamount(BigDecimal totalamount) {
        this.totalamount = totalamount;
    }

    public BigDecimal getPaymentfee() {
        return paymentfee;
    }

    public void setPaymentfee(BigDecimal paymentfee) {
        this.paymentfee = paymentfee;
    }

    public String getPayer() {
        return payer;
    }

    public void setPayer(String payer) {
        this.payer = payer == null ? null : payer.trim();
    }

    public String getOperator() {
        return operator;
    }

    public void setOperator(String operator) {
        this.operator = operator == null ? null : operator.trim();
    }

    public Integer getPaymentstatus() {
        return paymentstatus;
    }

    public void setPaymentstatus(Integer paymentstatus) {
        this.paymentstatus = paymentstatus;
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