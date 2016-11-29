<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>管理中心——Cloudring Shop</title>
<meta content="Cloudring" name="author">
<meta content="Cloudring" name="copyright">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/deafult/common.css">
<script type="text/javascript" src="<%=path%>/js/jquery.min.js"></script>
<style type="text/css">
.input .powered {
	font-size: 12px;
	text-align: right;
	color: #cccccc;
}
</style>
</head>

<body>
<div class="breadcrumb">管理中心首页</div>
<table class="input">
	<tr>
    	<th>系统名称：</th>
        <td>SHOP++网上商城系统<a href="##" class="silver" target="_blank">[授权查询]</a></td>
        <th>系统版本：</th>
        <td>4.0 RELEASE</td>
    </tr>
    <tr>
    	<th>官方网站：</th>
        <td><a href="##" target="_blank">http：//www.shopxx.net</a></td>
        <th>官方论坛：</th>
        <td><a href="##" target="_blank">http：//www.shopxx.net</a></td>
    </tr>
    <tr>
    	<td colspan="4">&nbsp;</td>
    </tr>
    <tr>
		<th>JAVA版本：</th>
		<td>1.7.0_80</td>
		<th>JAVA路径：</th>
		<td>/shopxx/jdk1.7/jre</td>
	</tr>
	<tr>
    	<th>操作系统名称：</th>
		<td>Linux</td>
		<th>操作系统构架：</th>
		<td>amd64</td>
	</tr>
	<tr>
		<th>Server信息：</th>
		<td><span title="Apache Tomcat/7.0.63">Apache Tomcat/7.0.63</span></td>
		<th>Servlet版本：</th>
        <td>3.0</td>
	</tr>
	<tr>
		<td colspan="4">&nbsp;</td>
	</tr>
	<tr>
		<th>等待审核订单数：</th>
		<td>160</td>
		<th>等待发货订单数：</th>
		<td>0</td>
	</tr>
	<tr>
    	<th>等待收款订单数：</th>
		<td>160</td>
		<th>等待退款订单数：</th>
		<td>0</td>
	</tr>
	<tr>
		<th>上架商品数：</th>
		<td>47</td>
		<th>下架商品数：</th>
		<td>0</td>
	</tr>
	<tr>
		<th>商品库存报警数：</th>
		<td>4</td>
		<th>缺货商品数：</th>
		<td>4</td>
	</tr>
	<tr>
		<th>会员总数：</th>
        <td>827</td>
		<th>未读消息数：</th>
		<td>1</td>
	</tr>
	<tr>
		<td class="powered" colspan="4">COPYRIGHT © 2005-2015 SHOPXX.NET ALL RIGHTS RESERVED.</td>
	</tr>
</table>
</body>
</html>
