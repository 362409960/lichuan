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
</head>

<body>
<div class="breadcrumb"><a href="index.html">首页</a>&raquo;&nbsp;订单列表<span>(共${ordersVO.total }条记录)</span></div>
<form id="listForm" method="get" action="<%=path%>/admin/order/order_search.do">
	<div class="bar">
        <div class="buttonGroup">
        	<a id="deleteButton" class="iconButton disabled" href="javascript:;" onclick="deleteOrder()">
            	<span class="deleteIcon icon"></span>&nbsp;删除
            </a>
            <a id="refreshButton" class="iconButton" href="javascript:;" onclick="refreshOrder()">
            	<span class="refreshIcon icon"></span>&nbsp;刷新
            </a>
            <div id="filterMenu" class="dropdownMenu">
            	<a class="button" href="javascript:;">
                	订单筛选&nbsp;<span class="arrow"></span>
                </a>
                <ul class="check">
                	<c:choose>
	                	<c:when test="${ordersVO.orderStatus == 0 }">
	                		<li val="0" class="checked">未处理</li>
	                		<li val="1">已处理</li>
		                    <li val="2">已完成</li>
		                    <li val="3">已作废</li>
	                	</c:when>
	                	<c:when test="${ordersVO.orderStatus == 1 }">
	                		<li val="0">未处理</li>
	                		<li val="1" class="checked">已处理</li>
		                    <li val="2">已完成</li>
		                    <li val="3">已作废</li>
	                	</c:when>
	                	<c:when test="${ordersVO.orderStatus == 2 }">
	                		<li val="0">未处理</li>
	                		<li val="1">已处理</li>
		                    <li val="2" class="checked">已完成</li>
		                    <li val="3">已作废</li>
	                	</c:when>
	                	<c:when test="${ordersVO.orderStatus == 3 }">
	                		<li val="0">未处理</li>
	                		<li val="1">已处理</li>
		                    <li val="2">已完成</li>
		                    <li val="3" class="checked">已作废</li>
	                	</c:when>
	                	<c:otherwise>
	                		<li val="0">未处理</li>
	                		<li val="1">已处理</li>
		                    <li val="2">已完成</li>
		                    <li val="3">已作废</li>
	                	</c:otherwise>
                	</c:choose>
                </ul>
                <input hidden="hidden" id="orderStatus" name="orderStatus">
            </div>
            <a id="moreButton" class="button" href="javascript:;">更多选项</a>
            <div id="pageSizeMenu" class="dropdownMenu">
            	<input hidden="hidden" id="pageSize" name="pageSize" value="${ordersVO.pageSize }">
            	<input hidden="hidden" id="pageIndex" name="pageIndex" value="${ordersVO.pageIndex }">
            	<input hidden="hidden" id="pageMax" name="pageMax" value="${ordersVO.pageMax }">
            	<a class="button" href="javascript:;">每页显示&nbsp;<span class="arrow"></span></a>
                <ul>
                	<c:if test="${ordersVO.pageSize == 10}">
                		<li val="10" class="current">10</li>
                		<li val="20" onclick="pageSizeSkip(20)">20</li>
	                    <li val="50" onclick="pageSizeSkip(50)">50</li>
	                    <li val="100" onclick="pageSizeSkip(100)">100</li>
                	</c:if>
                	<c:if test="${ordersVO.pageSize == 20}">
                		<li val="10" onclick="pageSizeSkip(10)">10</li>
                		<li val="20" class="current">20</li>
	                    <li val="50" onclick="pageSizeSkip(50)">50</li>
	                    <li val="100" onclick="pageSizeSkip(100)">100</li>
                	</c:if>
                	<c:if test="${ordersVO.pageSize == 50}">
                		<li val="10" onclick="pageSizeSkip(10)">10</li>
                		<li val="20" onclick="pageSizeSkip(20)">20</li>
	                    <li val="50" class="current">50</li>
	                    <li val="100" onclick="pageSizeSkip(100)">100</li>
                	</c:if>
                	<c:if test="${ordersVO.pageSize == 100}">
                		<li val="10" onclick="pageSizeSkip(10)">10</li>
                		<li val="20" onclick="pageSizeSkip(20)">20</li>
	                    <li val="50" onclick="pageSizeSkip(50)">50</li>
	                    <li val="100" class="current">100</li>
                	</c:if>
                </ul>
            </div>
        </div>
        <div id="searchMenu" class="dropdownMenu">
        	<div class="search">
            	<span class="arrow">&nbsp;</span>
                <input id="searchValue" type="text" maxlength="200" value="${searchValue }" name="searchValue">
                <input id="searchPram" hidden="hidden" value="" name="searchPram">
                <button type="submit">&nbsp;</button>
            </div>
            <ul>
            <c:choose>
            <c:when test="${searchPram ==  'orderSn'}">
            	<li val="orderSn" class="current">编号</li>
                <li val="shipName">收货人</li>
                <li val="shipArea">地区</li>
                <li val="shipAddress">地址</li>
                <li val="shipZipCode">邮编</li>
                <li val="shipPhone">电话</li>
            </c:when>
            <c:when test="${searchPram ==  'shipName'}">
            	<li val="orderSn">编号</li>
                <li val="shipName" class="current">收货人</li>
                <li val="shipArea">地区</li>
                <li val="shipAddress">地址</li>
                <li val="shipZipCode">邮编</li>
                <li val="shipPhone">电话</li>
            </c:when>
            <c:when test="${searchPram ==  'shipArea'}">
            	<li val="orderSn">编号</li>
                <li val="shipName">收货人</li>
                <li val="shipArea" class="current">地区</li>
                <li val="shipAddress">地址</li>
                <li val="shipZipCode">邮编</li>
                <li val="shipPhone">电话</li>
            </c:when>
            <c:when test="${searchPram ==  'shipAddress'}">
            	<li val="orderSn">编号</li>
                <li val="shipName">收货人</li>
                <li val="shipArea">地区</li>
                <li val="shipAddress" class="current">地址</li>
                <li val="shipZipCode">邮编</li>
                <li val="shipPhone">电话</li>
            </c:when>
            <c:when test="${searchPram ==  'shipZipCode'}">
            	<li val="orderSn">编号</li>
                <li val="shipName">收货人</li>
                <li val="shipArea">地区</li>
                <li val="shipAddress">地址</li>
                <li val="shipZipCode" class="current">邮编</li>
                <li val="shipPhone">电话</li>
            </c:when>
            <c:when test="${searchPram ==  'shipPhone'}">
            	<li val="orderSn">编号</li>
                <li val="shipName">收货人</li>
                <li val="shipArea">地区</li>
                <li val="shipAddress">地址</li>
                <li val="shipZipCode">邮编</li>
                <li val="shipPhone" class="current">电话</li>
            </c:when>
            <c:otherwise>
            	<li val="orderSn">编号</li>
                <li val="shipName">收货人</li>
                <li val="shipArea">地区</li>
                <li val="shipAddress">地址</li>
                <li val="shipZipCode">邮编</li>
                <li val="shipPhone">电话</li>
            </c:otherwise>
            </c:choose>
            </ul>
            <input hidden="hidden" id="orderSn" name="orderSn">
            <input hidden="hidden" id="shipName" name="shipName">
            <input hidden="hidden" id="shipArea" name="shipArea">
            <input hidden="hidden" id="shipAddress" name="shipAddress">
            <input hidden="hidden" id="shipZipCode" name="shipZipCode">
            <input hidden="hidden" id="shipPhone" name="shipPhone">
        </div>
    </div>
    <table id="listTable" class="list">
    	<tr>
        	<th class="check"><input type="checkbox" id="selectAll"></th>
            <th><a href="javascript:;" class="sort" name="sn">编号</a></th>
            <th><a href="javascript:;" class="sort" name="amount">订单金额</a></th>
            <th><a href="javascript:;" class="sort" name="member">会员</a></th>
            <th><a href="javascript:;" class="sort" name="consignee">收货人</a></th>
            <th><a href="javascript:;" class="sort" name="paymentMethodName">支付方式</a></th>
            <th><a href="javascript:;" class="sort" name="shippingMethodName">配送方式</a></th>
            <th><a href="javascript:;" class="sort" name="status">状态</a></th>
            <th><a href="javascript:;" class="sort" name="createDate">创建日期</a></th>
            <th><span>打印</span></th>
            <th><span>操作</span></th>
        </tr>
        <c:forEach items="${ordersVO.rows }" var="order">
        	<tr>
	        	<td><input type="checkbox" name="ids" value="${order.id }"></td>
	            <td>${order.orderSn }</td>
	            <td>￥${order.totalAmount }</td>
	            <td>${order.userId }</td>
	            <td>${order.shipName }</td>
	            <td>${order.paymentConfigName }</td>
	            <td>${order.deliveryTypeName }</td>
	            <c:if test="${order.orderStatus ==0}">
	            	<td>未处理<span class="silver"></span></td>
	            </c:if>
	            <c:if test="${order.orderStatus ==1}">
	            	<td>已处理<span class="silver"></span></td>
	            </c:if>
	            <c:if test="${order.orderStatus ==2}">
	            	<td>已完成<span class="silver"></span></td>
	            </c:if>
	            <c:if test="${order.orderStatus ==3}">
	            	<td>已作废<span class="silver"></span></td>
	            </c:if>
	            <td><span><fmt:formatDate value="${order.createDate}" pattern="yyyy-MM-DD"/></span></td>
	                
	            <td>
	            	<select name="print">
	                	<option value="">请选择...</option>
	                    <option value="order">订单</option>
	                    <option value="product">购物单</option>
	                    <option value="shipping">发货单</option>
	                    <option value="print">快递单</option>
	                </select>
	            </td>
	            <td>
	            	<a href="<%=path%>/admin/order/order_view.do?orderId=${order.id}">[查看]</a>
	                <a href="<%=path%>/admin/order/order_edit.do?orderId=${order.id}">[编辑]</a>
	            </td>
	        </tr>
        </c:forEach>
    </table>
    <div class="pagination" id="pageTotal">
    	<span class="firstPage">&nbsp;</span>
        <span class="previousPage">&nbsp;</span>
        <span class="currentPage">1</span>
        <a href="javascript:;">2</a>
        <a href="javascript:;">3</a>
        <a href="javascript:;" class="nextPage" onclick="pageIndexSkip('${ordersVO.pageIndex+1 }')">&nbsp;</a>
        <a href="javascript:;" class="lastPage" onclick="pageIndexSkip('${ordersVO.pageMax }')">&nbsp;</a>
        <span class="pageSkip">
        	共${ordersVO.pageMax }页
            <input id="pageNumber" name="pageNumber" value="1" maxlength="9">
           	<button type="submit">&nbsp;</button>
        </span>
    </div>
