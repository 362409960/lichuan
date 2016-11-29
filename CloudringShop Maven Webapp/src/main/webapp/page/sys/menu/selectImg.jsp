<%@ page language="java" isELIgnored="false" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>

<% 
    String path = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>字典分类列表</title>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />


<style type="text/css">
.iconlisttp{margin:0px; padding:20px;}
.iconlisttp span a{ padding:5px; margin-right:8px; display:inline-block; border:#fff 1px solid; font-size:12px; color:#706e6e; text-decoration:none;}.iconlisttp span a:hover{color:#005bac; text-decoration:underline;}
.iconlisttp span  img{border:none; vertical-align:middle; margin-right:8px;}
.iconlisttp span a:hover,.iconlisttp span a:focus,.iconlisttp span a:active{border:#84b8e1 1px dashed;}
</style>
<script language="javascript">
function imgClick(imgUrl) {
	var data={imgUrl:imgUrl};
	parent.window.returnValue=data; 
	window.close();
}
</script>
</head>

<body>
<div class="iconlisttp">
	<s:iterator value="imgList" status="st">
     	<span><a href="#" onclick="javascript:imgClick('${note}')" ><img src="<%=path%>/${note}" width="16" height="16" />${dic_value}</a></span>		
	</s:iterator>
</div>	
</body>
</html>
