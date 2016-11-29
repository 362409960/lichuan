<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/tlds/c.tld" prefix="c"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<title>Cloudring商城 - Powered By Cloudring</title>
	<meta name="author" content="Cloudring Team" />
	<meta name="copyright" content="Cloudring" />
	<meta name="keywords" content="Cloudring商城" />
	<meta name="description" content="Cloudring商城" />

<link href="<%=path %>/css/default/style.css" rel="stylesheet" type="text/css" />
<link href="<%=path %>/css/shop/common.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<%=path %>/js/jquery.min.js"></script>
<script type="text/javascript" src="<%=path %>/js/event.js"></script>
<script>var contextPath = "${pageContext.request.contextPath}";</script>
<script type="text/javascript">
$().ready(function() {
var $pageNumber = $("#pageNumber");
var $goodsForm = $("#goodsForm");
$.pageSkip = function(pageNumber) {
	$pageNumber.val(pageNumber);
	$goodsForm.submit();
	return false;
};
});
</script>
</head>

<body>

<jsp:include page="/page/shop/home/top.jsp" />  

<!--breadcrumbs区域-->
<div class="breadcrumbs">
	<div class="container">
    	<a href="<%=path %>/home/showShopIndex.do">首页</a>
        <span class="sep">&gt;</span>
         <c:forEach items="${mapSort1}" var="pc"  >
		   <c:forEach items="${pc.value}" var="k" varStatus="st">
		    <c:choose>
			<c:when  test="${st.last}">
          <span>${k.name}</span>
          </c:when>
          <c:otherwise>
		   <span><a href="<%=path %>/home/showShopHomeSecurity.do?type=1&skipName=${k.id}">${k.name}</a></span>
		   <span class="sep">&gt;</span>
	      </c:otherwise>
			</c:choose>
			</c:forEach>
			</c:forEach>
    </div>
</div>

