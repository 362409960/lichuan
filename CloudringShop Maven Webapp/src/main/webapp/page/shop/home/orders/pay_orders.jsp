<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="/WEB-INF/tlds/c.tld" prefix="c"%>
<%@page import="cloud.shop.common.Constants" %>
<%@page import="cloud.shop.goods.entity.Customer" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>订单支付 </title>
<meta name="author" content="" />
<meta name="copyright" content="" />
<link href="../css/shop/common.css" rel="stylesheet" type="text/css" />
<link href="../css/shop/order.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="../js/jquery.min.js"></script>
<script type="text/javascript" src="../js/shop/common.js"></script>
<script type="text/javascript">
var contextPath = "${pageContext.request.contextPath}";
$().ready(function() {
	var $dialogOverlay = $("#dialogOverlay");
	var $dialog = $("#dialog");
	var $other = $("#other");
	var $amountPayable = $("#amountPayable");
	var $fee = $("#fee");
	var $paymentForm = $("#paymentForm");
	var $paymentPluginId = $("#paymentPlugin input:radio");
	var $paymentButton = $("#paymentButton");
	var oid="${orders.oid}";
		// 订单锁定
		/* setInterval(function() {
			$.ajax({
				url: contextPath+"/orders/lock.do",
				type: "POST",
				data: {sn: oid},
				dataType: "json",
				cache: false
			});
		}, 50000); */
		
		// 检查等待付款
		/* setInterval(function() {
			$.ajax({
				url: contextPath+"/orders/check_pending_payment.do",
				type: "GET",
				data: {sn: oid},
				dataType: "json",
				cache: false,
				success: function(data) {
					if (!data) {
						location.href = contextPath+"/orders/view.do?sn="+oid;
					}
				}
			});
		}, 10000); */
	
	// 选择其它支付方式
	$other.click(function() {
		$dialogOverlay.hide();
		$dialog.hide();
	});
	
	// 支付插件
	$paymentPluginId.click(function() {
		$.ajax({
			url: contextPath+"/orders/calculate_amount.do",
			type: "GET",
			data: {paymentPluginId: $(this).val(), sn: oid},
			dataType: "json",
			cache: false,
			success: function(data) {
				if (data.message.type == "success") {
					$amountPayable.text(currency(data.amount, true, true));
					if (data.fee > 0) {
						$fee.text(currency(data.fee, true)).parent().show();
					} else {
						$fee.parent().hide();
					}
				} else {
					$.message(data.message);
					setTimeout(function() {
						location.reload(true);
					}, 3000);
				}
			}
		});
	});
	
	// 支付
	$paymentForm.submit(function() {
		$dialogOverlay.show();
		$dialog.show();
	});

});

</script>
<script type="text/javascript">  
        if(top != self) {  
            if(top.location != self.location) {  
                top.location = self.location;  
            }  
        }  
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
	<div id="dialogOverlay" class="dialogOverlay"></div>
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
	<div class="container payment">
		<div class="row">
			<div class="span12">
				<div id="dialog" class="dialog">
						<dl><dt>请在新打开的页面中完成付款</dt><dd>付款完成前请不要关闭此窗口</dd><dd>完成付款后请点击下面按钮</dd></dl>
					<div>
						<a href="<%=path %>/orders/viewDetail.do?sn=${orders.oid}" onclick="view();">完成付款</a>
						<a href="<%=path %>/home/showShopIndex.do">遇到问题</a>
					</div>
					<a href="javascript:;" id="other">选择其它支付方式</a>
				</div>
				<div class="result">
						<div class="title">您的订单已提交成功，正在等待付款！</div>
					<table>
						<tr>
							<th colspan="4">订单信息:</th>
						</tr>
						<tr>
							<td width="100">编号:</td>
							<td width="340">
								<strong>${orders.oid}</strong>
								<a href="<%=path %>/orders/viewDetail.do?sn=${orders.oid}">[查看订单]</a>
							</td>
							<td width="100">应付金额:</td>
							<td>
									<strong id="amountPayable">￥${orders.amounts_payable}元</strong>
									<span class="hidden">(支付手续费: <span id="fee">￥0.00</span>)</span>
							</td>
						</tr>
						<tr>
							<td>配送方式:</td>
							<td>${orders.pay_by}</td>
							<td>支付方式:</td>
							<td>${orders.delivery_method}</td>
						</tr>
							<tr>
								<td colspan="4"><!-- 请您在2015-10-13 09:35之前支付订单款项，否则该订单将失效！ --></td>
							</tr>
					</table>
							<form id="paymentForm" action="<%=path %>/orders/plugin_submit.do" method="post" target="_blank">
								<input type="hidden" name="type" value="1" />
								<input type="hidden" name="oid" value="${orders.oid}" />
								<table id="paymentPlugin" class="paymentPlugin">
									<tr>
										<th colspan="4">支付方式:</th>
									</tr>
										<tr>
													<td>
														<input type="radio" id="alipayDirectPaymentPlugin" name="paymentPluginId" value="alipayDirectPaymentPlugin" checked="checked" />
														<label for="alipayDirectPaymentPlugin">
																<em title="支付宝" style="background-image: url(http://image.demo.shopxx.net/4.0/201501/ea830132-c208-427b-86ca-383f17f95eae.gif);">&nbsp;</em>
														</label>
													</td>
										</tr>
										
								</table>
								<input type="submit" id="paymentButton" class="paymentButton" value="立即支付" />
							</form>
				</div>
			</div>
		</div>
	</div>

	<jsp:include page="/page/shop/home/foot.jsp" />
</body>
</html>
