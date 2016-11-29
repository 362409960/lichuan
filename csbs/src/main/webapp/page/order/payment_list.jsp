<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="/WEB-INF/tlds/c.tld" prefix="c"%>
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
<div class="breadcrumb"><a href="index.html">首页</a>&raquo;收款单列表<span>(共0条记录)</span></div>
<form id="listForm" method="get" action="##">
	<div class="bar">
        <div class="buttonGroup">
        	<a id="deleteButton" class="iconButton disabled" href="javascript:;">
            	<span class="deleteIcon icon"></span>&nbsp;删除
            </a>
            <a id="refreshButton" class="iconButton" href="javascript:;" onclick="refresh()">
            	<span class="refreshIcon icon"></span>&nbsp;刷新
            </a>
            <div id="pageSizeMenu" class="dropdownMenu">
            	<a class="button" href="javascript:;">每页显示&nbsp;<span class="arrow"></span></a>
                <ul>
                	<li val="10">10</li>
                    <li class="current" val="20">20</li>
                    <li val="50">50</li>
                    <li val="100">100</li>
                </ul>
            </div>
        </div>
        <div id="searchMenu" class="dropdownMenu">
        	<div class="search">
            	<span class="arrow"></span>
                <input id="searchValue" type="text" maxlength="200" value="" name="searchValue">
                <button type="submit"></button>
            </div>
            <ul>
            	<li val="sn">编号</li>
                <li val="account">收款账号</li>
                <li val="payer">付款人</li>
            </ul>
        </div>
    </div>
    <table id="listTable" class="list">
    	<tr>
        	<th class="check"><input type="checkbox" id="selectAll"></th>
            <th><a href="javascript:;" class="sort" name="sn">编号</a></th>
            <th><a href="javascript:;" class="sort" name="method">方式</a></th>
            <th><a href="javascript:;" class="sort" name="paymentMethod">支付方式</a></th>
            <th><a href="javascript:;" class="sort" name="fee">支付手续费</a></th>
            <th><a href="javascript:;" class="sort" name="amount">付款金额</a></th>
            <th><a href="javascript:;" class="sort" name="payer">付款人</a></th>
            <th><a href="javascript:;" class="sort" name="order">订单</a></th>
            <th><a href="javascript:;" class="sort" name="createDate">创建日期</a></th>
            <th><span>操作</span></th>
        </tr>
    </table>
</form>
<script type="text/javascript">
function refresh(){
	location.reload(true);
}
</script>
</body>
</html>
