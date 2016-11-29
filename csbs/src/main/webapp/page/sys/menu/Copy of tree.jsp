<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<% 
    String path = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>菜单树</title> 
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<jsp:include page="/inc/common.jsp" />

<script type="text/javascript">
	$(document).ready(function() {
		$.ajaxSetup({cache:false}); //ajax信息不缓存
		 $("#menuTree").tree({
			 data:{
				 type : "json", //类型为json
	             async : true, //动态加载data
	             opts : {
	                 async : true, //动态操作
	                 method : "GET",
	                 url : "<%=path%>/treeBuild.do"
	             }
			 },
			 
			 lang : {
		         loading : "目录加载中……" //在用户等待数据渲染的时候给出的提示内容，默认为loading   
		     },
		     
		     ui : {
		    	 theme_name : 'classic' //设置皮肤样式
		     },

		     callback :{
		    	 
		     }
			 
		 });
		
	});
	
	
	function nodeClick(nodeId, nodeParentId, nodeName) {
		jQuery.ajax({
			url:"viewMenu.action?rand=Math.random()*20",
	        type:"post",
	        cache:false,
	        async: false,
	        dataType:"json",
	        data:{"stMenu.id":nodeId},
	        
	        success:function(jsonData, textStatus) {
	        	jsonData = jQuery.evalJSON(jsonData);
	        	clearMenuInfo();
	        	
	        	// 填充菜单基本信息
	        	if(jsonData.name==""){
	        		$("#name").html("　"); 
	        	}else{
	        		 $("#name").html(jsonData.name);
	        	}
	        	if(jsonData.name==""){
	        		$("#parentName").html("　"); 
	        	}else{
	        		 $("#parentName").html(jsonData.parentName);
	        	}
	        	if(jsonData.url==""){
	        		$("#url").html("　"); 
	        	}else{
	        		 $("#url").html(jsonData.url);
	        	}
	        	if(jsonData.menuImgUrl==""){
	        		$("#menuImgUrl").html("　"); 
	        	}else{
	        		 $("#menuImgUrl").html("<img src='<%=path%>/"+jsonData.menuImgUrl+"'/>");
	        	}
	        	if(jsonData.note==""){
	        		$("#note").html("　"); 
	        	}else{
	        		 $("#note").html(jsonData.note);
	        	}
	        	
                $("#id").val(jsonData.id);
                $("#pid").val(jsonData.pid);     
	        },
            error:function(XMLHttpRequest, textStatus, errorThrown) {
                alert("查询菜单信息时出现异常！");
            }
			
		});
	}
	
	function deleteMenu(){
		var tree_id = $("#id").val();
		if(!tree_id || tree_id == "0"){
        	alert("未选择菜单。");
        	return;
        }
		
		var parent_id = $("#pid").val();

        // 要删除的节点ID，包括递归的子节点
        var pks = tree_id;
        jQuery.each($("#"+tree_id).find("li"), function(i, item) {
            pks = pks + "," + $(item).attr("id");
        });

        if(confirm("你确定要删除菜单[ " + $("#name").html() + " ]，以及下面的所有子菜单吗？")){
            jQuery.ajax({
                url:"deleteMenu.action",
                data:{"stMenu.id":pks},
                cache:false,
                dataType:"json",
                success:function(jsonData, textStatus) {
                	jsonData = jQuery.evalJSON(jsonData);
                    alert(jsonData.message);
                    // 刷新树
			        jQuery.tree.focused().refresh();
			        // 刷新详细信息
                    if(parent_id == "0"){
						clearMenuInfo();
					}
					else{
			            nodeClick(parent_id,"","");
		            }
                },
                error:function(XMLHttpRequest, textStatus, errorThrown) {
                    alert("操作失败！");
                }
            });
        }
    }
	
	
    // 清空菜单信息
    function clearMenuInfo(){
        $("#name").html("　");
        $("#parentName").html("　");
        $("#url").html("　");

        $("#note").html("　");
        $("#menuImgUrl").html("　");

        $("#id").val("0");
        $("#pid").val("");
    }
	
    function editMenu(){
    	var tree_id = $("#id").val();
    	
    	if(tree_id && tree_id != "0"){
    		var tree_parent_id = $("#pid").val();
        	openDialog("修改菜单", "<%=path%>/preUpdateMenu.do?stMenu.id=" + tree_id+"&stMenu.pid=" + tree_parent_id, 700, 400, onRenameCallback);
        }
        else{
        	alert("未选择菜单。");
        }
    }
    // 修改节点的回调函数
    function onRenameCallback(nodeId, nodeName) {
        // 刷新树
        jQuery.tree.focused().refresh();
        nodeClick(nodeId,"","");
    }
    
    function addChildMenu(){
    	var tree_parent_id = $("#id").val();
    	if(!tree_parent_id) tree_parent_id="0";
        openDialog("增加子菜单", "preInsertMenu.do?stMenu.pid=" + tree_parent_id, 700, 400, onCreateCallback);
    }
    // 新增节点的回调函数
    function onCreateCallback(nodeId, nodeName) {
        // 刷新树
        jQuery.tree.focused().refresh();
        nodeClick(nodeId,"","");
    }
    
    function addMenu(){
    	var tree_parent_id = $("#pid").val();
    	if(tree_parent_id){
        	openDialog("增加同级菜单", "preInsertMenu.do?stMenu.pid=" + tree_parent_id, 700, 400, onCreateCallback);
        }
        else{
        	alert("未选择菜单。");
        }
    }
    
    
</script>
</head>

<body onresize="setLayout()">
<div class="sme_mainrm">
<form id="frm" name="frm" method="post" >
    <input type="hidden" id="id" name="stMenu.id" value="${stMenu.id}" />
    <input type="hidden" id="pid" name="stMenu.pid" value="${stMenu.pid}" />
  <div class="sme_newlist">
    <table  border="0" cellpadding="0" cellspacing="0" style="width:100%;">
        <tr>
            <td valign="top" width="200px" >
                <!-- 菜单树-->
                <div id="menuTree" style="width:200px;height:90%;overflow:auto;border:#d0d0d0 solid 1px;"></div>
            </td>
            <td valign="top">
                     <div class="titlehead">&nbsp;&nbsp;菜单基本信息和操作按钮</div>

                    <div label="基本信息">
  						<div class="listinfo2">
                    		<div class="tablelist">
                        		<table border="0" cellpadding="0" cellspacing="0"  style="width:100%;table-layout:fixed;">
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

                          			<thead>
							     		<tr>
							      			<th width="17%" scope="row">显示图片</th>
							      			<td width="83%" id="menuImgUrl"></td>
							    		</tr>
							   		</thead>
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
                    
                
        		 <table  align="center"  >
        				<tr>
                            <td><div class="generalbtt"><a id="generaltse"; href="javascript:addMenu();" >增加同级菜单</a></div></td>
                            <td><div class="generalbtt"><a id="generaltse"; href="javascript:addChildMenu(0)" >增加子菜单</a></div></td>
                           <td> <div class="generalbtt"><a id="generaltse"; href="javascript:editMenu(0)" >修改菜单</a></div></td>
                           <td> <div class="generalbtt"><a id="generaltse"; href="javascript:deleteMenu(0)" >删除菜单</a></div></td>
                   		</tr>
                 </table>
            </td>
        </tr>
    </table>
     </div>
</form>
</div>
<jsp:include page="/inc/dialog.jsp" />
</body>
 
<script type="text/javascript">
clearMenuInfo();
</script>


</html>
