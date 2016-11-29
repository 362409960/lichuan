<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="/WEB-INF/tlds/c.tld" prefix="c"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
  </head>
  
  <body>
     <%-- <jsp:forward page="/home/showShopForwardIndex.do"/> --%>
     <%-- <c:redirect url="/login/login.do"/> --%>
     <%--单点登录改回不使用单点登录 --%>
     <c:redirect url="/home/showShopIndex.do"/>
  </body>
</html>
