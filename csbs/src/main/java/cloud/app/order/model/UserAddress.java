package cloud.app.order.model;

import java.util.Date;

public class UserAddress {
    private String id;

    private Date createdate;

    private Date modifydate;

    private String shipname;

    private String shiparea;

    private String shipareapath;

    private String shipzipcode;

    private String shipphone;

    private String shipmobile;

    private Integer defaultshiparea;

    private String userId;

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

    public Integer getDefaultshiparea() {
        return defaultshiparea;
    }

    public void setDefaultshiparea(Integer defaultshiparea) {
        this.defaultshiparea = defaultshiparea;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId == null ? null : userId.trim();
    }
}