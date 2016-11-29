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
<title>下载管理详细内容</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta content="" name="description">
<meta content="" name="keywords">
<meta content="Cloudring" name="author">
<meta content="Cloudring" name="copyright">
<link rel="shortcut icon" href="<%=path%>/images/sys/icon/icon.png">
<link href="<%=path%>/css/sys/common.css" rel="stylesheet" type="text/css">
<link href="<%=path%>/css/sys/main.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/style1.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/sys/page.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/sys/jquery-ui.css">
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
    <div class="blank9"></div>
    <div class="container">
    	<form id="aspnetForm" action="<%=path%>/programDownloadManager/toSeatchDetailedList.do" method="post" name="aspnetForm">
    		<input type="hidden" id="pageSize" name="pageSize" value="${PublishTerminal.pageSize}" />
    	    <input type="hidden" name="pageNumber" id="pageNumber" value="${PublishTerminal.pageNumber}" /> 
    	    <input type="hidden" name="publish_id" id="publish_id" value="${PublishTerminal.publish_id}" />
    	    <input type="hidden" name="task_name" id="task_name" value="${PublishTerminal.task_name}" />  
        	<div class="title_Nav">
            	<div class="title_text">
                	<p>
                    	 内容&gt;
                        <span>下载详细情况</span>
                    </p>
                </div>
                <div class="title_search">
                	<strong>查询:</strong>
                    <span>终端名称</span>
                    <input type="text" class="inp-90" id="termianl_name" name="termianl_name" value="${PublishTerminal.termianl_name }">
                    <span>内容</span>
                    <input type="text" class="inp-90" id="program" name="program" value="${PublishTerminal.program }">
                    <span>下载状态</span>
                    <select class="sel-80" name="state">
                    	<c:if test="${PublishTerminal.state == '' || empty PublishTerminal.state}">
	                    	<option value="" selected="selected">请选择</option>
	                    	<option value="0">未开始</option>
	                    	<option value="1">下载中</option>
	                    	<option value="2">已完成</option>
	                    	<option value="3">下载失败</option>
                    	</c:if>
                    	<c:if test="${PublishTerminal.state == '0' }">
	                        <option value="">请选择</option>
	                    	<option value="0" selected="selected">未开始</option>
	                    	<option value="1">下载中</option>
	                    	<option value="2">已完成</option>
	                    	<option value="3">下载失败</option>
                    	</c:if>
                        <c:if test="${PublishTerminal.state == '1' }">
	                        <option value="">请选择</option>
	                    	<option value="0">未开始</option>
	                    	<option value="1" selected="selected">下载中</option>
	                    	<option value="2">已完成</option>
	                    	<option value="3">下载失败</option>
                        </c:if>
                        <c:if test="${PublishTerminal.state == '2' }">
	                        <option value="">请选择</option>
	                    	<option value="0">未开始</option>
	                    	<option value="1">下载中</option>
	                    	<option value="2" selected="selected">已完成</option>
	                    	<option value="3">下载失败</option>
                        </c:if>
                        <c:if test="${PublishTerminal.state == '3' }">
	                        <option value="">请选择</option>
	                    	<option value="0">未开始</option>
	                    	<option value="1">下载中</option>
	                    	<option value="2">已完成</option>
	                    	<option value="3"  selected="selected">下载失败</option>
                        </c:if>
                    </select>
                    <input type="button" class="btn-01" value="搜索" onclick="search()">
                 </div>	
            </div>
            <div class="blank3"></div>
            <table class="main_white">
            	<colgroup>
                	<col width="50%">
                    <col width="50%">
                </colgroup>
            	<tr>
                	<td align="left">
                    	<span style="margin:0 5%">发布单号：${PublishTerminal.task_name}</span>
                        <span style="margin-right:36px; font-weight:bold;"></span>
                      <!--   <span>指定下载时间：</span>
                        <span></span> -->
                    </td>
                    <td align="right">
                        <input type="button" class="btn-01" value="返回" onclick="goBack()" >
                    </td>
                </tr>
            </table>
            <div class="table_box">
            	<table class="boxList">
                	<colgroup>
                    	<col width="15%">
                    	<col width="15%">
                        <col width="28%">
                        <col width="10%">
                        <col width="13%">
                        <col width="12%">
                        <col width="12%">
                    </colgroup>
                    <thead>
                    	<tr>
                            <th>终端名称</th>
                            <th>内容</th>
                            <th>下载进度(%)</th>
                            <th>下载状态</th>
                            <th>接收时间</th>
                            <th>完成时间</th>
                            <th>操作</th>
                        </tr>
                    </thead> 
                    <tbody>
                      <c:forEach items="${PublishTerminal.rows}" var="it" varStatus="st">
                    	<tr>
                            <th>${it.termianl_name}</th>
                            <th>${it.program}</th>
                            <th width="25%" class="download-progress">
                                <div class="progress-bar progress-complete ui-progressbar ui-widget ui-widget-content ui-corner-all"  >
	                                <div class="ui-progressbar-value ui-widget-header ui-corner-left ui-corner-right" style="width: ${it.progress}%;"></div>
	                                </div>
                                <div class="progress-info">${it.progress}</div>
                            </th>                            
                            <th>
                             <c:choose>
                             	<c:when test="${it.del_state eq 1}">已删除</c:when>
                             	<c:otherwise>
                             	   <c:if test="${it.state eq 0}">未开始</c:if>
                             	   <c:if test="${it.state eq 1}">下载中</c:if>
                             	   <c:if test="${it.state eq 2}">已完成</c:if>
                             	   <c:if test="${it.state eq 3}">下载失败</c:if>
                             	</c:otherwise>
                             </c:choose>
                            </th>
                            <th> <fmt:formatDate value="${it.reception_time}" pattern="yy-MM-dd HH:mm"/></th>
                            <th> <fmt:formatDate value="${it.complete_time}" pattern="yy-MM-dd HH:mm"/></th>
                            <th><a href="javascript:void(0)" onclick="resend('${it.program_id}','${it.termianl_id}')">重发</a></th>
                        </tr> 
                        </c:forEach>                     
                    </tbody>            
                </table>
            </div>
            <div class="pagebox">
            	<div class="pageleft">	            	
					<c:if test="${PublishTerminal.pageNumber != 1}">
	            			<a href="javascript:void(0)" onclick="pageSkip('${PublishTerminal.pageNumber-1}');">上一页</a>
	            	</c:if>	
	           	    <c:forEach var="i" begin="1" end="${PublishTerminal.pageMax}">
						<c:choose>
							<c:when test="${i==PublishTerminal.pageNumber}"><span class="cpb">${i}</span></c:when>
							<c:otherwise><a href="javascript:void(0)" onclick="pageSkip('${i}');">${i} </a></c:otherwise>
						</c:choose>						
					</c:forEach>
	            	<c:if test="${PublishTerminal.pageNumber != publish.pageMax}">
	            		 <a href="javascript:void(0)" onclick="pageSkip('${PublishTerminal.pageNumber+1}');">下一页</a>
	            	</c:if>
				</div>
                <div class="pageright">
                	<p>每页</p>             
                   <c:choose>
						<c:when test="${PublishTerminal.pageSize eq 50}">
							<span>50</span>
							<a href="javascript:void(0)" onclick="pageSize(30);">30</a>
							<a href="javascript:void(0)" onclick="pageSize(10);">10</a>
						</c:when>
						<c:when test="${PublishTerminal.pageSize eq 30}">
						   <a href="javascript:void(0)" onclick="pageSize(50);">50</a>
						   <span>30</span>
						   <a href="javascript:void(0)" onclick="pageSize(10);">10</a>
						</c:when>
						<c:otherwise>
							<a href="javascript:void(0)" onclick="pageSize(50);">50</a>
							<a href="javascript:void(0)" onclick="pageSize(30);">30</a>
							<span>10</span>
						</c:otherwise>					
					</c:choose>
				</div>
            </div>
        </form>
    </div>
   <script type="text/javascript" src="<%=path%>/js/sys/jquery.js"></script>
   <script type="text/javascript" src="<%=path%>/js/sys/jquery-ui.js"></script>
   <script type="text/javascript" src="<%=path%>/js/common.js"></script>
   <script type="text/javascript" src="<%=path%>/layer/layer.js"></script>

