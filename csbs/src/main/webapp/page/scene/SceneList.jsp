<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="/WEB-INF/tlds/c.tld" prefix="c"%>
<%	
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"+ request.getServerName() + ":" + request.getServerPort()+ path + "/";
%>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
	<link rel="stylesheet" type="text/css" href="../../css/easyui.css">
	<link rel="stylesheet" type="text/css" href="../../css/icon.css">
	<link rel="stylesheet" type="text/css" href="../../css/demo.css">
	<script type="text/javascript" src="../../js/jquery.min.js"></script>
	<script type="text/javascript" src="../../js/jquery.easyui.min.js"></script>
	<link href="../../css/main.css" rel="stylesheet" type="text/css" />
</head>

<body>
	<div id="right_top">
	  	<div id="loginout">
		    <div id="loginoutimg"><img src="../../images/loginout.gif" /></div>
		    <span class="logintext">退出系统</span>	 
		</div>			   		
	</div>
	<div id="right_font">
	  	<img src="../../images/main_14.gif"/> 您现在所在的位置：首页 → 场景管理 → 
	  	<span class="bfont">场景管理</span>
	</div>
	<div style="margin:20px 0;" align="center"></div>
	<form id="sceneListForm" method="post">
		<table class="tableForm_L" style="margin-top:3px" width="99%" border="0" cellpadding="0" align="center" style="width: 80%; margin-bottom: 10px">
	        <tr>
	          	<th width="5%">场景名称：</th>
	          	<td width="15%"><input class="easyui-text" name="sceneName" style="width: 150px; margin-right: 50px;"></td>
				<td width="60%"><a href="#" class="easyui-linkbutton" iconCls="icon-search" style="margin-left: 30px" plain="true" onclick="searchResult()">搜索</a></td>
	        </tr>
	    </table>
	</form>

	<table id="dg" style="width: 100%; height: 345px" toolbar="#toolbar">
		
	</table>
	
	<table id="dg1" class="easyui-dialog" style="width: 80%; height: 345px;" closed="true">
		
	</table>
	
	<div id="toolbar">
	    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="newScene()">新建</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="editScene()">编辑</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="destroyScene()">删除</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="relevanceScene()">关联</a>
    </div>
    
	<div id="dlg" class="easyui-dialog" style="width:400px;height:280px;padding:10px 20px" closed="true" buttons="#dlg-buttons">
        <div class="ftitle">用户信息</div>
       	<form id="fm" method="post" novalidate>
	       	<table style="line-height: 35px;">
	       		<tr>
					<td>场景名称</td>
					<td><input name="sceneName" class="easyui-textbox" /></td>
				</tr>
				<tr>
					<td>背景</td>
					<td><input name="background" class="easyui-textbox" /></td>
				</tr>
				<tr>
					<td>控制码</td>
					<td><input name="orders" class="easyui-textbox" /></td>
				</tr>
				<tr>
					<td>点击率</td>
					<td><input name="clickRate" class="easyui-textbox" /></td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<!-- 隐藏域 -->
						<input name="id" type="hidden"/>
						<a href="#" style="width: 60px;line-height: 0px;" class="easyui-linkbutton" onclick="saveScene()" iconcls="icon-save">保存</a>&nbsp;&nbsp;&nbsp; 
						<a href="#" style="width: 60px;line-height: 0px;" class="easyui-linkbutton" onclick="javascript:$('#dlg').window('close')" iconcls="icon-cancel">取消</a>
					</td>
				</tr>
	       	</table>
        </form>
    </div>
	
	<script type="text/javascript">
		var contextPath = "${pageContext.request.contextPath}";
		$(function(){
			$dg = $('#dg').datagrid({
				title: "模块信息列表",
        		url: contextPath+"/scene/sceneList",
				pagination : true,
        		loadMsg:'加载中请稍后...',
        		queryParams: form2Json("sceneListForm"), // 传查询条件
				columns : [[{
					field : 'id',
					checkbox : true
				},
				{
					title : '用户名',
					field : 'userId',
					width : 200
				}, {
					title : '场景名称',
					field : 'sceneName',
					width : 200
				},
				{
					title : '背景',
					field : 'background',
					width : 200
				},
				{
					title : '控制码',
					field : 'orders',
					width : 200
				},
				{
					title : '点击率',
					field : 'clickRate',
					width : 200
				},
				{
					title : '操作',
					width : 70,
					field : 'todo',
					formatter : function(value, rowData, rowIndex) {
						return "<a href='javascript:void(0)' onclick='dataView(" + rowData.id + ")'>关联</a>";
					}
					
					//title : '操作',
					//width : 130,
					//field : 'todo',
					//formatter : function(value, rowData, rowIndex) {
						//var returnDiv = $('<div></div>');
						//$('<a href="#"  class="btn-role-mod" onClick="editNotice(' + rowData.id + ');">修改</a>').appendTo(returnDiv);
						//$('<a href="#" class="btn-role-del" onClick="dellNotice(' + rowData.id + ');">删除</a>').appendTo(returnDiv);
						//return returnDiv.html();
					//}
				}
				]]
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
		
		function dataView(id){
			alert(id);
		}
		
        var url_pattern;//访问路径
        function editScene(){
        	var row = $('#dg').datagrid('getSelected');
           	var rows = $('#dg').datagrid('getSelections');
           	if (rows.length == 1) {
           		$('#dlg').dialog('open').dialog('setTitle','编辑场景');
               	$('#fm').form('load',row);
                url_pattern = '<%=request.getContextPath()%>/scene/updScene.do';
			} else if (rows.length > 1) {
				$.messager.alert('系统提示', '同一时间只能修改一条记录', 'error');
			} else {
				$.messager.alert('系统提示', '请勾选要修改的记录', 'error');
			}
       	}
       	
        function newScene(){
            $('#dlg').dialog('open').dialog('setTitle','新建场景');
         	$('#fm').form('clear');
            url_pattern = '<%=request.getContextPath()%>/scene/insertScene.do';
        }
        
        function saveScene(){
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
       	
        function destroyScene(){
        	var row = $('#dg').datagrid('getSelected');
            var rows = $('#dg').datagrid('getSelections');
            if (rows.length == 1) {
           		$.messager.confirm('删除','确定要删除？',function(r){  
                    if (r){  
                       $.post('<%=request.getContextPath()%>/scene/delScene.do',{id:row.id},function(result){
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
        
        function relevanceScene(){
        	var row = $('#dg').datagrid('getSelected');
           	var rows = $('#dg').datagrid('getSelections');
           	if (rows.length == 1) {
               	$dg = $('#dg1').datagrid({
					title: "模块信息列表",
	        		url: contextPath+"/scene/sceneList",
					pagination : true,
	        		loadMsg:'加载中请稍后...',
	        		queryParams: form2Json("sceneListForm"), // 传查询条件
					columns : [[{
						field : 'id',
						checkbox : true
					},
					{
						title : '用户名',
						field : 'userId',
						width : 200
					}, {
						title : '场景名称',
						field : 'sceneName',
						width : 200
					},
					{
						title : '背景',
						field : 'background',
						width : 200
					},
					{
						title : '控制码',
						field : 'orders',
						width : 200
					},
					{
						title : '点击率',
						field : 'clickRate',
						width : 200
					}
					]]
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
			    $('#dg1').dialog('open').dialog('setTitle','场景内容列表');
			} else if (rows.length > 1) {
				$.messager.alert('系统提示', '同一时间只能选择一条记录', 'error');
			} else {
				$.messager.alert('系统提示', '请勾选要选择的记录', 'error');
			}
        	
        }
		
	    //搜索方法 
		function searchResult() {
	   		$('#dg').datagrid({ queryParams: form2Json("sceneListForm") });
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
