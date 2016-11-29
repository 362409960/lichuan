<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="/WEB-INF/tlds/c.tld" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<% 
    String path = request.getContextPath();
%>
<html>
<head>
<meta charset="utf-8">
<title>管理中心——Cloudring Shop</title>
<meta content="Cloudring" name="author">
<meta content="Cloudring" name="copyright">
<link rel="stylesheet" type="text/css" href="<%=path %>/css/common.css">
<script src="<%=path%>/js/jquery.min.js"></script>
<script src="<%=path %>/js/jquery-tab.js"></script>
</head>

<body>
<div class="breadcrumb"><a href="index.html">首页</a>&raquo;&nbsp;查看订单</div>
<ul id="tab" class="tab">
    <li class="current"><input type="button" value="订单信息"></li>
    <li><input type="button" value="商品信息"></li>
    <li><input type="button" value="收款信息"></li>
    <li><input type="button" value="退款信息"></li>
    <li><input type="button" value="发货信息"></li>
    <li><input type="button" value="退货信息"></li>
    <li><input type="button" value="订单记录"></li>
</ul>
<form id="inputForm"  method="post" action="##">
    <table class="input tabContent" style="display:table;">
    	<colgroup>
        	<col width="*">
            <col width="360">
            <col width="*">
            <col width="*">
        </colgroup>
        <tr>
        	<td>&nbsp;</td>
            <td colspan="3">
            	<input type="button" id="reviewButton" class="button" value="审 核">
                <input type="button" id="paymentButton" class="button" value="收 款">
                <input type="button" id="refundsButton" class="button" value="退 款" disabled>
                <input type="button" id="shippingButton" class="button" value="发 货" disabled>
                <input type="button" id="returnsButton" class="button" value="退 货" disabled>
                <input type="button" id="receiveButton" class="button" value="收 货" disabled>
                <input type="button" id="completeButton" class="button" value="完 成" disabled>
                <input type="button" id="failButton" class="button" value="失败" disabled>
            </td>
        </tr>
    	<tr>
        	<th>编号:</th>
            <td>${ordersVO.orderSn }</td>
            <th>创建日期:</th>
            <td><fmt:formatDate value="${ordersVO.createDate}" pattern="yyyy-MM-DD HH:MM:dd"/></td>
        </tr>
        <tr>
        	<th>类型:</th>
            <td>普通订单</td>
            <th>状态:</th>
            <c:if test="${ordersVO.orderStatus ==0}">
            	<td>未处理<span class="silver"></span></td>
            </c:if>
            <c:if test="${ordersVO.orderStatus ==1}">
            	<td>已处理<span class="silver"></span></td>
            </c:if>
            <c:if test="${ordersVO.orderStatus ==2}">
            	<td>已完成<span class="silver"></span></td>
            </c:if>
            <c:if test="${ordersVO.orderStatus ==3}">
            	<td>已作废<span class="silver"></span></td>
            </c:if>
        </tr>
        <tr>
        	<th>会员:</th>
            <td><a href="member.html">${ordersVO.userId }</a></td>
            <th>会员等级:</th>
            <td>普通会员</td>
        </tr>
        <tr>
        	<th>商品价格:</th>
            <td>￥${ordersVO.productTotalPrice }</td>
            <th>兑换积分:</th>
            <td>0</td>
        </tr>
        <tr>
        	<th>订单金额:</th>
            <td><span id="amout" class="red">￥${ordersVO.totalAmount }</span></td>
            <th>已付金额:</th>
            <td>￥0.00<span class="silver">(应付金额: ￥${ordersVO.paymentFee })</span></td>
        </tr>
        <tr>
        	<th>商品重量:</th>
            <td>19000</td>
            <th>商品数量:</th>
            <td>${ordersVO.productTotalQuantity }</td>
        </tr>
        <tr>
        	<th>参与促销:</th>
            <td>-</td>
            <th>促销折扣:</th>
            <td>￥0.00</td>
        </tr>
        <tr>
        	<th>使用优惠券:</th>
            <td>-</td>
            <th>优惠券折扣:</th>
            <td>￥0.00</td>
        </tr>
        <tr>
        	<th>支付手续费:</th>
            <td>￥0.00</td>
            <th>运费:</th>
            <td>￥${ordersVO.deliveryFee }</td>
        </tr>
        <tr>
        	<th>调整金额:</th>
            <td>￥0.00</td>
            <th>赠送积分:</th>
            <td>5600</td>
        </tr>
        <tr>
        	<th>支付方式:</th>
            <td>${ordersVO.paymentConfigName }</td>
            <th>配送方式:</th>
            <td>${ordersVO.deliveryTypeName }</td>
        </tr>
        <tr>
        	<th>收货人:</th>
            <td>${ordersVO.shipName }</td>
            <th>地区:</th>
            <td>${ordersVO.shipArea }</td>
        </tr>
        <tr>
        	<th>地址:</th>
            <td>${ordersVO.shipAddress }</td>
            <th>邮编:</th>
            <td>${ordersVO.shipZipCode }</td>
        </tr>
        <tr>
        	<th>电话:</th>
            <td>${ordersVO.shipPhone }</td>
            <th>附言:</th>
            <td>${ordersVO.memo }</td>
        </tr>
    </table>
    <table class="item tabContent">
        <colgroup>
        	<col width="*">
            <col width="400">
            <col width="*">
            <col width="*">
            <col width="*">
        </colgroup>
    	<tr>
        	<th>商品编号</th>
            <th>商品名称</th>
            <th>商品价格</th>
            <th>商品数量</th>
            <th>小计</th>
        </tr>
        <tr>
        	<td>20150101140</td>
            <td><a href="##" target="_blank">索尼 KDL-50W700B</a></td>
            <td>￥4688.00</td>
            <td>1</td>
            <td>￥4688.00</td>
        </tr>
    </table>
    <table class="item tabContent">
		<tr>
			<th>编号</th>
			<th>方式</th>
			<th>支付方式</th>
			<th>支付手续费</th>
			<th>付款金额</th>
			<th>创建日期</th>
		</tr>
	</table>
    <table class="item tabContent">
		<tr>
			<th>编号</th>
			<th>方式</th>
			<th>支付方式</th>
			<th>退款金额</th>
			<th>创建日期</th>
		</tr>
	</table>
    <table class="item tabContent">
		<tr>
			<th>编号</th>
			<th>配送方式</th>
			<th>物流公司</th>
			<th>运单号</th>
			<th>收货人</th>
			<th>是否需要物流</th>
			<th>创建日期</th>
		</tr>
	</table>
    <table class="item tabContent">
		<tr>
			<th>编号</th>
			<th>配送方式</th>
			<th>物流公司</th>
			<th>运单号</th>
			<th>发货人</th>
			<th>创建日期</th>
		</tr>
	</table>
    <table class="item tabContent">
		<tr>
			<th>类型</th>
			<th>操作员</th>
			<th>内容</th>
			<th>创建日期</th>
		</tr>
        <tr>
            <td>订单创建</td>
            <td> -</td>
            <td> -</td>
            <td><span title="2015-12-30 11:40:52">2015-12-30</span></td>
        </tr>
	</table>
    <table class="input">
    	<tr>
        	<th>&nbsp;</th>
            <td>
                <input type="button" class="button" value="返 回" onClick="history.back(); return false;">
            </td>
        </tr>
    </table>
</form>
<script>
$(function(){
	$('.tab').tab();
});
</script>
</body>
</html>
