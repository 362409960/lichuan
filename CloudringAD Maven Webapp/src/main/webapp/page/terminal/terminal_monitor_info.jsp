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
<title>终端监控管理</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta content="" name="description">
<meta content="" name="keywords">
<meta content="Cloudring" name="author">
<meta content="Cloudring" name="copyright">
<link rel="shortcut icon" href="<%=path%>/images/icon/icon.png">
<link href="<%=path%>/css/common.css" rel="stylesheet" type="text/css">
<link href="<%=path%>/css/main.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/page.css">
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
    	<form id="aspnetForm" action="<%=path %>/terminalMonitor/terminal_list_search.do" method="post" name="aspnetForm">
    	<input type="hidden" name="pageSize" id="pageSize" value="${terminal.pageSize }">
		<input type="hidden" name="pageNumber" id="pageNumber" value="1">
        	<div class="title_Nav">
            	<div class="title_text">
                	<p>
                    	终端管理&gt;
                        <span>终端监控</span>
                    </p>
                </div>
                <div class="title_search">
                	<strong>查询:</strong>
                    <span>终端ID</span>
                    <input type="text" class="inp-60" name="id" value="${terminal.id }" maxlength="32">
                    <span>名称</span>
                    <input type="text" class="inp-60" name="name" value="${terminal.name }" maxlength="50">
                    <span>IP</span>
                    <input type="text" class="inp-90" name="ip" value="${terminal.ip }" maxlength="15">
                    <span>所属机构</span>
                    <input type="text" class="inp-90" name="mechanismName" value="${terminal.mechanismName}" maxlength="50">
                    <span>终端状态</span>
                    <select class="sel-120" name="status" id="status">
                    	<c:choose>
                             <c:when test="${empty terminal.status || terminal.status == ''}">
                                 <option value="" selected="selected">请选择</option>
                                 <option value="1" >在线</option>
                                 <option value="0" >离线</option>
                             </c:when>
                             <c:when test="${terminal.status=='1'}">
                                 <option value="" >请选择</option>
                                 <option value="1" selected="selected">在线</option>
                                 <option value="0" >离线</option>
                             </c:when>
                             <c:otherwise>
                                 <option value="" >请选择</option>
                                 <option value="1" >在线</option>
                                 <option value="0" selected="selected">离线</option>
                             </c:otherwise>
                         </c:choose>
                    </select>
                    <input type="button" class="btn-01" value="搜索" onclick="onSubmit()">
                 </div>	
            </div>
            <div class="blank3"></div>
            <table class="main_white">
            	<colgroup>
                	<col width="30%">
                    <col width="70%">
                </colgroup>
            	<tr>
                	<td align="left">
	                	<c:choose>
                             <c:when test="${empty terminal.status || terminal.status == ''}">
                                 <a href="javascript:;" style="margin:0 8px 0 12px;">所有终端(${onLine + offLine})</a>
		                    	 <a href="javascript:;" class="css_normal" style="margin-right:8px;" onclick="searchByStatus(1)">在线终端(${onLine })</a>
		                         <a href="javascript:;" class="css_normal" onclick="searchByStatus(0)">离线终端(${offLine })</a>
                             </c:when>
                             <c:when test="${terminal.status=='1'}">
                                 <a href="javascript:;" class="css_normal" style="margin:0 8px 0 12px;" onclick="searchByStatus('')">所有终端(${onLine + offLine})</a>
		                    	 <a href="javascript:;" style="margin-right:8px;">在线终端(${onLine })</a>
		                         <a href="javascript:;" class="css_normal" onclick="searchByStatus(0)">离线终端(${offLine })</a>
                             </c:when>
                             <c:otherwise>
                                 <a href="javascript:;" class="css_normal" style="margin:0 8px 0 12px;" onclick="searchByStatus('')">所有终端(${onLine + offLine})</a>
		                    	 <a href="javascript:;" class="css_normal" style="margin-right:8px;" onclick="searchByStatus(1)">在线终端(${onLine })</a>
		                         <a href="javascript:;">离线终端(${offLine })</a>
                             </c:otherwise>
                         </c:choose>
                    </td>
                    <td align="right">
                    	<input type="button" class="btn-01" value="定时开关机" onclick="timeSwitch()">
                        <input type="button" class="btn-01" value="远程安装" id="install">
                        <input type="button" class="btn-01" value="远程卸载" id="unstall">
                        <input type="button" class="btn-01" value="清空节目" onclick="clearTheShow()">
                        <input type="button" class="btn-01" value="重启终端" onclick="restartTerminal()">
                        <input type="button" class="btn-01" value="设置音量" onclick="setVolume()">
                    </td>
                </tr>
            </table>
            <div class="table_box">
            	<table class="boxList">
                	<colgroup>
                    	<col width="8%">
                    	<col width="15%">
                        <col width="10%">
                        <col width="10%">
                        <col width="15%">
                        <col width="15%">
                        <col width="12%">
                        <col width="15%">
                    </colgroup>
                    <thead>
                    	<tr>
                            <th>
                            	<input id="ckAll" type="checkbox" title="全选" name="ckAll">
                                <label for="ckAll">终端ID</label>
                            </th>
                            <th>
                            	终端名称
                                <img src="<%=path %>/images/icon/min_up.png" alt="">
                            </th>
                            <th>终端IP</th>
                            <th>终端状态</th>
                            <th>终端机构</th>
                            <th>所在分组</th>
                            <th>监控记录操作</th>
                            <th>备注</th>
                        </tr>
                    </thead> 
                    <tbody>
                    <c:forEach items="${terminal.rows }" var="terminal">
                    	<tr>
                        	<th>
                            	<input id="ckBox" type="checkbox" value="${terminal.id }" name="ckBox">
                                <label for="${terminal.id }">${terminal.id }</label>
                            </th>
                            <th>
                            	<div class="row-w50" style="max-width:200px;"><a title="${terminal.name }" href="<%=path%>/terminalMonitor/terminal_info.do?terminalId=${terminal.id }">${terminal.name }</a></div>
                            </th>
                            <th>${terminal.ip }</th>
                            <c:if test="${terminal.status == 1 }">
                            	<th>在线</th>
                            </c:if>
                            <c:if test="${terminal.status == 0 }">
                            	<th>离线</th>
                            </c:if>
                            <th title="${terminal.mechanismName }"><div class="row-w50" style="max-width:200px;">${terminal.mechanismName }</div></th>
                            <th title="${terminal.packetName }"><div class="row-w50" style="max-width:200px;">${terminal.packetName }</div></th>
                            <th><a href="<%=path%>/terminalMonitor/monitor_list.do?terminalId=${terminal.id }">详情</a></th>
                            <th title="${terminal.remark }"><div class="row-w50">${terminal.remark }</div></th>
                        </tr>
                     </c:forEach>
                    </tbody>            
                </table>
            </div>
            <div class="pagebox">
            	<div class="pageleft">
            		<c:if test="${pageTotal >10 }">
            		<c:if test="${terminal.pageNumber != 1}">
						<a href="javascript:void(0)" onclick="searchByPage('${terminal.pageNumber-1}','${terminal.pageSize}')">上一页</a>
					</c:if>
					
					<c:if test="${terminal.pageNumber != 1 and terminal.pageNumber != 2 and terminal.pageNumber != 3}">
            				<a href="javascript:void(0)" onclick="searchByPage('1','10')">1</a>
            				<span class="disabled">...</span>
           			</c:if>
            		<c:forEach begin="${terminal.pageNumber }" end="${terminal.pageNumber + 2}" step="1" var="pageIndex">
            			<c:if test="${pageIndex == terminal.pageNumber and pageIndex <= pageTotal}">
							<span class="cpb">${pageIndex}</span>
						</c:if>
            			<c:if test="${pageIndex != terminal.pageNumber and pageIndex <= pageTotal}">
							<a href="javascript:void(0)" onclick="searchByPage('${pageIndex}','${terminal.pageSize}')">${pageIndex}</a>
						</c:if>
            		</c:forEach>
            		
            		<c:if test="${terminal.pageNumber <= pageTotal - 3 }">
						<span class="disabled">...</span>
						<a href="javascript:void(0)" onclick="searchByPage('${pageTotal}','${terminal.pageSize}')">${pageTotal}</a>
					</c:if>
            		
            		<c:if test="${terminal.pageNumber != pageTotal}">
						<a href="javascript:void(0)" onclick="searchByPage('${terminal.pageNumber+1}','${terminal.pageSize}')">下一页</a>
					</c:if>
            	</c:if>
            	<c:if test="${pageTotal <= 10 }">
            		<c:if test="${terminal.pageNumber != 1}">
						<a href="javascript:void(0)" onclick="searchByPage('${terminal.pageNumber-1}','${terminal.pageSize}')">上一页</a>
					</c:if>
            		<c:forEach begin="1" end="${pageTotal}" step="1" var="pageIndex">
						<c:if test="${pageIndex == terminal.pageNumber}">
							<span class="cpb">${pageIndex}</span>
						</c:if>
						<c:if test="${pageIndex != terminal.pageNumber}">
							<a href="javascript:void(0)" onclick="searchByPage('${pageIndex}','${terminal.pageSize}')">${pageIndex}</a>
						</c:if>
					</c:forEach>
					<c:if test="${terminal.pageNumber != pageTotal}">
						<a href="javascript:void(0)" onclick="searchByPage('${terminal.pageNumber+1}','${terminal.pageSize}')">下一页</a>
					</c:if>
            	</c:if>	
                </div>
                <div class="pageright">
                	<p>每页</p>
                	<c:choose>
						<c:when test="${terminal.pageSize eq 10}">
							<a href="javascript:void(0)" onclick="searchByPage(1,50)">50</a>
		                    <a href="javascript:void(0)" onclick="searchByPage(1,30)">30</a>
		                    <span>10</span>
						</c:when>
						<c:when test="${terminal.pageSize eq 30}">
							<a href="javascript:void(0)" onclick="searchByPage(1,50)">50</a>
							<span>30</span>
		                    <a href="javascript:void(0)" onclick="searchByPage(1,10)">10</a>
						</c:when>
						<c:otherwise>
							<span>50</span>
							<a href="javascript:void(0)" onclick="searchByPage(1,30)">30</a>
		                    <a href="javascript:void(0)" onclick="searchByPage(1,10)">10</a>
						</c:otherwise>
					</c:choose>
                </div>
            </div>
        </form>
    </div>
