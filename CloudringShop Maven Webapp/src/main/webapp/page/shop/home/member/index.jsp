<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="/WEB-INF/tlds/c.tld" prefix="c"%>
<%@page import="cloud.shop.common.Constants" %>
<%@page import="cloud.shop.goods.entity.Customer" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title></title>
    <link href="<%=path%>/css/shop/common.css" rel="stylesheet" type="text/css" />
	<link href="<%=path%>/css/shop/member.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="<%=path%>/js/jquery.min.js"></script>
	<script type="text/javascript" src="<%=path%>/js/shop/common.js"></script>
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
 if(top != self) {  
            if(top.location != self.location) {  
                top.location = self.location;  
            }  
        }  
var contextPath = "${pageContext.request.contextPath}";
$().ready(function() {
    $("#main").attr("src",contextPath+"/member/showInit.do");
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
							<a href="#">三星</a>	 -->						
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
<div class="container member">
<div class="row">
<div class="span2">
	<div class="info">
		<div class="top"></div>
		<div class="content">
			<p>
				您好
				<strong><%=userName %></strong>
			</p>
			<p>
				会员等级:
				<span class="red">普通会员</span>
			</p>
		</div>
		<div class="bottom"></div>
	</div>
	<div class="menu">
		<div class="title">
			<a href="<%=path %>/member/showInit.do" target="main">会员中心</a>
		</div>
		<div class="content">
			<dl>
				<dt>交易信息</dt>
				<dd>
					<a href="<%=path %>/orders/list.do" target="main">我的订单</a>
				</dd>
				<!-- <dd>
					<a href="" >我的优惠券</a>
				</dd>
				<dd>
					<a href="" >兑换优惠券</a>
				</dd>
				<dd>
					<a href="" >我的积分</a>
				</dd> -->
			</dl>
			<!-- <dl>
				<dt>我的收藏</dt>
				<dd>
					<a href="" >商品收藏</a>
				</dd>
				<dd>
					<a href="" >到货通知</a>
				</dd>
				<dd>
					<a href="" >商品评论</a>
				</dd>
				<dd>
					<a href="">商品咨询</a>
				</dd>
			</dl> -->
			<!-- <dl>
				<dt>我的消息</dt>
				<dd>
					<a href="" >发送消息</a>
				</dd>
				<dd>
					<a href="" >我的消息</a>
				</dd>
				<dd>
					<a href="" >草稿箱</a>
				</dd>
			</dl> -->
			<dl>
				<dt>个人资料</dt>
				<dd>
					<a href="<%=path %>/member/showUserData.do" target="main">个人资料</a>
				</dd>
				<dd>
					<a href="<%=path %>/member/showUserPassword.do" target="main">修改密码</a>
				</dd>
				<dd>
					<a href="<%=path %>/member/showShippingAddress.do" target="main">收货地址</a>
				</dd>
			</dl>
			<!-- <dl>
				<dt>预存款</dt>
				<dd>
					<a href="" >预存款充值</a>
				</dd>
				<dd>
					<a href="" >我的预存款</a>
				</dd>
			</dl> -->
		</div>
		<div class="bottom"></div>
	</div>	
   </div>
   <div class="span10">
        <iframe id="main" name="main" src="" frameborder="0" scrolling="0" noresize marginheight="0" marginwidth="0" onLoad="iFrameHeight()"></iframe>
        </div>
 </div>
</div>
<jsp:include page="/page/shop/home/foot.jsp" />
  </body>
</html>
<script type="text/javascript" language="javascript">   
function iFrameHeight() {   
var ifm= document.getElementById("main");   
var subWeb = document.frames ? document.frames["main"].document : ifm.contentDocument;   
if(ifm != null && subWeb != null) {
   ifm.height = subWeb.body.scrollHeight;
   ifm.width = subWeb.body.scrollWidth;
}   
}   
</script>


