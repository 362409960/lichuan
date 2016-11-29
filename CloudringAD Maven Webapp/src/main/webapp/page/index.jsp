<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/tlds/c.tld" prefix="c"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>系统首页</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta content="" name="description">
<meta content="" name="keywords">
<meta content="Cloudring" name="author">
<meta content="Cloudring" name="copyright">
<link rel="shortcut icon" href="<%=path%>/images/sys/icon/icon.png">
<link href="<%=path%>/css/sys/common.css" rel="stylesheet" type="text/css">
<link href="<%=path%>/css/sys/main.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="<%=path%>/js/sys/jquery.js"></script>
<script type="text/javascript" src="<%=path%>/js/sys/common.js"></script>
<script type="text/javascript" src="<%=path%>/layer/layer.js"></script>

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
    	<div class="main_index_left">
        	<div class="index_bigimg">
            	<ul id="bigimgul">
                	<li>
                    	<a id="createProId" class="index_button index_button_11" href="<%=path%>/program/toMake.do"></a>
                    </li>
                    <li>
                    	<a class="index_button index_button_19" href="<%=path%>/publish/toPublish.do"></a>
                    </li>
                    <li>
                    	<a class="index_button index_button_59" href="<%=path%>/template/toList.do"></a>
                    </li>
                    <li>
                    	<a class="index_button index_button_22" href="<%=path%>/terminalMonitor/terminal_list.do"></a>
                    </li>
                </ul>
            </div>
            <div class="index_smallimg">
            	<div class="blank20"></div>
                <ul id="smallimgul">
                	<li><a href="<%=path%>/material/toList.do">素材管理</a></li>
                    <li><a href="<%=path%>/programDownloadManager/toPublishList.do">下载管理</a></li>
                    <li><a href="<%=path%>/removeTerminalProgram/toList.do">删除终端节目</a></li>
                    <li><a href="<%=path%>/terminalInfo/terminal_list.do">终端信息管理</a></li>
                </ul>
            </div>
        </div>
        <div class="main_index_right">
        	<h3 class="baseinfo">基本信息</h3>
            <ul class="main_index_right_ul">
            	<li class="li_index_right">
                	终端:
                    <a id="" href="<%=path%>/terminalInfo/terminal_list.do">${terminalList.size()}</a>
                </li>
                <li class="li_index_right">
                	节目：
                    <a id="" href="<%=path%>/program/toProject.do">${programTotal}</a>
                </li>
            </ul>
            <h3>最新节目</h3>
            <ul class="main_index_right_ul">
                <c:forEach items="${programList}" var="list" >
                    <li class="li_index_right"><a href="<%=path%>/program/toProgramDetailsEdit.do?id=${list.id}"><span title="${list.program_name}">${list.program_name}</span></a></li>
                </c:forEach>
            </ul>
           <!--  <h3>待审批发布单</h3>
            <div id="div_virtual_player">
            	
            </div> -->
        </div>
    </div>
    <div class="blank9"></div>
    <div class="footer"></div>
</body>
</html>