<div class="layer_install" style="display:none">
	<table id="installTable">
    	<tr>
        	<th>apk文件路径</th>
            <td><input type="file" id="apkFile" name="apkFile" style="width: 250px;"></td>
        </tr>
        <tr>
        	<th>apk包名</th>
            <td><input type="text" name="apkName" class="inp-01" id="apkName" maxlength="20"></td>
        </tr>
        <tr>
        	<th>上传进度：</th>
        	<td><span id="progress_percent">0%</span></td>
        </tr>
        <tr>
        	<th>&nbsp;</th>
            <td>
            	<input type="button" value="远程安装" onclick="remoteInstall()" class="btn-01">
            </td>
        </tr>
    </table>
</div>
<div class="layer_unstall" style="display:none">
	<table id="installTable">
        <tr>
        	<th>apk包名</th>
            <td><input type="text" name="apk_name" id="apk_name" class="inp-01"></td>
        </tr>
        <tr>
        	<th>&nbsp;</th>
            <td>
            	<input type="button" value="远程卸载" onclick="remoteUninstall()" class="btn-01">
            </td>
        </tr>
    </table>
</div>
<script type="text/javascript" src="<%=path%>/js/jquery.js"></script>
<script type="text/javascript" src="<%=path%>/js/common.js"></script>
<script type="text/javascript" src="<%=path%>/layer/layer.js"></script>
<script type="text/javascript" src="<%=path%>/js/jquery.ajaxfileupload.js"></script>
<script type="text/javascript">
$("#v_index").removeClass("visiting");
 $("#v_program").removeClass("visiting");