</form>
<script src="<%=path%>/js/jquery.min.js"></script>
<script src="<%=path%>/js/order_list.js"></script>

<script type="text/javascript">
function deleteOrder(){
	var $checkedIds=$('#listTable input[name="ids"]:checked');
	$.ajax({
		url: "<%=path%>/admin/order/order_delete.do",
		type: "POST",
		data: $checkedIds.serialize(),
		dataType: "json",
		cache: false,
		success: function(data) {
			location.reload(true);
		}
	});

};

function refreshOrder(){
	location.reload(true);
};

function pageIndexSkip(pageIndex){
	$("#pageIndex").val(pageIndex);
	$("#listForm").submit();
};
function pageSizeSkip(pageSize){
	$("#pageSize").val(pageSize);
	$("#listForm").submit();
};

$("#filterMenu li").click(function() {
	var $this = $(this);
	if ($this.hasClass("checked")) {
		$("#orderStatus").val("");
	} else {
		$("#orderStatus").val($this.attr("val"));
	}
	$("#listForm").submit();
});

$("#searchMenu li").click( function() {
	var $this = $(this);
	$("#searchMenu li").removeClass("current");
	$this.addClass("current");
});

$("#listForm").submit(function() {
	var $searchMenuItem = $("#searchMenu li.current");
	var $searchValue = $("#searchValue");
	$("pageIndex").val($("#pageNumber").val());
	if (!/^\d*[1-9]\d*$/.test($("#pageNumber").val())) {
		$("pageIndex").val("1");
	}
	if ($searchValue.size() > 0 && $searchValue.val() != "" && $searchMenuItem.attr("val") != "") {
		var $dest = $("#" + $searchMenuItem.attr("val"));
		$("#searchPram").val($searchMenuItem.attr("val"));
		$dest.val($searchValue.val());
	};
});
</script>
</body>
</html>
