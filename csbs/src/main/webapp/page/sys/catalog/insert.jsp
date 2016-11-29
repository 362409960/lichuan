<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<jsp:include page="/inc/common.jsp" />
</head>

<body>
<div class="listinfo">
<form id="frm" name="frm" method="post" class="extendarea">
    <s:token />
    <table border="0" cellpadding="0" cellspacing="0" style="width:100%;table-layout:fixed;">
    
        <tr>
            <td width="120px"><span class="Horizontallist">字典分类代码</span></td>
            <td>
           		 <div class="geinputleft">
           		 <div class="geinputright">
           		 <div class="geinputmid">
              			<input type="text" id="pkid" name="catalog.pkid" onblur="checkUniqueId()" rules="required,string" maxlength="40" />
           		 </div>
           		 </div>
           		 </div>
            </td>
            <td><span class="required">*(最长40位)</span></td>
        </tr>
        
        <tr>
            <td><span class="Horizontallist">字典分类名</span></td>
            <td>
           		 <div class="geinputleft"><div class="geinputright"><div class="geinputmid">
                		<input type="text" id="catalog_name" name="catalog.catalogName"  onblur="checkUnique()" maxlength="20" />
             	 </div></div></div>
            </td>
            <td> <span class="required">*(最长20位)</span></td>
        </tr>
        
        <tr>
            <td><span class="Horizontallist">说明</span></td>
            <td colspan="2">
            	<table width="100%" border="0" cellspacing="0" cellpadding="0">
                	<tr>
                		<td>
              				 <textarea id="note" name="catalog.note" rows="4" cols="34" tip="说明" rules="text" maxlength="50"></textarea>
                		</td> 
                	</tr>
                </table>
            </td>
            <td>(最长50个字)</td>
        </tr>
        
        <tr>
    		<td valign="top">&nbsp;</td>
    		<td height="60" colspan="2">
  				<table width="100%" border="0" cellspacing="0" cellpadding="0">
  					<tr>
    					<td><div class="generalbtt"><a  id="generaltse"; href="javascript:save();">保存</a></div></td>
    					<td><div class="generalbtt"><a  id="generaltse"; href="javascript:closeDialog();">关闭</a></div></td>
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

		return flag
	}
   
	function trim(str){ 
		//删除左右两端的空格
		return str.replace(/(^\s*)|(\s*$)/g, "");
	}


	function save(){
		var pkid = document.getElementById("pkid").value;
		var catalog_name = document.getElementById("catalog_name").value;
		
		if( trim(pkid) == ""){
			alert("字典分类代码不能够为空");
			document.getElementById("pkid").focus();
			return;
		}else{
			var falg = checkNotChina(pkid);
			if( !falg ){
			   alert("字典分类代码只能是字符、数字、下滑线组成");
			   document.getElementById("pkid").focus();
			   return;
			}
		}

		if( trim(catalog_name) == ""){
			alert("字典分类名不能够为空");
			document.getElementById("catalog_name").focus();
			return;
		}

		if (checkUniqueId() && checkUnique()){
			
		}

		var params = $('#frm').serializeObject();
		jQuery.ajax({
			url:"<s:url value="/admin/catalog/insert.do" encode="false"/>",
            type:"POST",
            cache:false,
            async:false,
            dataType: "json",
            data: params,
            success:function(json, textStatus) {
                if (json.code == "1") {
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
	
	
	// 检查字典分类名是否存在
	function checkUnique() {
	    var obj = $("#catalog_name");
	    var obj_value= obj.val();
	    obj_value = jQuery.trim(obj_value);
	    var result = false;
	    if (obj_value != "") {
	        jQuery.ajax({
	            url:"<s:url value="/admin/catalog/checkUnique.do" encode="false"/>",
	            type:"get",
	            cache:false,
	            async:false,
	            dataType: "json",
	            data: {"catalog.catalogName":obj_value},
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
	                alert("检查字典分类名是否存在时出现异常！");
	            }
	        });
	    }
	    
	    return result;
	}
	
	//检查字典分类代码是否存在
	function checkUniqueId() {
	    var obj = $("#pkid");
	    var obj_value= obj.val();
	    obj_value = jQuery.trim(obj_value);
	    var result = false;
	    if (obj_value != "") {
	        jQuery.ajax({
	            url:"<s:url value="/admin/catalog/checkUniqueId.do" encode="false"/>",
	            type:"get",
	            cache:false,
	            async:false,
	            dataType: "json",
	            data: {"catalog.pkid":obj_value},
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
	                alert("检查字典分类代码是否存在时出现异常！");
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