$("#v_terminal").addClass("visiting");
$("#v_sys").removeClass("visiting");
$("#v_mater").removeClass("visiting");
function searchByPage(pageNumber,pageSize){
	$("#pageNumber").val(pageNumber);
	$("#pageSize").val(pageSize);
	$("#aspnetForm").submit();
}

function onSubmit(){
	$("#aspnetForm").submit();
}

//点击所有终端
function searchByStatus(status){
	$("#status").val(status);
	$("#aspnetForm").submit();
}


//定时开关机
function timeSwitch(){
	var ids = "";
	$('input[name="ckBox"]:checked').each(function(i, dom){    
		if (i != $('input[name="ckBox"]:checked').length - 1){
			ids += $(this).val()+",";    
        }
		else{
			ids += $(this).val();
		}
	});
	
	if(ids == ""){
		layer.alert('请先选择要操作的终端!', {icon:5,title:'提示'});
		return;
	}
	
	layer.open({
		type: 2,
	    title: '',
	    shadeClose: false,
	    shade:  [0.8],
	    maxmin: false, //开启最大化最小化按钮
	    area: ['1024px', '480px'],
	    content: '<%=path%>/timeSwitch/timeSwitch_list.do?ids='+ids
	});
	
// 	if(navigator.userAgent.indexOf("Chrome") >0 ){
// 		var winOption = "modal=yes,height=400,width=1024,top=50,left=50,toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,fullscreen=0";
// 	    window.open("<%=path%>/timeSwitch/timeSwitch_list.do?ids="+ids,window, winOption);
// 	}else{
// 		window.showModalDialog("<%=path%>/timeSwitch/timeSwitch_list.do?ids="+ids,window, "dialogHeight:400px;dialogWidth:1024px;center:yes;status:no;scroll:no");
// 	}
}

