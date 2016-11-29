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
<title>插播消息</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta content="" name="description">
<meta content="" name="keywords">
<meta content="Cloudring" name="author">
<meta content="Cloudring" name="copyright">
<link rel="shortcut icon" href="<%=path%>/images/icon/icon.png">
<link href="<%=path%>/css/common.css" rel="stylesheet" type="text/css">
<link href="<%=path%>/css/main.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/page.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/jquery-ui.css">
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
    	<form id="aspnetForm" action="<%=path %>/newsStream/news_stream_search.do" method="post" name="aspnetForm">
		<input type="hidden" name="pageSize" id="pageSize" value="${newsStream.pageSize }">
		<input type="hidden" name="pageNumber" id="pageNumber" value="1">
		<input type="hidden" name="terminalId" id="terminalId" value="${newsStream.terminalId }">
        	<div class="title_Nav">
            	<div class="title_text">
                	<p>
                    	终端管理&gt;
                        <span>插播消息</span>
                    </p>
                </div>
                <div class="title_search">
                	<strong>查询:</strong>
                    <span>创建人</span>
                    <input type="text" class="inp-90" name="creator" value="${newsStream.creator }" maxlength="50">
                    <span>创建日期</span>
                    <input type="text" id="startDate" name="startDate" value="${newsStream.startDate }" class="Wdate"  onClick="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'endDate\')}'})" readonly>
                    -
                    <input type="text" id="endDate" name="endDate" value="${newsStream.endDate }" class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'startDate\')}'})"  readonly>
                    <input type="submit" class="btn-01" value="搜索">
                 </div>	
            </div>
            <div class="blank3"></div>
            <table class="main_white">
            	<colgroup>
                	<col width="30%">
                    <col width="70%">
                </colgroup>
            	<tr>
                	<td align="left">
                    	<a href="javascript:;" style="margin:0 8px 0 12px;">共计：(${newsStream.total })</a>
                    </td>
                    <td align="right">
                    	<input type="button" class="btn-01" value="返回" onclick="goBack()">
                        <input type="button" class="btn-01" value="删除" onclick="deleteMessage()">
                    </td>
                </tr>
            </table>
            <div class="table_box">
            	<table class="boxList">
                	<colgroup>
                    	<col width="5%">
                    	<col width="25%">
                        <col width="10%">
                        <col width="15%">
                        <col width="15%">
                    </colgroup>
                    <thead>
                    	<tr>
                            <th>
                            	<input id="ckAll" type="checkbox" title="全选" name="ckAll">
                            </th>
                            <th>消息内容</th>
                            <th>播放时长</th>
                            <th>创建人</th>
                            <th>创建时间</th>
                        </tr>
                    </thead> 
                    <tbody>
                    	<c:forEach items="${newsStream.rows }" var="message">
	                    	<tr>
	                        	<th>
	                            	<input id="ckBox" type="checkbox" value="${message.id }" name="ckBox">
	                            </th>
	                            <th title="${message.message }"><div class="row-w500">${message.message }</div></th>
	                            <c:if test="${message.durationType == 'SECONDS' }">
	                            	<th>${message.playDuration }秒</th>
	                            </c:if>
	                            <c:if test="${message.durationType == 'MINUTES' }">
	                            	<th>${message.playDuration }分钟</th>
	                            </c:if>
	                            <c:if test="${message.durationType == 'HOURS' }">
	                            	<th>${message.playDuration }小时</th>
	                            </c:if>
	                            <c:if test="${message.durationType == 'DAYS' }">
	                            	<th>${message.playDuration }天</th>
	                            </c:if>
	                            
	                            <th>${message.creator }</th>
	                            <th><fmt:formatDate value="${message.createDate }" pattern="yyyy-MM-dd HH:mm"/>  </th>
	                        </tr>
                        </c:forEach>
                    </tbody>            
                </table>
            </div>
            <div class="pagebox">
            	<div class="pageleft">
            	<c:if test="${pageTotal >10 }">
            		<c:if test="${newsStream.pageNumber != 1}">
						<a href="javascript:void(0)" onclick="searchByPage('${newsStream.pageNumber-1}','${newsStream.pageSize}')">上一页</a>
					</c:if>
					
					<c:if test="${newsStream.pageNumber != 1 and newsStream.pageNumber != 2 and newsStream.pageNumber != 3}">
            				<a href="javascript:void(0)" onclick="searchByPage('1','10')">1</a>
            				<span class="disabled">...</span>
           			</c:if>
            		<c:forEach begin="${newsStream.pageNumber }" end="${newsStream.pageNumber + 2}" step="1" var="pageIndex">
            			<c:if test="${pageIndex == newsStream.pageNumber and pageIndex <= pageTotal}">
							<span class="cpb">${pageIndex}</span>
						</c:if>
            			<c:if test="${pageIndex != newsStream.pageNumber and pageIndex <= pageTotal}">
							<a href="javascript:void(0)" onclick="searchByPage('${pageIndex}','${newsStream.pageSize}')">${pageIndex}</a>
						</c:if>
            		</c:forEach>
            		
            		<c:if test="${newsStream.pageNumber <= pageTotal - 3 }">
						<span class="disabled">...</span>
						<a href="javascript:void(0)" onclick="searchByPage('${pageTotal}','${newsStream.pageSize}')">${pageTotal}</a>
					</c:if>
            		
            		<c:if test="${newsStream.pageNumber != pageTotal}">
						<a href="javascript:void(0)" onclick="searchByPage('${newsStream.pageNumber+1}','${newsStream.pageSize}')">下一页</a>
					</c:if>
            	</c:if>
            	<c:if test="${pageTotal <= 10 }">
            		<c:if test="${newsStream.pageNumber != 1}">
						<a href="javascript:void(0)" onclick="searchByPage('${newsStream.pageNumber-1}','${newsStream.pageSize}')">上一页</a>
					</c:if>
            		<c:forEach begin="1" end="${pageTotal}" step="1" var="pageIndex">
						<c:if test="${pageIndex == newsStream.pageNumber}">
							<span class="cpb">${pageIndex}</span>
						</c:if>
						<c:if test="${pageIndex != newsStream.pageNumber}">
							<a href="javascript:void(0)" onclick="searchByPage('${pageIndex}','${newsStream.pageSize}')">${pageIndex}</a>
						</c:if>
					</c:forEach>
					<c:if test="${newsStream.pageNumber != pageTotal}">
						<a href="javascript:void(0)" onclick="searchByPage('${newsStream.pageNumber+1}','${newsStream.pageSize}')">下一页</a>
					</c:if>
            	</c:if>	
                </div>
                <div class="pageright">
                	<p>每页</p>
                	<c:choose>
						<c:when test="${newsStream.pageSize eq 10}">
							<a href="javascript:void(0)" onclick="searchByPage(1,50)">50</a>
		                    <a href="javascript:void(0)" onclick="searchByPage(1,30)">30</a>
		                    <span>10</span>
						</c:when>
						<c:when test="${newsStream.pageSize eq 30}">
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
<script type="text/javascript" src="<%=path%>/js/jquery-ui.js"></script>
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

