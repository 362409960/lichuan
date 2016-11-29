<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="/WEB-INF/tlds/c.tld" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<%String path = request.getContextPath();%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<link rel="stylesheet" type="text/css" href="../../css/main.css"/>
<link rel="stylesheet" type="text/css" href="../../css/easyui.css"/>
<link rel="stylesheet" type="text/css" href="../../css/icon.css"/>
<link rel="stylesheet" type="text/css" href="../../css/demo.css"/>
<link rel="stylesheet" type="text/css" href="../../js/zTree/zTreeStyle.css"/>
<script type="text/javascript" src="../../js/jquery.min.js"></script>
<script type="text/javascript" src="../../js/jquery.easyui.min.js"></script>
<script type="text/javascript" src="../../js/zTree/jquery.ztree-2.6.min.js"></script>

<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />

<script language="javascript">
var zTree;
$(document).ready(function() {
    // 初始化菜单树
    var setting = {
     	enable: true,
	    showLine: true,
	    isSimpleData : true, //数据是否采用简单 Array 格式，默认false
		treeNodeKey : "id", //在isSimpleData格式下，当前节点id属性
		treeNodeParentKey : "pid", //在isSimpleData格式下，当前节点的父节点id属性
	    checkable: true
	};
	
	var zn = '${zTreeNodes}';
	var zTreeNodes = eval(zn);
	zTree = $("#tree").zTree(setting, zTreeNodes);
});

//修改
function save(){
	var nodes = zTree.getCheckedNodes();
	var tmpNode;
	var ids = "";
	for(var i=0; i<nodes.length; i++){
		tmpNode = nodes[i];
		if(i!=nodes.length-1){
			ids += tmpNode.id+",";
		}else{
			ids += tmpNode.id;
		}
	}
	var checkIds = document.getElementsByName("roleIds");
	var selectedArr = new Array();
	var notSelectArr = new Array();
	for(var n=0;n<checkIds.length;n++){
		if (checkIds[n].checked){
			selectedArr.push(checkIds[n].value);
		}else{
			notSelectArr.push(checkIds[n].value);
		}
	}
	var userId = "${sysUser.id}";
    $.ajax({
		url : "<%=request.getContextPath()%>/admin/user/grantRole.do?id="+userId+"&selectedArr="+selectedArr+"&notSelectArr="+notSelectArr+"&menuIds="+ids,
		type: "POST",
		cache:false,
		async:true,
		dataType: "json",
		//data: params,
		success:function(data) {
			if(data){
				window.location.href = '<%=request.getContextPath()%>/admin/user/list.do';
				//alert("保存成功！");
			}else{
				alert("保存失败！"); 
			}
        },
		error:function(XMLHttpRequest, textStatus, errorThrown) {
            alert("操作出现异常！");
        }
    });
}

 
</script>
 
</head>

<body>
<form id="frm" name="frm" method="post" class="extendarea">
	<input type="hidden" id="id" name="sysUserVO.id"  value="${sysUserVO.id}" />
	<input type="hidden" id="menuIds" name="menuIds"/>
	<input type="hidden" id="tempRoleIds" name="tempRoleIds"/>
   	<div class="w001">
   		<div class="w001"><div class="titlehead">菜单操作</div>
	 		<table width="100%" border="0" cellspacing="0" cellpadding="0">
	   			<tr>
	    			<td valign="top">&nbsp;</td>
	    			<td height="30">
	    				<table width="50%" border="0" cellspacing="0" cellpadding="0">
	  						<tr>
	    						<td><div class="generalbtt"><input type="button" onclick="javascript:save();" value="保存"/></div></td>
	    						<td><div class="generalbtt"><input type="button" onclick="javascript:history.go(-1);" value="返回"/></div></td>
	  						</tr>
						</table>
					</td>
	  			</tr>
  			</table>
 		</div>
      	<div class="titlehead">用户基本信息</div>
        <div class="tablelist">
	   		<table border="0" cellpadding="0" cellspacing="0" style="width:100%;">
	       		<tr>
	           		<td align="left" valign="top">
	               		<table border="0" cellpadding="0" cellspacing="0" class="formlist" style="width:100%;table-layout:fixed;">
	                  		<tr>
	                       		<td>用户账号</td>
	                       		<td>${sysUser.userCode}</td>
	                      			<td>显示名</td>
	                       		<td>${sysUser.userName}</td>
	                   		</tr>
	               		</table>
	          		</td>
	       		</tr>
	  		</table>
  		</div>
  		<div class="titlehead">用户分配权限</div>
  		<table border="0" cellpadding="0" cellspacing="0" style="width:100%;">
      		<tr>
	           	<td align="left" valign="top">权限菜单<br/>
	           		<div align="left">
	           			<div id="tree" class="tree"></div>
	           		</div>
	           	</td>
	           	<td align="center" valign="top">配角色列表<br/>
	               	<table>
	               		<tr>
	               			<th>选择</th>
	               			<th>角色</th>
	               		</tr>
	           			<c:forEach items="${allRoles}" var="role">
	           				<tr>
	           	 				<td>
	           	 					<input type="checkbox" id ="roleIds" name="roleIds" value="${role.id}" ${role.is_checked eq "true"?"checked=\"checked\"":"" }/>
	           	 				</td>
	           	 				<td>${role.role_name}</td> 
	           	 			</tr>
	           			</c:forEach>
	               	</table>
	          	</td>
      		</tr>
	       	<!-- <tr>
	       		<td colspan="2" align="center">
	       			<table width="165" border="0" cellspacing="0" cellpadding="0">
	        			<tr>
	        				<td >
	        					<div class="generalbtt"><a id="generaltse">保存</a></div>
	        				</td>
	        				<td>
	        					<div class="generalbtt"><a id="generaltse" href="javascript:closeDialog();" >关闭</a></div>
	        				</td>
	        			</tr>
	       			</table>
	       		</td>
	       	</tr> -->
   		</table>
   	</div>
</form>
</body>
</html>
