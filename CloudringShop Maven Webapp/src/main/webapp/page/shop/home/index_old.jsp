<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="/WEB-INF/tlds/c.tld" prefix="c"%>
<%@page import="cloud.shop.common.Constants" %>
<%@page import="cloud.shop.goods.entity.Customer" %>
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
<link href="/favicon.ico" rel="icon" type="image/x-icon" />
<link href="../css/shop/slider.css" rel="stylesheet" type="text/css" />
<link href="../css/shop/common.css" rel="stylesheet" type="text/css" />
<link href="../css/shop/index.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="../js/jquery.min.js"></script>
<script type="text/javascript" src="../js/shop/jquery.tools.js"></script>
<script type="text/javascript" src="../js/shop/jquery.lazyload.js"></script>
<script type="text/javascript" src="../js/shop/slider.js"></script>
<script type="text/javascript" src="../js/shop/common.js"></script>
<style type="text/css">
.header {
	margin-bottom: 0px;
}
</style>
<script type="text/javascript">
if(top != self) {  
            if(top.location != self.location) {  
                top.location = self.location;  
            }  
        } 
$().ready(function() {

	var $productCategoryMenuItem = $("#productCategoryMenu li");
	var $slider = $("#slider");
	var $newArticleTab = $("#newArticle ul.tab");
	var $hotGoodsImage = $("div.hotGoods img");
	
	$productCategoryMenuItem.hover(
		function() {
			$(this).children("div.menu").show();
		}, function() {
			$(this).children("div.menu").hide();
		}
	);
	
	$slider.nivoSlider({
		effect: "random",
		animSpeed: 1000,
		pauseTime: 6000,
		controlNav: true,
		keyboardNav: false,
		captionOpacity: 0.4
	});
	
	$newArticleTab.tabs("ul.tabContent", {
		tabs: "li",
		event: "mouseover"
	});
	
	$hotGoodsImage.lazyload({
		threshold: 100,
		effect: "fadeIn",
		skip_invisible: false
	});

});
</script>
</head>
<body>
<%
    Customer sysUserVO = null;
	String userName = "";
    Object obj = session.getAttribute(Constants.SESSION_LOGIN_USER_GOODS);
    if(obj != null){
    	sysUserVO = (Customer)obj;
    	userName = sysUserVO.getName();    	
    }
%>
<script type="text/javascript">
$().ready(function() {

	var $headerName = $("#headerName");
	var $headerLogin = $("#headerLogin");
	var $headerRegister = $("#headerRegister");
	var $headerLogout = $("#headerLogout");
	var $goodsSearchForm = $("#goodsSearchForm");
	var $keyword = $("#goodsSearchForm input");
	var defaultKeyword = "商品搜索";
	
	var username = '<%=userName%>';	
	var nickname = getCookie("nickname");
	if ($.trim(nickname) != "") {
		$headerName.text(nickname).show();
		$headerLogout.show();
	} else if ($.trim(username) != "") {
		$headerName.text(username).show();
		$headerLogout.show();
	} else {
		$headerLogin.show();
		$headerRegister.show();
	}
	
	$keyword.focus(function() {
		if ($.trim($keyword.val()) == defaultKeyword) {
			$keyword.val("");
		}
	});
	
	$keyword.blur(function() {
		if ($.trim($keyword.val()) == "") {
			$keyword.val(defaultKeyword);
		}
	});
	
	$goodsSearchForm.submit(function() {
		if ($.trim($keyword.val()) == "" || $keyword.val() == defaultKeyword) {
			return false;
		}
	});

});
</script>

<div class="header">
	<div class="top">
		<div class="topNav">
			<ul class="left">
				<li>
					<span>您好，欢迎来到Cloudring商城</span>
					<span id="headerName" class="headerName">&nbsp;</span>
				</li>
				<li id="headerLogin" class="headerLogin">
					<a href="<%=path %>/login/login.do">登录</a>|
				</li>
				<li id="headerRegister" class="headerRegister">
					<a href="<%=path %>/register/showShopRegister.do">注册</a>
				</li>
				<li id="headerLogout" class="headerLogout">
					<a href="http://localhost:8080/cas/logout?service=http://localhost:8080/CloudringShop/login/login.do">[退出]</a>
				</li>
			</ul>
			<ul class="right">
						<li>
						    <% if("".equals(userName))
						    {%>
						    <a href="<%=path %>/home/tologin.do">会员中心</a>|
						   <% }else{%>
						     <a href="<%=path %>/member/showCentre.do">会员中心</a>|
						  <% }%>
						</li>
						<li>
							<a href="">帮助中心</a>|
						</li>
				<li id="headerCart" class="headerCart">
					<a href="<%=path %>/cart/showShopCart.do">购物车</a>
					(<em></em>)
				</li>
			</ul>
		</div>
	</div>
	<div class="container">
		<div class="row">
			<div class="span3">
				<a href="http://www.cloudring.net">
					<img src="<%=path %>/images/logo_shop.png" alt="Cloudring" />
				</a>
			</div>
			<div class="span6">
				<div class="search" >
					<form id="goodsSearchForm" action="<%=path %>/home/showShopInquiry.do" method="get">
						<input name="keyword" class="keyword" value="商品搜索" autocomplete="off" x-webkit-speech="x-webkit-speech" x-webkit-grammar="builtin:search" maxlength="30" />
						<button type="submit">&nbsp;</button>
					</form>
				</div>
				<div class="hotSearch">
						<!-- 热门搜索:
							<a href="#">苹果</a>
							<a href="#">三星</a>	 -->						
				</div>
			</div>
			<div class="span3">
				<div class="phone">
					<em>服务电话</em>
					4000-300-656
				</div>
			</div>
		</div>
		<div class="row">
			<div class="span12">
				<dl class="mainNav">
					<dt>
						<a href="<%=path%>/home/showShopProductcategory.do">所有商品分类</a>
					</dt>
							<dd>
								<a href="<%=path %>/home/showShopIndex.do">首页</a>
							</dd>
							<c:forEach items="${menu}" var="menu">
							<dd>
								<a href="<%=path %>/home/showShopHomeSecurity.do?type=1&skipName=${menu.key}">${menu.value}</a>
							</dd>
							</c:forEach>
				</dl>
			</div>
		</div>
	</div>
