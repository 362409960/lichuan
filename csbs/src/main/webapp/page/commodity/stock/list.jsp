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
<title>管理中心——Cloudring Shop</title>
<link rel="stylesheet" type="text/css" href="<%=path%>/css/deafult/common.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/deafult/main.css">
<script type="text/javascript" src="<%=path%>/js/jquery.min.js"></script>
</head>

<body>
<div class="breadcrumb"><a href="<%=path%>/index.jsp">首页</a>&raquo;库存记录<span>(共${total}条记录)</span></div>
<form id="listForm" method="post" action="<%=path%>/admin/invManag/toSearch.do">
	<input type="hidden" id="pageSize" name="pageSize" value="20" />
	<input type="hidden" id="searchProperty" name="searchProperty" value="" />
	<input type="hidden" id="orderProperty" name="orderProperty" value="" />
	<input type="hidden" id="orderDirection" name="orderDirection" value="" />

	<div class="bar">
        <div class="buttonGroup">
        	<a class="button" href="<%=path%>/admin/invManag/toInQuany.do">
            	入库
            </a>
            <a class="button" href="<%=path%>/admin/invManag/toOutQuany.do">
            	出库
            </a>
            <a id="refreshButton" class="iconButton" href="javascript:;">
            	<span class="refreshIcon icon"></span>&nbsp;刷新
            </a>
            <div id="pageSizeMenu" class="dropdownMenu">
            	<a class="button" href="javascript:;">每页显示&nbsp;<span class="arrow"></span></a>
                <ul>
                	<c:choose>
                      <c:when test="${invManag.pageSize=='10'}">
                         <li class="current" val="10">10</li>
	                    <li  val="20">20</li>
	                    <li val="50">50</li>  
                      </c:when>
                      <c:when test="${invManag.pageSize=='20'}">
                         <li val="10">10</li>
	                    <li class="current" val="20">20</li>
	                    <li val="50">50</li>  
                      </c:when>
                      <c:otherwise>
                         <li val="10">10</li>
	                    <li val="20">20</li>
	                    <li class="current" val="50">50</li>  
                      </c:otherwise>
                   </c:choose>
                </ul>
            </div>
        </div>
        <div id=searchPropertyMenu class="dropdownMenu">
        	<div class="search">
            	<span class="arrow"></span>
                <input id="searchValue" type="text" maxlength="200" value="" name="searchValue">
                <button type="submit"></button>
            </div>
            <ul>
            	<li val="product_no">编号</li>
                <li val="update_user">操作员</li>
            </ul>
        </div>
    </div>
    <table id="listTable" class="list">
    	<tr>
            <th><a href="javascript:;" class="sort" name="product_no">编号</a></th>
            <th><a href="javascript:;" class="sort" name="product_name">商品</a></th>
            <th><a href="javascript:;" class="sort" name="type">类型</a></th>
            <th><a href="javascript:;" class="sort" name="inQuantity">入库数量</a></th>
            <th><a href="javascript:;" class="sort" name="outQuantity">出库数量</a></th>
            <th><a href="javascript:;" class="sort" name="stock">当前库存</a></th>
            <th><a href="javascript:;" class="sort" name="update_user">操作员</a></th>
            <th><a href="javascript:;" class="sort" name="remark">备注</a></th>
            <th><a href="javascript:;" class="sort" name="create_time">创建日期</a></th>
        </tr>
        <c:forEach items="${invManag.rows}" var="it" varStatus="st">
        <tr>
        	<td>${it.product_no}</td>
            <td><span title="${it.product_name}">${it.product_name}</span></td>
            <c:choose>
               <c:when test="${it.type=='0'}">  <td>出库</td></c:when>
                <c:when test="${it.type=='1'}">  <td>入库</td></c:when>
               <c:otherwise>  <td></td></c:otherwise>
            </c:choose>
            <td>${it.inQuantity}</td>
            <td>${it.outQuantity}</td>
            <td>${it.stock}</td>
            <td>${it.update_user}</td>
            <td>&nbsp;</td>
            <td><span title="<fmt:formatDate value="${it.create_time}" pattern="yy-MM-dd hh:mm:ss"/>"><fmt:formatDate value="${it.create_time}" pattern="yy-MM-dd"/></span></td>
        </tr> 
        </c:forEach>      
    </table>
    <div class="pagination">
    	  <c:choose>
		     <c:when test="${invManag.pageMax!=0}">
		     <c:choose>
				<c:when test="${invManag.pageIndex+1==1}">
				   <c:choose>
				    <c:when test="${invManag.pageIndex+1==invManag.pageMax}">	
				     <input type="hidden" name="pageNumber" id="pageNumber" value="1" />                          
					 </c:when>
					 <c:otherwise>
							<span class="firstPage">&nbsp;</span>
							<span class="previousPage">&nbsp;</span>
							<c:forEach var="i" begin="${p_begin}" end="${p_end}">
					            <c:choose>
					              <c:when test="${i==invManag.pageIndex+1}"><span class="currentPage">${i}</span></c:when>
					              <c:otherwise><a href="javascript:$.pageSkip(${i});">${i}</a></c:otherwise>
					            </c:choose>
					         </c:forEach>						
							<a href="javascript: $.pageSkip(${invManag.pageIndex+2});" class="nextPage">&nbsp;</a>
							<a href="javascript: $.pageSkip(${invManag.pageMax});" class="lastPage">&nbsp;</a>
							<span class="pageSkip">
					        	共${invManag.pageMax}页
					            <input id="pageNumber" name="pageNumber" value="${invManag.pageIndex+1}" maxlength="9">
					           	<button type="submit">&nbsp;</button>
					        </span>
					 </c:otherwise>
					 </c:choose>
				</c:when>
				<c:when test="${invManag.pageIndex+1==invManag.pageMax}">
				     	<a href="javascript: $.pageSkip(1);" class="firstPage">&nbsp;</a>
						<a href="javascript: $.pageSkip(${invManag.pageIndex});" class="previousPage">&nbsp;</a>
						<c:forEach var="i" begin="${p_begin}" end="${p_end}">
				            <c:choose>
				              <c:when test="${i==invManag.pageIndex+1}"><span class="currentPage">${i}</span></c:when>
				              <c:otherwise><a href="javascript:$.pageSkip(${i});">${i}</a></c:otherwise>
				            </c:choose>
				         </c:forEach>
						<span class="nextPage">&nbsp;</span>
						<span class="lastPage">&nbsp;</span>
						<span class="pageSkip">
				        	共${invManag.pageMax}页
				            <input id="pageNumber" name="pageNumber" value="${invManag.pageIndex+1}" maxlength="9">
				           	<button type="submit">&nbsp;</button>
				        </span>
				
				</c:when>							
				<c:otherwise>
					<a href="javascript: $.pageSkip(1);" class="firstPage">&nbsp;</a>
					<a href="javascript: $.pageSkip(${invManag.pageIndex});" class="previousPage">&nbsp;</a>
						<c:forEach var="i" begin="${p_begin}" end="${p_end}">
				            <c:choose>
				              <c:when test="${i==invManag.pageIndex+1}"><span class="currentPage">${i}</span></c:when>
				              <c:otherwise><a href="javascript:$.pageSkip(${i});">${i}</a></c:otherwise>
				            </c:choose>
				         </c:forEach>
					<a href="javascript: $.pageSkip(${invManag.pageIndex+2});" class="nextPage">&nbsp;</a>
					<a href="javascript: $.pageSkip(${invManag.pageMax});" class="lastPage">&nbsp;</a>
					<span class="pageSkip">
			        	共${invManag.pageMax}页
			            <input id="pageNumber" name="pageNumber" value="${invManag.pageIndex+1}" maxlength="9">
			           	<button type="submit">&nbsp;</button>
			        </span>
				</c:otherwise>
			</c:choose>
		     </c:when>
		     <c:otherwise> <input type="hidden" name="pageNumber" id="pageNumber" value="1" />     </c:otherwise>
		   </c:choose>
    </div>