//远程安装
$("#install").click(function(){
	var ids = "";
	$('input[name="ckBox"]:checked').each(function(i, dom){    
		if (i != $('input[name="ckBox"]:checked').length - 1){
			ids += $(this).val()+",";    
        }
		else{
			ids += $(this).val();
		}
	});
	
	if(ids == ""){
		layer.alert('请先选择要操作的终端!', {icon:5,title:'提示'});
		return;
	}
	layer.open({
		type:1,
		title:['远程安装APK','font-size:14px;font-weight:bold'],
		shadeClose: true,
		shade: 0.8,
		area:['400px','220px'],
		content:$('.layer_install'),
	});
});

function remoteInstall(){
	var ids = "";
	$('input[name="ckBox"]:checked').each(function(i, dom){    
		if (i != $('input[name="ckBox"]:checked').length - 1){
			ids += $(this).val()+",";    
        }
		else{
			ids += $(this).val();
		}
	});
	
	if(ids == ""){
		layer.alert('请先选择要操作的终端!', {icon:5,title:'提示'});
		return;
	}
	
	var apkFile = $("#apkFile").val();
	if(apkFile == ''){
		layer.alert('请选择文件', {icon:5,title:'提示'});
		return;
	}
	
	
	var apkName = $("#apkName").val();
	if(apkName == ''){
		layer.alert('请输入apk包名', {icon:5,title:'提示'});
		return;
	}
	
	
	var index1=apkFile.lastIndexOf(".");  
	var index2=apkFile.length;
	var fileType = apkFile.substring(index1,index2);
	
	if(fileType != ".apk"){
		layer.alert('上传文件格式不正确，必须为有效文件类型:apk', {icon:5,title:'提示'});
		return;
	}
// 	$.ajax({
// 	    type: "post", 
// 	    dataType: "json", 
// 	    url: "", 
// 	    data: {"ids":ids,"apkName":apkName,"apkPath":apkPath}, 
// 	    success: function(data) {
// 	    	if(data.message != 1){
// 	    		layerAlter("提示","命令设置失败");
// 	    	}else{
// 	    		layerAlter("提示","命令设置成功");
// 	    		window.location="<%=path%>/terminalMonitor/terminal_list.do";
// 	    	}
// 	    }, 
// 	    error: function(err) {
// 	    	alert(err);
// 	    } 
// 	});
	oTimer = setInterval("getProgress()", 10);
	$.ajaxFileUpload({
        url: '<%=path %>/terminalCommand/remoeInstall.do?ids='+ids+'&apkName='+apkName, 
        type: 'post',
        secureuri: false, //一般设置为false
        fileElementId: 'apkFile', // 上传文件的id、name属性名
        dataType: 'text', //返回值类型，一般设置为json、application/json
        success: function(data, status){
    		window.clearInterval(oTimer);
    		layer.alert('命令设置成功', {icon:1,title:'提示'},function(index){
    			window.location="<%=path%>/terminalMonitor/terminal_list.do";
		 	});
        },
        error: function(data, status, e){ 
            layer.alert(e, {icon:5,title:'提示'});
        }
    });
	
}


var oTimer = null;
function getProgress() {
	var now = new Date();
    $.ajax({
        type: "post",
        dataType: "json",
        url: "<%=path%>/file/progress.do",
        data: now.getTime(),
        success: function(data) {
        	$("#progress_percent").text(data[0].percent);
        },
        error: function(err) {
        	layer.alert(err, {icon:5,title:'提示'});
        }
    });
}


