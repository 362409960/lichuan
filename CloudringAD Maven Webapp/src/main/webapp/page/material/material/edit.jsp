<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/tlds/c.tld" prefix="c"%>
<%@ taglib uri="/WEB-INF/tlds/fmt.tld" prefix="fmt"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>


<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>节目制作</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta content="" name="description">
<meta content="" name="keywords">
<meta content="Cloudring" name="author">
<meta content="Cloudring" name="copyright">
<link rel="shortcut icon" href="<%=path%>/images/sys/icon/icon.png">
<link href="<%=path%>/css/sys/common.css" rel="stylesheet" type="text/css">
<link href="<%=path%>/css/sys/main.css" rel="stylesheet" type="text/css">
<style type="text/css">
html,body{
	height:100%;
	width:100%;
	overflow:auto;
}
</style>
</head>

<body>
	<jsp:include page="/page/top.jsp" /> 
    <div class="container">
    	<form id="aspnetForm" action="<%=path%>/material/edit.do" method="post" name="aspnetForm">
    	<input type="hidden" id="id" name="id" value="${material.id}" />
        	<div class="main_nav">管理详细信息</div>
            <table class="detailTable">
            	<colgroup>
                	<col width="15%">
                    <col width="25%">
                    <col width="auto">
                </colgroup>
                <tr class="detailRow1">
                	<td>名称:</td>
                    <td>  <input name="name" type="text" value="${material.name}" id="name" style="width:148px;" /></td>
                    <td rowspan="13">                    
                    	<img class="img" src="${material.file_path}" style="height:280px;width:850px;">
                    </td>
                </tr>
                <tr>
                	<td>大小:</td>
                    <td>${material.file_size}</td>
                </tr>
                <tr>
                	<td>分类:</td>
                    <td><c:if test="${material.material_type=='1'}">视频</c:if>
                        <c:if test="${material.material_type=='2'}">图片</c:if>
                        <c:if test="${material.material_type=='3'}">文件</c:if></td>
                </tr>
                <tr>
                	<td>时长:</td>
					<td>${material.video_play_time}</td>
                </tr>
                <tr class="detailRow1">
                	<td>分辨率:</td>
                    <td>${material.pixels}</td>
                </tr>
                <tr>
                	<td>虚拟路径:</td>
                    <td>${material.file_path}</td>
                </tr>
                <tr class="detailRow1">
                	<td>创建人:</td>
                    <td>${material.create_user}</td>
                </tr>
                <tr>
                	<td>上传时间:</td>
                    <td><fmt:formatDate value="${material.upload_time}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                </tr>
                <tr>
                	<td>修改人:</td>
                    <td>${material.update_time}</td>
                </tr>
                <tr>
                	<td>修改时间:</td>
                    <td><fmt:formatDate value="${material.update_time}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                </tr>
                <tr class="detailRow1">
                	<td>备注:</td>
                    <td>
                    	<textarea name="remark" rows="2" cols="20" id="remark" style="height:40px;">${material.remark}</textarea>
                    </td>
                </tr>
            </table>
            <div class="detailbutton">
            	<input type="button" value="保存" class="btn-01" id="edit">
                <input type="button" value="返回" class="btn-01" onclick="history.back(); return false;">
            </div>
        </form>
    </div>
<script type="text/javascript" src="<%=path%>/js/sys/jquery.js"></script>
<script type="text/javascript" src="<%=path%>/js/sys/common.js"></script>
<script type="text/javascript"  src="<%=path%>/layer/layer.js"></script>
</body>
</html>
<script type="text/javascript">
var contextPath = "${pageContext.request.contextPath}";
	$(document).ready(function(){	
	 $("#v_index").removeClass("visiting");
 $("#v_program").removeClass("visiting");
$("#v_terminal").removeClass("visiting");
$("#v_sys").removeClass("visiting");
$("#v_mater").addClass("visiting");
	    $('#edit').click(function(){
	    	var $form = $("#aspnetForm");
		    if($("[name='name']").val().length>50){
		 		//alert("名称长度不能大于50位！");
		 		layerAlter("提示","名称长度不能大于50位！");    
		 		return false;
		 	}
		    if($("[name='remark']").val().length>500){
		 		//alert("备注不能大于500位！");
		 		layerAlter("提示","备注不能大于500位！"); 
		 		return false;
		 	}
	    	$form.submit(); 
	    });
	});
</script>
