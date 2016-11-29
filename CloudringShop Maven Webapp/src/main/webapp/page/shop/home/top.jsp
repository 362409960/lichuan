<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
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
<!-- <link rel="shortcut icon" href="http://s01.mifile.cn/favicon.ico" type="image/x-icon" /> -->
<link href="../css/default/index.css" rel="stylesheet" type="text/css" />
<link href="../css/default/flexslider.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="../js/jquery.min.js"></script>
<script type="text/javascript" src="../js/jquery.flexslider-min.js"></script>
<script type="text/javascript" src="../js/event.js"></script>
<script>var contextPath = "${pageContext.request.contextPath}";</script>
<script>
$().ready(function() {
 var isAll='${isAll}';
if(isAll!='true')
{
   $("#link_all").css("visibility","visible");	
}

	var $headerCartQuantity = $("#headerCart em");
	function showHeaderCartQuantity() {
		if ($headerCartQuantity.size() == 0) {			
			return;
		 }	
		$.ajax({
			url: contextPath+"/cart/quantity.do",
			type: "GET",
			dataType: "json",
			cache: false,
			global: false,
			success: function(data) {
				$headerCartQuantity.text(data);
			}
		});
	}
	showHeaderCartQuantity();
	  
	$('.category-item').each(function(index, element) {
  	$(element).hover(function(){
		$(element).addClass('category-item-active').siblings().removeClass('category-item-active');
	},function(){
		$(element).removeClass('category-item-active');
	});  
  });
  
       var oCart=document.getElementById('topbar_cart');
		var oCarta=document.getElementById('cart');
		var oInfo=document.getElementById('topbar-info');
		var oMenu=getClass(oCart,'cart-menu')[0];  /*获取类 函数是getClass*/
		var timer=null;	   
		var cart_class=oCart.className;
		oCart.onmouseover=function(){ 
		oMenu.style.display='block';
		showCart();
		this.className=cart_class+' topbar-cart-filled';
		}
		oCart.onmouseout=function(){			  /*鼠标离开*/
			oMenu.style.display='none';
			this.className=cart_class;
		}
		
		oCart=null;
		oCarta=null;
		
		var username = '<%=userName%>';	
		if ($.trim(username) != "")
		{
		   var user_menu=getClass(oInfo,'user-menu')[0];
		   var oUser=getClass(oInfo,'user')[0]; 
		   var old_class=oUser.className;
		   oUser.onmouseover=function(){
			user_menu.style.display='block';
			oUser.className=old_class+' user-active';
		    };
		    oUser.onmouseout=function(){
			user_menu.style.display='none';
			oUser.className=old_class;
		    }; 
		}
	});
	
	function showCart(){
	 var cart_menu=$("#cart_menu");
	    $.ajax({
			url: contextPath+"/cart/shoppingCart.do",
			type: "GET",
			dataType: "json",
			cache: false,
			global: false,
			success: function(data) {
			var msc=eval(data);
			if(msc.quantity!=0)
			{
			 document.getElementById("loading").style.display="none";			  
			  cart_menu.html("");
			   var html='<ul class="cart-list">';
			   $.each(msc.list, function (i, item) {  
			        html+='<li><div class="cart-item clearfix first"><a href="'+contextPath+'/home/showShopProductDetails.do?type=2&skipName='+item.goods_id+'" class="thumb">';
          			html+='<img src='+item.goods_url+' alt=""/></a><a href="'+contextPath+'/home/showShopProductDetails.do?type=2&skipName='+item.goods_id+'" class="name">'+item.picture+'</a>';  
          			html+='<span class="price">'+item.price+'元 X '+item.quantity+'</span>  <a href="javascript:void(0);" class="btn-del" onclick="deleteCart(\''+item.id+'\'\);">X</a></div></li>    ';
       			 });  
			   html+='</ul><div class="cart-total clearfix"><span class="total">共<em>'+msc.quantity+'</em>件商品 <span class="price"><em>'+msc.totalPrice+'</em>元</span></span><a href="'+contextPath+'/cart/showShopCart.do" class="btn-cart">去购物车结算</a>';			
			  cart_menu.append(html);
			 
			}
			}
		});      
	
	}
	function deleteCart(id)
	{
	   $.ajax({
				url: contextPath+"/cart/deleteCart.do",
				type: "POST",
				data: {id: id},
				dataType: "json",
				cache: false,				
				success: function(data) {
					location.reload(true);
				}
			});
	}
