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
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common.js"></script>
<script type="text/javascript"  src="<%=path%>/layer/layer.js"></script>
<style type="text/css">
html,body{
	height:100%;
	width:100%;
	overflow:auto;
}
</style>
<script type="text/javascript">
	$("#v_index").removeClass("visiting");
 	$("#v_program").removeClass("visiting");
	$("#v_terminal").removeClass("visiting");
	$("#v_sys").addClass("visiting");
	$("#v_mater").removeClass("visiting");
	
	$(function(){
		$("#departmentname").click(function() {
			var url = "<%=request.getContextPath()%>/admin/department/listDepartment.do?action=ztree";
// 	        var returnParm = window.showModalDialog(url, "", "dialogHeight:310px;dialogWidth:410px;dialogTop:400;dialogLeft:700;center:yes;status:no;");
// 	        if (returnParm != null) {
// 	        	var parm = returnParm.split(",");
// 	        	$("#pid").val(parm[0]);
// 	            $("#parentName").val(parm[1]);
// 	        }
	        
	        var returnParm='';
	        var winOption = "height="+310+",width="+410+",top=400,left=700,toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,fullscreen=0";
	        
	        if(navigator.userAgent.indexOf("Chrome") >0){//谷歌浏览器
	        	returnParm=window.open(url,window, winOption);
	        	$("#departmentid").val(document.getElementById("departmentid").value);
	            $("#departmentname").val(document.getElementById("departmentname").value);
	        }else{
	        	returnParm=window.showModalDialog(url, "", "dialogHeight:310px;dialogWidth:410px;dialogTop:400;dialogLeft:700;center:yes;status:no");
	        }
	        
	        if (returnParm != null) {
	        	var parm = returnParm.split(",");
	        	$("#departmentid").val(parm[0]);
	            $("#departmentname").val(parm[1]);
	        }
	        
	    });
	});
	
	function save(){
		var form = $("#departmentForm");
		var id = $("#id").val();
		var name = $("#name").val();
		var kgReg = /^[^\s]*$/;//空格
		
		if($("[name='parentName']").val()==""){
			layerAlter("提示","上级机构不能为空！");
			return false;
		}
		if($("[name='name']").val()==""||!kgReg.test($("[name='name']").val())){
			layerAlter("提示","机构名称不能为空或空格字符！");
			return false;
		}
		if($("[name='remark']").val().length>500){
	 		layerAlter("提示","备注长度不能大于500位！");
	 		return false;
	 	}
		$.ajax({
			url : "<%=request.getContextPath()%>/admin/department/queryName.do?id="+id+"&name="+name,
			type: "POST",
			cache:false,
			async:true,
			dataType: "json",
			success:function(data) {
				if(data=="true"){
					layerAlter("提示","机构名称已存在！");
				}else{
					form.submit();
				}
	        },
			error:function(XMLHttpRequest, textStatus, errorThrown) {
	            layerAlter("提示","操作出现异常！");
	        }
	    });
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
			<input id="departmentid" name="pid" type="hidden" value="${department.pid }" />
			
        	<div class="main_nav">编辑用户信息</div>
            <table class="detailTable">
            	<colgroup>
                	<col width="15%">
                    <col width="35%">
                    <col width="15%">
                    <col width="35%">
                </colgroup>
                <tr class="detailRow1">
                	<td>上级机构:&nbsp;&nbsp;<span class="cRed">*</span></td>
                    <td>
						<c:if test="${department.pid eq '0' }"></c:if>
						<c:if test="${department.pid != '0' }"><input name="parentName" type="text" id="departmentname" readonly="readonly" value="${department.parentName }" /></c:if>
                    </td>
                    <td>机构名称:&nbsp;&nbsp;<span class="cRed">*</span></td>
                    <td>
                    	<input name="name" type="text" maxlength="48" id="name" value="${department.name }" />
                    </td>
                </tr>
                <!-- <tr>
                	<td>分发服务器：</td>
                    <td>
                    	<select name="dist_server" id="dist_server">
							<option value="">请选择</option>
							<option value="1">主服务器</option>
						</select>
                    </td>
                    <td colspan="2"></td>
                </tr> -->
                <tr>
                	<td>机构备注：</td>
                    <td colspan="3">
                    	<textarea name="remark" rows="2" cols="20" id="remark">${department.remark }</textarea>
                    </td>
                </tr>
            </table>
            <div class="detailbutton">
                <input type="button" value="提交" class="btn-01" onclick="save();"/>&nbsp;&nbsp;
				<input type="button" value="返回" class="btn-01" onclick="javascript:history.go(-1);">
            </div>
        </form>
    </div>
</body>
</html>
