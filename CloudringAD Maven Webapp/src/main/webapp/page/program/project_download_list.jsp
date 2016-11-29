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
<title>下载管理</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta content="" name="description">
<meta content="" name="keywords">
<meta content="Cloudring" name="author">
<meta content="Cloudring" name="copyright">
<link rel="shortcut icon" href="<%=path%>/images/sys/icon/icon.png">
<link href="<%=path%>/css/sys/common.css" rel="stylesheet" type="text/css">
<link href="<%=path%>/css/sys/main.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/sys/page.css">
<script type="text/javascript" src="<%=path%>/js/sys/jquery.js"></script>
<script type="text/javascript" src="<%=path%>/js/sys/common.js"></script>
<script type="text/javascript"  src="<%=path%>/layer/layer.js"></script>
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
    <div class="blank9"></div>
    <div class="container">
    	<form id="aspnetForm" action="<%=path%>/programDownloadManager/toPublishSearch.do" method="post" name="aspnetForm">
    		<input type="hidden" id="pageSize" name="pageSize" value="${publish.pageSize}" />
    	    <input type="hidden" name="pageNumber" id="pageNumber" value="${publish.pageNumber}" /> 
        	<div class="title_Nav">
            	<div class="title_text">
                	<p>
                    	节目管理&gt;
                        <span>下载管理</span>
                    </p>
                </div>
                <div class="title_search">
                	<strong>查询:</strong>
                    <span>发布单号</span>
                    <input type="text" class="inp-90" id="task_id" name="task_id" value="${publish.task_id}">
                    <span>节目名称</span>
                    <input type="text" class="inp-90" id="program_name" name="program_name" value="${publish.program_name}">                    
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
                    	<span  style="padding-left:15px;">共计:</span>
                        <strong>${publish.total};</strong>
                        <!-- <a href="javascript:;" style="margin-left:24px;">按终端查看</a> -->
                    </td>
                </tr>
            </table>
            <div class="table_box">
            	<table class="boxList">
                	<colgroup>
                    	<col width="7%">
                        <col width="10%">
                        <col width="49%">
                        <%-- <col width="16%"> --%>
                        <col width="18%">
                    </colgroup>
                    <thead>
                    	<tr>
                            <th>操作</th>
                            <th>发布单号</th>
                            <th>节目名称</th>                            
                            <th>已下载数/总数</th>
                        </tr>
                    </thead> 
                    <tbody>
                     <c:forEach items="${publish.rows}" var="it" varStatus="st">
                        <tr >
                            <td style="text-align:center;font-weight:normal;color:#000;">
                                <a href="<%=path%>/programDownloadManager/toDetailedList.do?id=${it.id}&task_name=${it.task_id}" class="underLine">
                                    	查看详细
                                </a>
                            </td>
                            <td>
                                ${it.task_id}
                            </td>                          
                            <td style="text-align: center;">
                             	 ${it.program_name}
                            </td>
                            <td style="text-align: center;">
                              ${it.state}/${it.state_del}
                            </td>
                        </tr>

                    </c:forEach> 
                    </tbody>            
                </table>
            </div>
            <div class="pagebox">
            	<!-- <div class="pageleft">	            	
					<c:if test="${publish.pageNumber != 1}">
	            			<a href="javascript:void(0)" onclick="pageSkip(${publish.pageNumber-1});">上一页</a>
	            	</c:if>	
	           	    <c:forEach var="i" begin="1" end="${publish.pageMax}">
						<c:choose>
							<c:when test="${i==publish.pageNumber}"><span class="cpb">${i}</span></c:when>
							<c:otherwise><a href="javascript:void(0)" onclick="pageSkip(${i});">${i} </a></c:otherwise>
						</c:choose>						
					</c:forEach>
	            	<c:if test="${publish.pageNumber != publish.pageMax}">
	            		 <a href="javascript:void(0)" onclick="pageSkip(${publish.pageNumber+1});">下一页</a>
	            	</c:if>
				</div> -->
				
				<div class="pageleft">
            		<c:if test="${publish.pageMax >10 }">
            		<c:if test="${publish.pageNumber != 1}">
	            			<a href="javascript:void(0)" onclick="pageSkip('${publish.pageNumber-1}');">上一页</a>
	            	</c:if>
					
					<c:if test="${publish.pageNumber != 1 and publish.pageNumber != 2 and publish.pageNumber != 3}">
            				<a href="javascript:void(0)" onclick="pageSkip('1')">1</a>
            				<span class="disabled">...</span>
           			</c:if>
            		<c:forEach begin="${publish.pageNumber }" end="${publish.pageNumber + 2}" step="1" var="pageIndex">
            			<c:if test="${pageIndex == publish.pageNumber and pageIndex <= publish.pageMax}">
							<span class="cpb">${pageIndex}</span>
						</c:if>
            			<c:if test="${pageIndex != publish.pageNumber and pageIndex <= publish.pageMax}">
							<a href="javascript:void(0)" onclick="pageSkip('${pageIndex}')">${pageIndex}</a>
						</c:if>
            		</c:forEach>
            		
            		<c:if test="${publish.pageNumber <= publish.pageMax - 3 }">
						<span class="disabled">...</span>
						<a href="javascript:void(0)" onclick="pageSkip('${publish.pageMax}')">${publish.pageMax}</a>
					</c:if>
            		
            		<c:if test="${publish.pageNumber != publish.pageMax}">
						<a href="javascript:void(0)" onclick="pageSkip('${publish.pageNumber+1}')">下一页</a>
					</c:if>
            	</c:if>
            	<c:if test="${publish.pageMax <= 10 }">
            		<c:if test="${publish.pageNumber != 1}">
						<a href="javascript:void(0)" onclick="pageSkip('${publish.pageNumber-1}')">上一页</a>
					</c:if>
            		<c:forEach begin="1" end="${publish.pageMax}" step="1" var="pageIndex">
						<c:if test="${pageIndex == publish.pageNumber}">
							<span class="cpb">${pageIndex}</span>
						</c:if>
						<c:if test="${pageIndex != publish.pageNumber}">
							<a href="javascript:void(0)" onclick="pageSkip('${pageIndex}')">${pageIndex}</a>
						</c:if>
					</c:forEach>
					<c:if test="${publish.pageNumber != publish.pageMax}">
						<a href="javascript:void(0)" onclick="pageSkip('${publish.pageNumber+1}')">下一页</a>
					</c:if>
            	</c:if>	
                </div>
				
                <div class="pageright">
                	<p>每页</p>             
                   <c:choose>
						<c:when test="${publish.pageSize eq 50}">
							<span>50</span>
							<a href="javascript:void(0)" onclick="pageSize(30);">30</a>
							<a href="javascript:void(0)" onclick="pageSize(10);">10</a>
						</c:when>
						<c:when test="${publish.pageSize eq 30}">
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
     var publish_name=trim($("#program_name").val());  
    $("#program_name").val(publish_name);
    var task_id=trim($("#task_id").val());
    $("#task_id").val(task_id);
   
      $listForm.submit();
	 return false;
  
   
}
function trim(str) {
	// 删除左右两端的空格
	return str.replace(/(^\s*)|(\s*$)/g, "");
}

</script>

