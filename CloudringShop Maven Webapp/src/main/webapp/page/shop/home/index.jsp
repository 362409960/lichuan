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
<link href="../css/default/index.css" rel="stylesheet" type="text/css" />
<link href="../css/default/flexslider.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="../js/jquery.min.js"></script>
<script type="text/javascript" src="../js/jquery.flexslider-min.js"></script>
</head>

<body>
<jsp:include page="/page/shop/home/top.jsp" />
<script>
    	$(function(){
			$('.nav-item .link').each(function(index, element) {
                $(this).hover(function(){
					$('.header-nav-menu').slideDown();
				},function(){
					$('.header-nav-menu').slideUp();
				});
            });
			$('.brick-item').each(function(index, element) {
				var that=this;
                $(this).hover(function(){
					$(that).addClass('brick-item-active');
				},function(){
					$(that).removeClass('brick-item-active');
				});
            });
			 $('.tab-list > li').mouseover(function(){
				$(this).addClass('tab-active').siblings('li').removeClass();
				$('#accessories-content').find('.tab-content').eq($(this).index()).show().siblings().hide();
			}); 
		});
    </script>
    
    
<div class="site-container container">
	<div class="site-banner-sup">
    	<div class="flexslider site-slider" id="slider">
        	<ul class="slides">
        	  <c:forEach items="${comList}" varStatus="st" var="com">
            	<li>
                	<a href="javascript:void(0);" target="_blank">
                    <img src="${com.file_path}" alt="${com.t_name}" title="${com.t_name}" /> 	
                    </a>
                </li>
                </c:forEach>
               
            </ul>
        </div>      
    </div>
    <div class="site-banner-sub row">
    		<div class="span4">
            	<ul class="channel-list clearfix">
                	<li class="top left">
                    	<a href="javascript:void(0);" target="_blank">
                        	<i class="iconfont"></i>
                            电信专场
                        </a>
                    </li>
                    <li class="top">
                    	<a href="javascript:void(0);" target="_blank">
                        	<i class="iconfont"></i>
                            企业团购
                        </a>
                    </li>
                    <li class="top">
                    	<a href="javascript:void(0);" target="_blank">
                        	<i class="iconfont"></i>
                            官翻产品
                        </a>
                    </li>
                    <li class="left">
                    	<a href="javascript:void(0);" target="_blank">
                        	<i class="iconfont"></i>
                            智慧移动
                        </a>
                    </li>
                    <li class="">
                    	<a href="javascript:void(0);" target="_blank">
                        	<i class="iconfont"></i>
                            话费充值
                        </a>
                    </li>
                    <li class="">
                    	<a href="javascript:void(0);" target="_blank">
                        	<i class="iconfont"></i>
                            访伪查询
                        </a>
                    </li>
                </ul>
            </div>
            <div class="span16">
            	<ul class="promo-list clearfix">
                	<li class="first">
                    	<a href="javascript:void(0);">
                        	<img src="/upload_cloudringshop/upload/20150921/f675047e-91ec-46ac-a718-6c003fc9b901.jpg" alt="" style="width:316px;height:170px"  />
                        </a>
                    </li>
                    <li>
                    	<a href="javascript:void(0);">
                        	<img src="/upload_cloudringshop/upload/20150921/7a09df9e-3f64-4670-82c2-87f3fd0bec0b.jpg" alt="" style="width:316px;height:170px" />
                        </a>
                    </li>
                    <li>
                    	<a href="javascript:void(0);">
                        	<img src="/upload_cloudringshop/upload/20150921/313597c4-10be-41a6-8827-9b75889ad88a.jpg" alt="" style="width:316px;height:170px" />
                        </a>
                    </li>
                </ul>
            </div>
   		</div>
    <div class="site-star-goods">
    	<div class="plain-box">
        	<div class="box-hd">
            	<h2 class="title">克劳德菱明星单品</h2>
                <div class="more">
                	<a class="control control-prev control-disabled" href="javascript:void(0);">&lt;</a><a class="control control-next" href="javascript:void(0);">&gt;</a>
                </div>
            </div>
            <div class="box-bd">
            	<div class="carousel-wrapper">
                	<ul class="carousel-list clearfix" style="width:2480px;">
                	  <c:forEach items="${stratList}" varStatus="st" var="strat">
                    	<li class="rainbow-item-${st.index+1}">
                        	<a href="<%=path %>/home/showShopProductDetails.do?type=2&skipName=${strat.id}" class="thumb">
                            	<img src="${strat.productImageListStore}" title="${strat.name}"/>
                            </a>
                            <h3 class="title">
                            	<a href="<%=path %>/home/showShopProductDetails.do?type=2&skipName=${strat.id};" target="_blank">${strat.name}</a>
                            </h3>
                             <p class="desc">${strat.title}</p> 
                            <p class="price">${strat.price}元起</p>
                        </li>
                        </c:forEach>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="page-main site-main">
	<div class="container">
    	<div id="smart" class="site-brick-box plain-box site-brick-row-box site-smart">
        	<div class="box-hd">
            	<h2 class="title">智能硬件</h2>
                <div class="more">
                	<a href="<%=path %>/home/showShopInquiry.do" target="_blank" class="more-link">
                    	查看全部&gt;
                    </a>
                </div>
            </div>
            <div class="box-bd">
            	<div class="row">
                	<div class="span4 span-first">
                    	<ul class="site-brick-list clearfix">
                        	<li class="brick-item brick-item-1">
                            	<a href="javascript:void(0);" target="_blank">
                                	<img src="../images/default/img06.jpg" alt=""/>
                                </a>
                            </li>
                        </ul>
                    </div>
                    <div class="span16">
                    	<ul class="brick-list clearfix">
                    	 <c:forEach items="${hardList}" varStatus="st" var="hard">
                        	<li class="brick-item brick-item-active brick-item-m">
                            	<div class="figure figure-img">
                                	<a href="<%=path %>/home/showShopProductDetails.do?type=2&skipName=${hard.id}" target="_blank">
                                    	<img src="${hard.productImageListStore}" width="160" height="160" alt="${hard.name}"/>
                                    </a>
                                </div>
                                <h3 class="title">
                                	<a href="<%=path %>/home/showShopProductDetails.do?type=2&skipName=${hard.id}" target="_blank">
                                    	${hard.name}
                                    </a>
                                </h3>
                                <p class="desc">${hard.title}</p>
                                <p class="price"><span class="num">${hard.price}元</span></p>
                                <div class="flag flag-postfree">免邮费</div>
                            </li>
                            </c:forEach>                           
                        </ul>
                    </div>
                </div>
            </div>
        </div>   
        <div id="recommend" class="site-brick-box plain-box site-brick-row-1-box site-smart">
        	<div class="box-hd">
            	<h2 class="title">为你推荐</h2>
                <div class="more">
                	<a class="control control-prev control-disabled" href="javascript:void(0);">&lt;</a><a class="control control-next" href="javascript:void(0);">&gt;</a>
                </div>
            </div>
            <div id="recommend-bd" class="box-bd container">
            	<div class="recommend-wrap">
                	<ul class="recommend-wrap-list clearfix" style="width:4960px;">
                	<c:forEach items="${reList}" var="rl">
                    	<li class="recommend-list">
                        	<dl>
                            	<dt>
                                	<a href="<%=path %>/home/showShopProductDetails.do?type=2&skipName=${rl.id}" target="_blank">
                                    	<img src="${rl.productImageListStore}" style="width: 200px;height: 200px;" alt="${rl.title}"/>
                                    </a>
                                </dt>
                                <dd class="recommend-name">
                                	<a href="<%=path %>/home/showShopProductDetails.do?type=2&skipName=${rl.id}" target="_blank">
                                    	 ${rl.title}
                                    </a>
                                </dd>
                                <dd class="recommend-price">${rl.price}元</dd>
                                <dd class="recommend-tips">3万人好评</dd>
                            </dl>
                        </li>
                        </c:forEach>
                        
                    </ul>
                </div>
            </div>
        </div>
      </div>
      </div>
<script>
$(function(){
	$('#slider').flexslider({
		animation: "slide",
		controlNav: true,
		directionNav:true
  });

  
});
</script>

<jsp:include page="/page/shop/home/foot_new.jsp" />
</body>
</html>
