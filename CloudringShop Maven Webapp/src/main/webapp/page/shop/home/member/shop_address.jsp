<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="/WEB-INF/tlds/c.tld" prefix="c"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title></title>
    <link href="<%=path%>/css/shop/common.css" rel="stylesheet" type="text/css" />
	<link href="<%=path%>/css/shop/member.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="<%=path%>/js/jquery.min.js"></script>
	<script type="text/javascript" src="<%=path%>/js/shop/common.js"></script>
<style>
body {
    overflow-x:hidden;overflow-y:hidden;
}
</style>
<script type="text/javascript">
var contextPath = "${pageContext.request.contextPath}";
$().ready(function() {

	var $listTable = $("#listTable");
	var $delete = $("#listTable a.delete");
	

	// 删除
	$delete.click(function() {
		if (confirm("您确定要删除吗？")) {
			var $tr = $(this).closest("tr");
			var id = $tr.find("input[name='id']").val();
			$.ajax({
				url: contextPath+"/shipAddress/deleteShipAddress.do",
				type: "POST",
				data: {id: id},
				dataType: "json",
				cache: false,
				success: function(message) {
					if (message== true) {
						var $siblings = $tr.siblings();
						if ($siblings.size() <= 1) {
							$listTable.after('<p>暂无信息<\/p>');
						} else {
							$siblings.last().addClass("last");
						}
						$tr.remove();
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
				<div class="list">
					<div class="title">收货地址</div>
					<div class="bar">
						<a href="<%=path%>/shipAddress/add.do" class="button">添加收货地址</a>
					</div>
					<table id="listTable" class="list">
						<tr>
							<th>
								收货人
							</th>
							<th>
								地址
							</th>
							<th>
								是否默认
							</th>
							<th>
								操作
							</th>
						</tr>
						<c:forEach items="${user}" var="list" varStatus="st">
							<tr class="last">
								<td>
									<input type="hidden" name="id" value="${list.id}" />
									${list.contacts}
								</td>
								<td>
									<span title="${list.province_id}${list.city_id}${list.district_id}${list.address}">${list.province_id}${list.city_id}${list.district_id}${list.address}</span>
								</td>
								<td>
									<c:choose>
									<c:when test="${list.isdefault=='1'}">是</c:when>
									<c:otherwise>否</c:otherwise> 
									</c:choose> 
								</td>
								<td>
									<a href="<%=path%>/shipAddress/edit.do?id=${list.id}">[编辑]</a>
									<a href="javascript:;" class="delete">[删除]</a>
								</td>
						</tr>
						</c:forEach>
					</table>
					<c:choose>
					    <c:when test="${isTrue==false}"> <p>暂无信息</p></c:when>
					    <c:otherwise></c:otherwise>
					</c:choose>
				</div>
			</div>
   
</div>
</div>
  </body>
</html>
