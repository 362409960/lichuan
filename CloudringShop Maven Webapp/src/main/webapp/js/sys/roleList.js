$(function(){
	//请空查询条件
	$("#searchRole").val("");
	//绑定查询按钮点击事件
	$("#search").click(function(){
		var params = $("#searchForm").serialize();
		var page = $('.pagination-page-list').val();
		params = params + "&page=1&rows=" + page;//加上页码
		$.ajax({
			url: 'role_findPageByRole.action',
			async:false,
			dataType:'json',
			data: params,
			type:'POST',
			success:function(obj){
				$('#dg').datagrid('loadData',obj);
			}
		});
	});
	//初始化table --dg
	$("#dg").datagrid({
		title : '当前查询角色信息',
		width: 'auto',
		height: '345px',
		pageSize : 10,
		fitColumns : true,
		pagination : true,
		rownumbers : true,
		striped:true,
		url : 'role_findPageByRole.action',
		frozenColumns : [ [ {
			field : 'id',
			checkbox : true
		} ] ],
		columns : [ [ {
			field : 'roleName',
			title : "角色名",
			width : 150,
			align : 'center'
		}]]
	});
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
				buttons:[{
					iconCls:'icon-search',
					text:"查看",
					handler:function(){
					}
				},{
					iconCls:'icon-add',
					text:"新增",
					handler:function(){
						$("#viewWindow").css({display:"block"});
						$("#id").val("");
						$("#form")[0].reset();//清空表单
						$('#viewWindow').dialog({
							 title:"添加角色",
							 width:"302px",
							 height:"150px",
							 modal:true,
							 shadow:true,
							 buttons:[{
								text:'保存',
								iconCls:'icon-ok',
								handler:function(){
									var params = $("#form").serialize();
									if (!$("#form").form("validate")) {
										return;
									}
									
									$.ajax( {
										url : 'role_saveRole.action',
										data : params,
										dataType : 'json',
										async : false,
										cache : false,
										type : 'POST',
										error : function(textStatus, errorThrown) {
											showAlert("系统ajax交互错误: " + textStatus);
										},
										success : function(data) {
											if(data.msg == "1"){
												$.messager.alert('错误','角色重复!请重新输入!','error');
											}else if(data.result){
												$('#dg').datagrid('reload');
												$.messager.alert('提示','用户添加操作成功!','info');
												$('#viewWindow').dialog("close");
											}
										}
									});
								}
							}, {
								text:'取消',
								iconCls:'icon-cancel',
								handler:function(){
									$('#viewWindow').dialog("close");
									$('#viewWindow').css({display:"none"});
								}
							}]
						 });
					}
				},{
					iconCls:'icon-edit',
					text:"修改",
					handler:function(){
						var selected = $('#dg').datagrid('getSelections');
						if (selected.length == 0) {
							$.messager.alert('提示','请选中要被编辑的一行记录.','info');
							return;
						}
						if (selected.length > 1) {
							$.messager.alert('提示','只能选中一行进行编辑.','info');
							return;
						}
						$("#viewWindow").css({display:"block"});
						$("#form")[0].reset();//清空表单
						$.ajax( {
							url : "role_findRoleById?id=" + selected[0].id,
							dataType : "json",
							async : false,
							cache : false,
							type : "POST",
							success : function(data) {
								if(data.result){
									$('#form').form('load',data.data);
								}else{
									$.messager.alert('错误','查询角色出错!','error');
								}
								
							}
						});
						$('#viewWindow').dialog({
							 title:"修改角色",
							 width:"302px",
							 height:"150px",
							 modal:true,
							 shadow:true,
							 buttons:[{
								text:'保存',
								iconCls:'icon-ok',
								handler:function(){
									var params = $("#form").serialize();
									if (!$("#form").form("validate")) {
										return;
									}
									
									$.ajax( {
										url : 'role_updateRole.action',
										data : params,
										dataType : 'json',
										async : false,
										cache : false,
										type : 'POST',
										error : function(textStatus, errorThrown) {
											showAlert("系统ajax交互错误: " + textStatus);
										},
										success : function(data) {
											if(data.msg == "1"){
												$.messager.alert('错误','角色重复!请重新输入!','error');
											}else if(data.result){
												$('#dg').datagrid('reload');
												$.messager.alert('提示','用户添加操作成功!','info');
												$('#viewWindow').dialog("close");
											}
										}
									});
								}
							}, {
								text:'取消',
								iconCls:'icon-cancel',
								handler:function(){
									$('#viewWindow').dialog("close");
									$('#viewWindow').css({display:"none"});
								}
							}]
						 });
					}
				},
				{
					iconCls:'icon-remove',
					text:"删除",
					handler:function(){
						var selected = $('#dg').datagrid('getSelections');
						if (selected.length == 0) {
							$.messager.alert('提示','请至少选中一行要被删除的记录.','info');
							return;
						}else{
							var ids = "";
							for(var i=0;i<selected.length;i++){
								ids += selected[i].id + ",";
							}
							$.messager.confirm("确认","确定删除？",function(){
								$.ajax( {
									url : "role_deleteRole",
									dataType : "json",
									data : {"ids":ids},
									async : false,
									cache : false,
									type : "POST",
									success : function(data) {
										if(data.result){
											$.messager.alert('提示','删除成功!','info');
											$('#dg').datagrid('reload');
										}else{
											$.messager.alert('提示','删除出错!','info');
										}
									}
								});
							});
						}
						}
				}]
			});			
		})