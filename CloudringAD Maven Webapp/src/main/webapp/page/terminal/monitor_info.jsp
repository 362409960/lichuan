<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/tlds/c.tld" prefix="c"%>
<%@ taglib uri="/WEB-INF/tlds/fmt.tld" prefix="fmt"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta charset="utf-8">
<title>监控记录</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta content="" name="description">
<meta content="" name="keywords">
<meta content="Cloudring" name="author">
<meta content="Cloudring" name="copyright">
<link rel="shortcut icon" href="<%=path%>/images/icon/icon.png">
<link href="<%=path%>/css/common.css" rel="stylesheet" type="text/css">
<link href="<%=path%>/css/main.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/page.css">
<script type="text/javascript" src="<%=path%>/js/My97DatePicker/WdatePicker.js"></script>
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
    	<form id="aspnetForm" action="<%=path %>/terminalMonitor/monitor_list_search.do" method="post" name="aspnetForm">
    	<input type="hidden" name="pageSize" id="pageSize" value="${dataGathering.pageSize }">
		<input type="hidden" name="pageNumber" id="pageNumber" value="1">
		<input type="hidden" name="terminalId" id="terminalId" value="${dataGathering.terminalId }">
        	<div class="title_Nav">
            	<div class="title_text">
                	<p>
                    	终端管理&gt;
                    	终端监控&gt;
                        <span>监控记录</span>
                    </p>
                </div>
                <div class="title_search">
                	<strong>查询:</strong>
                    <span>终端IP</span>
                    <input type="text" class="inp-90" name="ip" value="${dataGathering.ip }" maxlength="100">
                    <span>监控时间</span>
                    <input type="text" id="startDate" name="startDate" value="${dataGathering.startDate }" class="Wdate"  onClick="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'endDate\')}'})" readonly>
                    -
                    <input type="text" id="endDate" name="endDate" value="${dataGathering.endDate }" class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'startDate\')}'})"  readonly>
                    <input type="button" class="btn-01" value="搜索" onclick="onSubmit()">
                 </div>	
            </div>
            <div class="blank3"></div>
            <table class="main_white">
            	<colgroup>
                	<col width="30%">
                    <col width="70%">
                </colgroup>
            	<tr>
                	<td align="left" style="padding-left: 10px;">
                         <a href="javascript:;">总计(${dataGathering.total })</a>
                    </td>
                    <td align="right">
                    	<input type="button" value="返回" class="btn-01" onclick="goBack()">
                    </td>
                </tr>
            </table>
            <div class="table_box">
            	<table class="boxList">
                	<colgroup>
                    	<col width="5%">
                    	<col width="10%">
                    	<col width="5%">
                        <col width="10%">
                        <col width="5%">
                        <col width="10%">
                    </colgroup>
                    <thead>
                    	<tr>
                            <th>终端ID</th>
                            <th>终端名称</th>
                            <th>记录类型</th>
                            <th>终端IP</th>
                            <th>详情</th>
                            <th>监控时间</th>
                        </tr>
                    </thead> 
                    <tbody>
                    <c:forEach items="${dataGathering.rows }" var="dataGathering">
                    	<tr>
                            <th>${dataGathering.terminalId }</th>
                            <th><div class="row-w50">${dataGathering.terminalName }</div></th>
                            <c:if test="${dataGathering.type == 0}">
                            	<th>文本</th>
                            </c:if>
                            <c:if test="${dataGathering.type == 1}">
                            	<th>图片</th>
                            </c:if>
                            <c:if test="${dataGathering.type == 2}">
                            	<th>视频</th>
                            </c:if>
                            <th>${dataGathering.ip }</th>
                            <th><a href="${dataGathering.content }" target="_blank">查看</a></th>
                            <th><fmt:formatDate value="${dataGathering.createDate }" pattern="yyyy-MM-dd HH:mm:ss"/></th>
                        </tr>
                     </c:forEach>
                    </tbody>            
                </table>
            </div>
            <div class="pagebox">
            	<div class="pageleft">
            		<c:if test="${pageTotal >10 }">
            		<c:if test="${dataGathering.pageNumber != 1}">
						<a href="javascript:void(0)" onclick="searchByPage('${dataGathering.pageNumber-1}','${dataGathering.pageSize}')">上一页</a>
					</c:if>
					
					<c:if test="${dataGathering.pageNumber != 1 and dataGathering.pageNumber != 2 and dataGathering.pageNumber != 3}">
            				<a href="javascript:void(0)" onclick="searchByPage('1','10')">1</a>
            				<span class="disabled">...</span>
           			</c:if>
            		<c:forEach begin="${dataGathering.pageNumber }" end="${dataGathering.pageNumber + 2}" step="1" var="pageIndex">
            			<c:if test="${pageIndex == dataGathering.pageNumber and pageIndex <= pageTotal}">
							<span class="cpb">${pageIndex}</span>
						</c:if>
            			<c:if test="${pageIndex != dataGathering.pageNumber and pageIndex <= pageTotal}">
							<a href="javascript:void(0)" onclick="searchByPage('${pageIndex}','${dataGathering.pageSize}')">${pageIndex}</a>
						</c:if>
            		</c:forEach>
            		
            		<c:if test="${dataGathering.pageNumber <= pageTotal - 3 }">
						<span class="disabled">...</span>
						<a href="javascript:void(0)" onclick="searchByPage('${pageTotal}','${dataGathering.pageSize}')">${pageTotal}</a>
					</c:if>
            		
            		<c:if test="${dataGathering.pageNumber != pageTotal}">
						<a href="javascript:void(0)" onclick="searchByPage('${dataGathering.pageNumber+1}','${dataGathering.pageSize}')">下一页</a>
					</c:if>
            	</c:if>
            	<c:if test="${pageTotal <= 10 }">
            		<c:if test="${dataGathering.pageNumber != 1}">
						<a href="javascript:void(0)" onclick="searchByPage('${dataGathering.pageNumber-1}','${dataGathering.pageSize}')">上一页</a>
					</c:if>
            		<c:forEach begin="1" end="${pageTotal}" step="1" var="pageIndex">
						<c:if test="${pageIndex == dataGathering.pageNumber}">
							<span class="cpb">${pageIndex}</span>
						</c:if>
						<c:if test="${pageIndex != dataGathering.pageNumber}">
							<a href="javascript:void(0)" onclick="searchByPage('${pageIndex}','${dataGathering.pageSize}')">${pageIndex}</a>
						</c:if>
					</c:forEach>
					<c:if test="${dataGathering.pageNumber != pageTotal}">
						<a href="javascript:void(0)" onclick="searchByPage('${dataGathering.pageNumber+1}','${dataGathering.pageSize}')">下一页</a>
					</c:if>
            	</c:if>	
                </div>
                <div class="pageright">
                	<p>每页</p>
                	<c:choose>
						<c:when test="${dataGathering.pageSize eq 10}">
							<a href="javascript:void(0)" onclick="searchByPage(1,50)">50</a>
		                    <a href="javascript:void(0)" onclick="searchByPage(1,30)">30</a>
		                    <span>10</span>
						</c:when>
						<c:when test="${dataGathering.pageSize eq 30}">
							<a href="javascript:void(0)" onclick="searchByPage(1,50)">50</a>
							<span>30</span>
		                    <a href="javascript:void(0)" onclick="searchByPage(1,10)">10</a>
						</c:when>
						<c:otherwise>
							<span>50</span>
							<a href="javascript:void(0)" onclick="searchByPage(1,30)">30</a>
		                    <a href="javascript:void(0)" onclick="searchByPage(1,10)">10</a>
						</c:otherwise>
					</c:choose>
                </div>
            </div>
        </form>
    </div>
<script type="text/javascript" src="<%=path%>/js/jquery.js"></script>
<script type="text/javascript" src="<%=path%>/js/common.js"></script>
<script type="text/javascript" src="<%=path%>/layer/layer.js"></script>
<script type="text/javascript" src="<%=path%>/js/jquery.ajaxfileupload.js"></script>
<script type="text/javascript">
$("#v_index").removeClass("visiting");
 $("#v_program").removeClass("visiting");
$("#v_terminal").addClass("visiting");
$("#v_sys").removeClass("visiting");
$("#v_mater").removeClass("visiting");

function goBack(){
	window.location="<%=path%>/terminalMonitor/terminal_list.do";
};

function searchByPage(pageNumber,pageSize){
	$("#pageNumber").val(pageNumber);
	$("#pageSize").val(pageSize);
	$("#aspnetForm").submit();
}

function onSubmit(){
	$("#aspnetForm").submit();
}

</script>
</body>
</html>
