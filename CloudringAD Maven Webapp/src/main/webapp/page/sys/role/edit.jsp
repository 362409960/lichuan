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
<!-- <script type="text/javascript" src="<%=path%>/js/zTree/jquery.ztree-2.6.min.js"></script> -->
<script type="text/javascript" src="<%=path%>/js/zTree/jquery.ztree.all.js"></script>
<script type="text/javascript"  src="<%=path%>/layer/layer.js"></script>
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
				enable: true//复选框显示
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
		var roleId = $("#id").val();
		var role_name = $.trim($("#role_name").val());
		var remark = $("#remark").val();
		var kgReg = /^[^\s]*$/;//空格
		var nodes = zTree.getCheckedNodes();
		var tmpNode;
		var ids = "";
		
		if(role_name==""||!kgReg.test(role_name)){
			layerAlter("提示","请输入角色名称！");
			return false;
		}
		
		if(nodes.length==0){
			layerAlter("提示","角色权限不能为空！");
			return false;
		}
		
		for(var i=0; i<nodes.length; i++){
			tmpNode = nodes[i];
			if(i!=nodes.length-1){
				ids += tmpNode.id+",";
			}else{
				ids += tmpNode.id;
			}
		}
		
		$.ajax({
			url : "<%=request.getContextPath()%>/admin/role/queryName.do",
			type: "POST",
			cache:false,
			async:true,
			dataType: "json",
			data:$("#searchForm").serialize(),
			success:function(data) {
				if(data=="true"){
					layerAlter("提示","角色名称已存在！");
				}else{
					$.ajax({
						url : "<%=request.getContextPath()%>/admin/role/roleEdit.do?menuIds="+ids,
						type: "POST",
						cache:false,
						async:true,
						dataType: "json",
						data:$("#searchForm").serialize(),
						success:function(data) {
							if(data){
								window.location.href = '<%=request.getContextPath()%>/admin/role/listRole.do';
								//layerAlter("提示","保存成功！");
							}else{
								layerAlter("提示","保存失败！"); 
							}
				        },
						error:function(XMLHttpRequest, textStatus, errorThrown) {
				            layerAlter("提示","操作出现异常！");
				       }
				   });
				}
	        },
			error:function(XMLHttpRequest, textStatus, errorThrown) {
	            layerAlter("提示","操作出现异常！");
	        }
	    });
	}

</script>
</head>

<body>
	<jsp:include page="/page/top.jsp" />
    <div class="blank9"></div>
	<div class="container">
		<form id="searchForm" name="searchForm" method="post" action="<%=path %>/admin/role/roleEdit.do">
			<!-- 隐藏域 -->
			<input name="id" type="hidden" id="id" value="${roleVO.id }" />
			<div class="main_nav">权限信息</div>
			<table class="detailTable">
				<colgroup>
					<col width="15%">
					<col width="35%">
					<col width="50%">
				</colgroup>
				<tr class="detailRow1">
					<td>角色名称: <span class="cRed">*</span></td>
					<td><input name="role_name" type="text" id="role_name" value="${roleVO.role_name }" /></td>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td>备注:</td>
					<td>
						<textarea name="remark" rows="4" cols="20" id="remark" style="width:100%;">${roleVO.remark }</textarea>
					</td>
					<td>&nbsp;</td>
				</tr>
				<tr class="detailRow1">
					<td>角色权限: <span class="cRed">*</span></td>
					<td colspan="2">
						<div id="ztree" class="ztree" style="width:90%;height:300px;overflow:auto;overflow-x:hidden;margin-top:2px;margin-left:2px;"></div>
					</td>
				</tr>
			</table>
			<div class="detailbutton">
				<input type="button" value="提交" class="btn-01" onclick="save();" />&nbsp;&nbsp;
				<input type="button" value="返回" class="btn-01" onclick="javascript:history.go(-1);">
			</div>
		</form>
	</div>
</body>
</html>
