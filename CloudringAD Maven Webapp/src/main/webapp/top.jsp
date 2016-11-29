<%@ page language="java" pageEncoding="utf-8" %>
<%@page import="cloud.app.common.Constants" %>
<%@page import="cloud.app.system.vo.SysUserVO" %>


<% 
    String path = request.getContextPath();
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>头部</title>
	<link rel="stylesheet" type="text/css" href="<%=path%>/css/201202/main.css" />
    <script type="text/javascript" src="<%=path%>/js/jquery.min.js"></script>
</head>

<script language="javascript">
		function btnChangeClass(btn,clsName){
			if(btn){
				btn.className = clsName;
			}
		}

		function btnChangepwd_Click(){
			var url = "<%=path%>/modifyPwd.jsp";
			window.showModalDialog(url,'','dialogWidth:600px;dialogHeight:260px;help:no;status:no;fullscreen=3;center:yes;location:no');
		}

		function btnExit_Click(){
			top.location = "<%=path%>/sys/logout.do";
		}
		
		function btnLogin_Click(){
			top.location = "<%=path%>/login.jsp";
		}
</script>
<%
    SysUserVO sysUserVO = null;
	String userName = "游客";
    Object obj = session.getAttribute(Constants.SESSION_LOGIN_USER);
    if(obj != null){
    	sysUserVO = (SysUserVO)obj;
    	userName = sysUserVO.getUserName();
    }
%>
<body>
		<div class="sme_header">
			<div class="sme_top">
	    		<div class="sme_logo"><a href="#" title="回到首页"></a></div>
	        	<h1>&nbsp;Cloud云平台</h1>
	        	<%if("游客".equals(userName)){ %>
    	 			<h2>用户名：<%=userName%>&nbsp;|&nbsp;
	        			<a href="#" title="登陆" onclick="btnLogin_Click();">登陆</a>
	        		</h2>
				<%}else{ %>
	 				 <h2>用户名：<%=userName%>&nbsp;|&nbsp;<a href="#" title="修改密码" onclick="btnChangepwd_Click();">修改密码</a>&nbsp;|&nbsp;<a href="#" title="注销" onclick="btnExit_Click();">注销</a>|&nbsp;</h2>
				<%}%>
	   	 	</div>
		</div>
	</body>
</html>
