<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<% 
    String path = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>菜单树</title>
<link rel="stylesheet" type="text/css" href="<%=path%>/css/main.css"/>
<link rel="stylesheet" type="text/css" href="<%=path%>/css/easyui.css"/>
<link rel="stylesheet" type="text/css" href="<%=path%>/css/icon.css"/>
<link rel="stylesheet" type="text/css" href="<%=path%>/css/demo.css"/>
<link rel="stylesheet" type="text/css" href="<%=path%>/js/zTree/zTreeStyle.css"/>
<script type="text/javascript" src="<%=path%>/js/jquery.min.js"></script>
<script type="text/javascript" src="<%=path%>/js/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=path%>/js/zTree/jquery.ztree-2.6.min.js"></script>

<script type="text/javascript">
	var zTree;
	$(document).ready(function() {
	    // 初始化菜单树
	    var setting = {
	     	enable: true,
		    showLine: true,
		    isSimpleData : true, //数据是否采用简单 Array 格式，默认false
			treeNodeKey : "id", //在isSimpleData格式下，当前节点id属性
			treeNodeParentKey : "pid", //在isSimpleData格式下，当前节点的父节点id属性
		    checkable: false,
 		    callback: {click: zTreeOnClick}
		};
		
		function zTreeOnClick(event, treeId, treeNode) {
			nodeClick(treeNode);
		};
		
		var zn = '${zTreeNodes}';
		var zTreeNodes = eval(zn);
		zTree = $("#menuTree").zTree(setting, zTreeNodes);
	});
	
	//节点单击赋值显示
	function nodeClick(treeNode) {
		clearMenuInfo();//清空
		
      	// 填充菜单基本信息
      	$("#name").html(treeNode.name);
	    $("#parentName").html(treeNode.parentName);
      	$("#url").html(treeNode.menuUrl);
      	$("#menuImgUrl").html("<img src='<%=path%>/"+treeNode.menuImgUrl+"'/>");
      	$("#note").html(treeNode.note);
      	if(treeNode.pid == null){
      		$("#pid").val("0");
      	}else{
        	$("#pid").val(treeNode.pid);
      	}
        $("#id").val(treeNode.id);
    }
	
	//删除菜单节点
	function deleteMenu(){
        var tree_parent_pid = $("#pid").val();
        var parent_id = $("#id").val();
    	if(tree_parent_pid != "-1"){
    		if(tree_parent_pid == "0"){//删除父节点及下面的子节点
    			if(confirm("你确定要删除菜单[ " + $("#name").html() + " ]，以及下面的所有子菜单吗？")){
		            jQuery.ajax({
		                url:"<%=path%>/menu/deleteSTMenu.do",
		                data:{"id":parent_id,"pid":tree_parent_pid},
		                cache:false,
		                dataType:"json",
		                success:function(data) {
		                	if(data){
		                		alert("删除成功！");
		                		window.location.reload(); 
		                	}else{
		                		alert("删除失败！");
		                	}
		                },
		                error:function(XMLHttpRequest, textStatus, errorThrown) {
		                    alert("操作失败！");
		                }
		            });
		        }
    		}else{//只删除子节点
    			if(confirm("你确定要删除菜单[ " + $("#name").html() + " ]？")){
		            jQuery.ajax({
		                url:"<%=path%>/menu/deleteSTMenu.do",
		                data:{"id":parent_id,"pid":tree_parent_pid},
		                cache:false,
		                dataType:"json",
		                success:function(data) {
		                	if(data){
		                		alert("删除成功！");
		                		window.location.reload(); 
		                	}else{
		                		alert("删除失败！");
		                	}
		                },
		                error:function(XMLHttpRequest, textStatus, errorThrown) {
		                    alert("操作失败！");
		                }
		            });
 		        }
    		}
    	}else{
    		alert("未选择菜单。");
        	return;
        }
    }
	
	
    // 清空菜单信息
    function clearMenuInfo(){
        $("#name").html("");
        $("#parentName").html("");
        $("#url").html("");
        $("#note").html("");
        $("#menuImgUrl").html("");
        $("#id").val("");
        $("#pid").val("0");
    }

    // 修改节点的回调函数
    function onRenameCallback(nodeId, nodeName) {
        // 刷新树
        jQuery.tree.focused().refresh();
        nodeClick(nodeId,"","");
    }
    
    //增加子节点
    function addChildMenu(){
    	var tree_parent_pid = $("#pid").val();
    	var parent_id = $("#id").val();
    	if(tree_parent_pid != "-1"){
    		if(tree_parent_pid=="0"){
    			window.location.href = '<%=path%>/menu/insert.do?pid='+$("#pid").val()+"&parent_id="+parent_id;
    		}else{
    			alert("已是子节点，不能添加。");
    		}
        	
        }else{
        	alert("未选择菜单。");
        }
    }
    // 新增节点的回调函数
    function onCreateCallback(nodeId, nodeName) {
        // 刷新树
        jQuery.tree.focused().refresh();
        nodeClick(nodeId,"","");
    }
    
    //增加同级菜单
    function addMenu(){
    	var tree_parent_pid = $("#pid").val();
    	var parent_id = $("#id").val();
    	if(parent_id == "0"){
    		alert("已是父级菜单。");
    		return;
    	}
    	if(tree_parent_pid != "-1"){
        	//openDialog("增加同级菜单", "preInsertMenu.do?stMenu.pid=" + tree_parent_id, 700, 400, onCreateCallback);
        	//window.open ('<%=path%>/menu/insert.do', 'newwindow', 'height=100, width=400, top=0, left=0, toolbar=no, menubar=no, scrollbars=no, resizable=no,location=n o, status=no');
        	//window.showModelDialog('<%=path%>/menu/insert.do','','dialogWidth=200px;dialogHeight=100px');
        	window.location.href = '<%=path%>/menu/insert.do?pid='+$("#pid").val();
        }else{
        	alert("未选择菜单。");
        }
    }
    
    //修改菜单
    function editMenu(){
    	var tree_parent_pid = $("#pid").val();
    	var parent_id = $("#id").val();
    	if(parent_id == "0"){
    		alert("未选择菜单。");
    		return;
    	}
    	if(tree_parent_pid != "-1"){
        	window.location.href = '<%=path%>/menu/insert.do?pid='+$("#pid").val()+"&id="+$("#id").val();
        }else{
        	alert("未选择菜单。");
        }
    }
    
    
