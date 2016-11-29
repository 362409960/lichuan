/**
 * 
 */
package cloud.app.order.vo;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import cloud.app.entity.BaseModel;
import cloud.app.order.model.OrderItem;
import cloud.app.order.model.OrderLog;
import cloud.app.order.model.Payment;
import cloud.app.order.model.Refund;
import cloud.app.order.model.Reship;
import cloud.app.order.model.Shipping;

/**
 * @author zhoushunfang
 *
 */
public class OrdersVO extends BaseModel{
	
	private List<OrderItem> orderItemList;//商品信息
	
	private List<Payment> payment;//付款信息
	
	private List<Refund> refund;//退款信息
	
	private List<Shipping> shipping;//发货信息
	
	private List<Reship> reship;//退货信息
	
	private List<OrderLog> orderLogList;//订单记录
	
	private String id;

    private Date createDate;

    private Date modifyDate;

    private BigDecimal deliveryFee;

    private String deliveryTypeName;

    private String orderSn;

    private Integer orderStatus;

    private String paymentConfigName;

    private BigDecimal paymentFee;

    private Integer paymentStatus;

    private BigDecimal productTotalPrice;

    private BigDecimal totalAmount;

    private Integer productTotalQuantity;

    private String shipName;

    private String shipArea;

    private String shipAreaPath;

    private String shipAddress;

    private String shipZipCode;

    private String shipPhone;

    private String shipMobile;

    private Integer shipStatus;

    private String userId;

    private String memo;

	public List<OrderItem> getOrderItemList() {
		return orderItemList;
	}

	public void setOrderItemList(List<OrderItem> orderItemList) {
		this.orderItemList = orderItemList;
	}

	public List<Payment> getPayment() {
		return payment;
	}

	public void setPayment(List<Payment> payment) {
		this.payment = payment;
	}

	public List<Refund> getRefund() {
		return refund;
	}

	public void setRefund(List<Refund> refund) {
		this.refund = refund;
	}

	public List<Shipping> getShipping() {
		return shipping;
	}

	public void setShipping(List<Shipping> shipping) {
		this.shipping = shipping;
	}

	public List<Reship> getReship() {
		return reship;
	}

	public void setReship(List<Reship> reship) {
		this.reship = reship;
	}

	public List<OrderLog> getOrderLogList() {
		return orderLogList;
	}

	public void setOrderLogList(List<OrderLog> orderLogList) {
		this.orderLogList = orderLogList;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
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

	public BigDecimal getDeliveryFee() {
		return deliveryFee;
	}

	public void setDeliveryFee(BigDecimal deliveryFee) {
		this.deliveryFee = deliveryFee;
	}

	public String getDeliveryTypeName() {
		return deliveryTypeName;
	}

	public void setDeliveryTypeName(String deliveryTypeName) {
		this.deliveryTypeName = deliveryTypeName;
	}

	public String getOrderSn() {
		return orderSn;
	}

	public void setOrderSn(String orderSn) {
		this.orderSn = orderSn;
	}

	public Integer getOrderStatus() {
		return orderStatus;
	}

	public void setOrderStatus(Integer orderStatus) {
		this.orderStatus = orderStatus;
	}

	public String getPaymentConfigName() {
		return paymentConfigName;
	}

	public void setPaymentConfigName(String paymentConfigName) {
		this.paymentConfigName = paymentConfigName;
	}

	public BigDecimal getPaymentFee() {
		return paymentFee;
	}

	public void setPaymentFee(BigDecimal paymentFee) {
		this.paymentFee = paymentFee;
	}

	public Integer getPaymentStatus() {
		return paymentStatus;
	}

	public void setPaymentStatus(Integer paymentStatus) {
		this.paymentStatus = paymentStatus;
	}

	public BigDecimal getProductTotalPrice() {
		return productTotalPrice;
	}

	public void setProductTotalPrice(BigDecimal productTotalPrice) {
		this.productTotalPrice = productTotalPrice;
	}

	public BigDecimal getTotalAmount() {
		return totalAmount;
	}

	public void setTotalAmount(BigDecimal totalAmount) {
		this.totalAmount = totalAmount;
	}

	public Integer getProductTotalQuantity() {
		return productTotalQuantity;
	}

	public void setProductTotalQuantity(Integer productTotalQuantity) {
		this.productTotalQuantity = productTotalQuantity;
	}

	public String getShipName() {
		return shipName;
	}

	public void setShipName(String shipName) {
		this.shipName = shipName;
	}

	public String getShipArea() {
		return shipArea;
	}

	public void setShipArea(String shipArea) {
		this.shipArea = shipArea;
	}

	public String getShipAreaPath() {
		return shipAreaPath;
	}

	public void setShipAreaPath(String shipAreaPath) {
		this.shipAreaPath = shipAreaPath;
	}

	public String getShipAddress() {
		return shipAddress;
	}

	public void setShipAddress(String shipAddress) {
		this.shipAddress = shipAddress;
	}

	public String getShipZipCode() {
		return shipZipCode;
	}

	public void setShipZipCode(String shipZipCode) {
		this.shipZipCode = shipZipCode;
	}

	public String getShipPhone() {
		return shipPhone;
	}

	public void setShipPhone(String shipPhone) {
		this.shipPhone = shipPhone;
	}

	public String getShipMobile() {
		return shipMobile;
	}

	public void setShipMobile(String shipMobile) {
		this.shipMobile = shipMobile;
	}

	public Integer getShipStatus() {
		return shipStatus;
	}

	public void setShipStatus(Integer shipStatus) {
		this.shipStatus = shipStatus;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getMemo() {
		return memo;
	}

	public void setMemo(String memo) {
		this.memo = memo;
	}

	
}