//远程卸载
$("#unstall").click(function(){
	var ids = "";
	$('input[name="ckBox"]:checked').each(function(i, dom){    
		if (i != $('input[name="ckBox"]:checked').length - 1){
			ids += $(this).val()+",";    
        }
		else{
			ids += $(this).val();
		}
	});
	
	if(ids == ""){
		layer.alert('请先选择要操作的终端!', {icon:5,title:'提示'});
		return;
	}
	layer.open({
		type:1,
		title:['远程卸载APK','font-size:14px;font-weight:bold'],
		shadeClose: true,
		shade: 0.8,
		area:['400px','170px'],
		content:$('.layer_unstall'),
	});
});
function remoteUninstall(){
	var ids = "";
	$('input[name="ckBox"]:checked').each(function(i, dom){    
		if (i != $('input[name="ckBox"]:checked').length - 1){
			ids += $(this).val()+",";    
        }
		else{
			ids += $(this).val();
		}
	});
	
	
	if(ids == ""){
		layer.alert('请先选择要操作的终端!', {icon:5,title:'提示'});
		return;
	}
	
	var apkName = $("#apk_name").val();
	if(apkName == ''){
		return;
	}

	
	$.ajax({
	    type: "post", 
	    dataType: "json", 
	    url: "<%=path %>/terminalCommand/reoteUninstall.do", 
	    data: {"ids":ids,"apkName":apkName}, 
	    success: function(data) {
	    	if(data.message != 1){
	    		layer.alert('命令设置失败', {icon:5,title:'提示'});
	    	}else{
	    		layer.alert('命令设置成功', {icon:1,title:'提示'},function(index){
	    			window.location="<%=path%>/terminalMonitor/terminal_list.do";
    		 	});
	    	}
	    }, 
	    error: function(err) {
	    	layer.alert(err, {icon:5,title:'提示'});
	    } 
	});
}

//清空节目
function clearTheShow(){
	var ids = "";
	$('input[name="ckBox"]:checked').each(function(i, dom){    
		if (i != $('input[name="ckBox"]:checked').length - 1){
			ids += $(this).val()+",";    
        }
		else{
			ids += $(this).val();
		}
	});
	if(ids == ""){
		layer.alert('请先选择要操作的终端!', {icon:5,title:'提示'});
		return;
	}
	
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
		    			window.location="<%=path%>/terminalMonitor/terminal_list.do";
	    		 	});
		    	}
		    }, 
		    error: function(err) {
		    	layer.alert(err, {icon:5,title:'提示'});
		    } 
		});
	});
	
}

//重启终端
function restartTerminal(){
	var ids = "";
	$('input[name="ckBox"]:checked').each(function(i, dom){    
		if (i != $('input[name="ckBox"]:checked').length - 1){
			ids += $(this).val()+",";    
        }
		else{
			ids += $(this).val();
		}
	});
	if(ids == ""){
		layer.alert('请先选择要操作的终端!', {icon:5,title:'提示'});
		return;
	}
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
		    			window.location="<%=path%>/terminalMonitor/terminal_list.do";
	    		 	});
		    	}
		    }, 
		    error: function(err) {
		    	layer.alert(err, {icon:5,title:'提示'});
		    } 
		});
	});
}

//设置音量
function setVolume(){
    var terminalIds = "";

	$('input[name="ckBox"]:checked').each(function(i, dom){    
		if (i != $('input[name="ckBox"]:checked').length - 1){
			terminalIds += $(this).val()+",";    
        }
		else{
			terminalIds += $(this).val();
		}
	});
	 
	if(terminalIds == ""){
		layer.alert('请先选择要操作的终端!', {icon:5,title:'提示'});
		return;
	}
 
	layer.open({
		type: 2,
	    title: '',
	    shadeClose: false,
	    shade:  [0.8],
	    maxmin: false, //开启最大化最小化按钮
	    area: ['750px', '180px'],
	    content: '<%=path%>/terminalMonitor/volume_page.do?terminalIds='+terminalIds
	});
	
	
	
// 	if(navigator.userAgent.indexOf("Chrome") >0 ){
// 		var winOption = "modal=yes,height=180,width=750,top=50,left=50,toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,fullscreen=0";
// 	    window.open("<%=path%>/page/terminal/setVolume.jsp",window, winOption);
// 	}else{
// 		window.showModalDialog("<%=path%>/page/terminal/setVolume.jsp", window, "dialogHeight:180px;dialogWidth:750px;center:yes;status:no;scroll:no");
// 	}
}


//全选
$(document).ready(function(e) {
    $('#ckAll').click(function(){
		var _this=this;
		var oCheckbox=$('.table_box').find("input[type=checkbox]");
		oCheckbox.each(function(index, element) {
			$(this).attr('checked',_this.checked);
		});
		console.log(_this.checked);
	});	
    var $aCheckBox=$("[name='ckBox']");
    $aCheckBox.each(function(index, element){
    	var $this=$(this);
    	$this.bind('click',function(){
    		var $aChLen=$(':checkbox[name=ckBox]:checked').length;
    		var $aBox=$aCheckBox.length;
    		if($aChLen==$aBox){
    			$("#ckAll").attr('checked',this.checked);
    		}else{
    			$("#ckAll").removeAttr('checked');
    		}
    	});
    });
});
</script>
</body>
</html>
