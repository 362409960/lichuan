package cloud.app.order.model;

import java.math.BigDecimal;
import java.util.Date;

public class PaymentConfig {
    private String id;

    private Date createDate;

    private Date modifyDate;

    private String name;

    private Integer orderList;

    private BigDecimal paymentFee;

    private Integer paymentFeeType;

    private Integer paymentConfigType;

    private String description;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id == null ? null : id.trim();
    }

    public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public Date getModifyDate() {
		return modifyDate;
	}

	public void setModifyDate(Date modifyDate) {
		this.modifyDate = modifyDate;
	}

	public Integer getOrderList() {
		return orderList;
	}

	public void setOrderList(Integer orderList) {
		this.orderList = orderList;
	}

	public BigDecimal getPaymentFee() {
		return paymentFee;
	}

	public void setPaymentFee(BigDecimal paymentFee) {
		this.paymentFee = paymentFee;
	}

	public Integer getPaymentFeeType() {
		return paymentFeeType;
	}

	public void setPaymentFeeType(Integer paymentFeeType) {
		this.paymentFeeType = paymentFeeType;
	}

	public Integer getPaymentConfigType() {
		return paymentConfigType;
	}

	public void setPaymentConfigType(Integer paymentConfigType) {
		this.paymentConfigType = paymentConfigType;
	}

	public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description == null ? null : description.trim();
    }
}