package cloud.app.order.model;

import java.math.BigDecimal;
import java.util.Date;

public class DeliveryType {
	private String id;

	private Date createDate;

	private Date modifyDate;

	private String name;

	private Integer deliveryMethod;

	private Integer firstWeightUnit;

	private Integer continueWeightUnit;

	private BigDecimal firstWeightPrice;

	private BigDecimal continueWeightPrice;

	private Integer orderList;

	private String defaultDeliveryCorId;

	private Double firstWeight;

	private Double continueWeight;

	private String description;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id == null ? null : id.trim();
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name == null ? null : name.trim();
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

	public Integer getDeliveryMethod() {
		return deliveryMethod;
	}

	public void setDeliveryMethod(Integer deliveryMethod) {
		this.deliveryMethod = deliveryMethod;
	}

	public Integer getFirstWeightUnit() {
		return firstWeightUnit;
	}

	public void setFirstWeightUnit(Integer firstWeightUnit) {
		this.firstWeightUnit = firstWeightUnit;
	}

	public Integer getContinueWeightUnit() {
		return continueWeightUnit;
	}

	public void setContinueWeightUnit(Integer continueWeightUnit) {
		this.continueWeightUnit = continueWeightUnit;
	}

	public BigDecimal getFirstWeightPrice() {
		return firstWeightPrice;
	}

	public void setFirstWeightPrice(BigDecimal firstWeightPrice) {
		this.firstWeightPrice = firstWeightPrice;
	}

	public BigDecimal getContinueWeightPrice() {
		return continueWeightPrice;
	}

	public void setContinueWeightPrice(BigDecimal continueWeightPrice) {
		this.continueWeightPrice = continueWeightPrice;
	}

	public Integer getOrderList() {
		return orderList;
	}

	public void setOrderList(Integer orderList) {
		this.orderList = orderList;
	}

	public String getDefaultDeliveryCorId() {
		return defaultDeliveryCorId;
	}

	public void setDefaultDeliveryCorId(String defaultDeliveryCorId) {
		this.defaultDeliveryCorId = defaultDeliveryCorId;
	}

	public Double getFirstWeight() {
		return firstWeight;
	}

	public void setFirstWeight(Double firstWeight) {
		this.firstWeight = firstWeight;
	}

	public Double getContinueWeight() {
		return continueWeight;
	}

	public void setContinueWeight(Double continueWeight) {
		this.continueWeight = continueWeight;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description == null ? null : description.trim();
	}
}