<script>
$(function() {
	$( "#progressbar" ).progressbar({
	  	value:50
	});
});

function goBack(){
	window.location="<%=path%>/programDownloadManager/toPublishList.do";
};

</script>
</body>
</html>
<script type="text/javascript">
var contextPath = "${pageContext.request.contextPath}";
var $listForm=$("#aspnetForm");
var $pageNumber=$("#pageNumber");
var $pageSize=$("#pageSize");
 $("#v_index").removeClass("visiting");
 $("#v_program").addClass("visiting");
$("#v_terminal").removeClass("visiting");
$("#v_sys").removeClass("visiting");
$("#v_mater").removeClass("visiting");
function pageSkip(pageNumber) {
	$pageNumber.val(pageNumber);
	$listForm.submit();
	return false;
}

function pageSize(pageSize) {
	$pageSize.val(pageSize);
	$pageNumber.val(1);
	$listForm.submit();
	return false;
}

function search(){
     var termianl_name=trim($("#termianl_name").val());  
    $("#termianl_name").val(termianl_name);
    var program=trim($("#program").val());
    $("#program").val(program);
   
      $listForm.submit();
	 return false;
}

function trim(str) {
	// 删除左右两端的空格
	return str.replace(/(^\s*)|(\s*$)/g, "");
}

function resend(id,termianl_id){        
     window.location.href = contextPath + "/publish/toPublishResendFirst.do?id="+ id+"&termianl_id="+termianl_id; 
}
</script>