<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="/WEB-INF/tlds/c.tld" prefix="c"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  <meta http-equiv="content-type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title></title>
	<link href="<%=path%>/css/shop/common.css" rel="stylesheet" type="text/css" />
	<link href="<%=path%>/css/shop/member.css" rel="stylesheet" type="text/css" /> 
	<script type="text/javascript" src="<%=path%>/js/jquery.min.js"></script>
	<script type="text/javascript" src="<%=path%>/js/shop/common.js"></script>
	<script type="text/javascript" src="<%=path%>/js/jquery.validate.js"></script>
<script type="text/javascript">
var contextPath = "${pageContext.request.contextPath}";
$().ready(function() {

	var $inputForm = $("#inputForm");
	// 表单验证
	$inputForm.validate({
		rules: {
			currentPassword: {
				required: true,
				remote: {
					url: contextPath+ "/member/check_password.do",
					cache: false
				}
			},
			password: {
				required: true,
				minlength: 6
			},
			rePassword: {
				required: true,
				equalTo: "#password"
			}
		}
		,messages: {
				currentPassword: {
					remote: "输入错误"
				}
			}
	});

});
</script>
<style>
body {
    overflow-x:hidden;overflow-y:hidden;
}
</style>

  </head>
  
  <body>
   <div class="container member">
  <div class="row"> 
    
			<div class="span10">
				<div class="input">
					<div class="title">修改密码</div>
					<form id="inputForm" action="<%=path %>/member/updateUserPassword.do" method="post">
					<input type="hidden" name="id"  value="${user.id}"/>
						<table class="input">
							<tr>
								<th>
									当前密码:
								</th>
								<td>
									<input type="password" name="currentPassword" class="text" maxlength="200" autocomplete="off" />
								</td>
							</tr>
							<tr>
								<th>
									新密码:
								</th>
								<td>
									<input type="password" id="password" name="password" class="text" maxlength="20" autocomplete="off" />
								</td>
							</tr>
							<tr>
								<th>
									确认密码:
								</th>
								<td>
									<input type="password" name="rePassword" class="text" maxlength="20" autocomplete="off" />
								</td>
							</tr>
							<tr>
								<th>
									&nbsp;
								</th>
								<td>
									<input type="submit" class="button" value="提 交" />
									<input type="button" class="button" value="返 回" onclick="history.back(); return false;" />
								</td>
							</tr>
						</table>
					</form>
				</div>
			</div>
</div>
</div>
  </body>
</html>
