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
	<meta name="author" content="SHOP++ Team" />
	<meta name="copyright" content="SHOP++" />
		<meta name="keywords" content="三星" />
		<meta name="description" content="三星" />
<link href="../css/shop/common.css" rel="stylesheet" type="text/css" />
<link href="../css/shop/goods.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="../js/jquery.min.js"></script>
<script type="text/javascript" src="../js/shop/jquery.lazyload.js"></script>
<script type="text/javascript" src="../js/shop/common.js"></script>
<script type="text/javascript">
var contextPath = "${pageContext.request.contextPath}";
$().ready(function() {

	var $headerCart = $("#headerCart");
	var $compareBar = $("#compareBar");
	var $compareForm = $("#compareBar form");
	var $compareSubmit = $("#compareBar a.submit");
	var $clearCompare = $("#compareBar a.clear");
	var $goodsForm = $("#goodsForm");
	var $orderType = $("#orderType");
	var $pageNumber = $("#pageNumber");
	var $pageSize = $("#pageSize");
	var $gridType = $("#gridType");
	var $listType = $("#listType");
	var $size = $("#layout a.size");
	var $previousPage = $("#previousPage");
	var $nextPage = $("#nextPage");
	var $sort = $("#sort a, #sort li");
	var $orderMenu = $("#orderMenu");
	var $startPrice = $("#startPrice");
	var $endPrice = $("#endPrice");
	var $result = $("#result");
	var $productImage = $("#result img");
	var $addCart = $("#result a.addCart");
	var $exchange = $("#result a.exchange");
	var $addFavorite = $("#result a.addFavorite");
	var $addCompare = $("#result a.addCompare");
	
	var layoutType = getCookie("layoutType");
	if (layoutType == "listType") {
		$listType.addClass("currentList");
		$result.removeClass("grid").addClass("list");
	} else {
		$gridType.addClass("currentGrid");
		$result.removeClass("list").addClass("grid");
	}
	
	$gridType.click(function() {
		var $this = $(this);
		if (!$this.hasClass("currentGrid")) {
			$this.addClass("currentGrid");
			$listType.removeClass("currentList");
			$result.removeClass("list").addClass("grid");
			addCookie("layoutType", "gridType");
		}
		return false;
	});
	
	$listType.click(function() {
		var $this = $(this);
		if (!$this.hasClass("currentList")) {
			$this.addClass("currentList");
			$gridType.removeClass("currentGrid");
			$result.removeClass("grid").addClass("list");
			addCookie("layoutType", "listType");
		}
		return false;
	});
	
	$size.click(function() {
		var $this = $(this);
		$pageNumber.val(1);
		$pageSize.val($this.attr("pageSize"));
		$goodsForm.submit();
		return false;
	});
	
	$previousPage.click(function() {
	var currPage='${mep.pageIndex+1}';
	if(1==currPage)
	{
	$pageNumber.val(1);
	}
	else
	{
	$pageNumber.val(currPage-1);
	}
		
		$goodsForm.submit();
		return false;
	});
	
	$nextPage.click(function() {
	    var currPage='${mep.pageIndex+2}';
		$pageNumber.val(currPage);
		$goodsForm.submit();
		return false;
	});
	
	
	$orderMenu.hover(
		function() {
			$(this).children("ul").show();
		}, function() {
			$(this).children("ul").hide();
		}
	);
	
	$sort.click(function() {
		var $this = $(this);
		if ($this.hasClass("current")) {
			$orderType.val("");
		} else {
			$orderType.val($this.attr("orderType"));
		}
		$pageNumber.val(1);
		$goodsForm.submit();
		return false;
	});
	
	$startPrice.add($endPrice).focus(function() {
		$(this).siblings("button").show();
	});
	
	$startPrice.add($endPrice).keypress(function(event) {
		return (event.which >= 48 && event.which <= 57) || (event.which == 46 && $(this).val().indexOf(".") < 0) || event.which == 8 || event.which == 13;
	});
	
	$goodsForm.submit(function() {
		if ($orderType.val() == "" || $orderType.val() == "topDesc") {
			$orderType.prop("disabled", true);
		}
		if ($pageNumber.val() == "" || $pageNumber.val() == "1") {
			$pageNumber.prop("disabled", true);
		}
		if ($pageSize.val() == "" || $pageSize.val() == "20") {
			$pageSize.prop("disabled", true);
		}
		if ($startPrice.val() == "" || !/^\d+(\.\d+)?$/.test($startPrice.val())) {
			$startPrice.prop("disabled", true);
		}
		if ($endPrice.val() == "" || !/^\d+(\.\d+)?$/.test($endPrice.val())) {
			$endPrice.prop("disabled", true);
		}
		if ($goodsForm.serializeArray().length < 1) {
			location.href = location.pathname;
			return false;
		}
	});
	
	$productImage.lazyload({
		threshold: 100,
		effect: "fadeIn"
	});
	
	// 加入购物车
	$addCart.click(function() {
		var $this = $(this);
		var productId = $this.attr("productId");
		$.ajax({
			url: contextPath+"/cart/insertCart.do",
			type: "POST",
			data: {productId: productId, quantity: 1},
			dataType: "json",
			cache: false,
			success: function(message) {
				if ( $headerCart.size() > 0 && window.XMLHttpRequest) {
					var $image = $this.closest("li").find("img");
					var cartOffset = $headerCart.offset();
					var imageOffset = $image.offset();
					$image.clone().css({
						width: 170,
						height: 170,
						position: "absolute",
						"z-index": 20,
						top: imageOffset.top,
						left: imageOffset.left,
						opacity: 0.8,
						border: "1px solid #dddddd",
						"background-color": "#eeeeee"
					}).appendTo("body").animate({
						width: 30,
						height: 30,
						top: cartOffset.top,
						left: cartOffset.left,
						opacity: 0.2
					}, 1000, function() {
						$(this).remove();
					});
				}
				$.message(message);
			}
		});
		return false;
	});
	var $headerCartQuantity = $("#headerCart em");	
function showQuantity() {
		if ($headerCartQuantity.size() == 0) {			
			return;
		 }	
		$.ajax({
			url: "../cart/quantity.do",
			type: "GET",
			dataType: "json",
			cache: false,
			global: false,
			success: function(data) {				
				if ($headerCartQuantity.text() != data && "opacity" in document.documentElement.style) {
					$headerCartQuantity.fadeOut(function() {
						$headerCartQuantity.text(data).fadeIn();							
					});
				} else {
					$headerCartQuantity.text(data);
					
				}
			}
		});
	}
	// 积分兑换
	$exchange.click(function() {
		var productId = $(this).attr("productId");
		$.ajax({
			url: "/order/check_exchange.jhtml",
			type: "GET",
			data: {productId: productId, quantity: 1},
			dataType: "json",
			cache: false,
			success: function(message) {
				if (message.type == "success") {
					location.href = "/order/checkout.jhtml?type=exchange&productId=" + productId + "&quantity=1";
				} else {
					$.message(message);
				}
			}
		});
		return false;
	});
	
	// 添加商品收藏
	$addFavorite.click(function() {
		var goodsId = $(this).attr("goodsId");
		$.ajax({
			url: "/member/favorite/add.jhtml",
			type: "POST",
			data: {goodsId: goodsId},
			dataType: "json",
			cache: false,
			success: function(message) {
				$.message(message);
			}
		});
		return false;
	});
	
	// 对比栏
	var compareGoods = getCookie("compareGoods");
	var compareGoodsIds = compareGoods != null ? compareGoods.split(",") : [];
	if (compareGoodsIds.length > 0) {
		$.ajax({
			url: "/goods/compare_bar.jhtml",
			type: "GET",
			data: {goodsIds: compareGoodsIds},
			dataType: "json",
			cache: true,
			success: function(data) {
				$.each(data, function (i, item) {
					var thumbnail = item.thumbnail != null ? item.thumbnail : "/upload/image/default_thumbnail.jpg";
					$compareBar.find("dt").after(
'<dd> <input type="hidden" name="goodsIds" value="' + item.id + '" \/> <a href="' + escapeHtml(item.url) + '" target="_blank"> <img src="' + escapeHtml(thumbnail) + '" \/> <span title="' + escapeHtml(item.name) + '">' + escapeHtml(abbreviate(item.name, 50)) + '<\/span> <\/a> <strong>' + currency(item.price, true) + '<del>' + currency(item.marketPrice, true) + '<\/del><\/strong> <a href="javascript:;" class="remove" goodsId="' + item.id + '">[删除]<\/a> <\/dd>'					);
				});
				$compareBar.fadeIn();
			}
		});
		
		$.each(compareGoodsIds, function(i, goodsId) { 
			$addCompare.filter("[goodsId='" + goodsId + "']").addClass("selected");
		});
	}
	
	// 移除对比
	$compareBar.on("click", "a.remove", function() {
		var $this = $(this);
		var goodsId = $this.attr("goodsId");
		$this.closest("dd").remove();
		for (var i = 0; i < compareGoodsIds.length; i ++) {
			if (compareGoodsIds[i] == goodsId) {
				compareGoodsIds.splice(i, 1);
				break;
			}
		}
		$addCompare.filter("[goodsId='" + goodsId + "']").removeClass("selected");
		if (compareGoodsIds.length == 0) {
			$compareBar.fadeOut();
			removeCookie("compareGoods");
		} else {
			addCookie("compareGoods", compareGoodsIds.join(","));
		}
		return false;
	});
	
	$compareSubmit.click(function() {
		if (compareGoodsIds.length < 2) {
			$.message("warn", "至少需要两个对比商品");
			return false;
		}
		
		$compareForm.submit();
		return false;
	});
	
	// 清除对比
	$clearCompare.click(function() {
		$addCompare.removeClass("selected");
		$compareBar.fadeOut().find("dd:not(.action)").remove();
		compareGoodsIds = [];
		removeCookie("compareGoods");
		return false;
	});
	
	// 添加对比
	$addCompare.click(function() {
		var $this = $(this);
		var goodsId = $this.attr("goodsId");
		if ($.inArray(goodsId, compareGoodsIds) >= 0) {
			return false;
		}
		if (compareGoodsIds.length >= 4) {
			$.message("warn", "最多只允许添加4个对比商品");
			return false;
		}
		$.ajax({
			url: "/goods/add_compare.jhtml",
			type: "GET",
			data: {goodsId: goodsId},
			dataType: "json",
			cache: false,
			success: function(data) {
				if (data.message.type == "success") {
					$this.addClass("selected");
					var thumbnail = data.thumbnail != null ? data.thumbnail : "/upload/image/default_thumbnail.jpg";
					$compareBar.show().find("dd.action").before(
'<dd> <input type="hidden" name="goodsIds" value="' + data.id + '" \/> <a href="' + escapeHtml(data.url) + '" target="_blank"> <img src="' + escapeHtml(thumbnail) + '" \/> <span title="' + escapeHtml(data.name) + '">' + escapeHtml(abbreviate(data.name, 50)) + '<\/span> <\/a> <strong>' + currency(data.price, true) + '<del>' + currency(data.marketPrice, true) + '<\/del><\/strong> <a href="javascript:;" class="remove" goodsId="' + data.id + '">[删除]<\/a> <\/dd>'					);
					compareGoodsIds.unshift(goodsId);
					addCookie("compareGoods", compareGoodsIds.join(","));
				} else {
					$.message(data.message);
				}
			}
		});
		return false;
	});
	
	$.pageSkip = function(pageNumber) {
		$pageNumber.val(pageNumber);
		$goodsForm.submit();
		return false;
	}

});
</script>
</head>
<body>
<script type="text/javascript">
<%
    Customer sysUserVO = null;
	String userName = "";
    Object obj = session.getAttribute(Constants.SESSION_LOGIN_USER_GOODS);
    if(obj != null){
    	sysUserVO = (Customer)obj;
    	userName = sysUserVO.getName();    	
    }
