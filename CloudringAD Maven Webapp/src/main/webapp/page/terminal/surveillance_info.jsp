<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/tlds/c.tld" prefix="c"%>
<%@ taglib uri="/WEB-INF/tlds/fmt.tld" prefix="fmt"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta charset="utf-8">
<title>监视器信息</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta content="" name="description">
<meta content="" name="keywords">
<meta content="Cloudring" name="author">
<meta content="Cloudring" name="copyright">
<link rel="shortcut icon" href="<%=path%>/images/icon/icon.png">
<link href="<%=path%>/css/common.css" rel="stylesheet" type="text/css">
<link href="<%=path%>/css/main.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/page.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/jquery-ui.css">
<link rel="stylesheet" href="<%=path%>/js/zTree/css/zTreeStyle/zTreeStyle.css" type="text/css">
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
.treeMode{
	width:100%;
	height:230px;
	overflow-x:hidden;
	overflow-y:auto;
	background-color:#fff
}
.surveillance_delay{
	border-left: 1px solid #ddd;
    height: 220px;
    left: 350px;
    padding: 10px 0 0 10px;
    position: fixed;
    text-align: left;
    top: 40px;
}
.surveillance_delay p{
	line-height:28px; 
}
</style>
</head>

<body>
<div class="surveillance_delay">
	监视器详情:
    <p><label><span style="color: red;">*</span>IP:<input type="text" value="" id="surveillance_ip" style="width:400px;" maxlength="50"></label></p>
   	<p><label><span style="color: red;">*</span>名称:<input type="text" value="" id="surveillance_remark" style="width:387px;" maxlength="25"></label></p>
    <p><label>延迟时间:<input type="text" value="0" id="delayTime" maxlength="10">分钟</label></p>
	<p><label>切换时间:<input type="text" value="0" id="transitTime" maxlength="10">秒</label></p>
    <input type="hidden" value="" id="surveillance_packetName" >
</div>

<div class="dialomain">
	<form method="post" name="">
    	<table class="main_nav">
            <tr>
            	<th>
                	<strong class="black">选择监视器:</strong>
                </th> 
           </tr>
        </table>
        <div class="treeMode">
        	<div class="tree left"  style="overflow:auto;"> <ul id="treeDemo" class="ztree"></ul> </div>
        </div>

        <div class="detailbutton" style="text-align:right">
            <input type="button" class="btn-01" value="确认增加" onclick="onInsert()">
            <input type="button" class="btn-01" value="确认修改" onclick="onUpdate()">
            <input type="button" class="btn-01" value="确认删除" onclick="onDelete()">
        </div>
    </form>
</div>

<script type="text/javascript" src="<%=path %>/js/jquery.js"></script>
<script type="text/javascript" src="<%=path%>/js/common.js"></script>
<script type="text/javascript" src="<%=path%>/layer/layer.js"></script>
<script type="text/javascript" src="<%=path%>/js/jquery-ui.js"></script>
<script type="text/javascript" src="<%=path%>/js/zTree/jquery.ztree.core.min.js"></script>
<script type="text/javascript" src="<%=path%>/js/zTree/jquery.ztree.excheck.min.js"></script>
<script type="text/javascript" src="<%=path%>/js/zTree/jquery.ztree.exedit.min.js"></script>
<script type="text/javascript" src="<%=path%>/js/jquery.ajaxfileupload.js"></script>
<script type="text/javascript">
var setting = {
	    treeNodeKey : "id",
	    treeNodeParentKey : "pId",
	    async : true, 
		view: {
			selectedMulti: false
		},
		edit: {
			enable: false,
			showRemoveBtn: false,
			showRenameBtn: false
		},
		check:{ 
			enable:false,
			chkboxType : { "Y" : "s", "N" : "ps" }
		},
		data: {
			keep: {
				parent:false,
				leaf:false
			},
			simpleData: {
				enable: true
			}
		},
		callback:{
			onClick:zTreeOnClick
		}
	};
	

