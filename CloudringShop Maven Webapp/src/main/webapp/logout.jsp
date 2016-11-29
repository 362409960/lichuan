<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="cloud.shop.common.Constants" %>
<%@page import="cloud.shop.goods.entity.Customer" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title></title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
  </head>
  
  <body>
   <%  
request.getSession().removeAttribute(Constants.SESSION_LOGIN_USER_GOODS);
request.getSession().removeAttribute("username");
request.getSession().invalidate(); 
response.sendRedirect("http://localhost:8080/cas/logout?service=http://localhost:8080/CloudringShop/login/login.do");  
%>  
  </body>
</html>
