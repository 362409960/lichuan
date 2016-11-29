<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="/WEB-INF/tlds/c.tld" prefix="c"%>
<%@ taglib uri="/WEB-INF/tlds/fmt.tld" prefix="fmt"%>
<%@page import="cloud.shop.common.Constants" %>
<%@page import="cloud.shop.goods.entity.Customer" %>
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
<%
    Customer sysUserVO = null;
	String userName = "";
    Object obj = session.getAttribute(Constants.SESSION_LOGIN_USER_GOODS);
    if(obj != null){
    	sysUserVO = (Customer)obj;
    	userName = sysUserVO.getName();    	
    }
%>
<body>
<script type="text/javascript">
$().ready(function() {

	var $headerName = $("#headerName");
	var $headerLogin = $("#headerLogin");
	var $headerRegister = $("#headerRegister");
	var $headerLogout = $("#headerLogout");
	var $goodsSearchForm = $("#goodsSearchForm");
	var $keyword = $("#goodsSearchForm input");
	var defaultKeyword = "商品搜索";
	
	var username = '<%=userName%>';	
	var nickname = getCookie("nickname");
	if ($.trim(nickname) != "") {
		$headerName.text(nickname).show();
		$headerLogout.show();
	} else if ($.trim(username) != "") {
		$headerName.text(username).show();
		$headerLogout.show();
	} else {
		$headerLogin.show();
		$headerRegister.show();
	}
	
	$keyword.focus(function() {
		if ($.trim($keyword.val()) == defaultKeyword) {
			$keyword.val("");
		}
	});
	
	$keyword.blur(function() {
		if ($.trim($keyword.val()) == "") {
			$keyword.val(defaultKeyword);
		}
	});
	
	$goodsSearchForm.submit(function() {
		if ($.trim($keyword.val()) == "" || $keyword.val() == defaultKeyword) {
			return false;
		}
	});

});
</script>
<div class="header">
	<div class="top">
		<div class="topNav">
			<ul class="left">
				<li>
					<span>您好，欢迎来到Cloudring商城</span>
					<span id="headerName" class="headerName">&nbsp;</span>
				</li>
				<li id="headerLogin" class="headerLogin">
					<a href="<%=path %>/home/tologin.do">登录</a>|
				</li>
				<li id="headerRegister" class="headerRegister">
					<a href="<%=path %>/register/showShopRegister.do">注册</a>
				</li>
				<li id="headerLogout" class="headerLogout">
					<a href="<%=path %>/login/loginout.do">[退出]</a>
				</li>
			</ul>
			<ul class="right">
						<li>
						    <% if("".equals(userName))
						    {%>
						    <a href="<%=path %>/home/tologin.do">会员中心</a>|
						   <% }else{%>
						     <a href="<%=path %>/member/showCentre.do">会员中心</a>|
						  <% }%>
						</li>
						<li>
							<a href="">帮助中心</a>|
						</li>
				<li id="headerCart" class="headerCart">
					<a href="<%=path %>/cart/showShopCart.do">购物车</a>
					(<em></em>)
				</li>
			</ul>
		</div>
	</div>
	<div class="container">
		<div class="row">
			<div class="span3">
				<a href="http://www.cloudring.net">
					<img src="<%=path %>/images/logo_shop.png" alt="Cloudring" />
				</a>
			</div>
			<div class="span6">
				<div class="search" >
					<form id="goodsSearchForm" action="<%=path %>/home/showShopInquiry.do" method="get">
						<input name="keyword" class="keyword" value="商品搜索" autocomplete="off" x-webkit-speech="x-webkit-speech" x-webkit-grammar="builtin:search" maxlength="30" />
						<button type="submit">&nbsp;</button>
					</form>
				</div>
				<div class="hotSearch">
						<!-- 热门搜索:
							<a href="#">苹果</a>
							<a href="#">三星</a>	 -->						
				</div>
			</div>
			<div class="span3">
				<div class="phone">
					<em>服务电话</em>
					800-8888888
				</div>
			</div>
		</div>
		<div class="row">
			<div class="span12">
				<dl class="mainNav">
					<dt>
						<a href="<%=path%>/home/showShopProductcategory.do">所有商品分类</a>
					</dt>
							<dd>
								<a href="<%=path %>/home/showShopIndex.do">首页</a>
							</dd>
							<c:forEach items="${menu}" var="menu">
							<dd>
								<a href="<%=path %>/home/showShopHomeSecurity.do?type=1&skipName=${menu.key}">${menu.value}</a>
							</dd>
							</c:forEach>
				</dl>
			</div>
		</div>
	</div>
</div>
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
<jsp:include page="/page/shop/home/foot.jsp" />
</body>
</html>