var zNodes;  
$(function(){
	var terminalId = "${terminalId}";
    $.ajax({  
    	enable: true,
        async : false,  
        cache:false,  
        type: 'POST',  
        dataType : "json",  
        url: "<%=path%>/surveillance/surveillance_list.do",//请求的action路径
        data: {"terminalId":terminalId}, 
        error: function () {//请求失败处理函数  
            layer.alert('请求失败', {icon:5,title:'提示'});
        },  
        success:function(data){ //请求成功后处理函数。    
        	zNodes = eval(data.packets);   //把后台封装好的简单Json格式赋给treeNodes  
        }  
    });  
});  



$(document).ready(function(){
	$.fn.zTree.init($("#treeDemo"), setting, zNodes).expandAll(true);
});


function zTreeOnClick(event, treeId, treeNode){
	var surveillanceId = treeNode.id; 
	if(surveillanceId == "A" || surveillanceId == "B" || surveillanceId == "C" || surveillanceId == "D" || surveillanceId == "E"){
		$("#surveillance_ip").val("");
		$("#surveillance_remark").val("");
		$("#delayTime").val(0);
		$("#transitTime").val(0);
		$("#surveillance_packetName").val(surveillanceId);
	}
	$.ajax({
	    type: "post", 
	    dataType: "json", 
	    url: "<%=path %>/surveillance/surveillance_info.do", 
	    data: {"surveillanceId":surveillanceId}, 
	    success: function(data) {
	    	if(data.surveillance != null){
	    		var surveillance = data.surveillance;
	    		$("#surveillance_ip").val(surveillance.ip);
	    		$("#surveillance_remark").val(surveillance.remark);
	    		$("#delayTime").val(surveillance.delayTime);
				$("#transitTime").val(surveillance.transitTime);
				$("#surveillance_packetName").val(surveillance.packetName);
	    	}
	    }
	});
}


//确认增加
function onInsert(){
	
	var $subObj={};
	
	var packetName = $("#surveillance_packetName").val();
	
	if(packetName == ""){
		layer.alert('请选择需要增加监视器的分组。', {icon:5,title:'提示'});
		return false;
	}
	
	var ip = $("#surveillance_ip").val();
	
	if(ip == ""){
		layer.alert('请输入监视器IP!', {icon:5,title:'提示'});
		return false;
	}
	
	var remark = $("#surveillance_remark").val();
	
	if(remark == ""){
		layer.alert('请输入监视器名称!', {icon:5,title:'提示'});
		return false;
	}
	

	var numberReg=/^\+?(0|[1-9][0-9]*)$/;
	
	var delayTime = $("#delayTime").val();
	var transitTime = $("#transitTime").val();
	
	if(!numberReg.test(delayTime)){
		layer.alert('延迟时间请输入正整数!', {icon:5,title:'提示'});
		return;
	}
	
	if(!numberReg.test(transitTime)){
		layer.alert('间隔时间请输入正整数!', {icon:5,title:'提示'});
		return;
	}
	
	
	$subObj["ip"] = ip;
	$subObj["remark"] = remark;
	
	var terminalId = "${terminalId}";
	$subObj["terminalId"] = terminalId;
	$subObj["delayTime"] = delayTime;
	$subObj["transitTime"] = transitTime;
	$subObj["packetName"] = packetName;
	
	var surveillances = JSON.stringify($subObj);
	
	$.ajax({
	    type: "post", 
	    dataType: "json", 
	    url: "<%=path %>/surveillance/surveillance_insert.do", 
	    data: {"surveillances":surveillances,"terminalId":terminalId}, 
	    success: function(data) {
	    	if(data.message != 1){
	    		layer.alert(data.message, {icon:5,title:'提示'});
	    	}else{
	    		layer.alert('监视器新增成功', {icon:1,title:'提示'},function(index){
	    			window.location=window.location;
    		 	});
	    	}
	    }, 
	    error: function(err) {
	    	alert(err);
	    } 
	});
	
}