function goBack(){
	window.location="<%=path%>/newsStream/terminal_list.do";
}


function deleteMessage(){
	var ids = "";
	$('input[name="ckBox"]:checked').each(function(i, dom){    
		if (i != $('input[name="ckBox"]:checked').length - 1){
			ids += $(this).val()+",";    
        }
		else{
			ids += $(this).val();
		}
	});
	if(ids == ""){
		layer.alert('请选择要删除的项!', {icon:5,title:'提示'});
		return;
	}
	layer.confirm("是否确认删除？",{icon: 3, title:'提示'},function(index){
		$.ajax({ 
		    type: "post", 
		    dataType: "json", 
		    url: "<%=path %>/newsStream/newsStream_id_delete.do", 
		    data: {"newsStreamIds":ids,"terminalId":"${newsStream.terminalId }"}, 
		    success: function(data) { 
		    	if(data.erron != 1){
		    		layer.alert('删除消息失败', {icon:5,title:'提示'});
		    	}else{
		    		
		    		layer.alert('删除消息成功', {icon:1,title:'提示'},function(index){
		    			window.location="<%=path%>/newsStream/news_stream_list.do?terminalId=${newsStream.terminalId }";
	    		 	});
		    	}
		    }, 
		    error: function(err) { 
		    	layer.alert(err, {icon:5,title:'提示'});
		    } 
		}); 
	});
};

$(document).ready(function(e) {
    $('#ckAll').click(function(){
		var _this=this;
		var oCheckbox=$('.table_box').find("input[type=checkbox]");
		oCheckbox.each(function(index, element) {
			$(this).attr('checked',_this.checked);
		});
		console.log(_this.checked);
	});	
    var $aCheckBox=$("[name='ckBox']");
    $aCheckBox.each(function(index, element){
    	var $this=$(this);
    	$this.bind('click',function(){
    		var $aChLen=$(':checkbox[name=ckBox]:checked').length;
    		var $aBox=$aCheckBox.length;
    		if($aChLen==$aBox){
    			$("#ckAll").attr('checked',this.checked);
    		}else{
    			$("#ckAll").removeAttr('checked');
    		}
    	});
    });
});

</script>
</body>
</html>
