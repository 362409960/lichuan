<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="/WEB-INF/tlds/c.tld" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="/WEB-INF/tlds/fn.tld" prefix="fn"%>
<!DOCTYPE html>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<html>
<head>
<meta charset="UTF-8">
<title>用户管理</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta content="" name="description">
<meta content="" name="keywords">
<meta content="Cloudring" name="author">
<meta content="Cloudring" name="copyright">
<link rel="shortcut icon" href="<%=request.getContextPath()%>/images/icon/icon.png">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/common.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/main.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/page.css">
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common.js"></script>
<script type="text/javascript"  src="<%=path%>/layer/layer.js"></script>
<style type="text/css">
html,body{
	height:100%;
	width:100%;
	overflow:auto;
}
</style>

<script type="text/javascript">
$(function(){
	$("#v_index").removeClass("visiting");
	$("#v_program").removeClass("visiting");
	$("#v_terminal").removeClass("visiting");
	$("#v_sys").addClass("visiting");
	$("#v_mater").removeClass("visiting");
	//全选
	$("#ckAll").click(function () {
		$('input[name="ckBox"]').attr("checked",this.checked);
	});
	
	//反选全选
	$('input[name="ckBox"]').click(function(){
        $("#ckAll").attr("checked",$('input[name="ckBox"]').length == $("input[name='ckBox']:checked").length ? true : false);
    });
	
	//删除
	$("#delete").click(function(){
		var ids = "";//获取优惠活动编号
		var check=document.getElementsByName("ckBox");
		var flag = false ;
		for(var i=0;i<check.length;i++){
			if(check[i].checked==true){
				flag = true;
			}
		}
		if(!flag){
	        layerAlter("提示","请选择要删除的用户！");
	        return false ;
	    }else{
	    	
	    	$('input[name="ckBox"]:checked').each(function(){
	    		ids+=$(this).parents("td").find("input[name='id']").val()+",";//获取优惠活动编号
		  	});
	    	
	    	layer.confirm('确定要删除吗？',{icon: 3, title:'提示'},function(index){
		    		$.ajax({
				   		url : "<%=request.getContextPath()%>/admin/user/deleteSysUser.do?ids="+ids.substring(0, ids.length-1),
				   		type: "POST",
				   		cache:false,
				   		async:true,
				   		dataType: "json",
				   		success:function(data) {
				   			if(data=="true"){
				   				$("#userForm").submit();
				   				//window.location.href = '<%=request.getContextPath()%>/admin/user/listSysUser.do';
				   			}else{
				   				layerAlter("提示","删除失败！"); 
				   			}
				        },
				   		error:function(XMLHttpRequest, textStatus, errorThrown) {
			               	layerAlter("提示","操作出现异常！");
			           	}
			       	});
	    		}
	    	);
	    	
	    }
	});
	
	//机构
	$("#departmentname").click(function() {
		var url = "<%=request.getContextPath()%>/admin/department/listDepartment.do?action=ztree";
		var returnParm='';
        var winOption = "height="+310+",width="+410+",top=400,left=700,toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,fullscreen=0";
        
        if(navigator.userAgent.indexOf("Chrome") >0){//谷歌浏览器
        	returnParm=window.open(url,window, winOption);
        	$("#departmentid").val(document.getElementById("departmentid").value);
            $("#departmentname").val(document.getElementById("departmentname").value);
        }else{
        	returnParm=window.showModalDialog(url, "", "dialogHeight:310px;dialogWidth:410px;dialogTop:400;dialogLeft:700;center:yes;status:no");
        }
        
        if (returnParm != null) {
        	var parm = returnParm.split(",");
        	$("#departmentid").val(parm[0]);
            $("#departmentname").val(parm[1]);
        }
    });
});


function searchPage(page,pageSize){
	$("#page").val(page);
	$("#pageSize").val(pageSize);
	$("#userForm").submit();
}

//清空
function empty(){
	$("#userName").val("");
	$("#departmentid").val("");
	$("#departmentname").val("");
}

</script>
</head>

