<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
<title>角色列表</title>
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
 	        layerAlter("提示","请选择要删除的角色！");
 	        return false ;
 	    }else{
 	    	
 	    	$('input[name="ckBox"]:checked').each(function(){
 	    		ids+=$(this).parents("td").find("input[name='id']").val()+",";
 		  	});
 	    	
   			layer.confirm('确定要删除吗？',{icon: 3, title:'提示'},function(index){
	 	    		$.ajax({
			 	   		url : "<%=request.getContextPath()%>/admin/role/deleteRole.do?ids="+ids.substring(0, ids.length-1),
			 	   		type: "POST",
			 	   		cache:false,
			 	   		async:true,
			 	   		dataType: "json",
			 	   		success:function(data) {
			 	   			if(data=="true"){
			 	   				$("#roleForm").submit();
			 	   				//window.location.href = '<%=request.getContextPath()%>/admin/role/listRole.do';
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
});

function searchPage(page,pageSize){
	$("#page").val(page);
	$("#pageSize").val(pageSize);
	$("#roleForm").submit();
}

</script>
</head>

<body>
	<jsp:include page="/page/top.jsp" />
    <div class="blank9"></div>
    <div class="container">
    	<form name="roleForm" method="post" action="<%=request.getContextPath()%>/admin/role/listRole.do" id="roleForm">
    		<input type="hidden" id="page" name="page" value="${pageNumber }" />
    		<input type="hidden" id="pageSize" name="pageSize" value="${pageSize }" />
        	<div class="title_Nav">
            	<div class="title_text">
                	<p>
                    	 系统设置&gt;
                        <span>角色管理</span>
                    </p>
                </div>
                <div class="title_search">
                	<strong>查询:</strong>
                    <span>角色名称</span>
                    <input type="text" class="inp-120" name="role_name" value="${role_name}" id="role_name">
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
                    	<span style="padding-left:15px;">共计：</span>
                        <strong class="black">${total };</strong>
                    </td>
                    <td align="right">
                        <input type="button" class="btn-01" value=" 新建 " onclick="location.href='<%=request.getContextPath()%>/admin/role/detailsRole.do?action=1'" />
						<input type="button" class="btn-01" value="删除" name="delete" id="delete" />
                    </td>
                </tr>
            </table>
            <div class="table_box">
            	<table class="boxList">
                	<colgroup>
                    	<col width="5%">
                    	<col width="35%">
                        <col width="30%">
                        <col width="30%">
                    </colgroup>
                    <thead>
                    	<tr>
                            <th>
                            	<input id="ckAll" type="checkbox" title="全选" name="ckAll">
                            </th>
                            <th>角色名称</th>
                            <th>创建时间</th>
                            <th>修改时间</th>
                        </tr>
                    </thead> 
                    <tbody>
                    	<c:forEach items="${list }" var="role">
							<tr>
								<td style="text-align: center;">
									<input id="ckBox" name="ckBox" type="checkbox" />
									<input id="id" name="id" type="hidden" value='${role.id }' />
								</td>
								<td style="text-align: center;"><a href='<%=request.getContextPath()%>/admin/role/detailsRole.do?id=${role.id }' target='_self' title='${role.role_name }'>${role.role_name }</a></td>
								<td style="text-align: center;"><fmt:formatDate value='${role.create_time}' pattern='yyyy-MM-dd HH:mm:ss'/></td>
								<td style="text-align: center;"><fmt:formatDate value='${role.update_time}' pattern='yyyy-MM-dd HH:mm:ss'/></td>
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
						<c:when test="${pageSize eq 5}">
							<a href="javascript:void(0)" onclick="searchPage(1,30)">30</a>
		                    <a href="javascript:void(0)" onclick="searchPage(1,10)">10</a>
		                    <span>5</span>
						</c:when>
						<c:when test="${pageSize eq 10}">
							<a href="javascript:void(0)" onclick="searchPage(1,30)">30</a>
							<span>10</span>
		                    <a href="javascript:void(0)" onclick="searchPage(1,5)">5</a>
						</c:when>
						<c:otherwise>
							<span>30</span>
							<a href="javascript:void(0)" onclick="searchPage(1,10)">10</a>
		                    <a href="javascript:void(0)" onclick="searchPage(1,5)">5</a>
						</c:otherwise>
					</c:choose>
                </div>
            </div>
        </form>
        
        <!-- <c:if test="${total != 0}">
			<div class="class_page">
				&nbsp;&nbsp;共${total}条记录
				<c:choose>
					<c:when test="${currentPage == 1}">
						<span class="disabled">首页</span>
					</c:when>
					<c:otherwise>
						<a href="<%=request.getContextPath()%>/admin/role/listRole.do?page=1">首页</a>
					</c:otherwise>
				</c:choose>
				<c:if test="${currentPage == 1}">
					<span class="disabled"><< 上一页</span>
				</c:if>
				<c:if test="${currentPage != 1}">
					<a href="<%=request.getContextPath()%>/admin/role/listRole.do?page=${currentPage-1}"><<
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
								<a href="<%=request.getContextPath()%>/admin/role/listRole.do?page=${pageIndex}">${pageIndex}</a>
							</c:if>
						</c:otherwise>
					</c:choose>
				</c:forEach>
	
				<c:if test="${currentPage == pageTimes}">
					<span class="disabled">下一页 >></span>
				</c:if>
				<c:if test="${currentPage != pageTimes}">
					<a
						href="<%=request.getContextPath()%>/admin/role/listRole.do?page=${currentPage+1}">下一页
						>></a>
				</c:if>
	
				<c:choose>
					<c:when test="${currentPage == pageTimes}">
						<span class="disabled">尾页</span>
					</c:when>
					<c:otherwise>
						<a
							href="<%=request.getContextPath()%>/admin/role/listRole.do?page=${pageTimes}">尾页</a>
					</c:otherwise>
				</c:choose>
			</div>
		</c:if> -->
    </div>
</body>
</html>
