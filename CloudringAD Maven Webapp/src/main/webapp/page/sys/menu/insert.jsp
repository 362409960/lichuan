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
<script type="text/javascript" src="<%=path%>/js/jquery.min.js"></script>
<script type="text/javascript" src="<%=path%>/js/jquery.easyui.min.js"></script>

<script type="text/javascript">
	//$("#menuImgUrlTd").html("<img src='<%=path%>/+"+menuImgUrl+"+/>");
	
	
	$(document).ready(function() {
		var imgUrl = "${stMenu.menuImgUrl}";
		var menuImgUrl = '<img src="<%=path%>/'+imgUrl+'"/>';
		if(imgUrl!=''){
			$("#menuImgUrlTd").html(menuImgUrl);
		}
		
 	});

	
	function save(){
		var name = $("#name").val();
	    var url = $("#url").val();
	    var menuImgUrl = $("#menuImgUrl").val();
	    var note = $("#note").val();
	    var pid = "${pid}";
	    var parent_id = $("#parent_id").val();
		$.ajax({
			url:"<%=path%>/menu/insertSTMenu.do?pid="+pid+"&name="+name+"&note="+note+"&url="+url+"&menuImgUrl="+menuImgUrl+"&parent_id="+parent_id,
	        type:"POST",
	        cache:false,
	        async:false,
	        dataType: "json",
	        success:function(data) {
	            if (data) {
	            	window.location.href = '<%=request.getContextPath()%>/menu/list.do';
	            } else {
	            	alert("操作失败！");
	            }
	        },
	        error:function(XMLHttpRequest, textStatus, errorThrown) {
	            alert("保存时出现异常！");
	        }
		});
	}
	
	function checkUnique(){
		var name = $("#name").val();
		alert(name);
// 		var name = $("#name").val();
		
// 		var old_name = $("#old_name").val();
// 		if(name == old_name) return true;
	
// 		jQuery.ajax({
// 			url:"checkUniqueMenuName.do",
// 			type:"post",
// 			dataType:"json",
// 			data:{"stMenu.name":name},
// 			success:function(jsonData, textStatus) {
// 				jsonData = jQuery.evalJSON(jsonData);
// 				if(jsonData.refalg=='yes'){
// 					alert("菜单名称已经存在.");
// 					$("#name").focus();
// 					return;
// 				}
// 			},
// 	        error:function(XMLHttpRequest, textStatus, errorThrown) {
// 	            alert("查询菜单信息时出现异常！");
// 	        }
// 		});
	}

</script>
</head>

<body>
	<form id="frm" name="frm" method="post" action="<%=path%>/menu/insertSTMenu.do">
		<div class="listinfo">
			<input type="hidden" id="showIndex" name="show_index" value="${stMenu.show_index}"/>
			<input type="hidden" id="pid" name="pid" value="${pid}"/>
			<input type="hidden" id="parent_id" name="parent_id" value="${parent_id}"/>
			<input type="hidden" id="id" name="id" value="${stMenu.id}"/>
		    <table border="0" cellpadding="0" cellspacing="0" style="width:100%;table-layout:fixed;">
		        <tr>
		            <td width="10%;">菜单名称</td>
		            <td width="10%;">
		                <input type="text" class="easyui-textbox" onblur="checkUnique()" required="true" missingMessage="请输入菜单名称" id="name" name="name" value="${stMenu.name}" maxlength="20" />
		            </td>
		        </tr>
		        <tr>
		            <td width="10%;">链接地址</td>
		            <td width="10%;"> 
		             	<input type="text" class="easyui-textbox" id="url" name="url" value="${stMenu.url}" maxlength="100"  />
		            </td>
		        </tr>
		        <!-- <tr>
		        	<td>显示图片</td>
		        	<td id="menuImgUrlTd"></td>
		        	<td><div class="generalbtt"><a id="generaltse"; href="javascript:selectImg()" >选择图片</a></div></td>
		        	<input type="hidden" id="menuImgUrl" name="menuImgUrl" value="${stMenu.menuImgUrl}" value=""/>
		        </tr> -->
		        <tr>
		            <td width="10%;">描述</td>
		            <td colspan="2" width="10%;">
		                <textarea class="textarea" id="note" name="note" rows="5" tip="描述" rules="text" maxlength="50">${stMenu.note}</textarea>&nbsp;&nbsp;&nbsp;(最长50个字)
		            </td>
		        </tr>
		       	<tr>
		       		<td width="100%;" colspan="2">
		       			<input type="submit" class="easyui-linkbutton" iconcls="icon-save" value="保存"/>&nbsp;&nbsp;&nbsp;
		       			<input type="button" onclick="javascript:history.go(-1);" value="返回"/>
		       		</td>
		       	</tr>
		    </table>
	    </div>
	</form>
</body>
</html>
