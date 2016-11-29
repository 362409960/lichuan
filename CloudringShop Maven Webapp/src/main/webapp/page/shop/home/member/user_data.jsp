<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="/WEB-INF/tlds/c.tld" prefix="c"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title></title>
	<link href="../css/shop/common.css" rel="stylesheet" type="text/css" />
	<link href="../css/shop/member.css" rel="stylesheet" type="text/css" /> 
	<script type="text/javascript" src="<%=path%>/js/jquery.min.js"></script>	
	 <script type="text/javascript" src="<%=path%>/js/shop/jquery.validate.js"></script> 
	
<script type="text/javascript">
var contextPath = "${pageContext.request.contextPath}";
$().ready(function() {

	var $inputForm = $("#inputForm");
	// 表单验证
	$inputForm.validate({
		rules: {
			email: {
				required: true,
				email: true
					,remote: {
						url: contextPath+ "/register/check_email.do",
						cache: false
					}
			}
						
						,mobile: {
								pattern: /^1[3|4|5|7|8]\d{9}$/
						}
		}
			,messages: {
				email: {
					remote: "已存在"
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
					<div class="title">个人资料</div>
					<form id="inputForm" action="<%=path %>/member/updateUserData.do" method="post">
					<input type="hidden" name="id"  value="${user.id}"/>
						<table class="input">
							<tr>
								<th>
									用户名:
								</th>
								<td>
									${user.name}
								</td>
							</tr>
							<tr>
								<th>
									<span class="requiredField">*</span>E-mail:
								</th>
								<td>
									<input type="text" name="email" class="text" value="${user.email}" maxlength="200" />
								</td>
							</tr>
							<tr>
								<th>
									昵称:
								</th>
								<td>
									<input type="text" name="nick" class="text" value="${user.nick}" maxlength="200" />
								</td>
							</tr>									
							<tr>
								<th>
									性别:
								</th>
								<td>
									<span class="fieldSet">
											<label>
											     <c:choose>
											         <c:when test="${user.sex==0}"><input type="radio" name="sex" value="0" checked="checked" />男</c:when>
											         <c:otherwise><input type="radio" name="sex" value="0" />男</c:otherwise>
											      </c:choose>
												
											</label>
											<label>
											<c:choose>
											         <c:when test="${user.sex==1}"><input type="radio" name="sex" value="1" checked="checked" />女</c:when>
											         <c:otherwise><input type="radio" name="sex" value="1" />女</c:otherwise>
											      </c:choose>
												
											</label>
									</span>
								</td>
							</tr>
							<tr>								
							<tr>
								<th>
									手机:
								</th>
								<td>
										<input type="text" name="mobile" class="text" value="${user.mobile}" maxlength="200" />
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
