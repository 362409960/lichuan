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
		 
		</div>			   		
	</div>
	<div id="right_font">
	  	<img src="../../images/main_14.gif"/> 您现在所在的位置：首页 → 商品管理 → 
	  	<span class="bfont">商品品牌</span>
	</div>
	<div style="margin:20px 0;" align="center"></div>
	<form id="merchandiseBrandListForm" method="post">
		<table class="tableForm_L" style="margin-top:3px" width="99%" border="0" cellpadding="0" align="center" style="width: 80%; margin-bottom: 10px">
	        <tr>
				<div id="tb" align="center" style="width:80%; margin-bottom:10px; margin-left:100px;">
	                                 品牌名称：<input class="easyui-text" name="name" style="width: 130px; margin-right: 30px;">
	       <a href="#" class="easyui-linkbutton" iconCls="icon-search" style="margin-left:30px" onclick="searchResult()">查 询</a>
	       </div>
	        </tr>
	    </table>
	</form>

	<table id="dg" style="width: 100%; height: 600px" toolbar="#toolbar">		
	</table>
	
	<div id="toolbar">
	    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="newScene()">新建</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="editScene()">编辑</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="destroyScene()">删除</a>
        <!-- <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="relevanceScene()">关联</a> -->
    </div>
    
	<div id="dlg" class="easyui-dialog" style="width:600;height:400px;padding:10px 20px" closed="true" buttons="#dlg-buttons">
        <div class="ftitle">商品品牌</div>
       	<form id="fm" method="post"  enctype="multipart/form-data" novalidate>
	       	<table style="line-height: 35px;">
	       		<tr>
					<td>品牌名称</td>
					<td><input name="name" class="easyui-textbox"  size="30"/></td>
				</tr>
				 <tr>
					<td>品牌LOGO</td>					
					<td><input type="file" name="logoPhoto" class="" size="30" /></td>
				</tr> 
				<tr>
					<td>公司的网站地址</td>
					<td><input name="url" class="easyui-textbox" size="60" /></td>
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
				title: "商品品牌列表",
        		url: contextPath+"/admin/brand/listMerchandisebrand.do",
				pagination : true,
				pageSize: 15,//每页显示的记录条数，默认为10
		        pageList: [10, 15, 20, 25, 30],//可以设置每页记录条数的列表
        		loadMsg:'加载中请稍后...',
        		queryParams: form2Json("merchandiseBrandListForm"), // 传查询条件
				columns : [[{
					field : 'id',
					checkbox : true
				},
				{
					title : '品牌名称',
					field : 'name',
					width : '20%'
				}, 
				{
					title : '品牌LOGO',
					field : 'logo',
					width : '20%',
					formatter:function(value,row,index){return '<img src="'+row.logo+'" width="40" height="40" />';}
				},
				{
					title : '公司的网站地址',
					field : 'url',
					width : '20%'
				},
				{
					title : '创建时间',
					width : '20%',
					field : 'create_time',					
					formatter:function(value,row,index){  
                         var showTime = new Date(value);  
                         return showTime.toLocaleString();  
                         }  
				},
				{
					title : '创建人',
					field : 'create_user',
					width : '20%'
				},
				{
					title : '修改时间',
					field : 'update_time',
					width : '20%',
					formatter:function(value,row,index){  
                         var showTime = new Date(value);  
                         return showTime.toLocaleString();  
                         }  
				},
				
				{
					title : '修改人',
					field : 'update_user',
					width : '20%'
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
           	       var id=row.id;      		
                url_pattern = '<%=request.getContextPath()%>/admin/brand/editMerchandiseBrand.do?id='+id; 
                var name='编辑界面';                            //网页名称，可为空; 
	           var iWidth=720;                          //弹出窗口的宽度; 
	           var iHeight=600;                         //弹出窗口的高度; 
	           //获得窗口的垂直位置 
	           var iTop = (window.screen.availHeight - 30 - iHeight) / 2; 
	           //获得窗口的水平位置 
	           var iLeft = (window.screen.availWidth - 10 - iWidth) / 2; 
	           window.open(url_pattern, name, 'height=' + iHeight + ',,innerHeight=' + iHeight + ',width=' + iWidth + ',innerWidth=' + iWidth + ',top=' + iTop + ',left=' + iLeft + ',status=no,toolbar=no,menubar=no,location=no,resizable=no,scrollbars=0,titlebar=no');
         
			} else if (rows.length > 1) {
				$.messager.alert('系统提示', '同一时间只能修改一条记录', 'error');
			} else {
				$.messager.alert('系统提示', '请勾选要修改的记录', 'error');
			}
       	}
       	
        function newScene(){           
           url_pattern='<%=request.getContextPath()%>/admin/brand/addMerchandiseBrand.do';
            var name='新增界面';                            //网页名称，可为空; 
           var iWidth=720;                          //弹出窗口的宽度; 
           var iHeight=600;                         //弹出窗口的高度; 
           //获得窗口的垂直位置 
           var iTop = (window.screen.availHeight - 30 - iHeight) / 2; 
           //获得窗口的水平位置 
           var iLeft = (window.screen.availWidth - 10 - iWidth) / 2; 
           window.open(url_pattern, name, 'height=' + iHeight + ',,innerHeight=' + iHeight + ',width=' + iWidth + ',innerWidth=' + iWidth + ',top=' + iTop + ',left=' + iLeft + ',status=no,toolbar=no,menubar=no,location=no,resizable=no,scrollbars=0,titlebar=no');
            
        }
        
       /*  function saveScene(){     
             $('#fm').form('submit',{
                url: contextPath+"/admin/brand/insertMerchandiseBrand.do",
               	onSubmit: function(){
                    return $(this).form('validate');
               	},              
                success: function(result){                         
                    $('#dlg').dialog('close');// 关闭dialog
                    $('#dg').datagrid('reload');// 刷新
               	}
            });
       	} */
       	
        function destroyScene(){
        	var row = $('#dg').datagrid('getSelected');
            var rows = $('#dg').datagrid('getSelections');
            if (rows.length == 1) {
           		$.messager.confirm('删除','确定要删除？',function(r){  
                    if (r){  
                       $.post('<%=request.getContextPath()%>/admin/brand/deleteMerchandiseBrand.do',{id:row.id},function(result){
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
	   		$('#dg').datagrid({ queryParams: form2Json("merchandiseBrandListForm") });
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