<!--条件筛选区域-->
<div class="container">
	<div class="filter-box">
    	<div class="filter-list-wrap first">
        	<dl class="filter-list clearfix filter-list-row-2">
            	<dt>分类：</dt>
                <dd class="active">全部</dd>
                <c:forEach items="${mapSort2}" var="sort">
					<c:forEach items="${sort.value}" var="s">
                <dd>
                	<a href="<%=path %>/home/showShopHomeSecurity.do?type=1&skipName=${s.id}">${s.name}</a>
                </dd>
                </c:forEach>
                </c:forEach> 
               </dl>               
            <a href="javascript:void(0);" class="more">更多</a>
        </div>
        <div class="filter-list-wrap" style="display: none;">
        	<dl class="filter-list clearfix filter-list-row-3">
            	<dt>机型：</dt>
                <dd class="active">全部</dd>
                <dd>
                	<a href="javascript:void(0);">小米Note</a>
                </dd>
                <dd>
                	<a href="javascript:void(0);">小米手机4c</a>
                </dd>
                <dd>
                	<a href="javascript:void(0);">红米Note 2</a>
                </dd>
                <dd>
                	<a href="javascript:void(0);">小米手机4</a>
                </dd>
                <dd>
                	<a href="javascript:void(0);">红米Note/增强版</a>
                </dd>
                <dd>
                	<a href="javascript:void(0);">红米2A</a>
                </dd>
                <dd>
                	<a href="javascript:void(0);">小米手机3</a>
                </dd>
                <dd>
                	<a href="javascript:void(0);">红米手机2</a>
                </dd>
                <dd>
                	<a href="javascript:void(0);">小米电视2</a>
                </dd>
                <dd>
                	<a href="javascript:void(0);">小米盒子</a>
                </dd>
                <dd>
                	<a href="javascript:void(0);">红米手机</a>
                </dd>
                <dd>
                	<a href="javascript:void(0);">小米手机2A</a>
                </dd>
                <dd>
                	<a href="javascript:void(0);">小米手机2/2S</a>
                </dd>   
            </dl>
            <a href="javascript:void(0);" class="more">更多</a>
        </div>
        <div class="filter-list-wrap" style="display: none;">
        	<dl class="filter-list clearfix filter-list-row-4">
            	<dt>品牌：</dt>
                <dd class="active">全部</dd>
                <dd>
                	<a href="javascript:void(0);">小米</a>
                </dd>
                <dd>
                	<a href="javascript:void(0);">EMIE</a>
                </dd>
                <dd>
                	<a href="javascript:void(0);">IVS</a>
                </dd>
                <dd>
                	<a href="javascript:void(0);">fotopro</a>
                </dd>
                <dd>
                	<a href="javascript:void(0);">铁三角</a>
                </dd>
                <dd>
                	<a href="javascript:void(0);">小米</a>
                </dd>
                <dd>
                	<a href="javascript:void(0);">EMIE</a>
                </dd>
                <dd>
                	<a href="javascript:void(0);">IVS</a>
                </dd>
                <dd>
                	<a href="javascript:void(0);">fotopro</a>
                </dd>
                <dd>
                	<a href="javascript:void(0);">铁三角</a>
                </dd>
                <dd>
                	<a href="javascript:void(0);">小米</a>
                </dd>
                <dd>
                	<a href="javascript:void(0);">EMIE</a>
                </dd>
                <dd>
                	<a href="javascript:void(0);">IVS</a>
                </dd>
                <dd>
                	<a href="javascript:void(0);">fotopro</a>
                </dd>
                <dd>
                	<a href="javascript:void(0);">铁三角</a>
                </dd>
                <dd>
                	<a href="javascript:void(0);">小米</a>
                </dd>
                <dd>
                	<a href="javascript:void(0);">EMIE</a>
                </dd>
                <dd>
                	<a href="javascript:void(0);">IVS</a>
                </dd>
                <dd>
                	<a href="javascript:void(0);">fotopro</a>
                </dd>
                <dd>
                	<a href="javascript:void(0);">铁三角</a>
                </dd>  
            </dl>
            <a href="javascript:void(0);" class="more">更多</a>
        </div>
    </div>
</div>


 <form id="goodsForm" action="<%=path %>/home/showShopHomeSecurity.do" method="get">
					<input type="hidden" id="skipName" name="skipName" value="${skipName}" />
					<input type="hidden" id="promotionId" name="promotionId" value="" />
					<input type="hidden" id="orderType" name="orderType" value="" /> 
					<input type="hidden" id="pageNumber" name="pageNumber" value="" />
					<input type="hidden" id="pageSize" name="pageSize" value="20" />