<body>
	<jsp:include page="/page/top.jsp" />
    <div class="blank9"></div>
    <div class="container">
    	<form name="userForm" method="post" action="<%=request.getContextPath()%>/admin/user/listSysUser.do" id="userForm">
    		<input type="hidden" id="page" name="page" value="${page }" />
    		<input type="hidden" id="pageSize" name="pageSize" value="${pageSize }" />
        	<div class="title_Nav">
            	<div class="title_text">
                	<p>
                    	 系统设置&gt;
                        <span>用户管理</span>
                    </p>
                </div>
                <div class="title_search">
                	<strong>查询:</strong>
                    <span>用户名</span>
                    <input name="userName" type="text" id="userName" value="${userName }" class="inp-90" />
                    <span>所属机构</span>
                    <input type="text" class="inp-90" id="departmentname" name="departmentname" value="${departmentname }" placeholder="请选择机构" readonly="readonly">
                    <input type="hidden" id="departmentid" name="departmentid" value="${departmentid }">
                    <input type="submit" class="btn-01" value="搜索">
                    <input type="button" class="btn-01" value="清空" onclick="empty()">
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
                    	<span style="padding-left:15px;">共计：</span>
                        <strong class="black">${total };</strong>
                    </td>
                    <td align="right">
                        <input type="button" class="btn-01" value=" 新建 " onclick="location.href='<%=request.getContextPath()%>/admin/user/detailsUser.do?action=1'" /> 
						<input type="button" class="btn-01" name="delete" id="delete" value="删除" />
                    </td>
                </tr>
            </table>
            <div class="table_box">
            	<table class="boxList">
                	<colgroup>
                		<col width="5%">
                    	<col width="10%">
                    	<col width="15%">
                        <col width="10%">
                        <col width="10%">
                        <!-- <col width="10%"> -->
                        <col width="20%">
                        <col width="20%">
                    </colgroup>
                    <thead>
                    	<tr>
                            <th>
                            	<input id="ckAll" type="checkbox" title="全选" name="ckAll">
                            </th>
                            <th>用户名</th>
                            <th>用户代码</th>
                            <th>号码</th>
                            <th>所属机构</th>
                            <!-- <th>用户角色</th> -->
                            <th>创建时间</th>
                            <th>电子邮件</th>
                        </tr>
                    </thead>
                    <tbody>
                    	<c:forEach items="${list }" var="user">
	                    	<tr>
	                        	<td style="text-align: center;">
	                            	<input id="ckBox" name="ckBox" type="checkbox" />
									<input id="id" name="id" type="hidden" value="${user.id }" />
	                            </td>
	                            <td style="text-align: center;">
	                            	<a href='<%=request.getContextPath()%>/admin/user/detailsUser.do?id=${user.id }' target='_self' title='${user.userName }'>${user.userName }</a>
	                            </td>
	                            <td style="text-align: center;">${user.userCode }</td>
	                            <td style="text-align: center;">${user.phone }</td>
	                            <td style="text-align: center;">${user.departmentname }</td>
	                            <!-- <td style="text-align: center;" title="${user.role }">${user.role }</td> -->
	                            <td style="text-align: center;">${fn:substring(user.createTime ,0,19 )}</td>
	                            <td style="text-align: center;">${user.email }</td>
	                        </tr>
                        </c:forEach>
                    </tbody>            
                </table>
            </div>
            
            <div class="pagebox">
            	<!-- <div class="pageleft">
            		<c:if test="${currentPage != 1}">
						<a href="javascript:void(0)" onclick="searchPage('${currentPage-1}','${pageSize}')">上一页</a>
					</c:if>
            		<c:forEach begin="1" end="${pageTimes}" step="1" var="pageIndex">
						<c:choose>
							<c:when test="${pageIndex > 10}">
								<span class="disabled">...</span>
							</c:when>
							<c:otherwise>
								<c:if test="${pageIndex == currentPage}">
									<span class="cpb">${pageIndex}</span>
								</c:if>
								<c:if test="${pageIndex != currentPage}">
									<a href="javascript:void(0)" onclick="searchPage('${pageIndex}','${pageSize}')">${pageIndex}</a>
								</c:if>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					<c:if test="${currentPage != pageTimes}">
						<a href="javascript:void(0)" onclick="searchPage('${currentPage+1}','${pageSize}')">下一页</a>
					</c:if>
                </div> -->
                
                <div class="pageleft">
	            	<c:if test="${pageTimes > 10 }">
	            		<c:if test="${currentPage != 1}">
							<a href="javascript:void(0)" onclick="searchPage('${currentPage-1}','${pageSize}')">上一页</a>
						</c:if>
						
						<c:if test="${currentPage != 1 and currentPage != 2 and currentPage != 3}">
	            			<a href="javascript:void(0)" onclick="searchPage(1,5)">1</a>
	            			<span class="disabled">...</span>
	           			</c:if>
	            		<c:forEach begin="${currentPage }" end="${currentPage + 2}" step="1" var="pageIndex">
	            			<c:if test="${pageIndex == currentPage and pageIndex <= pageTimes}">
								<span class="cpb">${pageIndex}</span>
							</c:if>
	            			<c:if test="${pageIndex != currentPage and pageIndex <= pageTimes}">
								<a href="javascript:void(0)" onclick="searchPage('${pageIndex}','${pageSize}')">${pageIndex}</a>
							</c:if>
	            		</c:forEach>
	            		
	            		<c:if test="${currentPage <= pageTimes - 3 }">
							<span class="disabled">...</span>
							<a href="javascript:void(0)" onclick="searchPage('${pageTimes}','${pageSize}')">${pageTimes}</a>
						</c:if>
	            		
	            		<c:if test="${currentPage != pageTimes}">
							<a href="javascript:void(0)" onclick="searchPage('${currentPage+1}','${pageSize}')">下一页</a>
						</c:if>
	            	</c:if>
	            	<c:if test="${pageTimes < 10 }">
	            		<c:if test="${currentPage != 1}">
							<a href="javascript:void(0)" onclick="searchPage('${currentPage-1}','${pageSize}')">上一页</a>
						</c:if>
	            		<c:forEach begin="1" end="${pageTimes}" step="1" var="pageIndex">
							<c:if test="${pageIndex == currentPage}">
								<span class="cpb">${pageIndex}</span>
							</c:if>
							<c:if test="${pageIndex != currentPage}">
								<a href="javascript:void(0)" onclick="searchPage('${pageIndex}','${pageSize}')">${pageIndex}</a>
							</c:if>
						</c:forEach>
						<c:if test="${currentPage != pageTimes}">
							<a href="javascript:void(0)" onclick="searchPage('${currentPage+1}','${pageSize}')">下一页</a>
						</c:if>
	            	</c:if>	
                </div>
                
                <div class="pageright">
                	<p>每页</p>
                	<c:choose>
						<c:when test="${pageSize eq 10}">
							<a href="javascript:void(0)" onclick="searchPage(1,50)">50</a>
		                    <a href="javascript:void(0)" onclick="searchPage(1,30)">30</a>
		                    <span>10</span>
						</c:when>
						<c:when test="${pageSize eq 30}">
							<a href="javascript:void(0)" onclick="searchPage(1,50)">50</a>
							<span>30</span>
		                    <a href="javascript:void(0)" onclick="searchPage(1,10)">10</a>
						</c:when>
						<c:otherwise>
							<span>50</span>
							<a href="javascript:void(0)" onclick="searchPage(1,30)">30</a>
		                    <a href="javascript:void(0)" onclick="searchPage(1,10)">10</a>
						</c:otherwise>
					</c:choose>
                </div>
            </div>
            
            <!-- <div class="pagebox">
            	<div class="pageleft">
                	<span class="cpb">1</span>
                    <a href="javascript:;">2</a>
                    <a href="javascript:;">下一页</a>
                </div>
                <div class="pageright">
                	<p>每页</p>
                    <a href="javascirp:;">30</a>
                    <a href="javascirp:;">10</a>
                    <span>5</span>
                </div>
            </div> -->
        </form>
        
        <!-- <c:if test="${total != 0}">
			<div class="class_page">
				&nbsp;&nbsp;共${total}条记录
				<c:choose>
					<c:when test="${currentPage == 1}">
						<span class="disabled">首页</span>
					</c:when>
					<c:otherwise>
						<a href="<%=request.getContextPath()%>/admin/user/listSysUser.do?page=1">首页</a>
					</c:otherwise>
				</c:choose>
				<c:if test="${currentPage == 1}">
					<span class="disabled"><< 上一页</span>
				</c:if>
				<c:if test="${currentPage != 1}">
					<a href="<%=request.getContextPath()%>/admin/user/listSysUser.do?page=${currentPage-1}"><<
						上一页</a>
				</c:if>
	
				<c:forEach begin="1" end="${pageTimes}" step="1" var="pageIndex">
					<c:choose>
						<c:when test="${pageIndex > 10}">
							<span class="disabled">...</span>
						</c:when>
						<c:otherwise>
							<c:if test="${pageIndex == currentPage}">
								<span class="disabled">${pageIndex}</span>
							</c:if>
							<c:if test="${pageIndex != currentPage}">
								<a href="<%=request.getContextPath()%>/admin/user/listSysUser.do?page=${pageIndex}">${pageIndex}</a>
							</c:if>
						</c:otherwise>
					</c:choose>
				</c:forEach>
	
				<c:if test="${currentPage == pageTimes}">
					<span class="disabled">下一页 >></span>
				</c:if>
				<c:if test="${currentPage != pageTimes}">
					<a href="<%=request.getContextPath()%>/admin/user/listSysUser.do?page=${currentPage+1}">下一页
						>></a>
				</c:if>
	
				<c:choose>
					<c:when test="${currentPage == pageTimes}">
						<span class="disabled">尾页</span>
					</c:when>
					<c:otherwise>
						<a
							href="<%=request.getContextPath()%>/admin/user/listSysUser.do?page=${pageTimes}">尾页</a>
					</c:otherwise>
				</c:choose>
			</div>
		</c:if> -->
    </div>
</body>
</html>
