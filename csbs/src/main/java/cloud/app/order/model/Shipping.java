package cloud.app.order.model;

import java.math.BigDecimal;
import java.util.Date;

public class Shipping {
    private String id;

    private Date createdate;

    private Date modifydate;

    private String shippingsn;

    private String deliverytypename;

    private String deliverycorpname;

    private String deliverysn;

    private BigDecimal deliveryfee;

    private String shipname;

    private String shiparea;

    private String shipareapath;

    private String shipaddress;

    private String shipzipcode;

    private String shipphone;

    private String shipmobile;

    private String oderId;

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

    public String getShippingsn() {
        return shippingsn;
    }

    public void setShippingsn(String shippingsn) {
        this.shippingsn = shippingsn == null ? null : shippingsn.trim();
    }

    public String getDeliverytypename() {
        return deliverytypename;
    }

    public void setDeliverytypename(String deliverytypename) {
        this.deliverytypename = deliverytypename == null ? null : deliverytypename.trim();
    }

    public String getDeliverycorpname() {
        return deliverycorpname;
    }

    public void setDeliverycorpname(String deliverycorpname) {
        this.deliverycorpname = deliverycorpname == null ? null : deliverycorpname.trim();
    }

    public String getDeliverysn() {
        return deliverysn;
    }

    public void setDeliverysn(String deliverysn) {
        this.deliverysn = deliverysn == null ? null : deliverysn.trim();
    }

    public BigDecimal getDeliveryfee() {
        return deliveryfee;
    }

    public void setDeliveryfee(BigDecimal deliveryfee) {
        this.deliveryfee = deliveryfee;
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

    public String getOderId() {
        return oderId;
    }

    public void setOderId(String oderId) {
        this.oderId = oderId == null ? null : oderId.trim();
    }

    public String getMemo() {
        return memo;
    }

    public void setMemo(String memo) {
        this.memo = memo == null ? null : memo.trim();
    }
}