<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!-- admin/dictionary/update.jsp by hy -->
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<jsp:include page="/inc/common.jsp" />
</head>

<body>
<div class="listinfo">
<form id="frm" name="frm" method="post" class="extendarea">
	<input type="hidden" id="pkid" name="dictionary.pkid"  value="${dictionary.pkid}" />
	<input type="hidden" id="catalog_id" name="dictionary.catalog_id"  value="${dictionary.catalog_id}" />
	<input type="hidden" id="old_name" value="${dictionary.dic_code}" />
	<input type="hidden" id="old_vale" value="${dictionary.dic_value}" />
    <!-- 工具栏 -->
    <table border="0" cellpadding="0" cellspacing="0" style="width:100%;table-layout:fixed;">
        <tr>
            <td width="120px"><span class="Horizontallist">字典代码</span> </td>
            <td>
               <div class="geinputleft"><div class="geinputright"><div class="geinputmid">
                	<input type="text" id="dic_code" name="dictionary.dic_code"  title="字典代码" onblur="checkUnique()" tip="字典代码" rules="required,string" maxlength="40" value="${dictionary.dic_code}"/>
                </div></div></div>
            </td>
            <td><span class="required">*</span></td>
            <td width="120px">(最长40位)</td>
        </tr>
        <tr>
            <td><span class="Horizontallist">字典值</span></td>
            <td>
                <div class="geinputleft"><div class="geinputright"><div class="geinputmid">
                	<input type="text" id="dic_value" name="dictionary.dic_value"  title="字典值" onblur="checkUniqueDicValue()"  tip="字典值" rules="required" maxlength="20" value="${dictionary.dic_value}" />
                 </div></div></div>
            </td>
            <td><span class="required">*</span></td>
            <td>(最长20位)</td>
        </tr>
        
        <tr>
            <td width="120px"><span class="Horizontallist">排序序号</span></td>
            <td>
              <div class="geinputleft"><div class="geinputright"><div class="geinputmid">
                <input type="text" id="show_index" name="dictionary.show_index"  tip="排序序号" rules="required,num" maxlength="2" value="${dictionary.show_index}"/>
              </div></div></div>
            </td>
            <td><span class="required">*</span></td>
            <td width="120px">(最长2个字)</td>
        </tr>
        <tr>
            <td><span class="Horizontallist">说明</span></td>
            <td colspan="2">
            	<table width="100%" border="0" cellspacing="0" cellpadding="0">
                	<tr>
                		<td>
              				 <textarea id="note" name="dictionary.note" rows="4" cols="34" tip="说明" rules="text" maxlength="50">${dictionary.note}</textarea>
                		</td>
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
    					<td><div class="generalbtt"><a id="generaltse"; href="javascript:save();">保存</a></div></td>
    					<td><div class="generalbtt"><a id="generaltse"; href="javascript:closeDialog();">关闭</a></div></td>
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
//修改
function save(){
    if(checkUnique()&& checkUniqueDicValue()){
    	var params = $('#frm').serializeObject();
    	jQuery.ajax({
            url:"<s:url value="/admin/catalog/dictionary/update.action" encode="false"/>",
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
                	alert("操作失败！原因："+json.message); 
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
    var obj = $("#dic_code");
    var obj_value= obj.val();
    obj_value = jQuery.trim(obj_value);
    var old_value = $("#old_name").val();
    if(obj_value == old_value) return true;
    var result = false;
    if (obj_value != "") {
        jQuery.ajax({
            url:"<s:url value="/admin/catalog/dictionary/checkUnique.action" encode="false"/>",
            type:"POST",
            cache:false,
            async:false,
            dataType: "json",
            data: {"dictionary.dic_code":obj_value,"dictionary.catalog_id":$("#catalog_id").val()},
            success:function(json, textStatus) {
                if (json.code == "0") {
                    obj.addClass("error");
                    alert(json.message);
                } else {
                    obj.removeClass("error");
                    result = true;
                }
            },
            error:function(XMLHttpRequest, textStatus, errorThrown) {
                alert("检查字典代码是否存在时出现异常！");
            }
        });
    }
    
    return result;
}
//检查字典值是否存在
function checkUniqueDicValue() {
    var obj = $("#dic_value");
    var obj_value= obj.val();
    obj_value = jQuery.trim(obj_value);
    var old_value = $("#old_vale").val();
    if(obj_value == old_value) return true;
    var result = false;
    if (obj_value != "") {
        jQuery.ajax({
            url:"<s:url value="/admin/catalog/dictionary/checkUniqueDicValue.action" encode="false"/>",
            type:"POST",
            cache:false,
            async:false,
            dataType: "json",
            data: {"dictionary.dic_value":obj_value, "dictionary.catalog_id":$("#catalog_id").val()},
            success:function(json, textStatus) {
                if (json.code == "0") {
                    obj.addClass("error");
                    alert(json.message);
                } else {
                    obj.removeClass("error");
                    result = true;
                }
            },
            error:function(XMLHttpRequest, textStatus, errorThrown) {
                alert("检查字典值是否存在时出现异常！");
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
