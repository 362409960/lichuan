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
<title>终端监控-终端详细信息</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta content="" name="description">
<meta content="" name="keywords">
<meta content="Cloudring" name="author">
<meta content="Cloudring" name="copyright">
<link rel="shortcut icon" href="images/icon/icon.png">
<link rel="stylesheet" type="text/css" href="<%=path %>/css/common.css">
<link rel="stylesheet" type="text/css" href="<%=path %>/css/main.css">
<link rel="stylesheet" type="text/css" href="<%=path %>/css/default.css">
<style type="text/css">
html,body{
	height:100%;
	width:100%;
	overflow:auto;
}
</style>
</head>

<body>
	<jsp:include page="/page/top.jsp" />  
    <div class="container">
    	<form id="aspnetForm" action="#" method="post" name="aspnetForm">
        	<div class="main_nav">终端详细信息</div>
            <table class="detailTable">
            	<colgroup>
                	<col width="10%">
                    <col width="23%">
                    <col width="10%">
                    <col width="23%">
                    <col width="10%">
                    <col width="24%">
                </colgroup>
                <tr class="detailRow1">
                	<td>终端名称:</td>
                    <td>${terminal.name }</td>
                    <td>所属机构:</td>
                    <td title="${terminal.mechanismName }"><div class="row-w50" style="width: 320px;">${terminal.mechanismName }</div></td>
                    <td>终端状态:</td>
                    <c:if test="${terminal.status == 1 }">
                    	<th>在线</th>
                    </c:if>
                    <c:if test="${terminal.status == 0 }">
                    	<th>离线</th>
                    </c:if>
                </tr>
                <tr>
                	<td>终端IP:</td>
                    <td>${terminal.ip }</td>
                    <td>分辨率:</td>
                    <td>${terminal.reolution }</td>
                    <td>版本:</td>
                    <td>${terminal.version }</td>
                </tr>
                <tr class="detailRow1">
                	<td>播放节目名称:</td>
                    <td>&nbsp;</td>
                    <td>当前场景:</td>
                    <td>&nbsp;</td>
                    <td>播放消息:</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                	<td>磁盘剩余空间:</td>
                    <td>未知</td>
<!--                     <td>应用程序:</td> -->
<!--                     <td><a href="javascript:;">点击查看</a></td> -->
                    <td>状态更新时间:</td>
                    <td><fmt:formatDate value="${terminal.modifyDate }" pattern="yyyy-MM-dd HH:mm"/>  </td>
                </tr>
            </table>
            <div class="detailbutton">
            	<input type="button" value="清空节目" class="btn-01" onClick="clearTheShow()">
                <input type="button" value="定时开关机" class="btn-01" onClick="timeSwitch()">
<!--                 <input type="button" value="获取终端信息" class="btn-01" onClick="layerSucc()"> -->
                <input type="button" value="设置音量" class="btn-01" onClick="setVolume()">
                <input type="button" value="重启终端" class="btn-01" onClick="restartTerminal()">
                <input type="button" value="返回" class="btn-01" onclick="goBack()">
            </div>
            <div class="main_nav">
            	<div class="left">当天日程表:</div>
                <div class="right">
                </div>
            </div>
			<div class="left" style="height: 280px;overflow-x: hidden;overflow-y: auto;width: 65%;">
            	<table class="tbList">
                	<colgroup>
                    	<col width="50%">
                        <col width="20%">
                        <col width="20%">
                        <col width="20%">
                        <col width="15%">
                    </colgroup>
                    <tr>
                    	<td>节目名称</td>
                        <td>开始日期</td>
                        <td>结束日期</td>
                        <td>操作</td>
                    </tr>
                    <c:forEach items="${publishs }" var="publish">
                    	<c:if test="${publish.program_id != null}">
		                    <tr>
		                    	<td>${publish.program_name }</td>
		                        <td><fmt:formatDate value="${publish.publish_time }" pattern="yyyy-MM-dd HH:mm:ss"/></td>
		                        <td><fmt:formatDate value="${publish.expiration }" pattern="yyyy-MM-dd HH:mm:ss"/></td>
		                        <td><a href="javascript:;" onclick="deleteProgram('${publish.id}')">删除</a></td>
		                    </tr>
	                    </c:if>
                    </c:forEach>
                </table>
            </div>
            
        </form>
    </div>
