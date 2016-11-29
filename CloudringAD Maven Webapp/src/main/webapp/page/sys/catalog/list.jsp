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
<script type="text/javascript" src="../../js/datapicker/WdatePicker.js"></script>
<script>var contextPath = "${pageContext.request.contextPath}";</script>
</head>

<body>
	<div style="margin: 20px 0;" align="center"></div>
	<form id="catalogListForm" method="post">
		<table class="tableForm_L" style="margin-top:3px" width="99%" border="0" cellpadding="0" align="center" style="width: 80%; margin-bottom: 10px">
	        <tr>
	          	<th width="15%">字典分类代码</th>
	          	<td width="15%"><input class="easyui-text" name="pkid" style="width: 150px; margin-right: 50px;"></td>
				<th width="15%">字典分类名称</th>
	          	<td width="15%"><input class="easyui-text" name="catalogName" style="width: 150px; margin-right: 50px;"></td>
				<td width="40%"><a href="#" class="easyui-linkbutton" iconCls="icon-search" style="margin-left: 30px" plain="true" onclick="searchResult()">搜索</a></td>
	        </tr>
	    </table>
	</form>
	 
	<table id="dg" style="width: 100%; height: 345px" toolbar="#toolbar">
		
	</table>
	
	<div id="toolbar">
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="catalogDataMsg()">字典数据管理</a>
	    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="newCatalog()">新增</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="editCatalog()">编辑</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="destroyCatalog()">删除</a>
    </div>
	
	<div id="dlg" class="easyui-dialog" style="width:500px;height:350px;padding:10px 20px" closed="true" buttons="#dlg-buttons">
        <div class="ftitle">字典信息</div>
       	<form id="fm" method="post" novalidate>
	       	<table>
	       		<tr >
					<td>字典分类代码</td>
					<td><input name="pkid" class="pkid" class="easyui-textbox" style="width: 200px;" required="true" missingMessage="请输入字典分类代码" /></td>
				</tr>
				<tr>
					<td>字典分类名称</td>
					<td><input name="catalogName" class="easyui-textbox" style="width: 200px;" required="true" missingMessage="请输入字典分类名称" /></td>
				</tr>
				<tr>
					<td>备注</td>
					<td><textarea id="note" name="note" rows="4" cols="30" maxlength="50"></textarea></td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<!-- 隐藏域 -->
						<input type="hidden" id="id" name="id"/>
						<a href="#" id="saveBtn" class="easyui-linkbutton" onclick="saveCatalog()" iconcls="icon-save">保存</a> 
						<a href="#" class="easyui-linkbutton" onclick="javascript:$('#dlg').window('close')" iconcls="icon-cancel">取消</a>
					</td>
				</tr>
	       	</table>
        </form>
    </div>
    
	<script type="text/javascript">
		$(function(){
			$dg = $('#dg');
			$dg.datagrid({
				title: "字典信息列表",
        		url: contextPath+"/admin/catalog/listCatalog.do",
				pagination : true,
        		loadMsg:'加载中请稍后...',
        		queryParams: form2Json("catalogListForm"), // 传查询条件
		//		onLoadSuccess : quality_kpi_grid_onLoadSuccess,
				columns : [[{
					field : 'id',
					checkbox : true
				},
				{
					title : '字典分类代码',
					field : 'pkid',
					width : '30%'
				}, {
					title : '字典分类名称',
					field : 'catalogName',
					width : '30%'
				}, {
					title : '备注',
					field : 'note',
					width : '35%'
				}
// 				,
// 				{
// 					title : '操作',
// 					width : 230,
// 					field : 'todo',
// 					formatter : function(value, rowData, rowIndex) {
// 						var returnDiv = $('<div></div>');
// 						$('<a href="#" onClick="newCatalog();">新增&nbsp;&nbsp;&nbsp;&nbsp;</a>').appendTo(returnDiv);
// 						$('<a href="#" plain="true" onClick="editCatalog();">编辑</a>').appendTo(returnDiv);
// 						return returnDiv.html();
// 					}
// 				}
				]]
				//toolbar : '#quality_kpi_datagrid_toolbar'
			});
			
			//设置分页控件
		    var p = $('#dg').datagrid('getPager');
		    p.pagination({
		        pageSize: 10,//每页显示的记录条数，默认为10
		        pageList: [10, 15, 20, 25, 30],//可以设置每页记录条数的列表
		        beforePageText: '第',//页数文本框前显示的汉字
		        afterPageText: '页    共 {pages} 页',
		        displayMsg: '当前显示 {from} - {to} 条记录   共 {total} 条记录'
		    });
		});
		
        var url_pattern;//访问路径
        
        //新增
        function newCatalog(){
            $('#dlg').dialog('open').dialog('setTitle','新建字典');
         	$('#fm').form('clear');
         	$(".pkid").removeAttr("disabled");//去除disabled属性
            url_pattern = '<%=request.getContextPath()%>/admin/catalog/insertCatalog.do';
        }
       	
       	//修改
       	function editCatalog(){
        	var row = $('#dg').datagrid('getSelected');
           	var rows = $('#dg').datagrid('getSelections');
           	$("#id").val(row.pkid);
           	if (rows.length == 1) {
           		$('#dlg').dialog('open').dialog('setTitle','编辑字典');
               	$('#fm').form('load',row);
               	$(".pkid").attr("disabled","disabled");
                url_pattern = '<%=request.getContextPath()%>/admin/catalog/updateCatalog.do';
			} else if (rows.length > 1) {
				$.messager.alert('系统提示', '同一时间只能修改一条记录', 'error');
			} else {
				$.messager.alert('系统提示', '请勾选要修改的记录', 'error');
			}
       	}
       	
       	//字典数据管理
       	function catalogDataMsg(){
        	var row = $('#dg').datagrid('getSelected');
           	var rows = $('#dg').datagrid('getSelections');
           	if (rows.length == 1) {
                window.location.href = '<%=request.getContextPath()%>/admin/catalog/dictionaryData.do?pkid='+row.pkid;
			} else if (rows.length > 1) {
				$.messager.alert('系统提示', '同一时间只能查看一条记录', 'error');
			} else {
				$.messager.alert('系统提示', '请勾选要查看的记录', 'error');
			}
       	}
       	
        function saveCatalog(){
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
       	
        function destroyCatalog(){
        	var row = $('#dg').datagrid('getSelected');
            var rows = $('#dg').datagrid('getSelections');
            if (rows.length == 1) {
           		$.messager.confirm('删除','确定要删除？',function(r){
                    if (r){  
                       $.post('<%=request.getContextPath()%>/admin/catalog/deleteCatalog.do',{pkid:row.pkid},function(result){
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
	   		$('#dg').datagrid({ queryParams: form2Json("catalogListForm") });
	   		//设置分页控件
		    var p = $('#dg').datagrid('getPager');
		    p.pagination({
		        pageSize: 10,//每页显示的记录条数，默认为10
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
