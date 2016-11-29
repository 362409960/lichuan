<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/tlds/c.tld" prefix="c"%>
<%@ taglib uri="/WEB-INF/tlds/fn.tld" prefix="fn" %>  
<%@page import="cloud.shop.common.Constants" %>
<%@page import="cloud.shop.goods.entity.Customer" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%
    Customer sysUserVO = null;
	String userName = "";
    Object obj = session.getAttribute(Constants.SESSION_LOGIN_USER_GOODS);
    if(obj != null){
    	sysUserVO = (Customer)obj;
    	userName = sysUserVO.getName();    	
    }
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
<link href="<%=path %>/css/default/layout.css" rel="stylesheet" type="text/css" />
<link href="<%=path %>/css/default/cart.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<%=path %>/js/jquery.min.js"></script>
<script type="text/javascript" src="<%=path %>/js/event.js"></script>
<script type="text/javascript" src="<%=path %>/js/cart.js"></script>
<script type="text/javascript" src="<%=path %>/js/move.js"></script>
<script>var contextPath = "${pageContext.request.contextPath}";</script>
<script type="text/javascript">
$().ready(function() {
var $submit = $("#submit");
var username = '<%=userName%>';	
if ($.trim(username) != "")
{
	var oInfo=document.getElementById('topbar-info');
	var user_menu=getClass(oInfo,'user-menu')[0];
	var oUser=getClass(oInfo,'user')[0];  
	var old_class=oUser.className;
	oInfo.onmouseover=function(){
		user_menu.style.display='block';
		oUser.className=old_class+' user-active';
	};
	oInfo.onmouseout=function(){
		user_menu.style.display='none';
		oUser.className=old_class;
	};
}

		// 提交
	$submit.click(function() {
		if (!$.checkLogin()) {
			$.redirectLogin(null, "必须登录后才能提交订单");
			return false;
		}
	});
		
		
});

</script>
</head>

<body>
<!--site-header 导航栏区域-->
<div class="site-header site-mini-header">
	<div class="container">
    	<div class="header-logo">
        	<a class="logo ir" title="Cloudring" href="http://www.cloudring.net">Cloudring商城</a>        	
        </div>
        <div class="header-title has-more">
        	<h2>我的购物车</h2>
            <p><a href="javascript:void(0);" target="_blank">问题反馈&gt;</a></p>
        </div>
       <div class="topbar-info" id="topbar-info">
         <% if("".equals(userName))  {%>
          <a href="<%=path %>/page/shop/home/reception_login.jsp" class="link">登录</a>
           <% }else{%>
           <span class="user">
            	<a href="<%=path %>/member/showCentre.do" class="user-name">
                	<span class="name"><%=userName %></span>
                    <i>&or;</i>
                </a>
                <ul class="user-menu">
                	<li>
                    	<a href="<%=path %>/member/showCentre.do" target="_blank">个人中心</a>
                    </li>
                    <li>
                    	<a href="javascript:void(0);" target="_blank">评价晒单</a>
                    </li>
                    <li>
                    	<a href="javascript:void(0);" target="_blank">我的喜欢</a>
                    </li>
                    <li>
                    	<a href="javascript:void(0);" target="_blank">智慧账户</a>
                    </li>
                    <li>
                    	<a href="<%=path %>/login/loginout.do" >退出登录</a>
                    </li>
                </ul>
            </span>
            <% }%>
            <span class="sep">|</span>
              <% if("".equals(userName))  {%>
            <a href="<%=path %>/register/showShopRegister.do" class="link">注册</a> 
            <% }else{%>
            <a href="javascript:void(0);" target="_blank" class="link-order">我的订单</a>
            <% }%>
        </div>
    </div>
</div>