<script src="<%=path%>/js/jquery.js"></script>
<script src="<%=path%>/js/common.js"></script>
<script src="<%=path%>/layer/layer.js"></script>
<script src="<%=path%>/js/terminate.js"></script>
<script type="text/javascript">
$("#v_index").removeClass("visiting");
 $("#v_program").removeClass("visiting");
$("#v_terminal").addClass("visiting");
$("#v_sys").removeClass("visiting");
$("#v_mater").removeClass("visiting");
function goBack(){
	window.location="<%=path%>/terminalMonitor/terminal_list.do";
};

function layerSucc(){
	layer.confirm('命令设置成功!',{icon: 1, title:'提示'},function(index){
		  window.location=window.location;
		});
}

//清空节目
function clearTheShow(){
	var ids = "${terminal.id}";
	layer.confirm('清空已选择终端上的节目？',{icon: 3, title:'提示'},function(index){
		$.ajax({
		    type: "post", 
		    dataType: "json", 
		    url: "<%=path %>/terminalCommand/emptyProgram.do", 
		    data: {"ids":ids}, 
		    success: function(data) {
		    	if(data.message != 1){
		    		layer.alert('命令设置失败', {icon:5,title:'提示'});
		    	}else{
		    		layer.alert('命令设置成功', {icon:1,title:'提示'},function(index){
		    			window.location="<%=path%>/terminalMonitor/terminal_info.do?terminalId=${terminal.id }";
	    		 	});
		    	}
		    }, 
		    error: function(err) {
		    	layer.alert(err, {icon:5,title:'提示'});
		    } 
		});
	});
	
};

//定时开关机
function timeSwitch(){
	layer.open({
		type: 2,
	    title: '',
	    shadeClose: false,
	    shade:  [0.8],
	    maxmin: false, //开启最大化最小化按钮
	    area: ['1024px', '480px'],
	    content: '<%=path%>/timeSwitch/timeSwitch_list.do?ids='+"${terminal.id}"
	});
// 	window.showModalDialog("<%=path%>/timeSwitch/timeSwitch_list.do?ids="+ids,window, "dialogHeight:400px;dialogWidth:1024px;center:yes;status:no;scroll:no");
};

//设置音量
function setVolume(){
	layer.open({
		type: 2,
	    title: '',
	    shadeClose: false,
	    shade:  [0.8],
	    maxmin: false, //开启最大化最小化按钮
	    area: ['750px', '180px'],
	    content: '<%=path%>/terminalMonitor/volume_page.do?terminalIds='+"${terminal.id}"
	});
// 	window.showModalDialog("<%=path%>/page/terminal/setVolume.jsp", ids,window, "dialogHeight:100px;dialogWidth:400px;center:yes;status:no;scroll:no");
};

//重启终端
function restartTerminal(){
	var ids = "${terminal.id}";
	
	layer.confirm('确定发出重启终端命令吗？',{icon: 3, title:'提示'},function(index){
		$.ajax({
		    type: "post", 
		    dataType: "json", 
		    url: "<%=path %>/terminalCommand/restart.do", 
		    data: {"ids":ids}, 
		    success: function(data) {
		    	if(data.message != 1){
		    		layer.alert('命令设置失败', {icon:5,title:'提示'});
		    	}else{
		    		layer.alert('命令设置成功', {icon:1,title:'提示'},function(index){
		    			window.location="<%=path%>/terminalMonitor/terminal_info.do?terminalId=${terminal.id }";
	    		 	});
		    	}
		    }, 
		    error: function(err) {
		    	layer.alert(err, {icon:5,title:'提示'});
		    } 
		});
	});
};

//删除节目
function deleteProgram(publishId){
	var terminalId = "${terminal.id}";
	layer.confirm('是否删除这个节目？',{icon: 3, title:'提示'},function(index){
			$.ajax({
			    type: "post", 
			    dataType: "json", 
			    url: "<%=path %>/terminalInfo/terminal_program_delete.do", 
			    data: {"publishId":publishId,"terminalId":terminalId}, 
			    success: function(data) {
			    	if(data.message != 1){
			    		layer.alert('删除失败', {icon:5,title:'提示'});
			    	}else{
			    		layer.alert('删除成功', {icon:1,title:'提示'},function(index){
			    			window.location="<%=path%>/terminalMonitor/terminal_info.do?terminalId="+terminalId+"";
		    		 	});
			    	}
			    }, 
			    error: function(err) {
			    	layer.alert(err, {icon:5,title:'提示'});
			    } 
			});
		});
}

</script>
</body>
</html>
