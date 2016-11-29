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
	<title>Cloudring</title>
<link href="../css/shop/common.css" rel="stylesheet" type="text/css" />
<link href="../css/shop/goods.css" rel="stylesheet" type="text/css" />
<link href="../css/shop/magiczoomplus.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="../js/jquery.min.js"></script>
<script type="text/javascript" src="../js/jquery-migrate-1.2.1.js"></script>
<script type="text/javascript" src="../js/shop/jquery.tools.js"></script>
<script type="text/javascript" src="../js/shop/jquery.validate.js"></script>
<script type="text/javascript" src="../js/shop/common.js"></script>
<script type="text/javascript" src="../js/shop/mzp-packed.js"></script>

<script type="text/javascript">
var contextPath = "${pageContext.request.contextPath}";
$().ready(function() {

	var $headerCart = $("#headerCart");
	var $historyGoods = $("#historyGoods");
	var $clearHistoryGoods = $("#historyGoods a.clear");
	var $zoom = $("#zoom1");
	var $thumbnailScrollable = $("#thumbnailScrollable");
	var $thumbnail = $("#thumbnailScrollable a");
	var $dialogOverlay = $("#dialogOverlay");
	var $preview = $("#preview");
	var $previewClose = $("#preview a.close");
	
	var $price = $("#price");
	var $marketPrice = $("#marketPrice");
	var $rewardPoint = $("#rewardPoint");
	var $exchangePoint = $("#exchangePoint");
	var $specification = $("#specification dl");
	var $specificationTips = $("#specification div");
	var $specificationValue = $("#specification a");
	var $productNotifyForm = $("#productNotifyForm");
	var $productNotify = $("#productNotify");
	var $productNotifyEmail = $("#productNotify input");
	var $addProductNotify = $("#addProductNotify");
	var $quantity = $("#quantity");
	var $increase = $("#increase");
	var $decrease = $("#decrease");
	var $addCart = $("#addCart");
	var $exchange = $("#exchange");
	
	var $window = $(window);
	var $bar = $("#bar ul");
	var $introductionTab = $("#introductionTab");
	var $parameterTab = $("#parameterTab");
	var $reviewTab = $("#reviewTab");
	var $consultationTab = $("#consultationTab");
	var $introduction = $("#introduction");
	var $parameter = $("#parameter");
	var $review = $("#review");
	var $addReview = $("#addReview");
	var $consultation = $("#consultation");
	var $addConsultation = $("#addConsultation");
	var barTop = $bar.offset().top;
	var barWidth = $bar.width();
	var productId = $("#productId").val();
	var productData = {};
	
	
	
	
	// 商品缩略图滚动
	$thumbnailScrollable.scrollable();
	
	$thumbnail.hover(function() {
		var $this = $(this);
		if ($this.hasClass("current")) {
			return false;
		}
		
		$thumbnail.removeClass("current");
		$this.addClass("current").click();
	});
	
	
	
	
	$previewClose.click(function() {
		$preview.hide();
		$dialogOverlay.hide();
	});
	
	// 规格值选择
	$specificationValue.click(function() {
		var $this = $(this);
		if ($this.hasClass("locked")) {
			return false;
		}
		
		$this.toggleClass("selected").parent().siblings().children("a").removeClass("selected");
		lockSpecificationValue();
		return false;
	});
	
	// 锁定规格值
	function lockSpecificationValue() {
		var currentSpecificationValueIds = $specification.map(function() {
			$selected = $(this).find("a.selected");
			return $selected.size() > 0 ? $selected.attr("val") : [null];
		}).get();
		$specification.each(function(i) {
			$(this).find("a").each(function(j) {
				var $this = $(this);
				var specificationValueIds = currentSpecificationValueIds.slice(0);
				specificationValueIds[i] = $this.attr("val");
				if (isValid(specificationValueIds)) {
					$this.removeClass("locked");
				} else {
					$this.addClass("locked");
				}
			});
		});
		var product = productData[currentSpecificationValueIds.join(",")];
		if (product != null) {
			productId = product.id;
			$price.text(currency(product.price, true));
			$marketPrice.text(currency(product.marketPrice, true));
			$rewardPoint.text(product.rewardPoint);
			$exchangePoint.text(product.exchangePoint);
			if (product.isOutOfStock) {
				if ($addProductNotify.val() == "确定登记") {
					$productNotify.show();
				}
				$addProductNotify.show();
				$quantity.closest("dl").hide();
				$addCart.hide();
				$exchange.hide();
			} else {
				$productNotify.hide();
				$addProductNotify.hide();
				$quantity.closest("dl").show();
				$addCart.show();
				$exchange.show();
			}
		} else {
			productId = null;
		}
	}
	
	// 判断规格值ID是否有效
	function isValid(specificationValueIds) {
		for(var key in productData) {
			var ids = key.split(",");
			if (match(specificationValueIds, ids)) {
				return true;
			}
		}
		return false;
	}
	
	// 判断数组是否配比
	function match(array1, array2) {
		if (array1.length != array2.length) {
			return false;
		}
		for(var i = 0; i < array1.length; i ++) {
			if (array1[i] != null && array2[i] != null && array1[i] != array2[i]) {
				return false;
			}
		}
		return true;
	}
	
	
	
	// 购买数量
	$quantity.keypress(function(event) {
		return (event.which >= 48 && event.which <= 57) || event.which == 8;
	});
	
	// 增加购买数量
	$increase.click(function() {
		var quantity = $quantity.val();
		if (/^\d*[1-9]\d*$/.test(quantity)) {
			$quantity.val(parseInt(quantity) + 1);
		} else {
			$quantity.val(1);
		}
	});
	
	// 减少购买数量
	$decrease.click(function() {
		var quantity = $quantity.val();
		if (/^\d*[1-9]\d*$/.test(quantity) && parseInt(quantity) > 1) {
			$quantity.val(parseInt(quantity) - 1);
		} else {
			$quantity.val(1);
		}
	});
	
		// 加入购物车
		$addCart.click(function() {
			if (productId == null) {
				$specificationTips.fadeIn(150).fadeOut(150).fadeIn(150);
				return false;
			}
			var quantity = $quantity.val();
		
			if (/^\d*[1-9]\d*$/.test(quantity)) {
				$.ajax({
					url: contextPath+"/cart/insertCart.do",
					type: "POST",
					data: {productId: productId, quantity: quantity},
					dataType: "json",
					cache: false,
					success: function(message) {
						if ( $headerCart.size() > 0 && window.XMLHttpRequest) {
							var $image = $zoom.find("img");
							var cartOffset = $headerCart.offset();
							var imageOffset = $image.offset();
							$image.clone().css({
								width: 300,
								height: 300,
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
							 showQuantity();	
								$(this).remove();
							});
						}
						$.message(message);
					}
				});
			} else {
				$.message("warn", "购买数量必须为正整数");
			}
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
	
	
	$bar.width(barWidth);
	
	$window.scroll(function() {
		var scrollTop = $(this).scrollTop();
		if (scrollTop > barTop) {
			$bar.addClass("fixed");
			var introductionTop = $introduction.size() > 0 ? $introduction.offset().top - 36 : null;
			var parameterTop = $parameter.size() > 0 ? $parameter.offset().top - 36 : null;
			var reviewTop = $review.size() > 0 ? $review.offset().top - 36 : null;
			var consultationTop = $consultation.size() > 0 ? $consultation.offset().top - 36 : null;
			if (consultationTop != null && scrollTop >= consultationTop) {
				$bar.find("li").removeClass("current");
				$consultationTab.addClass("current");
			} else if (reviewTop != null && scrollTop >= reviewTop) {
				$bar.find("li").removeClass("current");
				$reviewTab.addClass("current");
			} else if (parameterTop != null && scrollTop >= parameterTop) {
				$bar.find("li").removeClass("current");
				$parameterTab.addClass("current");
			} else if (introductionTop != null && scrollTop >= introductionTop) {
				$bar.find("li").removeClass("current");
				$introductionTab.addClass("current");
			}
		} else {
			$bar.removeClass("fixed").find("li").removeClass("current");
		}
	});
	
		// 发表商品评论
		$addReview.click(function() {
			if ($.checkLogin()) {
				return true;
			} else {
				$.redirectLogin(null, "必须登录后才能发表商品评论");
				return false;
			}
		});
	
		// 发表商品咨询
		$addConsultation.click(function() {
			if ($.checkLogin()) {
				return true;
			} else {
				$.redirectLogin(null, "必须登录后才能发表商品咨询");
				return false;
			}
		});
	
	// 浏览记录
	var historyGoods = getCookie("historyGoods");
	var historyGoodsIds = historyGoods != null ? historyGoods.split(",") : [];
	for (var i = 0; i < historyGoodsIds.length; i ++) {
		if (historyGoodsIds[i] == 29) {
			historyGoodsIds.splice(i, 1);
			break;
		}
	}
	historyGoodsIds.unshift(29);
	if (historyGoodsIds.length > 6) {
		historyGoodsIds.pop();
	}
	addCookie("historyGoods", historyGoodsIds.join(","));
	$.ajax({
		url: "/goods/history.do",
		type: "GET",
		data: {goodsIds: historyGoodsIds},
		dataType: "json",
		cache: true,
		success: function(data) {
			$.each(data, function (i, item) {
				var thumbnail = item.thumbnail != null ? item.thumbnail : "/upload/image/default_thumbnail.jpg";
				$historyGoods.find("dt").after(
'<dd> <img src="' + escapeHtml(thumbnail) + '" \/> <a href="' + escapeHtml(item.url) + '" title="' + escapeHtml(item.name) + '">' + escapeHtml(abbreviate(item.name, 30)) + '<\/a> <strong>' + currency(item.price, true) + '<\/strong> <\/dd>'				);
			});
		}
	});
	
	// 清空浏览记录
	$clearHistoryGoods.click(function() {
		$historyGoods.remove();
		removeCookie("historyGoods");
	});
	
	// 点击数
	$.ajax({
		url: "/goods/hits/29.do",
		type: "GET",
		cache: true
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
	<div id="dialogOverlay" class="dialogOverlay"></div>
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
					<form id="goodsSearchForm" action="<%=path %>/home/showShopInquiryy.do" method="get">
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
	<div class="container goodsContent">
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
		<div class="hotGoods">
			<dl>
				<dt>热销商品</dt>
					<dd>
						<a href="#">
							<img src="http://www.cloudring.net/upload_cloudringshop/upload/20150918/055557ed641145d2956e5d39e1527c42.jpg" alt="模拟4寸红外迷你中速球"  style="width: 170px; "/>
							<span title="模拟4寸红外迷你中速球">模拟4寸红外迷你中速球</span>
						</a>
						<strong>
							￥1200.00
								<del>￥1040.00</del>
						</strong>
					</dd>
					<dd>
						<a href="#">
							<img src="http://www.cloudring.net/upload_cloudringshop/upload/20150918/2b86092c4f974629b97d829a427bcf07.jpg" alt="云台" style="width: 170px; "/>
							<span title="云台">云台</span>
						</a>
						<strong>
							￥2200.00
								<del>￥2000.00</del>
						</strong>
					</dd>
					<dd>
						<a href="#">
							<img src="http://www.cloudring.net/upload_cloudringshop/upload/20150918/9df1fe98d0fd4c049fbba716986d4623.jpg" alt="SDI 全高清白色枪机"  style="width: 170px; "/>
							<span title="SDI 全高清白色枪机">SDI 全高清白色枪机</span>
						</a>
						<strong>
							￥1200.00
								<del>￥1440.00</del>
						</strong>
					</dd>
			</dl>
		</div>
<div id="historyGoods" class="historyGoods">
	<dl>
		<dt>最近浏览过的</dt>
		<dd>
			<a href="javascript:;" class="clear">清除历史记录</a>
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
						   <c:forEach items="${listMer}" var="itms" varStatus="st">
						     
								<li>
									<a href="<%=path %>/home/showShopHomeSecurity.do?type=1&skipName=${itms.id}">${itms.name}</a>
								</li>
								</c:forEach>
					</ul>
				</div>
				<div class="productImage">
						<a href="${goodsP.productImageListStore}" id="zoom1" class="MagicZoom MagicThumb"><img id="main_img" name="main_img"  src="${goodsP.productImageListStore}" />
						</a>
					<a href="javascript:;" class="prev">&nbsp;</a>
					<div id="thumbnailScrollable" class="scrollable">
						<div class="items">
							<a href="${goodsP.productImageListStore}" rel="zoom1" rev="${goodsP.productImageListStore}"><img src="${goodsP.productImageListStore}" /></a>
					        <a href="${goodsP.productImageListStore}" rel="zoom1" rev="${goodsP.productImageListStore}"><img src="${goodsP.productImageListStore}" /></a>
					        <a href="${goodsP.productImageListStore}" rel="zoom1" rev="${goodsP.productImageListStore}"><img src="${goodsP.productImageListStore}" /></a>
						</div>
					</div>
					<a href="javascript:;" class="next">&nbsp;</a>
				</div>
				<div id="preview" class="preview">
					<a href="javascript:;" class="close">&nbsp;</a>
					<a href="javascript:;" class="prev">&nbsp;</a>
					<div id="previewScrollable" class="scrollable">
						<div class="items">
									<img src="../images/icon/blank.gif" data-original="${goodsP.productImageListStore}" title="" />
									<img src="../images/icon/blank.gif" data-original="${goodsP.productEntiretyImageListStore}" title="" />
									<img src="../images/icon/blank.gif" data-original="${goodsP.productDetailImageListStore}" title="" />
						</div>
					</div>
					<a href="javascript:;" class="next">&nbsp;</a>
				</div>
				<div class="info">
				<input type="hidden" id="productId" name="productId"  value="${goodsP.id}"/>
					<h1>
						${goodsP.name}
							<em>${goodsP.title}</em>
					</h1>
					<dl>
						<dt>编号:</dt>
						<dd>
							${goodsP.productSn}
						</dd>
					</dl>
						<dl>
							<dt>销售价:</dt>
							<dd>
								<strong id="price">￥${goodsP.title}</strong>
							</dd>
								<!-- <dd>
									<span>
										(<em>市场价:</em>
										<del id="marketPrice">￥14400.00</del>)
									</span>
								</dd> -->
						</dl>
							<!-- <dl>
								<dt>赠送积分:</dt>
								<dd id="rewardPoint">
									12000
								</dd>
							</dl> -->
				</div>
					<div class="action">
						<form id="productNotifyForm" action="/product_notify/save.jhtml" method="post">
						
							<dl id="productNotify" class="productNotify hidden">
								<dt>您的E-mail:</dt>
								<dd>
									<input type="text" name="email" maxlength="200" />
								</dd>
							</dl>
						</form>
						<dl class="quantity">
							<dt>数量:</dt>
							<dd>
								<input type="text" id="quantity" name="quantity" value="1" maxlength="4" onpaste="return false;" />
								<div>
									<span id="increase" class="increase">&nbsp;</span>
									<span id="decrease" class="decrease">&nbsp;</span>
								</div>
							</dd>
							<dd>
								台
							</dd>
						</dl>
						<div class="buy">
							<input type="button" id="addProductNotify" class="addProductNotify hidden" value="到货通知我" />
								<input type="button" id="addCart" class="addCart" value="加入购物车" />
							<!-- <a href="javascript:;" id="addFavorite">收藏</a> -->
						</div>
					</div>
				<div class="share">
					<div id="bdshare" class="bdshare_t bds_tools get-codes-bdshare">
						<a class="bds_qzone"></a>
						<a class="bds_tsina"></a>
						<a class="bds_tqq"></a>
						<a class="bds_renren"></a>
						<a class="bds_t163"></a>
						<span class="bds_more"></span>
						<a class="shareCount"></a>
					</div>
                   
				</div>
                 <div>
                    立即购买:<a href="http://mall.jd.com/index-150652.html" target="_blank"><img src="<%=path %>/images/logo_jd.png" /></a>
                    </div>
				<div id="bar" class="bar">
					<ul>
							<li id="introductionTab">
								<a href="#introduction">商品介绍</a>
							</li>
							<li id="parameterTab">
								<a href="#parameter">商品参数</a>
							</li>
							<li id="reviewTab">
								<a href="#review">商品评论</a>
							</li>
							<li id="consultationTab">
								<a href="#consultation">商品咨询</a>
							</li>
					</ul>
				</div>
					<div id="introduction" name="introduction" class="introduction">
						<div class="title">
							<strong>商品介绍</strong>
						</div>
							<div><p>${goodsP.description}<!-- <img src=""/> --></p></div>
					</div>
					<div id="parameter" name="parameter" class="parameter">
						<div class="title">
							<strong>商品参数</strong>
						</div>
						<div><p>${goodsP.product_parameters}<!-- <img src=""/> --></p></div>
					</div>
					<div id="review" name="review" class="review">
						<div class="title">商品评论</div>
						<div class="content clearfix">
								<p>
									暂无商品评论信息 <a href="/review/add/29.jhtml" id="addReview">[发表商品评论]</a>
								</p>
						</div>
					</div>
					<div id="consultation" name="consultation" class="consultation">
						<div class="title">商品咨询</div>
						<div class="content">
									<p>
										暂无商品咨询信息 <a href="/consultation/add/29.jhtml" id="addConsultation">[发表商品咨询]</a>
									</p>
						</div>
					</div>
			</div>
		</div>
	</div>
   <jsp:include page="/page/shop/home/foot.jsp" />	
</body>
</html>
