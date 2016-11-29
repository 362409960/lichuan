<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="/WEB-INF/tlds/c.tld" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
<title>机构详情</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta content="" name="description">
<meta content="" name="keywords">
<meta content="Cloudring" name="author">
<meta content="Cloudring" name="copyright">
<link rel="shortcut icon" href="<%=request.getContextPath()%>/images/icon/icon.png">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/common.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/main.css">
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common.js"></script>\
<script type="text/javascript" src="<%=path%>/layer/layer.js"></script>
<style type="text/css">
html,body{
	height:100%;
	width:100%;
	overflow:auto;
}
</style>
<script type="text/javascript">
	$(function(){
		$("#v_index").removeClass("visiting");
 		$("#v_program").removeClass("visiting");
		$("#v_terminal").removeClass("visiting");
		$("#v_sys").addClass("visiting");
		$("#v_mater").removeClass("visiting");
		
		$("#addUser").click(function() {
			var url = "<%=request.getContextPath()%>/admin/department/toUserInfo.do?id="+$("#id").val();
	        var winOption = "height="+440+",width="+1010+",top=300,left=400,toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,fullscreen=0";
	        navigator.userAgent.indexOf("Chrome") >0 ? window.open(url,window, winOption) : window.showModalDialog(url, "", "dialogHeight:440px;dialogWidth:1010px;dialogTop:300;dialogLeft:400;center:yes;status:no");
	    });
	});
	
	function save(){
		var id=$("#id").val();
		window.location.href = '<%=request.getContextPath()%>/admin/department/detailsDepartment.do?id='+id+"&action=1";
	}

</script>
</head>

<body>
	<jsp:include page="/page/top.jsp" />
    <div class="blank9"></div>
    <div class="container">
    	<form name="departmentForm" method="post" action="<%=request.getContextPath()%>/admin/department/editDepartment.do" id="departmentForm">
    		<!-- 隐藏域 -->
            <input id="id" name="id" type="hidden" value="${department.id }" />
			<input id="pid" name="pid" type="hidden" value="${department.pid }" />
			
        	<div class="main_nav">编辑用户信息</div>
            <table class="detailTable">
            	<colgroup>
                	<col width="15%">
                    <col width="35%">
                    <col width="15%">
                    <col width="35%">
                </colgroup>
                <tr class="detailRow1">
                	<td>上级机构: </td>
                    <td>
						${department.parentName }
                    </td>
                    <td>机构名称: </td>
                    <td>
                    	${department.name }
                    </td>
                </tr>
                <!-- <tr>
                	<td>分发服务器：</td>
                    <td>
                    	${department.dist_server }
                    </td>
                    <td colspan="2"></td>
                </tr> -->
                <tr>
                	<td>机构备注：</td>
                    <td colspan="3">
                    	${department.remark }
                    </td>
                </tr>
            </table>
            <div class="main_nav" style="text-align:right">
                <input type="button" value="编辑" class="btn-01" onclick="save();"/>&nbsp;&nbsp;
				<input type="button" value="返回" class="btn-01" onclick="javascript:history.go(-1);">
            </div>
            <div id="PlayerInfoDiv">
            	<div class="main_nav">
                	<table>
                    	<colgroup>
                        	<col width="20%">
                            <col width="30%">
                            <col width="20%">
                            <col width="30%">
                        </colgroup>
                        <tr>
                        	<!-- <td><strong class="black">所属终端</strong></td>
                            <td align="right" style="padding-right:15px;">
                            	<input type="button" value="分配终端" class="btn-01">
                                <input type="button" value="删除终端" class="btn-01">
                            </td> -->
                            <td></td>
                            <td></td>
                            <td><strong class="black">用户代码</strong></td>
                            <td align="right" style="padding-right:15px;">
                            	<input type="button" id="addUser" value="新建用户" class="btn-01">
                            </td>
                        </tr>
                    </table>
                </div>
                <!-- <table class="detailTable">
                	<colgroup>
                    	<col width="50%">
                        <col width="50%">
                    </colgroup>
                    <tr>
                    	<td>
                        	<ul class="userList">
                            	<li>
                                	<input type="checkbox" value="">
                                    <label for="">
                                    	fende<span class="cRed">(播放终端)</span>
                                    </label>
                                </li>
                                <li>
                                	<input type="checkbox" value="">
                                    <label for="">
                                    	虚拟终端<span class="cRed">(播放终端)</span>
                                    </label>
                                </li>
                            </ul>
                        </td>
                        <td>
                        	<div class="userList">
								<c:forEach items="${users }" var="user">
                            		<p>${user.userName }</p>
								</c:forEach>
                            </div>
                        </td>
                    </tr>
                </table> -->
                <table class="detailTable">
                    <tr>
                        <td>
                        	<div class="userList">
								<c:forEach items="${users }" var="user">
                            		<p>
                            			${user.userCode }
                            			<!-- <a href='<%=request.getContextPath()%>/admin/user/detailsUser.do?id=${user.id }' target='_self' title='${user.userCode }'>${user.userCode }</a> -->
                            		</p>
								</c:forEach>
                            </div>
                        </td>
                    </tr>
                </table>
            </div>
        </form>
    </div>
</body>
</html>