</script>

<style>
td,th {
    font-size: 14px;
    border: solid 1px #B4B4B4;
    border-collapse: collapse;
}
</style>
</head>

<body>
<div class="sme_mainrm">
	<form id="frm" name="frm" method="post" >
	    <input type="hidden" id="id" name="stMenu.id" />
	    <input type="hidden" id="pid" name="stMenu.pid" value="-1" />
	  	<div class="sme_newlist">
	    	<table border="1" cellpadding="0" cellspacing="0" style="width:100%;border: solid 1px #B4B4B4;border-collapse: collapse;">
	        	<tr>
	            	<td valign="top" width="200px">
	                	<!-- 菜单树-->
	                	<div id="menuTree" class="tree" style="overflow:auto;"></div>
	            	</td>
	            	<td valign="top">
	            		<div class="titlehead">&nbsp;&nbsp;菜单基本信息和操作按钮</div>
	                    <div label="基本信息">
	  						<div class="listinfo2">
	                    		<div class="tablelist">
	                        		<table border="1" cellpadding="0" cellspacing="0" style="width:100%;table-layout:fixed;border: solid 1px #B4B4B4;border-collapse: collapse;">
			                            <thead>
								     		<tr>
								      			<th width="17%" scope="row">菜单名称</th>
								      			<td width="83%" id="name"></td>
								   			</tr>
								   		</thead>
								    	<tbody>
								    		<tr>
								      			<th width="17%" scope="row">上级菜单</th>
								      			<td width="83%" id="parentName"></td>
								    		</tr>
								    	</tbody>
								    	<thead>
								     		<tr>
								      			<th width="17%" scope="row">链接地址</th>
								      			<td width="83%" id="url"></td>
								   			 </tr>
								   		</thead>
	
	                          			<!-- <thead>
								     		<tr>
								      			<th width="17%" scope="row">显示图片</th>
								      			<td width="83%" id="menuImgUrl"></td>
								    		</tr>
								   		</thead> -->
								   		<tbody>
								    		<tr>
								      			<th width="17%" scope="row">描述</th>
								      			<td width="83%"><textarea class="textarea" id="note" name="note" rows="5" disabled="disabled" readonly="readonly"></textarea></td>
								   			 </tr>
								    	</tbody>
	                        		</table>
	                       		 </div>
					        </div>
	                    </div>
	                    <div label="操作按钮">
	                        <div id="op_div"></div>
	                    </div>
	        			<table align="center" border="0">
	        				<tr>
	                            <td><div><a id="generaltse1" href="javascript:addMenu();" >增加同级菜单</a></div></td>
	                            <td><div><a id="generaltse1" href="javascript:addChildMenu()" >增加子菜单</a></div></td>
	                           	<td><div><a id="generaltse1" href="javascript:editMenu()" >修改菜单</a></div></td>
	                           	<td><div><a id="generaltse1" href="javascript:deleteMenu()" >删除菜单</a></div></td>
	                   		</tr>
	                 	</table>
	            	</td>
	        	</tr>
	    	</table>
	    </div>
	</form>
</div>
</body>
</html>
