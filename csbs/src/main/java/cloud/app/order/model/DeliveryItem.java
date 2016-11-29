package cloud.app.order.model;

import java.util.Date;

public class DeliveryItem {
    private String id;

    private Date createdate;

    private Date modifydate;

    private String productsn;

    private String productname;

    private String productId;

    private String shippingId;

    private String reshipId;

    private Integer deliveryquantity;

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

    public String getProductsn() {
        return productsn;
    }

    public void setProductsn(String productsn) {
        this.productsn = productsn == null ? null : productsn.trim();
    }

    public String getProductname() {
        return productname;
    }

    public void setProductname(String productname) {
        this.productname = productname == null ? null : productname.trim();
    }

    public String getProductId() {
        return productId;
    }

    public void setProductId(String productId) {
        this.productId = productId == null ? null : productId.trim();
    }

    public String getShippingId() {
        return shippingId;
    }

    public void setShippingId(String shippingId) {
        this.shippingId = shippingId == null ? null : shippingId.trim();
    }

    public String getReshipId() {
        return reshipId;
    }

    public void setReshipId(String reshipId) {
        this.reshipId = reshipId == null ? null : reshipId.trim();
    }

    public Integer getDeliveryquantity() {
        return deliveryquantity;
    }

    public void setDeliveryquantity(Integer deliveryquantity) {
        this.deliveryquantity = deliveryquantity;
    }
}