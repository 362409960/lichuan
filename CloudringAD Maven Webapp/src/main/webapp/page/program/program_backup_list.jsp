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
<title>节目备份</title>
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
    <div class="container">
    	<form id="backupForm" action="<%=path%>/programBackup/list.do" method="post" name="backupForm">
    		<input type="hidden" id="pageSize" name="pageSize" value="${program.pageSize}" />
    	    <input type="hidden" name="pageNumber" id="pageNumber" value="${program.pageNumber}" /> 
        	<div class="title_Nav">
            	<div class="title_text">
                	<p>
                    	节目管理&gt;
                        <span>节目备份</span>
                    </p>
                </div>
                <div class="title_search">
                	<strong>查询:</strong>
                    <span>节目名称</span>
                    <input type="text" class="inp-90" style="width: 180px;" id="program_name"  name="program_name"  value="${program.program_name}">
                    <span>发布时间</span>
 
                    <input type="text" class="Wdate" id="startTime" name="startTime"  value="${program.startTime}" onClick="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'endTime\')}'})" readonly>-
                    <input type="text" id="endTime" name="endTime" value="${program.endTime}" onClick="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'startTime\')}'})" class="Wdate" readonly>

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
                        <strong>${program.total};</strong>
                    </td>
                </tr>
            </table>
            <div class="table_box">
            	<table class="boxList" cellpadding="2">
                	<colgroup>
                        <col width="20%">
                        <col width="55%">
                        <col width="10%">
                        <col width="15%">
                    </colgroup>
                    <thead>
                    	<tr>
                            <th>节目名称</th>
                            <th>路径</th>
                            <th>文件大小(KB)</th>
                            <th>发布时间</th>
                        </tr>
                    </thead>
                    <tbody>
                      <c:forEach items="${program.rows}" var="it" varStatus="st"> 
                    	
                        <tr style="height:28px;">
                            <td style="text-align:center;">
                                ${it.program_name}  
                            </td>                          
                            <td style="text-align:center;">
	                            <span style="float:left; padding-left:3px;">
	                                <span title="${it.zipPath}">${it.zipPath}</span>
	                            </span> 
	                            <span style="float:right; padding-right:3px;">
	                                <a href="${it.file_url}" title="下载"> 下载 </a>
	                            </span>
                            </td>
                            <td style="text-align:center;">                                
                                ${it.fileSize}
                            </td>
                            <td style="text-align:center;">
                                <fmt:formatDate value="${it.create_time }" pattern="yyyy-MM-dd HH:mm"/> 
                            </td>
                        </tr>

                    </c:forEach> 
                    </tbody>             
                </table>
            </div>
            <div class="pagebox">
				<div class="pageleft">
            		<c:if test="${program.pageMax >10 }">
            		<c:if test="${program.pageNumber != 1}">
	            			<a href="javascript:void(0)" onclick="pageSkip('${program.pageNumber-1}');">上一页</a>
	            	</c:if>
					
					<c:if test="${program.pageNumber != 1 and program.pageNumber != 2 and program.pageNumber != 3}">
            				<a href="javascript:void(0)" onclick="pageSkip('1')">1</a>
            				<span class="disabled">...</span>
           			</c:if>
            		<c:forEach begin="${program.pageNumber }" end="${program.pageNumber + 2}" step="1" var="pageIndex">
            			<c:if test="${pageIndex == program.pageNumber and pageIndex <= program.pageMax}">
							<span class="cpb">${pageIndex}</span>
						</c:if>
            			<c:if test="${pageIndex != program.pageNumber and pageIndex <= program.pageMax}">
							<a href="javascript:void(0)" onclick="pageSkip('${pageIndex}')">${pageIndex}</a>
						</c:if>
            		</c:forEach>
            		
            		<c:if test="${program.pageNumber <= program.pageMax - 3 }">
						<span class="disabled">...</span>
						<a href="javascript:void(0)" onclick="pageSkip('${program.pageMax}')">${program.pageMax}</a>
					</c:if>
            		
            		<c:if test="${program.pageNumber != program.pageMax}">
						<a href="javascript:void(0)" onclick="pageSkip('${program.pageNumber+1}')">下一页</a>
					</c:if>
            	</c:if>
            	
            	<c:if test="${program.pageMax <= 10 }">
            		<c:if test="${program.pageNumber != 1}">
						<a href="javascript:void(0)" onclick="pageSkip('${program.pageNumber-1}')">上一页</a>
					</c:if>
            		<c:forEach begin="1" end="${program.pageMax}" step="1" var="pageIndex">
						<c:if test="${pageIndex == program.pageNumber}">
							<span class="cpb">${pageIndex}</span>
						</c:if>
						<c:if test="${pageIndex != program.pageNumber}">
							<a href="javascript:void(0)" onclick="pageSkip('${pageIndex}')">${pageIndex}</a>
						</c:if>
					</c:forEach>
					<c:if test="${program.pageNumber != program.pageMax}">
						<a href="javascript:void(0)" onclick="pageSkip('${program.pageNumber+1}')">下一页</a>
					</c:if>
            	</c:if>	
                </div>
				
                <div class="pageright">
                	<p>每页</p>             
                   <c:choose>
						<c:when test="${program.pageSize eq 50}">
							<span>50</span>
							<a href="javascript:void(0)" onclick="pageSize(30);">30</a>
							<a href="javascript:void(0)" onclick="pageSize(10);">10</a>
						</c:when>
						<c:when test="${program.pageSize eq 30}">
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
var $backupForm=$("#backupForm");
var $pageNumber=$("#pageNumber");
var $pageSize=$("#pageSize");

$("#v_index").removeClass("visiting");
$("#v_program").addClass("visiting");
$("#v_terminal").removeClass("visiting");
$("#v_sys").removeClass("visiting");
$("#v_mater").removeClass("visiting");

$(document).ready(function(){

});

function pageSkip(pageNumber) {
	$pageNumber.val(pageNumber);
	$backupForm.submit();
	return false;
}

function pageSize(pageSize) {
	$pageSize.val(pageSize);
	$pageNumber.val(1);
	$backupForm.submit();
	return false;
}

function search(){
    var program_name=trim($("#program_name").val());  
    $("#program_name").val(program_name);
    var startTime=$("#startTime").val();
    var endTime=$("#endTime").val();
    if(check(startTime,endTime)){
      $backupForm.submit();
	 return false;
    }
   
}
function trim(str) {
	// 删除左右两端的空格
	return str.replace(/(^\s*)|(\s*$)/g, "");
}
//验证日期（判断结束日期是否大于开始日期）日期格式为YY—MM—DD  
  function check(startTime,endTime){              
      if(startTime.length>0 && endTime.length>0){     
          var startTmp=startTime.split("-");  
          var endTmp=endTime.split("-");  
          var sd=new Date(startTmp[0],startTmp[1],startTmp[2]);  
          var ed=new Date(endTmp[0],endTmp[1],endTmp[2]);  
          if(sd.getTime()>ed.getTime()){   
              //alert("开始日期不能大于结束日期");  
              layerAlter("提示","开始日期不能大于结束日期");   
              return false;     
          }     
      }     
      return true;     
  }   

</script>
