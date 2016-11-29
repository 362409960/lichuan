package cloud.app.order.model;

import java.math.BigDecimal;
import java.util.Date;

public class Orders {
    private String id;

    private Date createdate;

    private Date modifydate;

    private BigDecimal deliveryfee;

    private String deliverytypename;

    private String ordersn;

    private Integer orderstatus;

    private String paymentconfigname;

    private BigDecimal paymentfee;

    private Integer paymentstatus;

    private BigDecimal producttotalprice;

    private BigDecimal totalamount;

    private Integer producttotalquantity;

    private String shipname;

    private String shiparea;

    private String shipareapath;

    private String shipaddress;

    private String shipzipcode;

    private String shipphone;

    private String shipmobile;

    private Integer shipstatus;

    private String userId;

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

    public BigDecimal getDeliveryfee() {
        return deliveryfee;
    }

    public void setDeliveryfee(BigDecimal deliveryfee) {
        this.deliveryfee = deliveryfee;
    }

    public String getDeliverytypename() {
        return deliverytypename;
    }

    public void setDeliverytypename(String deliverytypename) {
        this.deliverytypename = deliverytypename == null ? null : deliverytypename.trim();
    }

    public String getOrdersn() {
        return ordersn;
    }

    public void setOrdersn(String ordersn) {
        this.ordersn = ordersn == null ? null : ordersn.trim();
    }

    public Integer getOrderstatus() {
        return orderstatus;
    }

    public void setOrderstatus(Integer orderstatus) {
        this.orderstatus = orderstatus;
    }

    public String getPaymentconfigname() {
        return paymentconfigname;
    }

    public void setPaymentconfigname(String paymentconfigname) {
        this.paymentconfigname = paymentconfigname == null ? null : paymentconfigname.trim();
    }

    public BigDecimal getPaymentfee() {
        return paymentfee;
    }

    public void setPaymentfee(BigDecimal paymentfee) {
        this.paymentfee = paymentfee;
    }

    public Integer getPaymentstatus() {
        return paymentstatus;
    }

    public void setPaymentstatus(Integer paymentstatus) {
        this.paymentstatus = paymentstatus;
    }

    public BigDecimal getProducttotalprice() {
        return producttotalprice;
    }

    public void setProducttotalprice(BigDecimal producttotalprice) {
        this.producttotalprice = producttotalprice;
    }

    public BigDecimal getTotalamount() {
        return totalamount;
    }

    public void setTotalamount(BigDecimal totalamount) {
        this.totalamount = totalamount;
    }

    public Integer getProducttotalquantity() {
        return producttotalquantity;
    }

    public void setProducttotalquantity(Integer producttotalquantity) {
        this.producttotalquantity = producttotalquantity;
    }

    public String getShipname() {
        return shipname;
    }

    public void setShipname(String shipname) {
        this.shipname = shipname == null ? null : shipname.trim();
    }

    public String getShiparea() {
        return shiparea;
    }

    public void setShiparea(String shiparea) {
        this.shiparea = shiparea == null ? null : shiparea.trim();
    }

    public String getShipareapath() {
        return shipareapath;
    }

    public void setShipareapath(String shipareapath) {
        this.shipareapath = shipareapath == null ? null : shipareapath.trim();
    }

    public String getShipaddress() {
        return shipaddress;
    }

    public void setShipaddress(String shipaddress) {
        this.shipaddress = shipaddress == null ? null : shipaddress.trim();
    }

    public String getShipzipcode() {
        return shipzipcode;
    }

    public void setShipzipcode(String shipzipcode) {
        this.shipzipcode = shipzipcode == null ? null : shipzipcode.trim();
    }

    public String getShipphone() {
        return shipphone;
    }

    public void setShipphone(String shipphone) {
        this.shipphone = shipphone == null ? null : shipphone.trim();
    }

    public String getShipmobile() {
        return shipmobile;
    }

    public void setShipmobile(String shipmobile) {
        this.shipmobile = shipmobile == null ? null : shipmobile.trim();
    }

    public Integer getShipstatus() {
        return shipstatus;
    }

    public void setShipstatus(Integer shipstatus) {
        this.shipstatus = shipstatus;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId == null ? null : userId.trim();
    }

    public String getMemo() {
        return memo;
    }

    public void setMemo(String memo) {
        this.memo = memo == null ? null : memo.trim();
    }
}