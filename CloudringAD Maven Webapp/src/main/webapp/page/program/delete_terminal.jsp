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
<title>删除终端节目</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta content="" name="description">
<meta content="" name="keywords">
<meta content="Cloudring" name="author">
<meta content="Cloudring" name="copyright">
<link rel="shortcut icon" href="<%=path%>/images/sys/icon/icon.png">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/sys/common.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/sys/main.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/sys/page.css">


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
    	<form id="aspnetForm" action="<%=path%>/removeTerminalProgram/toSearch.do" method="post" name="aspnetForm">
    	<input type="hidden" id="pageSize" name="pageSize" value="${program.pageSize}" />
    	<input type="hidden" name="pageNumber" id="pageNumber" value="${program.pageNumber}" /> 
        	<div class="title_Nav">
            	<div class="title_text">
                	<p>
                    	节目管理&gt;
                        <span>删除终端节目</span>
                    </p>
                </div>
                <div class="title_search">
                	<strong>查询:</strong>
                    <span>节目名称</span>
                    <input type="text" class="inp-90" name="program_name">
                   <!--  <span>过期时间</span>
                    <input type="text" class="inp-70" readonly>-
                    <input type="text" class="inp-70" readonly> -->
                    <input type="submit" class="btn-01" value="搜索">
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
                    	<span  style="padding-left:15px;">搜索共计:</span>
                        <strong>${program.total};</strong>
                    </td>
                    <td align="right">
                        <input type="button" class="btn-01" value="删除" id="del">
                    </td>
                </tr>
            </table>
            <div class="table_box">
            	<table class="boxList" cellpadding="2">
                	<colgroup>
                    	<col width="5%">
                        <col width="40%">
                       <%--  <col width="15%"> --%>
                        <col width="20%">
                      <%--   <col width="15%"> --%>
                        <col width="20%">
                    </colgroup>
                    <thead>
                    	<tr>
                        	<th>
                            	<input id="ckAll" type="checkbox" title="全选" name="ckAll">
                            </th>
                            <th>节目名称</th>
                           <!--  <th>已下载终端个数</th> -->
                            <th>发布时间</th>
                            <!-- <th>过期时间</th> -->
                            <th>所属机构</th>
                        </tr>
                    </thead>
                     <tbody>
                      <c:forEach items="${program.rows}" var="it" varStatus="st">
                    	<tr>
                        	<td style="text-align:center;font-weight:normal;color:#000;">
                            	<input id="pgid" type="checkbox" value="${it.id}" name="ckBox">
                            </td>                            
                            <td>${it.program_name}</td>                          
                          <%--   <td>${it.program_type}</td>    --%>                                        
                            <td><fmt:formatDate value="${it.updated}" pattern="yy-MM-dd HH:mm"/></td>
                            <td>${it.affiliations}</td>                         
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
<script type="text/javascript" src="<%=path%>/js/sys/jquery.js"></script>
<script type="text/javascript" src="<%=path%>/js/sys/common.js"></script>
<script type="text/javascript"  src="<%=path%>/layer/layer.js"></script>
</body>
</html>
<script type="text/javascript">
var contextPath = "${pageContext.request.contextPath}";
var $listForm=$("#aspnetForm");
var $pageNumber=$("#pageNumber");
var $pageSize=$("#pageSize");
$(document).ready(function(){
 $("#v_index").removeClass("visiting");
 $("#v_program").addClass("visiting");
$("#v_terminal").removeClass("visiting");
$("#v_sys").removeClass("visiting");
$("#v_mater").removeClass("visiting");
/*全选按钮*/
	$('#ckAll').click(function(){
		var _this=this;
		var oCheckbox=$('.table_box').find("input[type=checkbox]");
		oCheckbox.each(function(index, element) {
			$(this).attr('checked',_this.checked);
		});
		console.log(_this.checked);
	});	
	 var ckBox=$('.table_box td').find('input[type=checkbox]');	
	ckBox.each(function(index, element) {
        $(element).click(function(){
			if($('.table_box td').find('input[type=checkbox]:checked').length==ckBox.length){
				$('#ckAll').attr('checked',true);	
			}else{
				$('#ckAll').attr('checked',false);
			}
		});
    });
	 
	
	//点击删除按钮
	$('#del').click(function(){
	layer.confirm('确定要删除吗？',{icon:3,title:'提示'}, function(index){ if($('.table_box td').find('input[type=checkbox]:checked').length==0){
			layerAlter("提示","请选择要删除的消息");    
		}else{
		var message='';
		  $(".table_box td").each(function(){
			    if($(this).find("input[type=checkbox]:checked").val() != undefined)
			    {
			      message+=$(this).find("input[type=checkbox]:checked").val()+',';	
			    }
			});
			var ids=message.substring(0,message.length-1);			
			  $.ajax({
	            type: "post",
	            url: contextPath + "/removeTerminalProgram/deleteById.do",
	            data:{ids:ids},
	            dataType: "json",
	            success: function (data) {	            
	               window.location.reload(true);	               
	            },
	            error: function (XMLHttpRequest, textStatus,errorThrown) {
	                alert(errorThrown);
	                return false;
	            }
       		 });
		}},function(index){ layer.closeAll(index);});
	 
		
	});
});

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

</script>