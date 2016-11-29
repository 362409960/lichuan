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
<title>模板编辑</title>
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
	overflow:hidden;
}
</style>
</head>

<body>
<jsp:include page="/page/top.jsp" /> 	
    <div class="container">
    	<form id="aspnetForm" action="#" method="post" name="aspnetForm">
    	<input type="hidden" id="id" name="id" value="${template.id}" />
        	<div class="main_nav">模板管理详细信息</div>
            <table class="detailTable">
            	<colgroup>
                	<col width="15%">
                    <col width="35%">
                    <col width="15%">
                    <col width="35%">
                </colgroup>
                <tr class="detailRow1">
                	<td>名称:</td>
                    <td>${template.name}</td>
                    <td>分辨率:</td>
                    <td>${template.resolution}</td>
                </tr>
               <!--  <tr>
                	<td>物理途径:</td>
                    <td>D:\webfile\Cloud\Project\Template\</td>
                    <td>虚拟路径:</td>
                    <td>/Project/Template/king.html</td>
                </tr> -->
                <tr class="detailRow1">
                	<td>创建人:</td>
                    <td>${template.createor}</td>
                    <td>创建时间:</td>
                    <td><fmt:formatDate value="${template.create_date}" pattern="yyyy-MM-dd HH:mm"/></td>
                </tr>
                <tr>
                	<td>修改人:</td>
                    <td>${template.editor}</td>
                    <td>修改时间:</td>
                    <td><fmt:formatDate value="${template.update_date}" pattern="yyyy-MM-dd HH:mm"/></td>
                </tr>
            </table>
            <div class="detailbutton">
            	<input type="button" value="编辑" class="btn-01" id="edit">
                <input type="button" value="立即制作" class="btn-01" id="make">
                <input type="button" value="返回" class="btn-01"  onclick="history.back(); return false;">
            </div>
            <%-- <div class="main_nav">
            	<div class="left">模板预览:</div>
            </div>
			<div class="prevwImg">            	
            		${template.context} 
            </div> --%>
        </form>
    </div>
</body>
 <script type="text/javascript" src="<%=path%>/js/sys/jquery.js"></script>
 <script type="text/javascript" src="<%=path%>/js/sys/common.js"></script>
 <script type="text/javascript" src="<%=path%>/layer/layer.js"></script>
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
	    window.location.href= contextPath + '/template/toMakeEdit.do?id=${template.id}';
    });
      
  $('#make').click(function(){    	
	    window.location.href= contextPath + '/template/toMake.do?id=${template.id}';
    });
});
</script>
