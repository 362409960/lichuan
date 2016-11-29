<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<%	
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"+ request.getServerName() + ":" + request.getServerPort()+ path + "/";
%>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<link rel="stylesheet" type="text/css" href="../../css/main.css">
<link rel="stylesheet" type="text/css" href="../../css/easyui.css">
<link rel="stylesheet" type="text/css" href="../../css/icon.css">
<link rel="stylesheet" type="text/css" href="../../css/demo.css">
<script type="text/javascript" src="../../js/jquery.min.js"></script>
<script type="text/javascript" src="../../js/jquery.easyui.min.js"></script>
<script>var contextPath = "${pageContext.request.contextPath}";</script>

</head>

<body>
	<div style="margin: 20px 0;" align="center"></div>
	<form id="sysUserListForm" method="post">
		<table class="tableForm_L" style="margin-top:3px" width="99%" border="0" cellpadding="0" align="center" style="width: 80%; margin-bottom: 10px">
	        <tr>
	          	<th width="8%">账号</th>
	          	<td width="15%"><input class="easyui-text" name="userCode" style="width: 150px; margin-right: 50px;"></td>
				</td>
				<th width="8%">用户名</th>
	          	<td width="15%"><input class="easyui-text" name="userName" style="width: 150px; margin-right: 50px;"></td>
				</td>
				<td width="40%"><a href="#" class="easyui-linkbutton" iconCls="icon-search" style="margin-left: 30px" plain="true" onclick="searchResult()">搜索</a></td>
	        </tr>
	    </table>
	</form>
	 
	<table id="dg" style="width: 100%; height: 345px" toolbar="#toolbar">
		
	</table>
	
	<div id="toolbar">
		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="initPwd()">初始密码</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="viweSysUser()">详情</a>
	    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="newSysUser()">新增</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="editSysUser()">编辑</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="relevanceSysUser()">分配权限</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="destroySysUser()">删除</a>
    </div>
	
	<div id="dlg" class="easyui-dialog" style="width:500px;height:250px;padding:10px 20px" closed="true" buttons="#dlg-buttons">
        <div class="ftitle">用户信息</div>
       	<form id="fm" method="post" novalidate>
	       	<table>
	       		<tr>
					<td>角色名</td>
					<td><input name="userCode" class="easyui-textbox" /></td>
				</tr>
				<tr>
					<td>角色KEY</td>
					<td><input name="userName" class="easyui-textbox" /></td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<!-- 隐藏域 -->
						<input name="id" type="hidden"/>
						<a href="#" class="easyui-linkbutton" onclick="saveSysUser()" iconcls="icon-save">保存</a> 
						<a href="#" class="easyui-linkbutton" onclick="javascript:$('#dlg').window('close')" iconcls="icon-cancel">取消</a>
					</td>
				</tr>
	       	</table>
        </form>
    </div>
    
    <div id="relevance" class="easyui-dialog" style="width:500px;height:250px;padding:10px 20px" closed="true" buttons="#dlg-buttons">
        <div class="ftitle">用户信息</div>
       	<form id="fm1" method="post" novalidate>
	       	<table>
	       		<tr>
					<td colspan="2" align="center">
						<!-- 隐藏域 -->
						<input name="SysUserid" type="hidden"/>
						<a href="#" class="easyui-linkbutton" onclick="saveSysUser1()" iconcls="icon-save">保存</a> 
						<a href="#" class="easyui-linkbutton" onclick="javascript:$('#dlg').window('close')" iconcls="icon-cancel">取消</a>
					</td>
				</tr>
	       		<tr>
					<td>角色名</td>
					<td>${SysUser_key }</td>
				</tr>
				<tr>
					<td>角色KEY</td>
					<td>${SysUser_key }</td>
				</tr>
				
	       	</table>
        </form>
    </div>
    
	<script type="text/javascript">
		$(function(){
			$dg = $('#dg');
			$dg.datagrid({
				title: "用户信息列表",
        		url: contextPath+"/admin/user/listSysUser.do",
				pagination : true,
        		loadMsg:'加载中请稍后...',
        		queryParams: form2Json("sysUserListForm"), // 传查询条件
		//		onLoadSuccess : quality_kpi_grid_onLoadSuccess,
				columns : [[{
					field : 'id',
					checkbox : true
				},
				{
					title : '账号',
					field : 'userCode',
					width : '15%'
				}, {
					title : '用户名',
					field : 'userName',
					width : '15%'
				}, {
					title : '用户名',
					field : 'userName',
					width : '15%'
				}, {
					title : '创建时间',
					field : 'createTime',
					width : '15%'
				}, {
					title : '上次登录IP',
					field : 'lastLoginIp',
					width : '15%'
				}, {
					title : '上次登录时间',
					field : 'lastLoginTime',
					width : '15%'
				},{
					title : '状态',
					field : 'state',
					width : '10%',
					formatter : function(value,row,index){
						if (value == "0"){
							return '正常';
						}else{
							return '禁用';
						}
					}
				}
// 				,
// 				{
// 					title : '操作',
// 					width : 230,
// 					field : 'todo',
// 					formatter : function(value, rowData, rowIndex) {
// 						var returnDiv = $('<div></div>');
// 						$('<a href="#" onClick="newSysUser();">新增&nbsp;&nbsp;&nbsp;&nbsp;</a>').appendTo(returnDiv);
// 						$('<a href="#" plain="true" onClick="editSysUser();">编辑</a>').appendTo(returnDiv);
// 						return returnDiv.html();
// 					}
// 				}
				]]
				//toolbar : '#quality_kpi_datagrid_toolbar'
			});
			
			//设置分页控件
		    var p = $('#dg').datagrid('getPager');
		    p.pagination({
		        pageSize: 15,//每页显示的记录条数，默认为10
		        pageList: [10, 15, 20, 25, 30],//可以设置每页记录条数的列表
		        beforePageText: '第',//页数文本框前显示的汉字
		        afterPageText: '页    共 {pages} 页',
		        displayMsg: '当前显示 {from} - {to} 条记录   共 {total} 条记录'
		    });
		});
		
        var url_pattern;//访问路径
       	
       	function viweSysUser(){
        	var row = $('#dg').datagrid('getSelected');
        	$('#dlg').dialog('open').dialog('setTitle','编辑用户');
            $('#fm').form('load',row);
       	}
       	
       	function editSysUser(){
        	var row = $('#dg').datagrid('getSelected');
           	var rows = $('#dg').datagrid('getSelections');
           	if (rows.length == 1) {
           		$('#dlg').dialog('open').dialog('setTitle','编辑用户');
               	$('#fm').form('load',row);
                url_pattern = '<%=request.getContextPath()%>/admin/user/updateSysUser.do';
			} else if (rows.length > 1) {
				$.messager.alert('系统提示', '同一时间只能修改一条记录', 'error');
			} else {
				$.messager.alert('系统提示', '请勾选要修改的记录', 'error');
			}
       	}
       	
       	function relevanceSysUser(){
        	var row = $('#dg').datagrid('getSelected');
           	var rows = $('#dg').datagrid('getSelections');
           	if (rows.length == 1) {
           		$('#relevance').dialog('open').dialog('setTitle','编辑场景');
               	$('#fm').form('load',row);
                url_pattern = '<%=request.getContextPath()%>/admin/user/updateSysUser.do';
			} else if (rows.length > 1) {
				$.messager.alert('系统提示', '同一时间只能修改一条记录', 'error');
			} else {
				$.messager.alert('系统提示', '请勾选要修改的记录', 'error');
			}
       	}
       	
        function newSysUser(){
            $('#dlg').dialog('open').dialog('setTitle','新建用户');
         	$('#fm').form('clear');
            url_pattern = '<%=request.getContextPath()%>/admin/SysUser/insertSysUser.do';
        }
        
        function saveSysUser1(){
            url_pattern = '<%=request.getContextPath()%>/admin/SysUser/insertSysUser1.do';
        }
        
        function saveSysUser(){
             $('#fm').form('submit',{
                url: url_pattern,
               	onSubmit: function(){
                    return $(this).form('validate');
               	},
                success: function(result){
                    $('#dlg').dialog('close');// 关闭dialog
                    $('#dg').datagrid('reload');// 刷新
               	}
            });
       	}
       	
        function destroySysUser(){
        	var row = $('#dg').datagrid('getSelected');
            var rows = $('#dg').datagrid('getSelections');
            if (rows.length == 1) {
           		$.messager.confirm('删除','确定要删除这个用户么？',function(r){  
                    if (r){  
                       $.post('<%=request.getContextPath()%>/admin/SysUser/deleteSysUser.do',{SysUserId:row.SysUserid},function(result){
                            $('#dg').datagrid('reload');
                        },'json');
                   }
                   $('#dg').datagrid('reload');
               });
			} else if (rows.length > 1) {
				$.messager.alert('系统提示', '同一时间只能删除一条记录', 'error');
			} else {
				$.messager.alert('系统提示', '请勾选要删除的记录', 'error');
			}
        }
		
	    //搜索方法 
		function searchResult() {
	   		$('#dg').datagrid({ queryParams: form2Json("sysUserListForm") });
	   		//设置分页控件
		    var p = $('#dg').datagrid('getPager');
		    p.pagination({
		        pageSize: 15,//每页显示的记录条数，默认为10
		        pageList: [10, 15, 20, 25, 30],//可以设置每页记录条数的列表
		        beforePageText: '第',//页数文本框前显示的汉字
		        afterPageText: '页    共 {pages} 页',
		        displayMsg: '当前显示 {from} - {to} 条记录   共 {total} 条记录'
		    });
		}
		
		//将表单数据转为json 
    	function form2Json(id) {
        	var arr = $("#" + id).serializeArray()
        	var jsonStr = "";
        	jsonStr += '{';
        	for (var i = 0; i < arr.length; i++) {
            	jsonStr += '"' + arr[i].name + '":"' + arr[i].value + '",'
        	}
        	jsonStr = jsonStr.substring(0, (jsonStr.length - 1));
        	jsonStr += '}'
        	var json = JSON.parse(jsonStr)
        	return json
    	}
		
	</script>
</body>
</html>
