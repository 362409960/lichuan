<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="/WEB-INF/tlds/c.tld" prefix="c"%>
<%@ taglib uri="http://java.fckeditor.net" prefix="FCK"%>  

<% String path = request.getContextPath();%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>测试管理</title>
	<jsp:include page="/inc/common.jsp" />
	
<style type="text/css">
    html{overflow-x:hidden; width:100%;}
</style>
 
 
</head>
<body> 
<div class="w001">
<form id="frm" name="frm" method="post" class="extendarea">
	<input type="hidden" id="id" name="stMenu.id"  value="${stMenu.id}" />
	<input type="hidden" id="showIndex" name="stMenu.show_index" value="${stMenu.show_index}"/>
	<input type="hidden" id="pid" name="stMenu.pid" value="${stMenu.pid}"/>
	<input type="hidden" id="old_name" value="${stMenu.name}" />

	<div class="listinfo">
    <table border="0" cellpadding="0" cellspacing="0" style="width:100%;table-layout:fixed;">
 
        <tr>
            <td width="120px">菜单名称</td>
            <td>
            	<div class="geinputleft">
            	    <div class="geinputright">
            	        <div class="geinputmid3">
                	        <input type="text" id="name" name="stMenu.name"  onblur="checkUnique()" maxlength="20"  value="${stMenu.name}"/>
                        </div>
                    </div>
                </div>
            </td>
            <td>
        </tr>
        
        
        
        <tr>
            <td>链接地址</td>
            <td>
            	<div class="geinputleft">
            	    <div class="geinputright">
            	        <div class="geinputmid3">
            		        <input type="text" id="url" name="stMenu.url"  maxlength="100"  value="${stMenu.url}" />
             	        </div>
             	    </div>
             	</div>
            </td>
        </tr>

         <tr>
        	<td>显示图片</td>
        	<td id="menuImgUrlTd">
	        	<s:if test="null != stMenu.menuImgUrl && ''!= stMenu.menuImgUrl">
	        		<img src='<%=path%>/${stMenu.menuImgUrl}'/>
	        	</s:if>
        	</td>
        	
        	<td><div class="generalbtt"><a  id="generaltse"; href="javascript:selectImg()" >选择图片</a></div></td>
        	<input type="hidden" id="menuImgUrl" name="stMenu.menuImgUrl" value="${stMenu.menuImgUrl}"/>
        </tr>
        
        <tr>
            <td>描述</td>
            <td colspan="2">
                <textarea class="textarea" id="note" name="stMenu.note" rows="5" tip="描述" rules="text" maxlength="50">${stMenu.note }</textarea>
            </td>
            <td>(最长50个字)</td>
        </tr> 	
</table>


<br />
<table width="100%" border="0" cellpadding="0" cellspacing="0" >
     <tr>
    	<td align="center" ><div class="generalbtt"><a id="generaltse"; href="javascript:save()" >保存</a></div></td>
    	<td align="center" ><div class="generalbtt"><a id="generaltse"; href="javascript:closeDialog();" >关闭</a></div></td>
    </tr>
</table>

</div>

</form>
</div>
 <jsp:include page="/inc/dialog.jsp" />
</body>
</html>

<script type="text/javascript">

	function checkUnique(){
		var name = $("#name").val();
		var id = $("#id").val();
		
		var old_name = $("#old_name").val();
		if(name == old_name) return true;
	
		jQuery.ajax({
			url:"checkUniqueMenuName.do",
			type:"post",
			dataType:"json",
			data:{"stMenu.name":name},
			success:function(jsonData, textStatus) {
				jsonData = jQuery.evalJSON(jsonData);
				if(jsonData.refalg=='yes'){
					alert("菜单名称已经存在.");
					$("#name").focus();
					return;
				}
			},
	        error:function(XMLHttpRequest, textStatus, errorThrown) {
	            alert("查询菜单信息时出现异常！");
	        }
		});
	}
	
    function selectImg(){
    	var data = window.showModalDialog('<s:url value="selectImg.do" encode="false"/>','','dialogWidth:750px;dialogHeight:400px;center:1;status:no;help:no;menubar:no');
    	if(typeof(data)!="undefined"){
    		 $("#menuImgUrlTd").html("<img src='<%=path%>/"+data.imgUrl+"'/>");
    		 $("#menuImgUrl").attr("value",data.imgUrl);
    	}else{
    		alert("没有选择有效的图片!");
    	}
    }
    
    function save(){
    	var params = $('#frm').serializeObject();
    	jQuery.ajax({
    		url:"<s:url value="updateMenu.action" encode="false"/>",
            type:"POST",
            cache:false,
            async:false,
            dataType: "json",
            data: params,
            success:function(jsonData, textStatus) {
            	jsonData = jQuery.evalJSON(jsonData);
            	
                if (jsonData.code == '1') {
                	alert("操作成功！"); 
                	window.parent.callFunc('${stMenu.id}','${stMenu.name}');
                	closeDialog();
                } else {
                	alert("操作失败！原因："+jsonData.message); 
                }
            },
            error:function(XMLHttpRequest, textStatus, errorThrown) {
                alert("保存时出现异常！");
            }
    	});
    }
    
	function closeDialog() {
		window.parent.innerWindowClose();
	}

	function isEmpty( str ){
		if ( str == "" ) return true;
		var regu = /^[ ]+$/;
		var re = new RegExp(regu);
		return re.test(str);
	}
</script>

