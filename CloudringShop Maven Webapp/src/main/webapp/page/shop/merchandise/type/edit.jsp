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
	
	   <link  type="text/css" rel="stylesheet" href="../../css/201202/manage.css"/>

<link  type="text/css" rel="stylesheet" href="../../css/201202/all_icon.css"/>


	<script type="text/javascript" src="../../js/jquery.min.js"></script>
	<script type="text/javascript" src="../../js/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="../../js/jquery.validate.js"></script>
	<link href="../../css/main.css" rel="stylesheet" type="text/css" />
	
	<style type="text/css">
    html{overflow-x:hidden; width:100%;}
</style>
	
</head>


<body> 
<div class="listinfo">
<form id="frm" name="frm" method="post" action="<%=path %>/admin/type/updateMerchandiseType.do" target="_parent">
<input type="hidden" name="id" value="${merch.id}">
<table width="100%" border="0" cellpadding="0" cellspacing="1" class="yanshi_newu2" style="background: green;">

<tr>
    <td align="center" width="80px" style="font-weight:bold">商品类型名称</td>
	<td class="shurukang_abv" width="310px">
		<div class="geinputleft3">
		<div class="geinputright">
		<div class="geinputmid3">
		    <input type="text" name="name" value="${merch.name} "  class="" onblur="showVerification()" id="name" /> 
		</div>
		</div>
		</div>
	</td>
	<td>&nbsp;<span class="required"style="color: red;" >*</span></td>
</tr>
<tr>
    <td align="center" width="80px" style="font-weight:bold">是否显示</td>
	<td class="shurukang_abv" width="310px">
		<!-- <div class="geinputleft3">
		<div class="geinputright">
		<div class="geinputmid3"> -->
		       <input type="radio" name="isSignDisplay" value="0" id="is1"/>显示
		       <input type="radio" name="isSignDisplay" value="1" id="is2"/>不显示	    
		<!-- </div>
		</div>
		</div> -->
	</td>
	<td>&nbsp;<span class="required" style="color: red;">*</span></td>
</tr>

<tr>
    <td align="center" class="yanshi_news11" style="font-weight:bold">商品类型编码</td>
	<td class="shurukang_abv">
		<div class="geinputleft3">
		<div class="geinputright">
		<div class="geinputmid3">
		    <input type="text" name="productTypeSN" value="${merch.productTypeSN}" id="metaKeywords"  maxlength="20"/>
		</div>
		</div>
		</div>
	</td>
	<td>&nbsp;<span class="required" style="color: red;">*</span></td>
</tr>


 
</table>

<br />
<table width="100%" border="0" cellpadding="0" cellspacing="0" >
     <tr>
    	<td align="center" ><div class="generalbtt"><a id="generaltse"; href="javascript:save()" >保存</a></div></td>
    	<td align="center" ><div class="generalbtt"><a id="generaltse"; href="javascript:closeDialog();" >关闭</a></div></td>
    </tr>
</table>

</form>
</div>
</body>
</html>

<script type="text/javascript">
        var isSignDisplay="${merch.isSignDisplay}";
        if("0"== isSignDisplay)
        {
           $("#is1").attr("checked","checked");
        }
        else
        {
           $("#is2").attr("checked","checked");
        }
           
    function save(){  
    
     var name = $("#name").val();
	if(name == null || name == ''){
		alert("请输入商品类型名称");
		$("#name").focus();
		return;
	}

	var productTypeSN = $("#productTypeSN").val();
    if(productTypeSN == null || productTypeSN == ''){
    	alert("商品类型编码");
    	$("#productTypeSN").focus();
    	return;
    }
		 var params = form2Json("frm");
		$.ajax({
		 url: "<%=path %>/admin/type/updateMerchandiseType.do",
		 type: "POST",
		 cache:false,
		 async:true,
		 dataType: "json",
		 data: params,
		 success:function(jsonData) {			
			 if(jsonData == 'true')
			 {
				 alert("保存成功！");				
				 closeDialog();
			 }
			 else{
				 alert("保存失败！"); 
			}
         },
         error:function(){
         alert("保存时出现异常！");
     }
	});
	
}
 function showVerification()
 {
    var name=$("#name").val();
    var params = form2Json("frm");
    if(""!=name || typeof(name)!="undefined" )
    {
      $.ajax({
      url: "<%=path %>/admin/type/verDataIsEffectivenes.do",
		 type: "POST",
		 cache:false,
		 async:true,
		 dataType: "json",
		 data: params,
		 success:function(jsonData) {		  
			 if(jsonData == 'true') {
			    $("input[name='name']").val("").focus(); 
			    alert("您输入的商品分类已经存在，请重新输入，谢谢！");
			    
			 }
         },
         error:function(){
         alert("保存时出现异常！");
     }
      });
    }
 }

    
    // 关闭窗口
    function closeDialog() {
        var url="<%=path%>/admin/type/list.do";
        opener.document.location=url;
        window.close();  
    }

	function isEmpty( str ){
		if ( str == "" ) return true;
		var regu = /^[ ]+$/;
		var re = new RegExp(regu);
		return re.test(str);
	}
	
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

