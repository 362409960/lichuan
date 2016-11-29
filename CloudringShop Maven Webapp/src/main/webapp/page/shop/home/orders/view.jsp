<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="/WEB-INF/tlds/c.tld" prefix="c"%>
<%@ taglib uri="/WEB-INF/tlds/fmt.tld" prefix="fmt"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>订单查看 </title>
<link href="<%=path%>/css/shop/common.css" rel="stylesheet" type="text/css" />
	<link href="<%=path%>/css/shop/member.css" rel="stylesheet" type="text/css" /> 
	<script type="text/javascript" src="<%=path%>/js/jquery.min.js"></script>
	<script type="text/javascript" src="<%=path%>/js/shop/common.js"></script>
	<script type="text/javascript" src="<%=path%>/js/shop/jquery.lSelect.js"></script>
	<script type="text/javascript" src="<%=path%>/js/shop/jquery.validate.js"></script> 
<script type="text/javascript">
var contextPath = "${pageContext.request.contextPath}";
$().ready(function() {

	var $payment = $("#payment");
	var $cancel = $("#cancel");
	var oid="${orders.oid}";
	// 订单支付
	$payment.click(function() {
	location.href = contextPath+"/orders/payment.do?sn="+oid;
		/* $.ajax({
			url: "check_lock.jhtml",
			type: "POST",
			data: {id: 565},
			dataType: "json",
			cache: false,
			success: function(message) {
				if (message.type == "success") {
					location.href = contextPath+"/orders/payment.do?sn=2015101421092";
				} else {
					$.message(message);
				}
			}
		}); */
		return false;
	});
	
	// 订单取消
	$cancel.click(function() {
		if (confirm("您确定要取消该订单吗？")) {
			$.ajax({
				url: contextPath+"/orders/cancel.do?sn="+oid,
				type: "POST",
				dataType: "json",
				cache: false,
				success: function(message) {
					if (message == true) {
						location.reload(true);
					} else {
						$.message(message);
					}
				}
			});
		}
		return false;
	});
	

});
</script>

</head>
<body>
	<div class="container member">
		<div class="row">
			<div class="span10">
				<div class="input order">
					<div id="dialog" class="dialog">
						<div id="close" class="close"></div>
						<ul>
							<li>时间</li>
							<li>内容</li>
						</ul>
						<div id="transitSteps" class="transitSteps">
							<table></table>
						</div>
					</div>
					<div class="title">订单查看</div>
					<div class="top">
						<span>编号: ${orders.oid}</span>
						<span>
								状态: <strong>${orders.status}</strong>
						</span>
						<c:choose>
						<c:when test="${isTrue=='true'}">
						<div class="action">
								<a href="javascript:;" id="payment" class="button">订单支付</a>
								<a href="javascript:;" id="cancel" class="button">订单取消</a>
						</div>
						</c:when>
						<c:otherwise></c:otherwise>
						</c:choose>
						<div class="tips">
						        <c:choose>
						           <c:when test="${orders.status=='等待付款'}">尊敬的客户，您的订单正在等待付款，请您及时支付订单款项！<em><!-- (过期时间: 2015-10-15 09:28:22) --></em></c:when>
						           <c:otherwise>尊敬的客户，您的订单${orders.status}，祝您购物愉快！</c:otherwise>
						        </c:choose>
						</div> 
					</div>
					<table class="info">
						<tr>
							<th>
								创建日期:
							</th>
							<td>
								<fmt:formatDate value="${orders.create_time}" pattern="yyyy-MM-dd"/>
							</td>
						</tr>
							<tr>
								<th>
									支付方式:
								</th>
								<td>
									${orders.pay_by}
								</td>
							</tr>
							<tr>
								<th>
									配送方式:
								</th>
								<td>
									${orders.delivery_method}
								</td>
							</tr>
						<tr>
							<th>
								商品价格:
							</th>
							<td>
								￥${orders.price}
							</td>
						</tr>
						<tr>
							<th>
								订单金额:
							</th>
							<td>
								￥${orders.order_amount}
							</td>
						</tr>
							<tr>
								<th>
									应付金额:
								</th>
								<td>
									￥${orders.amounts_payable}
								</td>
							</tr>
							<tr>
								<th>
									赠送积分:
								</th>
								<td>
									
								</td>
							</tr>
						<tr>
							<th>
								附言:
							</th>
							<td>
								
							</td>
						</tr>
					</table>
						<table class="info">
							<tr>
								<th>
									收货人:
								</th>
								<td>
									${orders.receiver}
								</td>
							</tr>
							<tr>
								<th>
									邮编:
								</th>
								<td>
									${orders.zip_code}
								</td>
							</tr>
							<tr>
								<th>
									地址:
								</th>
								<td>
									${orders.address}
								</td>
							</tr>
							<tr>
								<th>
									电话:
								</th>
								<td>
									${orders.tel}
								</td>
							</tr>
						</table>
					<table class="orderItem">
						<tr>
							<th>
								商品编号
							</th>
							<th>
								商品名称
							</th>
							<th>
								商品价格
							</th>
							<th>
								商品数量
							</th>
							<th>
								小计
							</th>
						</tr>
						<c:forEach items="${detialList}" var="list">
							<tr>
								<td>
									${list.id}
								</td>
								<td>
										${list.name}
								</td>
								<td>
										￥${list.price}
								</td>
								<td>
									${list.quantity}
								</td>
								<td>
										￥${list.subtotal}
								</td>
							</tr>
						</c:forEach>
					</table>
				</div>
			</div>
		</div>
	</div>

</body>
</html>
