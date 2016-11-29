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
<title>终端节目统计</title>
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
    	<form id="aspnetForm" action="<%=path %>/terminalProgram/program_list_search.do" method="post" name="aspnetForm">
    	<input type="hidden" name="pageSize" id="pageSize" value="${adPlayer.pageSize }">
		<input type="hidden" name="pageNumber" id="pageNumber" value="1">
        	<div class="title_Nav">
            	<div class="title_text">
                	<p>
                    	终端管理&gt;
                        <span>节目统计</span>
                    </p>
                </div>
                <div class="title_search">
                	<strong>查询:</strong>
                    <span>终端名称</span>
                    <input type="text" class="inp-90" name="terminalName" value="${adPlayer.terminalName }" maxlength="32">
                    <span>广告名称</span>
                    <input type="text" class="inp-90" name="adName" value="${adPlayer.adName }" maxlength="50">
                    <span>统计时间</span>
                    <input type="text" id="startDate" name="startDate" value="${adPlayer.startDate }" class="Wdate"  onClick="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'endDate\')}'})" readonly>
                    -
                    <input type="text" id="endDate" name="endDate" value="${adPlayer.endDate }" class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'startDate\')}'})"  readonly>
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
                        <a href="javascript:;">总计(${adPlayer.total })</a>
                    </td>
                    <td align="right">
                    </td>
                </tr>
            </table>
            <div class="table_box">
            	<table class="boxList">
                	<colgroup>
                    	<col width="10%">
                    	<col width="10%">
                        <col width="50%">
                        <col width="5%">
<!--                         <col width="10%"> -->
                    </colgroup>
                    <thead>
                    	<tr>
                            <th>终端ID</th>
                            <th>终端名称</th>
                            <th>广告名称</th>
                            <th>播放次数</th>
<!--                             <th>创建时间</th> -->
                        </tr>
                    </thead> 
                    <tbody>
                    <c:forEach items="${adPlayer.rows }" var="adPlayer">
                    	<tr>
                    		<th>${adPlayer.terminalId }</th>
                            <th title="${adPlayer.terminalName }"><div class="row-w50">${adPlayer.terminalName }</div></th>
<!--                             <th title="${adPlayer.adId }">${adPlayer.adId }</th> -->
                            <th title="${adPlayer.adName }">${adPlayer.adName }</th>
                            <th>${adPlayer.adCount }次</th>
<!--                             <th><fmt:formatDate value="${adPlayer.createDate }" pattern="yyyy-MM-dd HH:mm:ss"/></th> -->
                        </tr>
                     </c:forEach>
                    </tbody>            
                </table>
            </div>
            <div class="pagebox">
            	<div class="pageleft">
            		<c:if test="${pageTotal >10 }">
            		<c:if test="${adPlayer.pageNumber != 1}">
						<a href="javascript:void(0)" onclick="searchByPage('${adPlayer.pageNumber-1}','${adPlayer.pageSize}')">上一页</a>
					</c:if>
					
					<c:if test="${adPlayer.pageNumber != 1 and adPlayer.pageNumber != 2 and adPlayer.pageNumber != 3}">
            				<a href="javascript:void(0)" onclick="searchByPage('1','10')">1</a>
            				<span class="disabled">...</span>
           			</c:if>
            		<c:forEach begin="${adPlayer.pageNumber }" end="${adPlayer.pageNumber + 2}" step="1" var="pageIndex">
            			<c:if test="${pageIndex == terminal.pageNumber and pageIndex <= pageTotal}">
							<span class="cpb">${pageIndex}</span>
						</c:if>
            			<c:if test="${pageIndex != adPlayer.pageNumber and pageIndex <= pageTotal}">
							<a href="javascript:void(0)" onclick="searchByPage('${pageIndex}','${terminal.pageSize}')">${pageIndex}</a>
						</c:if>
            		</c:forEach>
            		
            		<c:if test="${adPlayer.pageNumber <= pageTotal - 3 }">
						<span class="disabled">...</span>
						<a href="javascript:void(0)" onclick="searchByPage('${pageTotal}','${adPlayer.pageSize}')">${pageTotal}</a>
					</c:if>
            		
            		<c:if test="${terminal.pageNumber != pageTotal}">
						<a href="javascript:void(0)" onclick="searchByPage('${adPlayer.pageNumber+1}','${adPlayer.pageSize}')">下一页</a>
					</c:if>
            	</c:if>
            	<c:if test="${pageTotal <= 10 }">
            		<c:if test="${adPlayer.pageNumber != 1}">
						<a href="javascript:void(0)" onclick="searchByPage('${adPlayer.pageNumber-1}','${adPlayer.pageSize}')">上一页</a>
					</c:if> 
            		<c:forEach begin="1" end="${pageTotal}" step="1" var="pageIndex">
						<c:if test="${pageIndex == adPlayer.pageNumber}">
							<span class="cpb">${pageIndex}</span>
						</c:if>
						<c:if test="${pageIndex != adPlayer.pageNumber}">
							<a href="javascript:void(0)" onclick="searchByPage('${pageIndex}','${adPlayer.pageSize}')">${pageIndex}</a>
						</c:if>
					</c:forEach>
					<c:if test="${adPlayer.pageNumber != pageTotal}">
						<a href="javascript:void(0)" onclick="searchByPage('${adPlayer.pageNumber+1}','${adPlayer.pageSize}')">下一页</a>
					</c:if>
            	</c:if>	
                </div>
                <div class="pageright">
                	<p>每页</p>
                	<c:choose>
						<c:when test="${adPlayer.pageSize eq 10}">
							<a href="javascript:void(0)" onclick="searchByPage(1,50)">50</a>
		                    <a href="javascript:void(0)" onclick="searchByPage(1,30)">30</a>
		                    <span>10</span>
						</c:when>
						<c:when test="${adPlayer.pageSize eq 30}">
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