</form>
</body>
</html>
<script language="JavaScript" type="text/JavaScript">
var contextPath = "${pageContext.request.contextPath}";
$(function(){
	var $listForm=$('#listForm');
	
	var $pageSizeMenu=$('#pageSizeMenu');/*每页显示*/
	var $pageSizeMenuItem = $('#pageSizeMenu li');
	var $searchMenu=$('#searchPropertyMenu'); /*搜索类别*/
	var $searchPropertyMenuItem = $("#searchPropertyMenu li");
	var $selectAll=$('#selectAll');
	var $searchValue = $("#searchValue");
	var $contentRow=$('#listTable tr:gt(0)');
	var $refreshButton = $('#refreshButton');	
	var $sort = $('#listTable a.sort');
	var $searchProperty = $("#searchProperty");
	var $orderProperty = $("#orderProperty");
	var $orderDirection = $("#orderDirection");
	var $pageNumber = $("#pageNumber");
	var $pageSize = $("#pageSize");
	
	
	$pageSizeMenu.hover(function(){
		$(this).children('ul').show();
	},function(){
		$(this).children('ul').hide();
	});
	
	$searchMenu.hover(function(){
		$(this).children('ul').show();	
	},function(){
		$(this).children('ul').hide();	
	});
	
	$searchPropertyMenuItem.click( function() {
		var $this = $(this);
		$searchProperty.val($this.attr("val"));
		$searchPropertyMenuItem.removeClass("current");
		$this.addClass("current");
	});
	
	$selectAll.click(function(){
		var $this=$(this);
		if($this.prop('checked')){			
			$contentRow.addClass('selected');
		}else{			
			$contentRow.removeClass('selected');	
		}
	});

	
	$refreshButton.click( function() {
		location.reload(true);
		return false;
	});
	
	$pageSizeMenuItem.click( function() {
		$pageSize.val($(this).attr("val"));
		$pageNumber.val("1");
		$listForm.submit();
	});
	
	$.pageSkip = function(pageNumber) {
		$pageNumber.val(pageNumber);
		$listForm.submit();
		return false;
	};
	
	$listForm.submit(function() {
		if (!/^\d*[1-9]\d*$/.test($pageNumber.val())) {
			$pageNumber.val("1");
		}
		if ($searchValue.size() > 0 && $searchValue.val() != "" && $searchProperty.val() == "") {
			$searchProperty.val($searchPropertyMenuItem.first().attr("val"));
		}
	});
	
	$sort.click( function() {
		var orderProperty = $(this).attr("name");
		if ($orderProperty.val() == orderProperty) {
			if ($orderDirection.val() == "asc") {
				$orderDirection.val("desc");
			} else {
				$orderDirection.val("asc");
			}
		} else {
			$orderProperty.val(orderProperty);
			$orderDirection.val("asc");
		}
		$pageNumber.val("1");
		$listForm.submit();
		return false;
	});
	
	if ($orderProperty.val() != "") {
		$sort = $("#listTable a[name='" + $orderProperty.val() + "']");
		if ($orderDirection.val() == "asc") {
			$sort.removeClass("desc").addClass("asc");
		} else {
			$sort.removeClass("asc").addClass("desc");
		}
	}
	
	$pageNumber.keypress(function(event) {
		return (event.which >= 48 && event.which <= 57) || event.which == 8 || (event.which == 13 && $(this).val().length > 0);
	});
});
function trim(str){ 
		//删除左右两端的空格
		return str.replace(/(^\s*)|(\s*$)/g, "");
	}
</script>
