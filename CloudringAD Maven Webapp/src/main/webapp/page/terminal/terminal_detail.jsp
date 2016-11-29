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
<title>终端信息-终端详细信息</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta content="" name="description">
<meta content="" name="keywords">
<meta content="Cloudring" name="author">
<meta content="Cloudring" name="copyright">
<link rel="shortcut icon" href="<%=path %>/images/icon/icon.png">
<link rel="stylesheet" type="text/css" href="<%=path %>/css/common.css">
<link rel="stylesheet" type="text/css" href="<%=path %>/css/main.css">
<style type="text/css">
html,body{
	height:100%;
	width:100%;
	overflow:auto;
}
.layer_surveillance{
	padding:10px;
}
.layer_surveillance td{
	padding: 8px 5px;
}
#surveillance_add,.surveillance_del{
	margin-left:30px;
}
.form_item{padding: 5px 0;}
</style>
</head>

<body>
	<jsp:include page="/page/top.jsp" />  
    <div class="container">
    	<form id="aspnetForm" action="#" method="post" name="aspnetForm">
        	<div class="main_nav">终端详细信息</div>
            <table class="detailTable">
            	<colgroup>
                	<col width="12%">
                    <col width="23%">
                    <col width="10%">
                    <col width="23%">
                    <col width="10%">
                    <col width="22%">
                </colgroup>
                <tr class="detailRow1">
                	<td>终端编号:</td>
                    <td>${terminal.id }</td>
                    <td>终端名称:</td>
                    <td>${terminal.name }</td>
                    <td>分辨率:</td>
                    <td>${terminal.reolution }</td>
                </tr>
                <tr>
                	<td>终端IP:</td>
                    <td>${terminal.ip }</td>
                    <td>MAC 地址:</td>
                    <td>${terminal.mac }</td>
                    <td>所属机构:</td>
                    <td title="${terminal.mechanismName }"><div class="row-w50" style="width: 320px;">${terminal.mechanismName }</div></td>
                </tr>
                <tr class="detailRow1">
                	<td>版本:</td>
                    <td>${terminal.version }</td>
                    <td>固件信息:</td>
                    <td>${terminal.firmware }</td>
                    <td>地址:</td>
                    <td>${terminal.address }</td>
                </tr>
                <tr>
                	<td>在线时长:</td>
                    <td>${terminal.online }</td>
                    <td>终端会议室:</td>
                    <td colspan="3">
                    	<input type="text" readonly name="">
                    </td>
                </tr>
                <tr class="detailRow1">
                	<td>备注：</td>
                    <td colspan="5" title="${terminal.remark }"><div class="row-w50" style="max-width: 1350px;">${terminal.remark }</div></td>
                </tr>
            </table>
            <div class="detailbutton">
            	<input type="button" value="编辑" class="btn-01" onclick="editTerminal()">
                <input type="button" value="返回" class="btn-01" onclick="goBack()">
            </div>
            <div class="main_nav">
            	<div class="left">当前播放节目信息</div>
                <div class="right">
                	<input type="button" value="保存" class="btn-01" onclick="save()">
                    <input type="button" value="清空节目" class="btn-01" onclick="clearTheShow()">
                </div>
            </div>
            <table>
            	<colgroup>
                	<col width="8%">
                    <col width="auto">
                </colgroup>
            	<tr>
                	<td style="visibility:hidden"></td>
                    <td>
                    	<div class="play_mess">
                        	<table class="tbList">
                            	<colgroup>
                                	<col width="10%">
                                    <col width="40%">
                                    <col width="15%">
                                    <col width="10%">
                                    <col width="15%">
                                    <col width="15%">
                                </colgroup>
                                <tr>
                                	<td>ID</td>
                                    <td>节目名称</td>
                                    <td>场景数</td>
                                    <td>播放时间</td>
                                    <td>发布时间</td>
                                    <td>操作</td>
                                </tr>
                                <c:forEach items="${publishs }" var="publish">
                                	<c:if test="${publish.program_id != null}">
	                                	<tr>
		                                	<td>${publish.program_id }</td>
		                                    <td>${publish.program_name }</td>
		                                    <td>${publish.affiliations }</td>
		                                    <td>${publish.publish_user }秒</td>
		                                    <td><fmt:formatDate value="${publish.publish_time }" pattern="yyyy-MM-dd HH:mm:ss"/></td>
		                                    <td><a href="javascript:;" onclick="deleteProgram('${publish.id}')">删除</a></td>
	                                	</tr>
                                	</c:if>
                                </c:forEach>
                            </table>
                        </div>
                    </td>
                </tr>
            </table>
        </form>
    </div>
    
<script src="<%=path %>/js/jquery.js"></script>
<script src="<%=path %>/js/common.js"></script>
<script type="text/javascript" src="<%=path%>/layer/layer.js"></script>
<script type="text/javascript">
$("#v_index").removeClass("visiting");
 $("#v_program").removeClass("visiting");
$("#v_terminal").addClass("visiting");
$("#v_sys").removeClass("visiting");
$("#v_mater").removeClass("visiting");

//返回
function goBack(){
	window.location.href="<%=path%>/terminalInfo/terminal_list.do";
};

//保存按钮
function save(){
	layer.confirm('保存成功!',{icon: 1, title:'提示'},function(index){
			window.location="<%=path%>/terminalInfo/terminal_list.do";
		});
}

//编辑
function editTerminal(){
	window.location="<%=path%>/terminalInfo/terminal_info.do?terminalId=${terminal.id}&action=update";
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
		    			window.location="<%=path%>/terminalInfo/terminal_info.do?terminalId="+ids+"&action=search";
	    		 	});
		    	}
		    }, 
		    error: function(err) {
		    	layer.alert(err, {icon:5,title:'提示'});
		    } 
		});
	}, function(){
		
	});
	
}

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
			    			window.location="<%=path%>/terminalInfo/terminal_info.do?terminalId="+terminalId+"&action=search";
		    		 	});
			    	}
			    }, 
			    error: function() {
			    	layer.alert(err, {icon:5,title:'提示'});
			    } 
			});
		});
}
</script>
</body>
</html>