<!--搭配中间区域-->
<div class="content">
	<div class="container">
    	<div class="order-list-box clearfix">
        	<ul class="order-list">
            	<li class="active first">
                	<a rel="nofollow" href="javascript:void(0);">推荐</a>
                </li>
                <li>
                	<a rel="nofollow" href="javascript:void(0);">新品</a>
                </li>
                <li class="up">
                	<a rel="nofollow" href="javascript:void(0);">价格<i></i></a>
                </li>
                <li>
                	<a rel="nofollow" href="javascript:void(0);">评论最多</a>
                </li>
            </ul>
            <ul class="type-list" >
            	<li>
                	<a href="javascript:void(0);">
                    	<span class="checkbox">
                        	<i>√</i>
                        </span>查看评论
                    </a>
                </li>
                <li>
                	<a href="javascript:void(0);">
                    	<span class="checkbox">
                        	<i>√</i>
                        </span>仅显示特惠商品
                    </a>
                </li>
                <li>
                	<a href="javascript:void(0);">
                    	<span class="checkbox">
                        	<i>√</i>
                        </span>仅显示有货商品
                    </a>
                </li>
            </ul>
        </div>
    	<div class="goods-list-box">
        	<div class="goods-list clearfix">
        	<c:forEach items="${mep.rows}" var="mm" varStatus="st">
            	<div class="goods-item">
                	<div class="figure figure-img">
                    	<a href="<%=path %>/home/showShopProductDetails.do?type=2&skipName=${mm.id}">
                        	<img src="${mm.productImageListStore}" alt="" width="200" height="200"/>
                        </a>
                    </div>
                    <p class="desc"></p>
                    <h2 class="title">
                    	<a href="<%=path %>/home/showShopProductDetails.do?type=2&skipName=${mm.id}">${mm.name}</a>
                    </h2>
                    <p class="price">
                    	${mm.price}元
                        <del></del>
                    </p>
                    <div class="thumbs">
                    	<ul class="thumb-list clearfix">
                        	<li><img src="${mm.productImageListStore}" alt="${mm.title}" width="34" height="34"/></li>
                           
                        </ul>
                    </div>
                    <div class="actions clearfix" id="addCart">
                    	<a href="javascript:void(0);" class="btn-like">
                        	<i></i><span></span>
                        </a>
                        <a href="<%=path %>/cart/insertCart.do?productId=${mm.id}" class="btn-buy">
                        	<span>加入购物车</span><i></i>
                        </a>
                    </div>
                    <div class="flags">
                    	<!-- <div class="flag flag-postfree"></div> -->
                    </div>
                </div>
                </c:forEach>
            </div>
            <div class="pagination">
					 <c:choose>
						     <c:when test="${mep.maxPage!=0}">
						     <c:choose>
								<c:when test="${mep.pageIndex+1==1}">
								   <c:choose>
								    <c:when test="${mep.pageIndex+1==mep.maxPage}">	                            
									 </c:when>
									 <c:otherwise>
											<span class="firstPage">&nbsp;</span>
											<span class="previousPage">&nbsp;</span>
												<span class="currentPage">${mep.pageIndex+1}</span>
											
											<a href="javascript: $.pageSkip(${mep.pageIndex+2});" class="nextPage">&nbsp;</a>
											<a href="javascript: $.pageSkip(${mep.maxPage});" class="lastPage">&nbsp;</a>
									 </c:otherwise>
									 </c:choose>
								</c:when>
								<c:when test="${mep.pageIndex+1==mep.maxPage}">
								     	<a href="javascript: $.pageSkip(1);" class="firstPage">&nbsp;</a>
										<a href="javascript: $.pageSkip(${mep.pageIndex});" class="previousPage">&nbsp;</a>
										<span class="currentPage">${mep.pageIndex+1}</span>
										<span class="nextPage">&nbsp;</span>
										<span class="lastPage">&nbsp;</span>
								
								</c:when>							
								<c:otherwise>
									<a href="javascript: $.pageSkip(1);" class="firstPage">&nbsp;</a>
									<a href="javascript: $.pageSkip(${mep.pageIndex});" class="previousPage">&nbsp;</a>
										<span class="currentPage">${mep.pageIndex+1}</span>
									<a href="javascript: $.pageSkip(${mep.pageIndex+2});" class="nextPage">&nbsp;</a>
									<a href="javascript: $.pageSkip(${mep.maxPage});" class="lastPage">&nbsp;</a>
								</c:otherwise>
							</c:choose>
						     </c:when>
						   </c:choose>
					</div>
        </div>
    </div>
    
</div>
 </form>
<jsp:include page="/page/shop/home/foot_new.jsp" />

<script>
$(function(){
	$('.filter-list-wrap .more').on('click',function(){
		$(this).parents('.filter-list-wrap').toggleClass('filter-list-wrap-toggled');
	});
	$('.type-list a').on('click',function(){
		$(this).children('span').toggleClass('checkbox-checked');
	});
	
	var oUl=$('.recommend-wrap-list');
	var oLi=$('.recommend-wrap-list li');
	var oLength=oLi.length;
	var sWidth=oLi.eq(0).outerWidth(true);
	var tTidth=oLength*sWidth;
	oUl.width(tTidth);
	
});
</script>
</body>
</html>

