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
<div class="breadcrumb"><a href="index.html">首页</a>&raquo;发货点列表<span>(共0条记录)</span></div>
<form id="listForm" method="get" action="##">
	<div class="bar">
    	<a class="iconButton" href="<%=path %>/page/order/delivery_add.jsp">
        	<span class="addIcon icon"></span>&nbsp;添加
        </a>
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
            	<li val="name">名称</li>
                <li val="contact">联系人</li>
                <li val="phone">电话</li>
                <li val="mobile">手机</li>
            </ul>
        </div>
    </div>
    <table id="listTable" class="list">
    	<tr>
        	<th class="check"><input type="checkbox" id="selectAll"></th>
            <th><a href="javascript:;" class="sort" name="name">名称</a></th>
            <th><a href="javascript:;" class="sort" name="contact">联系人</a></th>
            <th><a href="javascript:;" class="sort" name="areaName">地区名称</a></th>
            <th><a href="javascript:;" class="sort" name="address">地址</a></th>
            <th><a href="javascript:;" class="sort" name="zipCode">邮编</a></th>
            <th><a href="javascript:;" class="sort" name="phone">电话</a></th>
            <th><a href="javascript:;" class="sort" name="mobile">手机</a></th>
            <th><a href="javascript:;" class="sort" name="isDefault">是否默认</a></th>
            <th><span>操作</span></th>
        </tr>
        <tr>
            <td class="check">
                <input type="checkbox" name="ids" value="1" />
            </td>
            <td>北京配送中心</td>
            <td>北京配送中心</td>
            <td>北京市东城区</td>
            <td><span title="安德路888号">安德路888号</span></td>
            <td>100000</td>
            <td>010-88888888</td>
            <td> 13888888888 </td>
            <td><span class="trueIcon">&nbsp;</span></td>
            <td><a href="<%=path%>/admin/delivery/delivery_view.do?deliveryId=0">[编辑]</a></td>
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
