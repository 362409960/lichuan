<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="/WEB-INF/tlds/c.tld" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<html>
<head>
<meta charset="UTF-8">
<title>用户详情</title>
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
<script type="text/javascript" src="<%=path%>/layer/layer.js"></script>
<style type="text/css">
html,body {
	height: 100%;
	width: 100%;
	overflow:auto;
}
</style>
<script type="text/javascript">
	$("#v_index").removeClass("visiting");
 $("#v_program").removeClass("visiting");
$("#v_terminal").removeClass("visiting");
$("#v_sys").addClass("visiting");
$("#v_mater").removeClass("visiting");
	function save(){
		var id=$("#id").val();
		window.location.href = '<%=request.getContextPath()%>/admin/user/detailsUser.do?id='+id+"&action=1";
	}
	
</script>
</head>

<body>
	<jsp:include page="/page/top.jsp" />
	<div class="blank9"></div>
	<div class="container">
		<!-- 隐藏域 -->
		<input type="hidden" name="id" id="id" value="${user.id }" /> 
		<input type="hidden" name="province" id="province" value="${user.province_no}"> 
		<input type="hidden" name="city" id="city" value="${user.city_no}"> 
		<input type="hidden" name="district" id="district" value="${user.district_no}">
		
		<div class="main_nav">编辑用户信息</div>
		<table class="detailTable">
			<colgroup>
				<col width="15%">
				<col width="35%">
				<col width="15%">
				<col width="35%">
			</colgroup>
			<tr class="detailRow1">
				<td>用户代码(用户登录)：<span class="cRed">*</span></td>
				<td>${user.userCode }</td>
				<td>密码：<span class="cRed">*</span></td>
				<td>
					****** <!-- <input type="button" value="修改密码" class="btn-01" onclick="updatePwd();"> -->
				</td>
			</tr>
			<tr>
				<td>用户名：<span class="cRed">*</span></td>
				<td>${user.userName }</td>
				<td>电子邮件：</td>
				<td>${user.email }</td>
			</tr>
			<tr class="detailRow1">
				<td>地址：</td>
				<td colspan="3">
					${user.address }
				</td>
			</tr>
			<tr>
				<td>邮编：</td>
				<td>${user.postcode }</td>
				<td>号码：</td>
				<td>${user.phone }</td>
			</tr>
			<tr class="detailRow1">
				<td>QQ：</td>
				<td>${user.qq }</td>
				<td colspan="2"></td>
			</tr>
			<tr>
				<td valign="top" style="height:50px;">备注：</td>
				<td style="vertical-align:top;" colspan="3">
					<div class="word-style">${user.remark }</div>
				</td>
			</tr>
		</table>
		<div class="main_nav">权限信息</div>
		<table class="detailTable">
			<colgroup>
				<col width="15%">
				<col width="35%">
				<col width="50%">
			</colgroup>
			<tr>
				<td>所属机构: <span class="cRed">*</span></td>
				<td>${user.departmentname }</td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td>拥有角色: </td>
				<td colspan="2">
					<c:forEach items="${allRoles}" var="role">
						<c:if test="${role.is_checked eq 'true'}"><div class="imageholder">${role.role_name}</div></c:if>
					</c:forEach>
				</td>
			</tr>
		</table>
		<div class="detailbutton">
			<input type="button" value="编辑" class="btn-01" onclick="save();" />&nbsp;&nbsp;
			<input type="button" value="返回" class="btn-01" onclick="javascript:history.go(-1);">
		</div>
	</div>
</body>
</html>
