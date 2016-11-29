<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/tlds/c.tld" prefix="c"%>
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
    	<form id="aspnetForm" action="<%=path %>/newsStream/terminal_list_search.do" method="post" name="aspnetForm">
    	<input type="hidden" name="pageSize" id="pageSize" value="${terminal.pageSize }">
		<input type="hidden" name="pageNumber" id="pageNumber" value="1">
        	<div class="title_Nav">
            	<div class="title_text">
                	<p>
                    	终端管理&gt;
                        <span>插播消息</span>
                    </p>
                </div>
                <div class="title_search">
                	<strong>查询:</strong>
                    <span>名称</span>
                    <input type="text" class="inp-90" name="name" id="name" value="${terminal.name}" maxlength="50">
<!--                     <span>IP</span> -->
<!--                     <input type="text" class="inp-90" name="ip" id="ip" value="${terminal.ip}" maxlength="15"> -->
                    <span>所属机构</span>
                    <input type="text" class="inp-90" name="mechanismName" value="${terminal.mechanismName}" maxlength="50">
                    <span>终端状态</span>
                    <select class="sel-120" name="status" id="status">
                         <c:choose>
                             <c:when test="${empty terminal.status || terminal.status == ''}">
                                 <option value="" selected="selected">请选择</option>
                                 <option value="1" >在线</option>
                                 <option value="0" >离线</option>
                             </c:when>
                             <c:when test="${terminal.status=='1'}">
                                 <option value="" >请选择</option>
                                 <option value="1" selected="selected">在线</option>
                                 <option value="0" >离线</option>
                             </c:when>
                             <c:otherwise>
                                 <option value="" >请选择</option>
                                 <option value="1" >在线</option>
                                 <option value="0" selected="selected">离线</option>
                             </c:otherwise>
                         </c:choose>
                    </select>
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
                	<td align="left">
	                	<c:choose>
                             <c:when test="${empty terminal.status || terminal.status == ''}">
                                 <a href="javascript:;" style="margin:0 8px 0 12px;">所有终端(${onLine + offLine})</a>
		                    	 <a href="javascript:;" class="css_normal" style="margin-right:8px;" onclick="searchByStatus(1)">在线终端(${onLine })</a>
		                         <a href="javascript:;" class="css_normal" onclick="searchByStatus(0)">离线终端(${offLine })</a>
                             </c:when>
                             <c:when test="${terminal.status=='1'}">
                                 <a href="javascript:;" class="css_normal" style="margin:0 8px 0 12px;" onclick="searchByStatus('')">所有终端(${onLine + offLine})</a>
		                    	 <a href="javascript:;" style="margin-right:8px;">在线终端(${onLine })</a>
		                         <a href="javascript:;" class="css_normal" onclick="searchByStatus(0)">离线终端(${offLine })</a>
                             </c:when>
                             <c:otherwise>
                                 <a href="javascript:;" class="css_normal" style="margin:0 8px 0 12px;" onclick="searchByStatus('')">所有终端(${onLine + offLine})</a>
		                    	 <a href="javascript:;" class="css_normal" style="margin-right:8px;" onclick="searchByStatus(1)">在线终端(${onLine })</a>
		                         <a href="javascript:;">离线终端(${offLine })</a>
                             </c:otherwise>
                         </c:choose>
                    </td>
                    <td align="right">
                    	<input id="ckallp" type="checkbox">
                        <label for="ckallp"><strong>插播到所有终端</strong></label>
                    	<input type="button" class="btn-01" value="插播消息" onclick="spotsMessage()">
                        <input type="button" class="btn-01" value="清空消息" onclick="clearMessage()">
                    </td>
                </tr>
            </table>
            <div class="table_box">
            	<table class="boxList">
                	<colgroup>
                    	<col width="5%">
                    	<col width="20%">
                        <col width="10%">
                        <col width="*">
                        <col width="15%">
                    </colgroup>
                    <thead>
                    	<tr>
                            <th>
                            	<input id="ckAll" type="checkbox" title="全选" name="ckAll">
                            </th>
                            <th>
                            	终端名称
                                <img src="<%=path %>/images/icon/min_up.png" alt="">
                            </th>
                            <th>终端状态</th>
                            <th>插播消息</th>
                            <th>终端机构</th>
                            <th>所在分组</th>
                        </tr>
                    </thead> 
                    <tbody>
                    	<c:forEach items="${terminal.rows }" var="terminal">
	                    	<tr>
	                        	<th>
	                            	<input id="ckBox" type="checkbox" value="${terminal.id }" name="ckBox">
	                            </th>
	                            <th title="${terminal.name }"><div class="row-w50" style="max-width: 300px;">${terminal.name }</div></th>
	                            <c:if test="${terminal.status == 1 }">
	                            	<th>在线</th>
	                            </c:if>
	                            <c:if test="${terminal.status == 0 }">
	                            	<th>离线</th>
	                            </c:if>
	                            <th title="${terminal.message }"><a href="<%=path %>/newsStream/news_stream_list.do?terminalId=${terminal.id}" class="fr">更多...</a><div class="row-w500" style="width: 300px">${terminal.message }</div></th>
	                            <th>${terminal.mechanismName }</th>
	                            <th title="${terminal.packetName }"><div class="row-w500" style="width: 300px">${terminal.packetName }</div></th>
	                        </tr>
                        </c:forEach>
                    </tbody>            
                </table>
            </div>
            
            
            <div class="pagebox">
            	<div class="pageleft">
            		<c:if test="${pageTotal >10 }">
            		<c:if test="${terminal.pageNumber != 1}">
						<a href="javascript:void(0)" onclick="searchByPage('${terminal.pageNumber-1}','${terminal.pageSize}')">上一页</a>
					</c:if>
					
					<c:if test="${terminal.pageNumber != 1 and terminal.pageNumber != 2 and terminal.pageNumber != 3}">
            				<a href="javascript:void(0)" onclick="searchByPage('1','10')">1</a>
            				<span class="disabled">...</span>
           			</c:if>
            		<c:forEach begin="${terminal.pageNumber }" end="${terminal.pageNumber + 2}" step="1" var="pageIndex">
            			<c:if test="${pageIndex == terminal.pageNumber and pageIndex <= pageTotal}">
							<span class="cpb">${pageIndex}</span>
						</c:if>
            			<c:if test="${pageIndex != terminal.pageNumber and pageIndex <= pageTotal}">
							<a href="javascript:void(0)" onclick="searchByPage('${pageIndex}','${terminal.pageSize}')">${pageIndex}</a>
						</c:if>
            		</c:forEach>
            		
            		<c:if test="${terminal.pageNumber <= pageTotal - 3 }">
						<span class="disabled">...</span>
						<a href="javascript:void(0)" onclick="searchByPage('${pageTotal}','${terminal.pageSize}')">${pageTotal}</a>
					</c:if>
            		
            		<c:if test="${terminal.pageNumber != pageTotal}">
						<a href="javascript:void(0)" onclick="searchByPage('${terminal.pageNumber+1}','${terminal.pageSize}')">下一页</a>
					</c:if>
            	</c:if>
            	<c:if test="${pageTotal <= 10 }">
            		<c:if test="${terminal.pageNumber != 1}">
						<a href="javascript:void(0)" onclick="searchByPage('${terminal.pageNumber-1}','${terminal.pageSize}')">上一页</a>
					</c:if>
            		<c:forEach begin="1" end="${pageTotal}" step="1" var="pageIndex">
						<c:if test="${pageIndex == terminal.pageNumber}">
							<span class="cpb">${pageIndex}</span>
						</c:if>
						<c:if test="${pageIndex != terminal.pageNumber}">
							<a href="javascript:void(0)" onclick="searchByPage('${pageIndex}','${terminal.pageSize}')">${pageIndex}</a>
						</c:if>
					</c:forEach>
					<c:if test="${terminal.pageNumber != pageTotal}">
						<a href="javascript:void(0)" onclick="searchByPage('${terminal.pageNumber+1}','${terminal.pageSize}')">下一页</a>
					</c:if>
            	</c:if>	
            		
                </div>
                <div class="pageright">
                	<p>每页</p>
                	<c:choose>
						<c:when test="${terminal.pageSize eq 10}">
							<a href="javascript:void(0)" onclick="searchByPage(1,50)">50</a>
		                    <a href="javascript:void(0)" onclick="searchByPage(1,30)">30</a>
		                    <span>10</span>
						</c:when>
						<c:when test="${terminal.pageSize eq 30}">
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
	


