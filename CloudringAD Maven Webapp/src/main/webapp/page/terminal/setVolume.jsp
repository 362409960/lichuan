<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/tlds/c.tld" prefix="c"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta charset="utf-8">
<title></title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta content="" name="description">
<meta content="" name="keywords">
<meta content="Cloudring" name="author">
<meta content="Cloudring" name="copyright">
<link rel="shortcut icon" href="images/icon/icon.png">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/common.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/main.css">
<link rel="stylesheet" href="<%=path%>/css/jquery-ui.css">
<link rel="stylesheet" href="<%=path%>/css/jquery.cxcolor.css">
<style type="text/css">
html,body{
	height:100%;
	width:100%;
	overflow:auto;
}
body{
	background-color:#bfc2cb;
	background-image:none;
}
.dialomain{
	width:750px;
	margin:0; 
}
.detailbutton{
	margin-top: 100px;
}
</style>
</head>

<body>
<div class="dialomain">
	<form method="post" name="">
    	<table class="main_nav">
        	<colgroup>
            	<col width="15%">
                <col width="3%">
                <col width="auto">
            </colgroup>
            <tr>
            	<th>
                	<strong class="black">音量(1-100的数字):</strong>
                </th>
                <td>
                	<label class="output">${terminalVolume }</label>
                </td>
                <td><div id="slider"></div></td>
            </tr>
        </table>
        <div class="detailbutton">
            <input type="button" class="btn-01" value="确定" onclick="onSubmit()">
            <input type="button" class="btn-01" value="取消" onclick="onClose()">
        </div>
    </form>
</div>
<script src="<%=path%>/js/jquery.js"></script>
<script src="<%=path%>/js/jquery-ui.js"></script>
<script type="text/javascript" src="<%=path%>/js/common.js"></script>
<script type="text/javascript" src="<%=path%>/layer/layer.js"></script>
<script>
$(function(){
	$( "#slider" ).slider({
		value: $(".output").text(),
		slide: function (event, ui) {
			$(".output").text(ui.value);
		}
	});
});

function onSubmit(){
	var volume = $(".output").text();
	if(volume == 0){
		layer.alert('请选择1-100的数字', {icon:5,title:'提示'});
		return ;
	}
	
	layer.confirm('确定发出此命令吗?',{icon: 3, title:'提示'},function(index){
		var ids = "${terminalIds}";
		$.ajax({
		    type: "post", 
		    dataType: "json", 
		    url: "<%=path %>/terminalCommand/setVolume.do", 
		    data: {"ids":ids,"volume":volume}, 
		    success: function(data) {
		    	if(data.message != 1){
		    		layer.alert('命令设置失败', {icon:5,title:'提示'});
		    	}else{
		    		layer.alert('命令设置成功', {icon:1,title:'提示'},function(index){
		    			parent.location = parent.location;
			    		parent.layer.close(index);
	    		 	});
		    	}
		    }, 
		    error: function(err) {
		    	layer.alert(err, {icon:5,title:'提示'});
		    }
		});
	});
}

function onClose(){
	var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
	parent.layer.close(index);
}
</script>
</body>
</html>
