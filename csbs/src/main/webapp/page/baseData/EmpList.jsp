<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="/WEB-INF/tlds/c.tld" prefix="c"%>
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
  <img src="../../images/main_14.gif"/> 您现在所在的位置：首页 → 基础数据 → 
  <span class="bfont">员工管理</span>
</div>
<div style="margin:20px 0;" align="center"></div>
  <div id="tb" align="center" style="width:80%; margin-bottom:10px; margin-left:100px;">
    部门名称：<input class="easyui-text" style="width:130px; margin-right:30px;">
    上级部门：<input class="easyui-text" style="width:130px; margin-right:30px;">
    姓名：<input class="easyui-text" style="width:130px; margin-right:30px;">
    性别：<input type="radio" class="easyui-radio" value="0" name="sex" checked>男
         <input type="radio" class="easyui-radio" value="1" name="sex">女
    <a href="#" class="easyui-linkbutton" iconCls="icon-search" style="margin-left:30px">Search</a>
  </div>
    <!-- 
        1.rownumbers属性为true，会带有行号，该行号和数据库中的字段id无关 
        2.singleSelect属性为TRUE，则一次只能选中一行
        3.pagination属性为true，则会在底部自动显示分页工具栏
        4.url属性为读取的数据集地址，这里采用了json文件
        5.method属性为页面取值的方法
        6.idField属性定有了作为序号的字段（可以指定为任意字段），该字段的值会表示在复选框一列
    -->
	<table id="dg" title="员工信息列表" style="width:100%;height:345px"
           data-options="rownumbers:false,singleSelect:false,pagination:true,url:'datagrid_data2.json',method:'post',idField:'id'">
		<thead>
			<tr>
				<th data-options="field:'ck',width:30" checkbox="true"></th>
                <!-- 
                    宽度使用$(this).width()*0.2意思是使用当前表格的宽度的20%
                    当数据包含中文或其他文字时，读取时如果有乱码，可以用记事本打开json文件，并将其另存为编码是utf8格式的文件
                    如果是程序生成的文件，则需要在生成文件时注意编码格式
                    分页功能的实现请根据对应的语言环境实现
   				-->
                <th data-options="field:'id',width:$(this).width()*0.08,align:'center'">员工编号</th>
				<th data-options="field:'EmpNum',width:$(this).width()*0.08,align:'center'">工号</th>
				<th data-options="field:'Name',width:$(this).width()*0.08,align:'center'">姓名</th>
                <th data-options="field:'Status',width:$(this).width()*0.08,align:'center',formatter:sexFormat">性别</th>
                <th data-options="field:'IDCard',width:$(this).width()*0.13,align:'center'">身份证号</th>
                <th data-options="field:'InDate',width:$(this).width()*0.13,align:'center'">入职时间</th>
                <th data-options="field:'SortCode',width:$(this).width()*0.08,align:'center'">排序号</th>
                <th data-options="field:'SysDeptID',width:$(this).width()*0.1,align:'center',formatter:deptFormat">部门编号</th>
                <th data-options="field:'do',width:$(this).width()*0.19,align:'center',formatter:doFormat">操作</th>
			</tr>
		</thead>
	</table>
	<script type="text/javascript">
		//  对性别进行判断，0为男，1为女
		function sexFormat(value,row,index){
			if(value==1){
				return "女";
			}else{
				return "男";
			}
		}
	    //  对上级部门属性进行判断，程序中应将对应的数据用链接查询的方式查询并显示
		function deptFormat(value,row,index){
			if(value==1){
				return "总经理室";
			}else if(value==3){
				return "开发部";
			}else{
				return "";
			}
		}
		// 创建3个超链接放入到“操作”这一列
		function doFormat(value,row,index){
			return "<a href=?value='"+row.id+"' class='do' id='view'>查看</a> "+
			       "<a href=?value='"+row.id+"' class='do' id='edit'>修改</a> "+
			       "<a href=?value='"+row.id+"' class='do' id='delete'>删除</a>";
		}
		$(function(){
			var pager = $('#dg').datagrid().datagrid('getPager');	// 得到json中的数据		
			pager.pagination({
				//每页显示的记录条数，默认为10
				pageSize: 10,  
				//可以设置每页记录条数的列表
        		pageList: [5,10,15],  
				//页数文本框前显示的汉字  
        		beforePageText: '第',
				// 总页数汉字
        		afterPageText: '页    共 {pages} 页',  
				// 重写总页数显示内容
				displayMsg:"当前显示 {from} 到 {to} 条数据 共有 {total} 条数据",
				// 改方法为点击刷新按钮时触发
				onRefresh:function(){
					alert("点击了刷新按钮");
				},
				// 以下代码创建了分页工具栏中的查看、添加、编辑按钮，暂不使用
				//buttons:[{
//					iconCls:'icon-search',
//					handler:function(){
//						// 获得选中行的内容
//						var ids= $('#dg').datagrid('getSelections');
//						for(var i=0;i<ids.length;i++){
//							alert(ids[i].id);
//						}		
//					}
//				},{
//					iconCls:'icon-add',
//					handler:function(){
//						alert('add');
//					}
//				},{
//					iconCls:'icon-edit',
//					handler:function(){
//						alert('edit');
//					}
//				}]
			});			
		})
	</script>
</body>
</html>
