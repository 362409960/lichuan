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
<link href="<%=path %>/css/default/cart.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<%=path %>/js/jquery.min.js"></script>
<script type="text/javascript" src="<%=path %>/js/event.js"></script>
<script type="text/javascript" src="<%=path %>/js/cart.js"></script>
<script>var contextPath = "${pageContext.request.contextPath}";</script>
<script type="text/javascript">

</script>
</head>

<body style="background: #F5F5F5">

<jsp:include page="/page/shop/home/top.jsp" />  


<!--已成功加入购物车 page-main区域-->
<div class="page-main">
	<div class="container">
    	<div class="buy-succ-box clearfix">
        	<div class="goods-content">
            	<div class="goods-img">
                	<img src="${cart.goods_url}" alt="" style="width: 110px;height: 110px;"/>
                </div>
                <div class="goods-info">
                	<span class="name">${cart.picture}</span>
                    <span class="price">${cart.price}元</span>
                    <h3>已成功加入购物车！</h3>
                </div>
            </div>
            <div class="actions">
            	<a href="<%=path %>/home/showShopIndex.do;" class="buy-btn">继续购物</a>
                <a href="<%=path %>/cart/showShopCart.do" class="end-btn">去购物车结算</a>
            </div>
        </div>
    </div>
</div>


<div id="miRecommendBox" class="cart-recommend container" style="padding-top:60px;">
    <h2 class="recommend-title">
        <span>买购物车中商品的人还买了</span>
    </h2>
    <div class="recommend">
        <ul class="row">
        	<c:forEach items="${reList}" var="rl">
            <li class="recommend-list span4">
                <dl>
                    <dt>
                        <a href="<%=path %>/home/showShopProductDetails.do?type=2&skipName=${rl.id}" target="_blank">
                           <img src="${rl.productImageListStore}" style="width: 200px;height: 200px;" alt="${rl.title}"/>
                        </a>
                    </dt>
                    <dd class="recommend-name">
                        <a href="<%=path %>/home/showShopProductDetails.do?type=2&skipName=${rl.id}" target="_blank">${rl.title}</a>
                    </dd>
                    <dd class="recommend-price">${rl.price}元</dd>
                    <dd class="recommend-tips">
                         4.6万人好评
                         <a href="<%=path %>/cart/insertCart.do?productId=${rl.id}" target="_blank" class="btn">加入购物车</a>
                    </dd>
                </dl>
            </li>
            </c:forEach>
        </ul>
    </div>
</div>

<div id="miRecommendBox" class="cart-recommend container" style="padding-top:60px;">
    <h2 class="recommend-title">
        <span>最近浏览的商品和相关推荐</span>
    </h2>
    <div class="recommend">
        <ul class="row">
        <c:forEach items="${reList}" var="rl">
            <li class="recommend-list span4">
              <dl>
                    <dt>
                        <a href="<%=path %>/home/showShopProductDetails.do?type=2&skipName=${rl.id}" target="_blank">
                           <img src="${rl.productImageListStore}" style="width: 200px;height: 200px;" alt="${rl.title}"/>
                        </a>
                    </dt>
                    <dd class="recommend-name">
                        <a href="<%=path %>/home/showShopProductDetails.do?type=2&skipName=${rl.id}" target="_blank">${rl.title}</a>
                    </dd>
                    <dd class="recommend-price">${rl.price}元</dd>
                    <dd class="recommend-tips">
                         4.6万人好评
                         <a href="<%=path %>/cart/insertCart.do?productId=${rl.id}" target="_blank" class="btn">加入购物车</a>
                    </dd>
                </dl>
            </li>
            </c:forEach>
        </ul>
    </div>
</div>
<jsp:include page="/page/shop/home/foot_new.jsp" />


</body>
</html>

