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
<title>节目制作</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta content="" name="description">
<meta content="" name="keywords">
<meta content="Cloudring" name="author">
<meta content="Cloudring" name="copyright">
<link rel="shortcut icon" href="<%=path %>/images/icon/icon.png">
<link rel="stylesheet" type="text/css" href="<%=path %>/css/common.css">
<link rel="stylesheet" type="text/css" href="<%=path %>/css/main.css">
<link rel="stylesheet" type="text/css" href="<%=path %>/css/jquery-ui.css">
<link rel="stylesheet" type="text/css" href="<%=path %>/css/jquery.cxcolor.css">
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
.main_nav span{
	font-weight:normal;
}
textarea{
	width:95%;
}
.tip{
	width:95%;
	overflow:hidden;
	line-height:24px;
}
.detailbutton{
	border:none;
}
</style>
</head>

<body>
<div class="dialomain">
    	<div class="tabs">
          <div id="div_head">
          	<div class="main_nav" style="text-align:right;">
            	<span>播放时间:</span>
                <input type="text" class="inp-70" name="playDuration" id="playDuration" value="1" maxlength="10">
                <select id="playTime">
                	<option value="DAYS">天</option>
                    <option value="HOURS" selected>小时</option>
                    <option value="MINUTES">分钟</option>
                    <option value="SECONDS">秒</option>
                </select>
            </div>
          </div>
          <ul>
            <li><a href="#tabs-1">播放消息</a></li>
          </ul>
          <div id="tabs-1">
           	<table class="tabs-table">
            	<colgroup>
                	<col width="15%">
                    <col width="auto">
                </colgroup>
                <tr>
                	<td>播放速度</td>
                    <td>
                    	<select class="sel-120" id="playbackSpeed">
                        	<option value="fast">快</option>
                            <option value="normal">一般</option>
                            <option value="slow">慢</option>
                            <option value="veryfast">很快</option>
                        </select>
                    </td>
                </tr>
                <tr>
                	<td style="vertical-align:top;">消息内容</td>
                    <td>
                    	<textarea cols="20" rows="10" name="message" id="message" onkeyup="changeLeaveNumber()"></textarea>
                        <div class="tip">
                        	<div id="inputTip" class="inputTip right">
                            	还可输入的字符数:<span id="leaveNumber" class="f44">500</span>
                            </div>
                            <div class="left">
                            	<input id="isOrNo" type="checkbox" name="">
                                <label for="">追加插播消息</label>
                            </div>
                        </div>
                    </td>
                </tr>
                <tr>
                	<td>字体颜色</td>
                    <td>
                    	<span class="w_p50 left"><input type="text" id="fontColor" name="fontColor" class="color_title" value="#000000"><input id="color_d" class="input_cxcolor" type="text"></span>
                        <span class="w_p50 right">
                            大小
                            <select id="bodySize">
                                <option value="12">12</option>
                                <option value="14">14</option>
                                <option value="16">16</option>
                                <option value="18">18</option>
                                <option value="20">20</option>
                                <option value="22">22</option>
                                <option value="24">24</option>
                                <option value="26">26</option>
                                <option value="28">28</option>
                                <option value="30">30</option>
                                <option value="32">32</option>
                                <option value="34">34</option>
                                <option value="36">36</option>
                                <option value="38">38</option>
                                <option value="40" selected>40</option>
                            </select>
                        </span>
                    </td>
                </tr>
                <tr>
                	<td>停靠位置</td>
                    <td>
                    	<span class="w_p48 left">
                        	<select id="bodyPosition">
                            	<option value="1">顶部</option>
                            	<option value="3">中部</option>
                                <option value="2" selected>底部</option>
                            </select>
                        </span>
                        <span class="left">
            				透明度<label class="output">0</label>
                        </span>
                        <div id="slider" class="left"></div>
                    </td>
                </tr>
            </table>
            <div class="detailbutton">
            	<input type="button" class="btn-01" value="确定" onclick="onSubmit()">
                <input type="button" class="btn-01" value="取消" onclick="onClose()">
            </div>
          </div>
        </div>
</div>
<script src="<%=path %>/js/jquery.js"></script>
<script type="text/javascript" src="<%=path%>/js/common.js"></script>
<script type="text/javascript" src="<%=path%>/layer/layer.js"></script>
<script src="<%=path %>/js/jquery-ui.js"></script>
<script src="<%=path %>/js/jquery.cxcolor.js"></script>
<script>

function changeLeaveNumber(){
	var message = $("#message").val();
	$("#leaveNumber").text(500-$.trim(message).length);
}


var number=/^\+?[1-9][0-9]*$/;

function onSubmit(){
	var $subObj={};
	
	var playDuration = $("#playDuration").val();
	
	if(!number.test(playDuration)){
		layer.alert('播放时间请输入非零的正整数!', {icon:5,title:'提示'});
		return;
	}
	
	var message = $.trim($("#message").val());
	if(message == ''){
		layer.alert('请输入插播的消息!', {icon:5,title:'提示'});
		return;
	}
	
	if(message.length > 500 ){
		layer.alert('消息长度为1~500字,当前为'+message.length+'字', {icon:5,title:'提示'});
		return;
	}
	
	$subObj["terminalId"] = "${terminalIds}";
	$subObj["durationType"] = $("#playTime option:selected").val();
	$subObj["playSpeed"] = $("#playbackSpeed option:selected").val();
	$subObj["playDuration"] = playDuration;
	$subObj["fontColor"] = $("#fontColor").val();
	$subObj["message"] = message;
	if($("#isOrNo").attr("checked") != 'checked'){
		$subObj["isAdd"] = 0;
	}else{
		$subObj["isAdd"] = 1;
	}
	$subObj["fontSize"] = $("#bodySize option:selected").val();
	$subObj["fontPosition"] = $("#bodyPosition option:selected").val();
	$subObj["fontOpacity"] = $(".output").text();
	
	
	var newsStreams = JSON.stringify($subObj);
	
	$.ajax({
	    type: "post", 
	    dataType: "json", 
	    url: "<%=path %>/newsStream/news_stream_add.do", 
	    data: {"newsStreams":newsStreams}, 
	    success: function(data) {
	    	if(data.message != 1){
	    		layer.alert('插播消息失败', {icon:5,title:'提示'});
	    	}else{
    		 	layer.alert('插播消息成功', {icon:1,title:'提示'},function(index){
    		 		parent.location = "<%=path%>/newsStream/terminal_list.do";
    	    		parent.layer.close(index);
    		 	});
	    	}
	    }, 
	    error: function() {
	    	layer.alert(err, {icon:5,title:'提示'});
	    } 
	});
}
$(function(){
	
	$( ".tabs" ).tabs();
	$( "#slider" ).slider({
		value: $(".output").text(),
		slide: function (event, ui) {
			$(".output").text(ui.value);
		}
	});
	var $color=$('#color_d');
	var $colorTitle=$('.color_title');
	$color.cxColor();
	$color.bind('change',function(){
		 $colorTitle.val(this.value);
	});
});


function onClose(){
	var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
	parent.layer.close(index);
}
</script>
</body>
</html>
