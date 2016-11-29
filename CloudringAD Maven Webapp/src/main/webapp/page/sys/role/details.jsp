<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="/WEB-INF/tlds/c.tld" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<html>
<head>
<meta charset="UTF-8">
<title>角色详情</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta content="" name="description">
<meta content="" name="keywords">
<meta content="Cloudring" name="author">
<meta content="Cloudring" name="copyright">
<link rel="shortcut icon" href="<%=request.getContextPath()%>/images/icon/icon.png">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/common.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/main.css">
<!-- <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/zTree/zTreeStyle.css"/> -->
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/zTreeStyle/zTreeStyle.css"/>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common.js"></script>
<script type="text/javascript" src="<%=path%>/layer/layer.js"></script>
<!-- <script type="text/javascript" src="<%=path%>/js/zTree/jquery.ztree-2.6.min.js"></script> -->
<script type="text/javascript" src="<%=path%>/js/zTree/jquery.ztree.all.js"></script>
<style type="text/css">
html,body{
	height:100%;
	width:100%;
	overflow:auto;
}
</style>
<script language="javascript">
	
	var zTree;
	
	var setting = {
		check: {
			enable: false//复选框显示
		},
		data: {
			simpleData: {
				enable: true
			}
		}
	};
	
	$(document).ready(function() {
		$("#v_index").removeClass("visiting");
	 	$("#v_program").removeClass("visiting");
		$("#v_terminal").removeClass("visiting");
		$("#v_sys").addClass("visiting");
		$("#v_mater").removeClass("visiting");
		
		var zTreeNodes = eval('${zTreeNodes}');
		zTree = $.fn.zTree.init($("#ztree"), setting, zTreeNodes);
		zTree.expandAll(true);//节点展开
	});
	
// 	var zTree;
// 	$(document).ready(function() {
// 	    var setting = {
// 		    showLine: true,
// 		    isSimpleData : true, //数据是否采用简单 Array 格式，默认false
// 			treeNodeKey : "id", //在isSimpleData格式下，当前节点id属性
// 			treeNodeParentKey : "pid", //在isSimpleData格式下，当前节点的父节点id属性
// 		    checkable: true
// 		};
		
// 		var zn = '${zTreeNodes}';
// 		var zTreeNodes = eval(zn);
// 		zTree = $("#tree").zTree(setting, zTreeNodes);
// 		zTree.expandAll(true);//节点展开
// 	});
	
	function save(){
		var id=$("#id").val();
		window.location.href = '<%=request.getContextPath()%>/admin/role/detailsRole.do?id='+id+"&action=1";
	}
	
</script>
</head>

<body>
	<jsp:include page="/page/top.jsp" />
    <div class="blank9"></div>
	<div class="container">
		<!-- 隐藏域 -->
		<input name="id" type="hidden" id="id" value="${roleVO.id }" />
		<div class="main_nav">权限信息</div>
		<table class="detailTable">
			<col width="10%">
			<col width="20%">
			<col width="10%">
			<col width="20%">
			<col width="10%">
			<col width="20%">
			<tr class="detailRow1">
				<td>角色名称:</td>
				<td>${roleVO.role_name }</td>
				<td>应用级别:</td>
				<td></td>
				<td>创建人:</td>
				<td>${roleVO.create_user }</td>
			</tr>
			<tr>
				<td>创建时间:</td>
				<td><fmt:formatDate value='${roleVO.create_time}' pattern='yyyy-MM-dd HH:mm:ss' /></td>
				<td>修改人:</td>
				<td>${roleVO.update_user }</td>
				<td>修改时间:</td>
				<td><fmt:formatDate value='${roleVO.update_time}' pattern='yyyy-MM-dd HH:mm:ss' /></td>
			</tr>
			<tr class="detailRow1">
				<td>备注:</td>
				<td colspan="5">${roleVO.remark }</td>
			</tr>
			<tr>
				<td>角色权限:</td>
				<td colspan="5">
					<div id="ztree" class="ztree" style="width:99%;height:300px;overflow:auto;overflow-x:hidden;margin-top:2px;margin-left:2px;"></div>
				</td>
			</tr>
		</table>
		<div class="detailbutton">
			<input type="button" value="编辑" class="btn-01" onclick="save();" />&nbsp;&nbsp;
			<input type="button" value="返回" class="btn-01" onclick="javascript:history.go(-1);">
		</div>
	</div>
</body>
</html>
