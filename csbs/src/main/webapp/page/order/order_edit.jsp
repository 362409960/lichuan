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
<link rel="stylesheet" type="text/css" href="<%=path%>/css/common.css">
<script src="<%=path%>/js/jquery.min.js"></script>
<script src="<%=path%>/js/jquery-tab.js"></script>
</head>

<body>
<div class="breadcrumb"><a href="index.html">首页</a>&raquo;&nbsp;编辑订单</div>
<ul id="tab" class="tab">
    <li class="current"><input type="button" value="订单信息"></li>
    <li><input type="button" value="商品信息"></li>
</ul>
<form id="inputForm"  method="post" action="<%=path%>/admin/order/order_update.do">
	<input hidden="hidden" name="id" id="id" value="${ordersVO.id }">
    <table class="input tabContent" style="display:table;">
    	<colgroup>
        	<col width="*">
            <col width="360">
            <col width="*">
            <col width="*">
        </colgroup>
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
            <td><input type="text" id=deliveryFee name="deliveryFee" class="text" value="${ordersVO.deliveryFee }" maxlength="16"></td>
        </tr>
        <tr>
        	<th>调整金额:</th>
            <td><input type="text" id="offsetAmout" name="offsetAmout" class="text" value="0" maxlength="16"></td>
            <th>赠送积分:</th>
            <td><input type="text" name="rewardPoint" class="text" value="4688" maxlength="9"></td>
        </tr>
        <tr>
        	<th>支付方式:</th>
            <td>
            	<select name="paymentMethodId">
                	<option value="">请选择...</option>
                    <option value="1">网上支付</option>
                    <option value="2">银行汇款</option>
                    <option value="3" selected>货到付款</option>
                </select>
            </td>
            <th>配送方式:</th>
            <td>
            	<select name="shippingMethodId">
                	<option value="">请选择...</option>
                    <option value="1">普通快递</option>
                    <option value="2" selected>顺丰速运</option>
                </select>
            </td>
        </tr>
        <tr>
        	<th>抬头:</th>
            <td>
            	<span class="fieldSet">
                	<input type="text" id="invoiceTitle" name="invoiceTitle" class="text" value="" maxlength="200" disabled>
                    <label>
                    	<input type="checkbox" id="isInvoice" name="isInvoice" value="true">
                    </label>
                </span>
            </td>
            <th>税金:</th>
            <td><input type="text" id="tax" name="tax" class="text" value="0" maxlength="16" disabled></td>
        </tr>
        <tr>
        	<th>收货人:</th>
            <td>
            	<input type="text" name="shipName" class="text" value="${ordersVO.shipName }" maxlength="200">
            </td>
            <th>地区:</th>
            <td>
            	<span class="fieldSet">
                	<input type="hidden" id="areaId" name="areaId"  value="19">
                </span>
            </td>
        </tr>
        <tr>
        	<th>地址:</th>
            <td>
            	<input type="text" name="shipAddress" class="text" value="${ordersVO.shipAddress }" maxlength="200">
            </td>
            <th>邮编:</th>
            <td>
            	<input type="text" name="shipZipCode" class="text" value="${ordersVO.shipZipCode }" maxlength="200">
            </td>
        </tr>
        <tr>
        	<th>电话:</th>
            <td>
            	<input type="text" name="shipPhone" class="text" value="${ordersVO.shipPhone }" maxlength="200">
            </td>
            <th>附言:</th>
            <td>
            	<input type="text" name="memo" class="text" value="${ordersVO.memo }" maxlength="200">
            </td>
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
    <table class="input">
    	<tr>
        	<th>&nbsp;</th>
            <td>
            	<input type="submit" class="button" value="确 定">
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
