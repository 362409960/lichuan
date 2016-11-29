<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<% 
    String path = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta charset="utf-8">
<title>节目制作</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta content="" name="description">
<meta content="" name="keywords">
<meta content="Cloudring" name="author">
<meta content="Cloudring" name="copyright">
<link rel="shortcut icon" href="<%=request.getContextPath()%>/images/icon/icon.png">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/common.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/main.css">
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common.js"></script>
<style type="text/css">
html,body{
	height:100%;
	width:100%;
	overflow:hidden;
}
</style>
</head>

<body>
	<div id="header" class="header">
    	<div id="logo" class="logo">
        	<div class="lotipbox">
            	<a class="ali01" href="javascript:;">
                	<span id="azh"></span>
                </a>
                <div id="tanzh" class="lotoptan">
                	<div class="lotoptnr">
                    	<a id="modifyPwd" class="cWhite underLine" href="javascript:;">修改密码</a>
                        <a id="exitlogin" class="cWhite" href="javascript:;">退出</a>
                    </div>
                </div>
            </div>
        	<div class="welcome-info">
            	<span>欢迎您：</span><a id="loginName" href="javascript:;">20356</a>
            </div>
        </div>
        <div class="clearfix"></div>
        <div class="container_bg">
        	<div class="menuleft">
            	<div class="menuright">
                	<ul id="menu">
                    	<li>
                        	<a class="menuNormal" href="index.html">系统首页</a>
                        </li>
                        <li>
                        	<a class="menuNormal" href="javascript:;">节目管理</a>
                            <span>
                            	<a href="make.html">制作</a>
                                |
                                <a href="projectsetlist.html">管理</a>
                                |
                                <a href="publishManagelist.html">发布</a>
                                |
                                <a href="ProjectDownloadList.html">下载管理</a>
                                |
                                <a href="javascript:;">删除终端节目</a>
                                |
                                <a href="javascript:;">节目备份</a>
                                |
                                <a href="javascript:;">一键发布</a>
                                |
                            </span>
                        </li>
                        <li>
                        	<a class="menuNormal" href="javascript:;">终端管理</a>
                            <span>
                            	<a href="PlayerInsertMessage.html">插播消息</a>
                                |
                                <a href="PlayerMonitorInfo.html">终端监控</a>
                                |
                                <a href="PlayerInfo.html">终端信息</a>
                                |
                                <a href="javascript:;">终端带宽管理</a>
                                |
                                <a href="javascript:;">终端升级</a>
                                |
                            </span>
                        </li>
                        <li class="visiting">
                        	<a class="menuNormal" href="javascript:;">系统设置</a>
                            <span>
                            	<a href="<%=request.getContextPath()%>/admin/user/listSysUser.do">用户管理</a>
                                |
                                <a href="<%=request.getContextPath()%>/admin/role/listRole.do">角色管理</a>
                                |
                                <a class="subvisiting" href="<%=request.getContextPath()%>/admin/department/list.do">机构管理</a>
                                |
                                <a href="javascript:;">参数设置</a>
                                |
                                <a href="javascript:;">数据采集服务</a>
                                |
                            </span>
                        </li>
                        <li>
                        	<a class="menuNormal" href="javascript:;">系统日志</a>
                            <span>
                            	<a href="UserOperateInfo.html">用户操作日志</a>
                                |
                                <a href="MaterialList.html">素材统计表</a>
                                |
                            </span>
                        </li>
                        <li>
                        	<a class="menuNormal" href="javascript:;">素材管理</a>
                            <span>
                            	<a href="MaterialManage.html">素材管理</a>
                                |
                                <a href="MotherBoardManage.html">模板管理</a>
                                |
                                <a href="javascript:;">模板商城</a>
                                |
                                <a href="javascript:;">应用管理</a>
                                |
                            </span>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <div class="blank9"></div>
    <div class="container">
    	<form id="aspnetForm" action="#" method="post" name="aspnetForm">
        	<div class="title_Nav">
            	<div class="title_text">
                	<p>
                    	 系统设置&gt;
                        <span>机构管理</span>
                    </p>
                </div>
            </div>
            <div class="blank3"></div>
            <table class="main_white">
            	<colgroup>
                	<col width="50%">
                    <col width="50%">
                </colgroup>
            	<tr>
                	<td align="left">
                    	<span style="padding-left:15px;">共计：</span>
                        <strong class="black">1;</strong>
                    </td>
                    <td align="right">
                    	<input type="button" class="btn-01" value="新建">
                        <input type="button" class="btn-01" value="删除">
                    </td>
                </tr>
            </table>
            <div class="table_box">  
            </div>
        </form>
    </div>
</body>
</html>