</div>
	<div class="container index">
		<div class="row">
			<div class="span2">
					<div id="productCategoryMenu" class="productCategoryMenu">
						<ul>
						 <c:forEach items="${topMap}" varStatus="st" var="p">
								<li>
								     <div class="item">
											<div>	
											 <c:forEach  items="${p.key}" var="three">									     
													<a href="<%=path %>/home/showShopHomeSecurity.do?type=1&skipName=${three.key}">
														<strong>${three.value}</strong>
													</a>
											</c:forEach>	
											</div>							
										</div>										
										<div class="menu">										
										    <c:forEach items="${p.value}" var="pcValue" >
												 <dl class="clearfix">
													<dt>
														<a href="<%=path %>/home/showShopHomeSecurity.do?type=1&skipName=${pcValue.key.id}">${pcValue.key.name}</a>
													</dt>
													      <c:forEach items="${pcValue.value}" var="pc" varStatus="sst" >
													      <c:choose>
													      <c:when  test="${sst.last}">
													      <dd>
																<a href="<%=path %>/home/showShopHomeSecurity.do?type=1&skipName=${pc.id}">${pc.name}</a>
															</dd>
													      </c:when>
													      <c:otherwise>
														      <dd>
																	<a href="<%=path %>/home/showShopHomeSecurity.do?type=1&skipName=${pc.id}">${pc.name}</a>|
																</dd>
													      </c:otherwise>
															</c:choose>
															</c:forEach>
												</dl>	
												   </c:forEach>	
																
										</div>										
								</li>
								</c:forEach>
						</ul>
					</div>
			</div>
			<div class="span10">
				<div id="slider" class="slider">
	               <c:forEach items="${comList}" varStatus="st" var="com">
						<a href="#">
							<img src="${com.file_path}" alt="${com.t_name}" title="${com.t_name}" /> 								
						</a>
					</c:forEach>
				</div>			
			</div>
	    </div>
	   
	      <c:forEach items="${middleMap}" var="midd" varStatus="map">
				<div class="row">
					<div class="span12">
						<div class="hotGoods">
								<dl class="title1">
									<dt>
										<a href="<%=path %>/home/showShopHomeSecurity.do?type=1&skipName=${midd.key.id}"><!-- 家庭安全 -->${midd.key.name}</a>
									</dt>
									
									<c:forEach items="${midd.value}" var="list">
									    <c:forEach items="${list.key}" var="ki">
										<dd>
											<a href="<%=path %>/home/showShopHomeSecurity.do?type=1&skipName=${ki.id}"><!-- 手机通讯 -->${ki.name}</a>
										</dd>
										</c:forEach>
									</c:forEach>
								</dl>
									<div>
										<a href="#">
											<img src="http://www.cloudring.net/upload_cloudringshop/advertisement/20151014/s1.jpg" alt="iPhone6" title="iPhone6" />
										</a>
									</div>
								<ul>
								<c:forEach items="${midd.value}" var="list">
									    <c:forEach items="${list.value}" var="kv">
									<li>
										<a href="<%=path %>/home/showShopProductDetails.do?type=2&skipName=${kv.id}" title="${kv.title}" target="_blank">
											<div>
													<span title="${kv.name}">${kv.name}</span>
													<em title="${kv.title}">${kv.title}</em>
											</div>
											<strong>￥${kv.price}</strong>
											<img src="/upload/image/blank.gif" data-original="${kv.productImageListStore}" />
										</a>
									</li>
									</c:forEach>
									</c:forEach>
							</ul>
						</div>
					</div>
				</div>
				</c:forEach>
	</div>
<jsp:include page="/page/shop/home/foot.jsp" />
</body>
</html>
			  