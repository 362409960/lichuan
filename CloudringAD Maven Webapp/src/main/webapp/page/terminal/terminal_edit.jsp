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
<title>终端信息-编辑终端详细信息</title>
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
</style>
</head>

<body>
	<jsp:include page="/page/top.jsp" />
    <div class="container">
    	<form id="aspnetForm" action="<%=path%>/terminalInfo/terminal_update.do" method="post" name="aspnetForm">
    		<input type="hidden" name="id" id="id" value="${terminal.id }">
        	<div class="main_nav">编辑终端信息</div>
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
                	<td>终端编号:</td>
                    <td>${terminal.id }</td>
                    <td>终端名称:</td>
                    <td><input type="text" value="${terminal.name }" name="name" maxlength="50"></td>
                    <td>分辨率:</td>
                    <td>${terminal.reolution }</td>
                </tr>
                <tr>
                	<td>终端IP:</td>
                    <td>${terminal.ip }</td>
                    <td>MAC 地址:</td>
                    <td>${terminal.mac }</td>
                    <td>所属机构:</td>
                    <td>${terminal.mechanismName }</td>
                </tr>
                <tr class="detailRow1">
                	<td>版本:</td>
                    <td>${terminal.version }</td>
                    <td>固件信息:</td>
                    <td>${terminal.firmware }</td>
                    <td>地址:</td>
                    <td>
                    	<input type="text" name="address" value="${terminal.address }" maxlength="50">
                    </td>
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
                    <td colspan="5">
                    	<input type="text" name="remark" value="${terminal.remark }" maxlength="250">
                    </td>
                </tr>
            </table>
            <div class="main_nav">
                <div class="right">
                	<input type="submit" value="保存" class="btn-01">
                    <input type="button" value="返回" class="btn-01" onclick="goBack()">
                </div>
            </div>
        </form>
    </div>
<script src="<%=path %>/js/jquery.js"></script>
<script src="<%=path %>/js/common.js"></script>
<script src="<%=path%>/layer/layer.js"></script>
<script type="text/javascript">
$("#v_index").removeClass("visiting");
 $("#v_program").removeClass("visiting");
$("#v_terminal").addClass("visiting");
$("#v_sys").removeClass("visiting");
$("#v_mater").removeClass("visiting");
function goBack(){
	window.location="<%=path%>/terminalInfo/terminal_info.do?terminalId=${terminal.id}&action=search";
};

</script>
</body>
</html>
