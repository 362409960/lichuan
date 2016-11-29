<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!-- admin/catalog/update.jsp by hy -->
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />


</head>

<body>
<div class="listinfo">
<form id="frm" name="frm" method="post" class="extendarea">
	<input type="hidden" id="pkid" name="catalog.pkid"  value="${catalog.pkid}" />
	<input type="hidden" id="old_name" value="${catalog.catalogName}" />

    <table border="0" cellpadding="0" cellspacing="0" style="width:100%;table-layout:fixed;">
    
        <tr>
            <td width="120px"><span class="Horizontallist">字典分类代码</span></td>
            <td>${catalog.pkid}</td>
            <td></td>
        </tr>
        
        <tr>
            <td><span class="Horizontallist">字典分类名</span></td>
            <td>
           		 <div class="geinputleft"><div class="geinputright"><div class="geinputmid">
                		<input type="text" id="catalog_name" name="catalog.catalogName"  onblur="checkUnique()" maxlength="20" value="${catalog.catalogName }"/>
             	 </div></div></div>
            </td>
            <td align="left"> <span class="required">*(最长20位)</span></td>
        </tr>
        
        <tr>
            <td><span class="Horizontallist">说明</span></td>
            <td colspan="2">
            	<table width="100%" border="0" cellspacing="0" cellpadding="0">
                	<tr>
                		<td><textarea id="note" name="catalog.note" rows="4" cols="34"  tip="说明" rules="text" maxlength="50">${catalog.note }</textarea></td>
                		<td>(最长50个字)</td>
                	</tr>
                </table>
            </td>
            <td></td>
        </tr>
        
        <tr>
    		<td valign="top">&nbsp;</td>
    		<td height="60" colspan="2">
  				<table width="100%" border="0" cellspacing="0" cellpadding="0">
  					<tr>
    					<td><div class="generalbtt"><a id="generaltse";  href="javascript:save();">保存</a></div></td>
    					<td></td>
    					<td><div class="generalbtt"><a id="generaltse";  href="javascript:closeDialog();">关闭</a></div></td>
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
var regexp = "^[a-zA-Z][a-zA-Z0-9_]*$";

function checkNotChina(obj)
{
	var regExp = new RegExp(regexp);
	var flag = regExp.test(obj);

	return flag;
}

function trim(str){ 
	//删除左右两端的空格
	return str.replace(/(^\s*)|(\s*$)/g, "");
}

//修改
function save(){
	var catalog_name = document.getElementById("catalog_name").value;
	var old_name = $("#old_name").val();
 
	if( trim(catalog_name) == ""){
		alert("字典分类名不能够为空");
		document.getElementById("catalog_name").focus();
		return;
	}
	
	if(trim(catalog_name) == old_name || checkUnique()){
    	var params = $('#frm').serializeObject();
    	jQuery.ajax({
            url:"<s:url value="/admin/catalog/update.action" encode="false"/>",
            type:"POST",
            cache:false,
            async:false,
            dataType: "json",
            data: params,
            success:function(json, textStatus) {
                if (json.code == "0") {
                	alert("操作成功！"); 
                	window.parent.callFunc();
                	closeDialog();
                } else {
                	alert("操作失败！"); 
                }
            },
            error:function(XMLHttpRequest, textStatus, errorThrown) {
                alert("保存时出现异常！");
            }
        });
	}
}

// 检查字典分类名是否存在
function checkUnique() {
    var obj = $("#catalog_name");
    var obj_value= obj.val();
 
    var result = false;
    if (obj_value != "") {
        jQuery.ajax({
            url:"<s:url value="/admin/catalog/checkUnique.do" encode="false"/>",
            type:"POST",
            cache:false,
            async:false,
            dataType: "json",
            data: {"catalog.catalogName":obj_value},
            success:function(json, textStatus) {
                if (json.code == "0") {
                	result = false;
                } else {
                    result = true;
                }
            },
            error:function(XMLHttpRequest, textStatus, errorThrown) {
                alert("检查字典分类名是否存在时出现异常！");
            }
        });
    }
    
    return result;
}

// 关闭窗口
function closeDialog() {
    window.parent.innerWindowClose();
}
</script>
