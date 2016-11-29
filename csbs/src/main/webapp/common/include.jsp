<%@page import="cloud.app.common.Constants"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="/WEB-INF/tlds/c.tld" prefix="c"%>

<script>
	var contextPath = "${pageContext.request.contextPath}";
</script>
<%
	if (session.getAttribute(Constants.SESSION_LOGIN_USER) == null) {//判断是否存在session，不存在就跳转到首页(登陆页)
		String path = request.getContextPath();
		String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
		response.sendRedirect(basePath);
	}
%>