//确认修改
function onUpdate(){
	var zTree = $.fn.zTree.getZTreeObj("treeDemo"),
	nodes = zTree.getSelectedNodes(),
	treeNode = nodes[0];
	if (nodes.length == 0) {
		layer.alert('请先选择一个节点', {icon:5,title:'提示'});
		return;
	}
	if(treeNode.name == 'A' || treeNode.name == 'B' || treeNode.name == 'C' || treeNode.name == 'D' || treeNode.name == 'E'){
		layer.alert('不能修改分组', {icon:5,title:'提示'});
		return;
	}
	
	var $subObj={};
	
	

	var numberReg=/^\+?(0|[1-9][0-9]*)$/;
	
	var delayTime = $("#delayTime").val();
	var transitTime = $("#transitTime").val();
	
	if(!numberReg.test(delayTime)){
		layer.alert('延迟时间请输入正整数!', {icon:5,title:'提示'});
		return;
	}
	
	if(!numberReg.test(transitTime)){
		layer.alert('间隔时间请输入正整数!', {icon:5,title:'提示'});
		return;
	}
	
	if($("#surveillance_ip").val() == ""){
		layer.alert('请输入监控器IP!', {icon:5,title:'提示'});
		return;
	}
	
	if($("#surveillance_remark").val() == ""){
		layer.alert('请输入监控器名称!', {icon:5,title:'提示'});
		return;
	}
	
	var terminalId = "${terminalId}";
	
	$subObj["id"] = treeNode.id;
	$subObj["ip"] = $("#surveillance_ip").val();
	$subObj["remark"] = $("#surveillance_remark").val();
	$subObj["terminalId"] = terminalId;
	$subObj["delayTime"] = $("#delayTime").val();
	$subObj["transitTime"] = $("#transitTime").val();
	$subObj["packetName"] = $("#surveillance_packetName").val();
	
	var surveillances = JSON.stringify($subObj);
	$.ajax({
	    type: "post", 
	    dataType: "json", 
	    url: "<%=path %>/surveillance/surveillance_update.do", 
	    data: {"surveillances":surveillances}, 
	    success: function(data) {
	    	if(data.message != 1){
	    		layer.alert(data.message, {icon:5,title:'提示'});
	    	}else{
	    		layer.alert('监视器修改成功', {icon:1,title:'提示'},function(index){
	    			window.location=window.location;
    		 	});
	    	}
	    }, 
	    error: function(err) {
	    	layer.alert(err, {icon:5,title:'提示'});
	    } 
	});
	
}


//确认删除
function onDelete(){
	var zTree = $.fn.zTree.getZTreeObj("treeDemo"),
	nodes = zTree.getSelectedNodes(),
	treeNode = nodes[0];
	if (nodes.length == 0) {
		layer.alert('请先选择一个节点', {icon:5,title:'提示'});
		return;
	}
	if(treeNode.name == 'A' || treeNode.name == 'B' || treeNode.name == 'C' || treeNode.name == 'D' || treeNode.name == 'E'){
		layer.alert('不能删除分组', {icon:5,title:'提示'});
		return;
	}
	
	layer.confirm('是否删除这个监视器？',{icon: 3, title:'提示'},function(index){
		$.ajax({
		    type: "post", 
		    dataType: "json", 
		    url: "<%=path %>/surveillance/surveillance_delete.do", 
		    data: {"surveillanceId":treeNode.id}, 
		    success: function(data) {
		    	if(data.message != 1){
		    		layer.alert('删除失败', {icon:5,title:'提示'});
		    	}else{
		    		layer.alert('删除成功', {icon:1,title:'提示'},function(index){
		    			window.location=window.location;
	    		 	});
		    	}
		    }, 
		    error: function(err) {
		    	alert(err);
		    } 
		});
	}, function(){
		
	});
}

</script>
</body>
</html>
