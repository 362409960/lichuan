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
<script type="text/javascript" src="<%=path %>/js/jquery.min.js"></script>
<script type="text/javascript" src="<%=path %>/js/event.js"></script>
<script>var contextPath = "${pageContext.request.contextPath}";</script>
<script type="text/javascript">
$().ready(function() {

});
</script>
</head>

<body>

<jsp:include page="/page/shop/home/top.jsp" />  
<!--breadcrumbs区域-->
<div class="breadcrumbs">
	<div class="container">
    	<a href="index.html">首页</a>
        <span class="sep">&gt;</span>
        <a href="javascript:void(0);">全部结果</a>
        <span class="sep">&gt;</span>
        <span>${keyword}</span>
    </div>
</div>

<!--条件筛选区域-->
<div class="container">
	<div class="filter-box">
    	<div class="box-hd">
        	<h3 class="title">抱歉，没有搜索到与 “<span class="keyword">${keyword}</span>” 相关的商品</h3>
            <p class="tip">请检查您的输入是否有误<br/>如有任何意见或建议，期待您<a href="javascript:void(0);" target="_blank">反馈给我们</a></p>
            <p class="tip">您还可以尝试以下搜索：
            <c:forEach items="${menu}" var="menu" varStatus="st">
              <c:choose>
                <c:when test="${st.last}"><a href="<%=path %>/home/showShopHomeSecurity.do?type=1&skipName=${menu.key}">${menu.value}</a></c:when>
                <c:otherwise>
                <a href="<%=path %>/home/showShopHomeSecurity.do?type=1&skipName=${menu.key}">${menu.value}</a>
        		<span class="sep">|</span>
                
                </c:otherwise>
              </c:choose>
               
            </c:forEach>
            </p>
        </div>
    </div>
</div>

<!--搭配中间区域-->
<div class="content">
	<div class="container">
    <div class="recommend-container container">
    	<h2 class="recommend-title"><span>为你推荐</span></h2>
        <div class="recommend">
        	<div class="recommend-wrap" style="height:330px; overflow:hidden;">
            	<ul class="clearfix recommend-wrap-list">
            		<c:forEach items="${reList}" var="rl">
                	<li>
                    	<dl>
                        	<dt>
                            	<a href="<%=path %>/home/showShopProductDetails.do?type=2&skipName=${rl.id}" target="_blank">
                                	<img src="${rl.productImageListStore}" alt="${rl.title}" style="width: 200px;height: 200px;"/>
                                </a>
                            </dt>
                            <dd class="recommend-name">
                            	<a href="<%=path %>/home/showShopProductDetails.do?type=2&skipName=${rl.id}" target="_blank">${rl.title}</a>
                            </dd>
                            <dd class="recommend-price">${rl.price}元</dd>
                            <dd class="recommend-tips"> 4.5万人好评</dd>
                        </dl>
                    </li>
                    </c:forEach>
                </ul>
            </div>
            <div class="recommend-pager">
            	<ul class="pagers">
                	<li class="pager pager-active">
                    	<span class="dot">1</span>
                    </li>
                    <!-- <li class="pager">
                    	<span class="dot">2</span>
                    </li>
                    <li class="pager">
                    	<span class="dot">3</span>
                    </li>
                    <li class="pager">
                    	<span class="dot">4</span>
                    </li> -->
                </ul>
            </div>
        </div>
    </div>
</div>
</div>
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
	var oPapres=$('.pager');
	
	oPapres.on('click',function(){
		var mWdith=-$(this).index()*sWidth*5;
		$(this).addClass('pager-active').siblings('li').removeClass('pager-active');
		oUl.css('margin-left',mWdith);
	});
});
</script>
</body>
</html>