//提交按钮验证
function onSubmit(){
	$("#aspnetForm").submit();
}

//点击所有终端
function searchByStatus(status){
	$("#status").val(status);
	$("#aspnetForm").submit();
}


//插播到所有
$("#ckallp").click(function(){
	if($("#ckallp").attr("checked") == 'checked'){
		$("[name='ckBox']").attr("checked",'true');
		$("#ckAll").attr("checked",'true');
	}else{
	 	$("[name='ckBox']").removeAttr("checked");
	 	$("#ckAll").removeAttr("checked");
	}
});

//插播消息
function spotsMessage(){
	var terminalIds="";
	$('input[name="ckBox"]:checked').each(function(i, dom){
		if (i != $('input[name="ckBox"]:checked').length - 1){
			terminalIds += $(this).val()+",";    
        }
		else{
			terminalIds += $(this).val();
		}
	});
	if(terminalIds == "" || terminalIds.length <10){
		layer.alert('请选择要插播消息的终端', {icon:5,title:'提示'});
		return;
	}
	
	
	layer.open({
		type: 2,
	    title: '',
	    shadeClose: false,
	    shade:  [0.8],
	    maxmin: false, //开启最大化最小化按钮
	    area: ['1024px', '450px'],
	    content: '<%=path%>/newsStream/message_page.do?terminalIds='+terminalIds
	});
	
// 	if(navigator.userAgent.indexOf("Chrome") >0 ){
// 		var winOption = "modal=yes,height=450,width=1024,top=50,left=50,toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,fullscreen=0";
// 	    window.open("<%=path%>/page/terminal/insertMessage.jsp",window, winOption);
// 	}else{
// 		window.showModalDialog("<%=path%>/page/terminal/insertMessage.jsp",window,"dialogHeight:450px;dialogWidth:1024px;center:yes;status:no;scroll:no");
// 	}
}


//清空消息
function clearMessage(){
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
		layer.alert('请选择要清空消息终端', {icon:5,title:'提示'});
		return;
	}
	$.ajax({
	    type: "post", 
	    dataType: "json", 
	    url: "<%=path %>/terminalCommand/emptyMessage.do", 
	    data: {"ids":ids}, 
	    success: function(data) {
	    	if(data.message != 1){
	    		layer.alert('清空消息失败', {icon:5,title:'提示'});
	    	}else{
	    		layer.alert('清空消息成功', {icon:5,title:'提示'});
	    		window.location="<%=path%>/newsStream/terminal_list.do";
	    	}
	    }, 
	    error: function(err) {
	    	layer.alert(err, {icon:5,title:'提示'});
	    } 
	});
}


//全选
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