</script>
</head>

<body>
<div class="site-topbar">
	<div class="container">
    	<div class="topbar-nav">
        	<a href="http://www.cloudring.net//CloudringShop">智慧商城</a>
            <span class="sep">|</span>
            <a href="http://www.cloudring.net:8080/jforum">智慧社区</a>
            <span class="sep">|</span>
            <a href="http://mall.jd.com/index-150652.html"  target="_blank">京东商铺</a>
            <span class="sep">|</span>
            <a href="http://www.cloudring.net/CloudringEsbWeb">智慧云</a>
            <span class="sep">|</span>
            <a href="http://www.cloudring.net:8080/CloudringNews">智慧新闻</a>
            
            <!-- 
            <span class="sep">|</span>
            <a href="http://www.cloudring.net/CloudringEsbWeb/">产品中心</a>
            <span class="sep">|</span>
            <a href="http://www.cloudring.net/CloudringEsbWeb/smart/video.do">视频广场</a>             
             -->
            
            <span class="sep">|</span>
            <a href="http://www.cloudring.net:8080/CloudringDownload">下载中心</a>
            <span class="sep">|</span>
            <a href="javascript:void(0);">Select Region</a>
        </div>
       <div class="topbar-cart" id="topbar_cart">
        	<a href="<%=path %>/cart/showShopCart.do" id="cart" class="cart">
            	<i class="iconfont"></i>
                					购物车
                <span class="cart-num" id="headerCart">(<em></em>)</span>
            </a>
            <div class="cart-menu" id="cart_menu">
            	<div class="loading" id="loading" >购物车还没有商品，赶紧选购吧！</div>
            </div>
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
                    	<%-- <a href="<%=path %>/logout.jsp" >退出登录</a> --%>
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
<div class="site-header">
	<div class="container">
    	<div class="header-logo">
        	<a class="logo ir" title="Cloudring" href="http://www.cloudring.net">Cloudring商城</a>        	
        </div>
        <div class="header-nav">
        	<ul class="nav-list clearfix">
            	<li class="nav-category">
                	<a href="#" class="link-category" id="link_all" >
                    	<span class="text">全部分类</span>
                    </a>
                   <div class="site-category">
                    	<ul class="site-category-list clearfix">
                    	   <c:forEach items="${topMap}" varStatus="st" var="p">
                    	     <c:forEach  items="${p.key}" var="three">	
                        	<li class="category-item">
                            	<a href="<%=path %>/home/showShopHomeSecurity.do?type=1&skipName=${three.key}" class="title">${three.value}<i class="icon-m"></i></a>
                            	 <c:forEach items="${p.value}" var="list" > 
                            	  <c:choose>
                            	 	<c:when test="${fn:length(list.value)>12 }">
                            	 	 <div class="children clearfix children-col-3">
                            	 	 <ul class="children-list children-list-col children-list-col-1">
	                                  <c:forEach items="${list.value}" var="my" varStatus="stc">
	                                      <c:choose>
                                 	         <c:when test="${stc.index<6}">
	                                    	<li class="star-goods">
	                                        	<a href="<%=path %>/home/showShopProductDetails.do?type=2&skipName=${my.id}" class="link">
	                                            	<img class="thumb" width="40" height="40" alt="" src="${my.productImageListStore}"/>
	                                                <span class="text">${my.name}</span>
	                                            </a>                                           
	                                        </li>
	                                        </c:when>
	                                        </c:choose>
	                                       </c:forEach>                 
	                                   </ul>
	                                   <ul class="children-list children-list-col children-list-col-2">
	                                  <c:forEach items="${list.value}" var="my" varStatus="stc">
	                                      <c:choose>
                                 	         <c:when test="${stc.index>=6 && stc.index<12}">
	                                    	<li class="star-goods">
	                                        	<a href="<%=path %>/home/showShopProductDetails.do?type=2&skipName=${my.id}" class="link">
	                                            	<img class="thumb" width="40" height="40" alt="" src="${my.productImageListStore}"/>
	                                                <span class="text">${my.name}</span>
	                                            </a>                                           
	                                        </li>
	                                        </c:when>
	                                        </c:choose>
	                                       </c:forEach>                 
	                                   </ul>  
	                                   <ul class="children-list children-list-col children-list-col-3">
	                                  <c:forEach items="${list.value}" var="my" varStatus="stc">
	                                      <c:choose>
                                 	         <c:when test="${stc.index>=12}">
	                                    	<li class="star-goods">
	                                        	<a href="<%=path %>/home/showShopProductDetails.do?type=2&skipName=${my.id}" class="link">
	                                            	<img class="thumb" width="40" height="40" alt="" src="${my.productImageListStore}"/>
	                                                <span class="text">${my.name}</span>
	                                            </a>                                           
	                                        </li>
	                                        </c:when>
	                                        </c:choose>
	                                       </c:forEach>                 
	                                   </ul>          
	                                </div>
                            	 	</c:when>
                                 	<c:when test="${fn:length(list.value)<7 }">
                                 	<div class="children clearfix children-col-1">
                                 	 <ul class="children-list children-list-col children-list-col-1">
                                 	  <c:forEach items="${list.value}" var="my" varStatus="stc">
	                                    	<li class="star-goods">
	                                        	<a href="<%=path %>/home/showShopProductDetails.do?type=2&skipName=${my.id}" class="link">
	                                            	<img class="thumb" width="40" height="40" alt="" src="${my.productImageListStore}"/>
	                                                <span class="text">${my.name}</span>
	                                            </a>                                           
	                                        </li>
	                                       </c:forEach>                 
	                                   </ul>        
	                                </div>
                                 	</c:when>
                                 	<c:otherwise>
                                 	<div class="children clearfix children-col-2">                                 	  
                                 	 <ul class="children-list children-list-col children-list-col-1">
                                 	    <c:forEach items="${list.value}" var="my" varStatus="stc">
                                 	      <c:choose>
                                 	          <c:when test="${stc.index<6}">
	                                    	<li class="star-goods">
	                                        	<a href="<%=path %>/home/showShopProductDetails.do?type=2&skipName=${my.id}" class="link">
	                                            	<img class="thumb" width="40" height="40" alt="" src="${my.productImageListStore}"/>
	                                                <span class="text">${my.name}</span>
	                                            </a>                                           
	                                        </li>
	                                            </c:when>
                                 	      </c:choose>	 
	                                       </c:forEach>                 
	                                   </ul> 
	                                    <ul class="children-list children-list-col children-list-col-2">
                                 	    <c:forEach items="${list.value}" var="my" varStatus="stc">
                                 	      <c:choose>
                                 	         <c:when test="${stc.index>=6}">
                                 	          <li class="star-goods">
	                                        	<a href="<%=path %>/home/showShopProductDetails.do?type=2&skipName=${my.id}" class="link">
	                                            	<img class="thumb" width="40" height="40" alt="" src="${my.productImageListStore}"/>
	                                                <span class="text">${my.name}</span>
	                                            </a>                                           
	                                        </li>
                                 	          </c:when>
                                 	      </c:choose>	                                    	
	                                       </c:forEach>                 
	                                   </ul>               
	                                </div>
                                 	</c:otherwise>
                                 </c:choose> 
                                 
                                </c:forEach>   
                            </li>
                          </c:forEach>
                          </c:forEach>
                        </ul>
                    </div>
                </li>
                 <c:forEach items="${menu}" var="menu">
                <li class="nav-item">
                	<a href="<%=path %>/home/showShopHomeSecurity.do?type=1&skipName=${menu.key}" class="link">
                    	<span class="text">${menu.value}</span>
                        <span class="arrow"></span>
                    </a>                  
                </li>
                 </c:forEach>              
            </ul>
        </div>
        <div class="header-search">
        	<form class="search-form clearfix" method="post" action="<%=path %>/home/showShopInquiry.do">
            	<input id="search" class="search-text" value="${keyword}" type="search" autocomplete="off" name="keyword"/>
                <input type="submit" class="serch-btn" value="搜索"/>
                <div class="search-hot-words">
                	<a href="<%=path %>/home/showShopInquiry.do?keyword=魔镜">魔镜</a>
                    <a href="<%=path %>/home/showShopInquiry.do?keyword=激光微投">激光微投</a>
                </div>
            </form>
        </div>
    </div>
</div> 

</body>
</html>
