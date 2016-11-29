package cloud.app.order.model;

import java.util.Date;

public class DeliveryCorp {
    private String id;

    private Date createdate;

    private Date modifydate;

    private String name;

    private String url;

    private Integer orderlist;

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

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url == null ? null : url.trim();
    }

    public Integer getOrderlist() {
        return orderlist;
    }

    public void setOrderlist(Integer orderlist) {
        this.orderlist = orderlist;
    }
}