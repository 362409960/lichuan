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
	<link href="../../css/main.css" rel="stylesheet" type="text/css" />
	
	<style type="text/css">
    html{overflow-x:hidden; width:100%;}
</style>
	
</head>


<body> 
<div class="listinfo">
<form  action="<%=path %>/admin/brand/insertMerchandiseBrand.do" id="frm" method="post"  enctype="multipart/form-data">

<table width="100%" border="0" cellpadding="0" cellspacing="1" class="yanshi_newu2" style="background: green;">

<tr>
    <td align="center" width="80px" style="font-weight:bold">品牌名称</td>
	<td class="shurukang_abv" width="310px" >
		<div class="geinputleft3">
		<div class="geinputright">
		<div class="geinputmid3">
		    <input type="text" name="name"  onblur="showVerification()" id="name" class="required" /> 
		</div>
		</div>
		</div>
	</td>
	<td>&nbsp;<span class="required" style="color: red;">*</span></td>
</tr>
<tr>
    <td align="center" width="80px" style="font-weight:bold">品牌LOGO</td>
	<td class="shurukang_abv" width="310px">
		<div class="geinputleft3">
		<div class="geinputright">
		<div class="geinputmid3">
		    <input type="file" name="logoPhoto" accept="image/*" id="logoPhoto" size="30" class="required"  />
		</div>
		</div>
		</div>
	</td>
	<td>&nbsp;<span class="required" style="color: red;">*</span></td>
</tr>
<tr>
    <td align="center" style="font-weight:bold">公司的网站地址</td>
	<td class="shurukang_abv">
		<div class="geinputleft3">
		<div class="geinputright">
		<div class="geinputmid3">
		    <input type="text" name="url" id="url"  maxlength="20" class="required" />
		</div>
		</div>
		</div>
	</td>
	<td>&nbsp;<span style="color: red;">*</span></td>
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
var contextPath = "${pageContext.request.contextPath}";
    function save(){  
		
		var name = $("#name").val();
	if(name == null || name == ''){
		alert("请输入品牌名称");
		$("#name").focus();
		return;
	}

	var logoPhoto = $("#logoPhoto").val();
    if(logoPhoto == null || logoPhoto == ''){
    	alert("品牌LOGO");
    	$("#logoPhoto").focus();
    	return;
    }
    
    var url = $("#url").val();
    if(url == null || url == ''){
    	alert("公司的网站地址");
    	$("#url").focus();
    	return;
    }
    
            $('#frm').form('submit',{
                url: contextPath+"/admin/brand/insertMerchandiseBrand.do",
               	onSubmit: function(){
                    return $(this).form('validate');
               	},              
                success: function(result){ 
                   alert("保存成功！");	                        
                   closeDialog();
               	} ,
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
      url: "<%=path %>/admin/brand/verDataIsEffectivenes.do",
		 type: "POST",
		 cache:false,
		 async:true,
		 dataType: "json",
		 data: params,
		 success:function(jsonData) {		  
			 if(jsonData == 'true') {
			    $("input[name='name']").val("").focus(); 
			    alert("您输入的商品品牌已经存在，请重新输入，谢谢！");
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
        var url="<%=path%>/admin/brand/list.do";
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

