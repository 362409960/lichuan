<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%String path = request.getContextPath();%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<link rel="stylesheet" type="text/css" href="<%=path %>/css/main.css"/>
<link rel="stylesheet" type="text/css" href="<%=path %>/css/easyui.css"/>
<link rel="stylesheet" type="text/css" href="<%=path %>/css/icon.css"/>
<link rel="stylesheet" type="text/css" href="<%=path %>/css/demo.css"/>
<link rel="stylesheet" type="text/css" href="<%=path %>/js/zTree/zTreeStyle.css"/>
<script type="text/javascript" src="<%=path %>/js/jquery.min.js"></script>
<script type="text/javascript" src="<%=path %>/js/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=path %>/js/zTree/jquery.ztree-2.6.min.js"></script>

<script language="javascript">
var zTree;
$(document).ready(function() {
    var setting = {
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

//取得选中的菜单id 
function getMenuIds(){
	//取得所有选中的节点，返回节点对象的集合
	var menu = jQuery.tree.plugins.checkbox.get_checked();
	//得到节点的id，拼接成字符串
	var str="";
	for(var i=0; i<menu.size(); i++){
		str += menu[i].id;
		if(i < menu.size()-1){
            str += ",";
        }
	}
	//写回表单
	$("#menuIds").val(str);
} 

function save(){
	var roleId = "${roleVO.id}";
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
    $.ajax({
		url : "<%=request.getContextPath()%>/admin/role/grantRole.do?id="+roleId+"&menuIds="+ids,
		type: "POST",
		cache:false,
		async:true,
		dataType: "json",
		success:function(data) {
			 if(data){
				 window.location.href = '<%=request.getContextPath()%>/admin/role/list.do';
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

//展开所有节点
function openAllTree(){
	zTree.expandAll(true);
}

//关闭所有节点
function closeAllTree(){
	zTree.expandAll(false);
}

</script>
</head>

<body>
<form id="frm" name="frm" method="post" class="extendarea">
	<input type="hidden" id="id" name="roleVO.id"  value="${roleVO.id}" />
	<input type="hidden" id="menuIds" name="roleVO.role_name"  />
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
	<div class="w001"><div class="titlehead">角色基本信息</div>
   		<div class="listinfo2" > 
   			<table border="0"  cellpadding="0" cellspacing="0"  style="width:95%;">
        		<tr>
           			 <td width="10%">角色名：</td>
            		 <td width="40%">${roleVO.role_name}</td>
            		 <td width="12%">角色KEY：</td>
            		 <td width="38%">${roleVO.role_key}</td>
        		</tr>
    		</table>
    	</div>
    </div>
    <div class="w001"><div class="titlehead">关联菜单</div>
    	<div style="text-align:left;margin-left:5px;">
       		 <a href="javascript:openAllTree()"><span class="itembody">+全部展开</span></a>&nbsp;&nbsp;&nbsp;&nbsp;
        	 <a href="javascript:closeAllTree()"><span class="itembody">-全部收起</span></a>
    	</div>
    	<div id="tree" class="tree" style="width:90%;height:300px;overflow:auto;overflow-x:hidden;margin-top:2px;margin-left:2px;"></div>
    </div>
</form>
</body>
</html>
