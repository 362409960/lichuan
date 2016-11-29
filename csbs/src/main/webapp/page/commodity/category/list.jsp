<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/tlds/c.tld" prefix="c"%>
<%@ taglib uri="/WEB-INF/tlds/fmt.tld" prefix="fmt"%>
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
<link rel="stylesheet" type="text/css" href="<%=path%>/css/deafult/main.css">
<script type="text/javascript" src="<%=path%>/js/jquery.min.js"></script>
<script language="JavaScript" type="text/JavaScript">
$(function(){
var $refreshButton = $('#refreshButton');	
 $refreshButton.click( function() {
		location.reload(true);
		return false;
	});
});
</script> 
</head>

<body>
<div class="breadcrumb"><a href="<%=path%>/index.jsp">首页</a>&raquo;商品分类列表</div>
<div class="bar">
	<a id="iconButton" class="iconButton" href="<%=path%>/admin/category/toAdd.do">
        <span class="addIcon icon"></span>&nbsp;添加
    </a>
    <a id="refreshButton" class="iconButton" href="javascript:;">
        <span class="refreshIcon icon"></span>&nbsp;刷新
    </a>
</div>
<table id="listTable" class="list">
    <tr>
		<th><span>名称</span></th>
        <th><span>排序</span></th>
        <th><span>操作</span></th>
    </tr>
    <c:forEach var="it" items="${list}" varStatus="st">
       <c:choose>
           <c:when test="${it.level==0}">
     <tr>
    	<td><span style="margin-left:0; color:#000;">${it.category_name}</span></td>
        <td>${it.order_value}</td>
        <td>
            <a href="<%=path%>/admin/category/toEdit.do?id=${it.id}">[编辑]</a>
            <a href="<%=path%>/admin/category/deleteById.do?id=${it.id}" class="delete" val="${it.id}">[删除]</a>
        </td>
    </tr>
           </c:when>
           <c:otherwise>
      <tr>
    	<td><span style="margin-left:${it.level*20}px;">${it.category_name}</span></td>
        <td>${it.order_value}</td>
         <td>
            <a href="<%=path%>/admin/category/toEdit.do?id=${it.id}">[编辑]</a>
            <a href="<%=path%>/admin/category/deleteById.do?id=${it.id}" class="delete" val="${it.id}">[删除]</a>
        </td>
    </tr>
           </c:otherwise>
       </c:choose>
    </c:forEach>
	
</table>
</body>
</html>