%>
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
					<a href="<%=path %>/home/tologin.do">登录</a>|
				</li>
				<li id="headerRegister" class="headerRegister">
					<a href="<%=path %>/register/showShopRegister.do">注册</a>
				</li>
				<li id="headerLogout" class="headerLogout">
					<a href="<%=path %>/login/loginout.do">[退出]</a>
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
							<a href="#">三星</a>		 -->					
				</div>
			</div>
			<div class="span3">
				<div class="phone">
					<em>服务电话</em>
					800-8888888
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
	<div class="container goodsList">
		<div id="compareBar" class="compareBar">
			<form action="/goods/compare.jhtml" method="get">
				<dl>
					<dt>对比栏</dt>
					<dd class="action">
						<a href="javascript:;" class="submit">对 比</a>
						<a href="javascript:;" class="clear">清 空</a>
					</dd>
				</dl>
			</form>
		</div>
		<div class="row">
			<div class="span2">
	<div class="hotProductCategory">
			 <c:forEach items="${topMap}" var="top" varStatus="st">
			 <c:choose>
			   <c:when test="${st.index % 2 == 0}">	
			   		<dl class="odd clearfix">
			   </c:when>
			   <c:otherwise>
			     	<dl class="even clearfix">
			   </c:otherwise>
			 </c:choose>
				<dt>
				   <c:forEach items="${top.key}" var="key">
					<a href="<%=path %>/home/showShopHomeSecurity.do?type=1&skipName=${key.key}"><!-- 手机数码 -->${key.value}</a>
					</c:forEach>
				</dt>
				<c:forEach items="${top.value}" var="mc">
						<dd>
							<a href="<%=path %>/home/showShopHomeSecurity.do?type=1&skipName=${mc.id}"><!-- 手机通讯 -->${mc.name}</a>
						</dd>
				</c:forEach>
			</dl>
			</c:forEach>
	</div>
		<div class="hotBrand clearfix">
			<dl>
				<dt>热门品牌</dt>
					<dd>
						<a href="/brand/content/1.jhtml" title="苹果">
							<img src="http://image.demo.shopxx.net/4.0/201501/a8275260-f9fa-4e20-8173-35b755fabb14.gif" alt="苹果" />
							<span>苹果</span>
						</a>
					</dd>
					<dd class="even">
						<a href="/brand/content/2.jhtml" title="三星">
							<img src="http://image.demo.shopxx.net/4.0/201501/8aa08a42-f5b3-4f52-bea0-5ee8bd123b0c.gif" alt="三星" />
							<span>三星</span>
						</a>
					</dd>
					<dd>
						<a href="/brand/content/3.jhtml" title="索尼">
							<img src="http://image.demo.shopxx.net/4.0/201501/dd75c116-51a7-4fbd-b014-6cf4bedcd0bb.gif" alt="索尼" />
							<span>索尼</span>
						</a>
					</dd>
					<dd class="even">
						<a href="/brand/content/4.jhtml" title="华为">
							<img src="http://image.demo.shopxx.net/4.0/201501/2a5efa56-c4cd-4984-b11a-d56cadca6cff.gif" alt="华为" />
							<span>华为</span>
						</a>
					</dd>
					<dd>
						<a href="/brand/content/5.jhtml" title="魅族">
							<img src="http://image.demo.shopxx.net/4.0/201501/72657c6c-d279-4952-ac20-1abcff776b07.gif" alt="魅族" />
							<span>魅族</span>
						</a>
					</dd>
					<dd class="even">
						<a href="/brand/content/6.jhtml" title="佳能">
							<img src="http://image.demo.shopxx.net/4.0/201501/081d4e29-b631-4a49-8672-792a1308ce97.gif" alt="佳能" />
							<span>佳能</span>
						</a>
					</dd>
			</dl>
		</div>
		<div class="hotGoods">
			<dl>
				<dt>热销商品</dt>
					<dd>
						<a href="http://b2c.demo.shopxx.net/goods/content/201507/1.html">
							<img src="http://image.demo.shopxx.net/4.0/201501/e39f89ce-e08a-4546-8aee-67d4427e86e2-thumbnail.jpg" alt="苹果 iPhone 5s" />
							<span title="苹果 iPhone 5s">苹果 iPhone 5s</span>
						</a>
						<strong>
							￥4200.00
								<del>￥5040.00</del>
						</strong>
					</dd>
					<dd>
						<a href="http://b2c.demo.shopxx.net/goods/content/201507/2.html">
							<img src="http://image.demo.shopxx.net/4.0/201501/d7f59d79-1958-4059-852c-0d6531788b48-thumbnail.jpg" alt="苹果 iPhone 6" />
							<span title="苹果 iPhone 6">苹果 iPhone 6</span>
						</a>
						<strong>
							￥5200.00
								<del>￥6240.00</del>
						</strong>
					</dd>
					<dd>
						<a href="http://b2c.demo.shopxx.net/goods/content/201507/3.html">
							<img src="http://image.demo.shopxx.net/4.0/201501/031e30a4-6237-4650-a14c-5132aa126acd-thumbnail.jpg" alt="三星 G3818" />
							<span title="三星 G3818">三星 G3818</span>
						</a>
						<strong>
							￥1200.00
								<del>￥1440.00</del>
						</strong>
					</dd>
			</dl>
		</div>
		<div class="hotPromotion">
			<dl>
				<dt>热销促销</dt>
					<dd>
						<a href="/promotion/content/1.jhtml" title="iPhone促销专场">
								<img src="http://image.demo.shopxx.net/4.0/201501/0a1ceb47-f51c-4dfb-9d51-cb723c2f8e78.jpg" alt="iPhone促销专场" />
						</a>
					</dd>
					<dd>
						<a href="/promotion/content/2.jhtml" title="联想笔记本促销专场">
								<img src="http://image.demo.shopxx.net/4.0/201501/98229d3b-08b7-4888-a99e-cf21a2a03b65.jpg" alt="联想笔记本促销专场" />
						</a>
					</dd>
					<dd>
						<a href="/promotion/content/3.jhtml" title="平板电视促销专场">
								<img src="http://image.demo.shopxx.net/4.0/201501/2b71bacf-bd18-46fb-adab-072dd544ed66.jpg" alt="平板电视促销专场" />
						</a>
					</dd>
			</dl>
		</div>
			</div>
			<div class="span10">
				<div class="breadcrumb">
					<ul>
						<li>
							<a href="<%=path %>/home/showShopIndex.do">首页</a>
						</li>
						<li>搜索 &quot;${keyword}&quot; 结果列表</li>
					</ul>
				</div>
				<form id="goodsForm" action="<%=path %>/home/showShopInquiry.do" method="get">
					<input type="hidden" id="keyword" name="keyword" value="${keyword}" />
					<input type="hidden" id="orderType" name="orderType" value="" />
					<input type="hidden" id="pageNumber" name="pageNumber" value="1" />
					<input type="hidden" id="pageSize" name="pageSize" value="20" />
					<div class="bar">
						<div id="layout" class="layout">
							<label>布局:</label>
							<a href="javascript:;" id="gridType" class="gridType">
								<span>&nbsp;</span>
							</a>
							<a href="javascript:;" id="listType" class="listType">
								<span>&nbsp;</span>
							</a>
							<label>数量:</label>
							<a href="javascript:;" class="size current" pageSize="20">
								<span>20</span>
							</a>
							<a href="javascript:;" class="size" pageSize="40">
								<span>40</span>
							</a>
							<a href="javascript:;" class="size" pageSize="80">
								<span>80</span>
							</a>
							<span class="page">
								<label>共${mep.total}个商品 <c:choose><c:when test="${mep.maxPage!=0}">${mep.pageIndex+1}/${mep.maxPage}</c:when><c:otherwise>${mep.pageIndex+1}/${mep.pageIndex+1}</c:otherwise> </c:choose> </label>
								<c:choose>
								  <c:when test="${mep.maxPage!=0}">
								  <c:choose>
								          <c:when test="${mep.pageIndex+1==1}">
								             <c:choose>
								                 <c:when test="${mep.pageIndex+1==mep.maxPage}">								           	  
											   </c:when>
											   <c:otherwise>
												   <span>上一页</span>
										           <a href="javascript:;" id="nextPage" class="nextPage">
													<span>下一页</span>
												   </a>
											   </c:otherwise>
											   </c:choose>
								         </c:when>
								         <c:when test="${mep.pageIndex+1==mep.maxPage}">
								         <a href="javascript:;" id="previousPage" class="previousPage">
													<span>上一页</span>
										 </a>
												<span>下一页</span>
								         </c:when>
								         <c:otherwise>
								          <a href="javascript:;" id="previousPage" class="previousPage">
													<span>上一页</span>
										   </a>
										   <a href="javascript:;" id="nextPage" class="nextPage">
												<span>下一页</span>
										</a>
								        </c:otherwise>
								   </c:choose>
								  </c:when>
								</c:choose>
								   
							</span>
						</div>
						<div id="sort" class="sort">
							<div id="orderMenu" class="orderMenu">
									<span>置顶降序</span>
								<ul>
										<li orderType="topDesc">置顶降序</li>
										<li orderType="priceAsc">价格升序</li>
										<li orderType="priceDesc">价格降序</li>
										<li orderType="salesDesc">销量降序</li>
										<li orderType="scoreDesc">评分降序</li>
										<li orderType="dateDesc">日期降序</li>
								</ul>
							</div>
							<a href="javascript:;" class="asc" orderType="priceAsc">价格</a>
							<a href="javascript:;" class="desc" orderType="salesDesc">销量</a>
							<a href="javascript:;" class="desc" orderType="scoreDesc">评分</a>
							<input type="text" id="startPrice" name="startPrice" class="startPrice" value="" maxlength="16" title="价格过滤最低价格" onpaste="return false" />
							<label>-</label>
							<input type="text" id="endPrice" name="endPrice" class="endPrice" value="" maxlength="16" title="价格过滤最高价格" onpaste="return false" />
							<button type="submit">确 定</button>
						</div>
					</div>
					<div id="result" class="result grid clearfix">
					  <c:choose> 
						    <c:when test="${tal==0}">
						        <dl><dt>对不起，没有找到与 "${keyword}" 相关的商品</dt><dd>1、请确认搜索关键词是否正确</dd><dd>2、可尝试对搜索关键词根据其词义来进行拆分（多个词语之间用一个空格隔开），以获得更精确的搜索结果</dd></dl>
						    </c:when>
						    <c:otherwise>
						    <ul>
								<c:forEach items="${mep.rows}" var="mm" varStatus="st">
									<li>
										<a href="<%=path %>/home/showShopProductDetails.do?type=2&skipName=${mm.id}">
											<img src="/upload/image/blank.gif" data-original="${mm.productImageListStore}" />
											<div>
													<span title="${mm.name}">${mm.name}</span>
													<em title="${mm.title}">${mm.title}</em>
											</div>
										</a>
										<strong>
												 ￥${mm.price}
													<!-- <del>￥2280.00</del>[特价] -->
										</strong>
										<div class="action">
												<a href="javascript:;" class="addCart" productId="${mm.id}">加入购物车</a>
											<!-- <a href="javascript:;" class="addFavorite" title="收藏" goodsId="5">&nbsp;</a>
											<a href="javascript:;" class="addCompare" title="对比" goodsId="5">&nbsp;</a> -->
										</div>
									</li>
									</c:forEach>
							</ul>
						    </c:otherwise>
					  </c:choose>
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
													<!-- <a href="javascript: $.pageSkip(2);">2</a> -->
												<a href="javascript: $.pageSkip(${mep.pageIndex+2});" class="nextPage">&nbsp;</a>
												<a href="javascript: $.pageSkip(${mep.maxPage});" class="lastPage">&nbsp;</a>
										 </c:otherwise>
										 </c:choose>
									</c:when>
									<c:when test="${mep.pageIndex+1==mep.maxPage}">
									     	<a href="javascript: $.pageSkip(1);" class="firstPage">&nbsp;</a>
											<a href="javascript: $.pageSkip(${mep.pageIndex});" class="previousPage">&nbsp;</a>
											<!-- <a href="javascript: $.pageSkip(1);">1</a> -->
											<span class="currentPage">${mep.pageIndex+1}</span>
											<span class="nextPage">&nbsp;</span>
											<span class="lastPage">&nbsp;</span>
									
									</c:when>							
									<c:otherwise>
										<a href="javascript: $.pageSkip(1);" class="firstPage">&nbsp;</a>
										<a href="javascript: $.pageSkip(${mep.pageIndex});" class="previousPage">&nbsp;</a>
											<!-- <a href="javascript: $.pageSkip(1);">1</a> -->
											<span class="currentPage">${mep.pageIndex+1}</span>
										<a href="javascript: $.pageSkip(${mep.pageIndex+2});" class="nextPage">&nbsp;</a>
										<a href="javascript: $.pageSkip(${mep.maxPage});" class="lastPage">&nbsp;</a>
									</c:otherwise>
								</c:choose>
							     </c:when>
							   </c:choose>
								
						</div>
				</form>
			</div>
		</div>
	</div>
<jsp:include page="/page/shop/home/foot.jsp" />
</body>
</html>
