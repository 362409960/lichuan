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
<link href="../css/shop/common.css" rel="stylesheet" type="text/css" />
<link href="../css/shop/goods.css" rel="stylesheet" type="text/css" />
<link href="../css/shop/product_category.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="../js/jquery.min.js"></script>
<script type="text/javascript" src="../js/shop/common.js"></script>
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
	<div class="container productCategory">
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
						<li>商品分类</li>
					</ul>
				</div>
				<div class="list">
					<table>
					 <c:forEach items="${topMap}" var="top" varStatus="st">
							<tr>
							<c:forEach items="${top.key}" var="key">
								<th>
									<a href="<%=path %>/home/showShopHomeSecurity.do?type=1&skipName=${key.key}"><!-- 手机数码 -->${key.value}</a>
								</th>
								</c:forEach>
								<td>
								      <c:forEach items="${top.value}" var="mc">
										<a href="<%=path %>/home/showShopHomeSecurity.do?type=1&skipName=${mc.id}"><!-- 手机通讯 -->${mc.name}</a>
									</c:forEach>
								</td>
							</tr>
							</c:forEach>
					</table>
				</div>
			</div>
		</div>
	</div>
<jsp:include page="/page/shop/home/foot.jsp" /></body>
</html>
