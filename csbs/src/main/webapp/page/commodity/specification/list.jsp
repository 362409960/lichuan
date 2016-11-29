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
<meta content="Cloudring" name="author">
<meta content="Cloudring" name="copyright">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/deafult/common.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/deafult/main.css">
<script type="text/javascript" src="<%=path%>/js/jquery.min.js"></script>
</head>

<body>
<div class="breadcrumb"><a href="<%=path%>/index.jsp">首页</a>&raquo;规格列表<span>(共${total}条记录)</span></div>
<form id="listForm" method="post" action="<%=path%>/admin/specification/toSearch.do">
<input type="hidden" id="pageSize" name="pageSize" value="20" />
<input type="hidden" id="searchProperty" name="searchProperty" value="" />
<input type="hidden" id="orderProperty" name="orderProperty" value="" />
<input type="hidden" id="orderDirection" name="orderDirection" value="" />

	<div class="bar">
    	<a class="iconButton" href="<%=path%>/admin/specification/toAdd.do">
        	<span class="addIcon icon"></span>&nbsp;添加
        </a>
        <div class="buttonGroup">
        	<a id="deleteButton" class="iconButton disabled" href="javascript:;">
            	<span class="deleteIcon icon"></span>&nbsp;删除
            </a>
            <a id="refreshButton" class="iconButton" href="javascript:;">
            	<span class="refreshIcon icon"></span>&nbsp;刷新
            </a>
            <div id="pageSizeMenu" class="dropdownMenu">
            	<a class="button" href="javascript:;">每页显示&nbsp;<span class="arrow"></span></a>
                <ul>
                	<c:choose>
                      <c:when test="${spec.pageSize=='10'}">
                         <li class="current" val="10">10</li>
	                    <li  val="20">20</li>
	                    <li val="50">50</li>  
                      </c:when>
                      <c:when test="${spec.pageSize=='20'}">
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
        <div id="searchPropertyMenu" class="dropdownMenu">
        	<div class="search">
            	<span class="arrow"></span>
                <input id="searchValue" type="text" maxlength="200" value="" name="searchValue">
                <button type="submit"></button>
            </div>
            <ul>
            	<li val="group_name">名称</li>
            </ul>
        </div>
    </div>
    <table id="listTable" class="list">
    	<tr>
        	<th class="check"><input type="checkbox" id="selectAll"></th>
            <th><a href="javascript:;" class="sort" name="group_name">名称</a></th>
            <th><a href="javascript:;" class="sort" name="productCategoryId">绑定分类</a></th>
            <th><span>可选项</span></th>
            <th><a href="javascript:;" class="sort" name="order_value">排序</a></th>
            <th><span>操作</span></th>
        </tr>
          <c:forEach items="${spec.rows}" var="pIt" varStatus="st">
        <tr>
        	<td><input type="checkbox" name="ids" value="${pIt.id}"></td>
            <td>${pIt.group_name}</td>
            <td>${pIt.productCategoryId}</td>
            <td>${pIt.sp_options}</td>
            <td>${pIt.order_value}</td>
            <td><a href="<%=path%>/admin/specification/toEdit.do?id=${pIt.id}">[编辑]</a>&nbsp; <a href="<%=path%>/admin/specification/toCopy.do?id=${pIt.id}" >[复制]</a></td>
        </tr>
        </c:forEach>
    </table>
     <div class="pagination">
         <c:choose>
		     <c:when test="${spec.pageMax!=0}">
		     <c:choose>
				<c:when test="${spec.pageIndex+1==1}">
				   <c:choose>
				    <c:when test="${spec.pageIndex+1==spec.pageMax}">	
				     <input type="hidden" name="pageNumber" id="pageNumber" value="1"/>                          
					 </c:when>
					 <c:otherwise>
							<span class="firstPage">&nbsp;</span>
							<span class="previousPage">&nbsp;</span>
							<c:forEach var="i" begin="${p_begin}" end="${p_end}">
					            <c:choose>
					              <c:when test="${i==spec.pageIndex+1}"><span class="currentPage">${i}</span></c:when>
					              <c:otherwise><a href="javascript:$.pageSkip(${i});">${i}</a></c:otherwise>
					            </c:choose>
					         </c:forEach>						
							<a href="javascript: $.pageSkip(${spec.pageIndex+2});" class="nextPage">&nbsp;</a>
							<a href="javascript: $.pageSkip(${spec.pageMax});" class="lastPage">&nbsp;</a>
							<span class="pageSkip">
					        	共${spec.pageMax}页
					            <input id="pageNumber" name="pageNumber" value="${spec.pageIndex+1}" maxlength="9">
					           	<button type="submit">&nbsp;</button>
					        </span>
					 </c:otherwise>
					 </c:choose>
				</c:when>
				<c:when test="${spec.pageIndex+1==spec.pageMax}">
				     	<a href="javascript: $.pageSkip(1);" class="firstPage">&nbsp;</a>
						<a href="javascript: $.pageSkip(${spec.pageIndex});" class="previousPage">&nbsp;</a>
						<c:forEach var="i" begin="${p_begin}" end="${p_end}">
				            <c:choose>
				              <c:when test="${i==spec.pageIndex+1}"><span class="currentPage">${i}</span></c:when>
				              <c:otherwise><a href="javascript:$.pageSkip(${i});">${i}</a></c:otherwise>
				            </c:choose>
				         </c:forEach>
						<span class="nextPage">&nbsp;</span>
						<span class="lastPage">&nbsp;</span>
						<span class="pageSkip">
				        	共${spec.pageMax}页
				            <input id="pageNumber" name="pageNumber" value="${spec.pageIndex+1}" maxlength="9">
				           	<button type="submit">&nbsp;</button>
				        </span>
				
				</c:when>							
				<c:otherwise>
					<a href="javascript: $.pageSkip(1);" class="firstPage">&nbsp;</a>
					<a href="javascript: $.pageSkip(${spec.pageIndex});" class="previousPage">&nbsp;</a>
						<c:forEach var="i" begin="${p_begin}" end="${p_end}">
				            <c:choose>
				              <c:when test="${i==spec.pageIndex+1}"><span class="currentPage">${i}</span></c:when>
				              <c:otherwise><a href="javascript:$.pageSkip(${i});">${i}</a></c:otherwise>
				            </c:choose>
				         </c:forEach>
					<a href="javascript: $.pageSkip(${spec.pageIndex+2});" class="nextPage">&nbsp;</a>
					<a href="javascript: $.pageSkip(${spec.pageMax});" class="lastPage">&nbsp;</a>
					<span class="pageSkip">
			        	共${spec.pageMax}页
			            <input id="pageNumber" name="pageNumber" value="${spec.pageIndex+1}" maxlength="9">
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
	var $deleteButton=$('#deleteButton');
	var $selectAll=$('#selectAll');
	var $searchValue = $("#searchValue");
	var $enabledIds=$('#listTable input[name="ids"]:enabled');
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
			$enabledIds.prop('checked',true);
			$deleteButton.removeClass('disabled');
			$contentRow.addClass('selected');
		}else{
			$enabledIds.prop('checked',false);
			$deleteButton.addClass('disabled');
			$contentRow.removeClass('selected');	
		}
	});
	$enabledIds.each(function(index, element) {
        var $this=$(this);
		$this.click(function(){
			var $checkedIds=$('#listTable input[name="ids"]:checked');
			if($checkedIds.length==$enabledIds.length){
				$selectAll.prop('checked',true);
			}else{
				$selectAll.prop('checked',false);
			}
			if($checkedIds.length==0){
				$deleteButton.addClass('disabled');
			}else{
				$deleteButton.removeClass('disabled');
			}
			if($this.prop('checked')){
				$contentRow.eq(index).addClass('selected');
			}else{
				$contentRow.eq(index).removeClass('selected');
			}
		});
    });
	
	$deleteButton.click(function(){
		var $this=$(this);
		if($this.hasClass('disabled')){
			return false;
		}
	var $checkedIds = $("#listTable input[name='ids']:enabled:checked");	
	  if($checkedIds.serialize()==null || trim($checkedIds.serialize()) == ''){
	        alert("没有数据，不能删除");
     			 return false;
	  }else{
	  $.ajax({
		url: contextPath+"/admin/specification/deleteById.do",
		type: "POST",
		data: $checkedIds.serialize(),
		dataType: "json",
		cache: false,
		success: function(data) {
			location.reload(true);
		}
	});
	    $selectAll.prop("checked", false);
		$checkedIds.prop("checked", false);
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
