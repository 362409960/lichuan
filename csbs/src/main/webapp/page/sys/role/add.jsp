<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>

<% String path = request.getContextPath(); %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<jsp:include page="/inc/common.jsp" />
</head>
<body>


<div class="listinfo">
<form id="frm" name="frm" method="post" class="extendarea">
<input type="hidden" id="id" name="roleVO.id" value="${roleVO.id}" />

<s:token />


    <!-- 工具栏 -->
    <table border="0" cellpadding="0" cellspacing="0"  style="width:100%;table-layout:fixed;">
    
        <tr>
            <td width="120px"><span class="Horizontallist">角色名 </span></td>
            <td>
            	<div class="geinputleft"><div class="geinputright"><div class="geinputmid">
                	<input type="text" id="role_name" name="roleVO.role_name" title="角色名"  tip="角色名" value="${roleVO.role_name}" maxlength="20" />
               </div></div></div>
            </td>
            <td><span class="required">*(最长20位)</span></td>
        </tr>
        
        <tr>
            <td ><span class="Horizontallist">角色KEY</span></td>
            <td>
                <div class="geinputleft"><div class="geinputright"><div class="geinputmid">
                	<input type="text" id="role_key" name="roleVO.role_key" title="角色KEY值"  tip="角色KEY值" value="${roleVO.role_key}" maxlength="20" />
             	 </div></div></div>
            </td>
            <td><span class="required">*(最长16位)</span></td>
        </tr>
        
        <tr>
    		<td valign="top">&nbsp;</td>
    		<td height="60" colspan="2">
    			<table width="100%" border="0" cellspacing="0" cellpadding="0">
  					<tr>
    					<td><div class="generalbtt"><a id="generaltse"; href="javascript:save()">保存</a></div></td>
    					<td><div class="generalbtt"><a id="generaltse"; href="javascript:closeDialog()">关闭</a></div></td>
  					</tr>
				</table>
			</td>
  		</tr>
    </table>
</form>
</div>

</body>
</html>


<script language="javascript">
 var result = false;
 
//修改
function save(){
    var roleName = $("#role_name").val();
	if(roleName == null || roleName == ''){
		alert("请输入角色名");
		$("#role_name").focus();
		return;
	}

	var roleKey = $("#role_key").val();
    if(roleKey == null || roleKey == ''){
    	alert("请输入角色KEY");
    	$("#role_key").focus();
    	return;
    }
 
    if(!checkUnique()){
    	alert("角色名或者角色KEY已经存在");
    	$("#role_name").focus();
    	return;
    }
    
    var params = $("#frm").serializeObject();
    $.ajax({
		url : "<%=path%>/admin/role/add.do",
		type: "POST",
		cache:false,
		async:true,
		dataType: "json",
		data: params,
		success:function(jsonData, textStatus) {
			 jsonData = jQuery.evalJSON(jsonData);
			 if(jsonData.success == 'ture'){
				 alert("保存成功！");
				 window.parent.callFunc();
				 closeDialog();
			 }else{
				 alert("保存失败！"); 
			}
		},
		error:function(XMLHttpRequest, textStatus, errorThrown) {
            alert("检查角色KEY是否存在时出现异常！");
        }
    });
}

//检查角色KEY是否存在
function checkUnique() {
    var params = $("#frm").serializeObject();
	$.ajax({
		url : "<%=path%>/admin/role/checkUnique.do",
		type: "POST",
		cache:false,
		async:false,  //异步才能修改全局变量的值
		dataType: "json",
		data: params,
		success:function(json, textStatus) {
			json = jQuery.evalJSON(json);
			
            if (json.code == "0") {
            	result = false;
            } else {
            	result = true;
            }
		},
		error:function(XMLHttpRequest, textStatus, errorThrown) {
            alert("检查角色KEY是否存在时出现异常！");
        }
	});
	
	return result;
}

// 关闭窗口
function closeDialog() {
    window.parent.innerWindowClose();
}
</script>