<!--购物车中间 page-main区域-->
<div class="page-main">
	<div class="container">
	<c:choose>
		<c:when test="${isTrue==false}">
			<div class="cart-empty">
	        	<h2>您的购物车还是空的！</h2>
	            <p class="login-desc">您的购物车还是空的！</p>
	            <% if("".equals(userName))  {%>
	            <a href="<%=path %>/login/login.do" class="login-a">立即登录</a>
	            <a href="<%=path %>/home/showShopIndex.do" class="shop-a">马上去购物</a>
	            <% }else{%>
	             <a href="<%=path %>/home/showShopIndex.do" class="shop-a">马上去购物</a>
	             <% }%>
	        </div>
        </c:when>
		<c:otherwise>
		<div id="cartBox">
        	<div class="cart-goods-list">
            	<div class="list-head clearfix">
                	<div class="col col-check">
                    	<i id="selectAll" class="icon-checkbox icon-checkbox-selected">√</i>
                        全选
                    </div>
                    <div class="col col-img">&nbsp;</div>
                    <div class="col col-name">商品名称</div>
                    <div class="col col-price">单价</div>
                    <div class="col col-num">数量</div>
                    <div class="col col-total">小计</div>
                    <div class="col col-action">操作</div>
                </div>
               	<div id="cartListBody" class="list-body">
               	<c:forEach items="${cart}" var="cart" varStatus="st">
                	<div class="item-box">
                    	<div class="item-table">
                        	<div class="item-row clearfix">
                            	<div class="col col-check">
                                    <i class="icon-checkbox icon-checkbox-selected">√</i>
                                    <input type="hidden" name="id" class="hideId"  value="${cart.id}" />
                                </div>
                                <div class="col col-img">
                                	<a href="javascript:void(0);" target="_blank">
                                    	<img src="${cart.goods_url}" alt="" style="width: 80px;height: 80px;"/>
                                    </a>
                                </div>
                                <div class="col col-name">
                                	<div class="tags"></div>
                                    <h3 class="name" style="width: 380px;">
                                    	<a href="javascript:void(0);" target="_blank"> ${cart.picture}</a>
                                    </h3>
                                </div>
                                <div class="col col-price">${cart.price}元</div>
                                <div class="col col-num">
                                	<div class="change-goods-num clearfix">
                                    	<a href="javascript:void(0);" class="minus">-</a>
                                        <input class="goods-num" autocomplete="off" type="text" value="${cart.quantity}"/>
                                        <a href="javascript:void(0);" class="plus">+</a>
                                    </div>
                                </div>
                                <div class="col col-total"> 
                                	${cart.quantity*cart.price}元 
                                	<p class="pre-info"></p>
                                </div>
                                <div class="col col-action">
                                	<a href="javascript:void(0);" title="删除" class="del">x</a>
                                </div>
                            </div>
                        </div>                  
                    </div>
                    </c:forEach>
                </div>
            </div>
            <div id="cartBar" class="cart-bar clearfix">
            	<div class="section-left">
                	<a href="<%=path %>/home/showShopIndex.do" class="back-shopping">继续购物</a> 
                    <span class="cart-total">
                    	共
                        <i id="cartTotalNum">${length}</i>
                         		件商品，已选择
                         <i id="selTotalNum">${length}</i>
                         		件 
                    </span>
                </div>
                <span class="total-price"> 合计：<em id="cartTotalPrice">${sum}元</em></span>
                <a id="goCheckout" href="<%=path %>/orders/checkout.do" id="submit" class="btn-a">去结算</a>
            </div>
        </div>
        
        <div id="miRecommendBox" class="cart-recommend container">
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
		</c:otherwise>
</c:choose>
		
    	
    </div>
</div>

<jsp:include page="/page/shop/home/foot_new.jsp" />
<div id="modalAlert" class="modal-alert">
	<div class="modal-bd">
    	<div class="text">
        	<h3 id="alertMsg">确定要删除吗？</h3>
        </div>
        <div class="actions">
        	<input id="alertCancel" class="alertCancel" type="button" value="取消" />
            <input id="alertOk" class="alertOk" type="button" value="确定" />
        </div>
        <a href="javascript:void(0);" class="close">x</a>
    </div>
</div>

</body>
</html>

