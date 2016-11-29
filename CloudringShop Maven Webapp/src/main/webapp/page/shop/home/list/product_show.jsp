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
<script>var contextPath = "${pageContext.request.contextPath}";</script>
<script type="text/javascript">

var $pageNumber = $("#pageNumber");
var $pageSize = $("#pageSize");
// 加入购物车
function addCart(id)
{
 $.ajax({
		url: contextPath+"/cart/insertCart.do",
		type: "POST",
		data: {productId: id, quantity: 1},
		dataType: "json",
		cache: false,
		success: function(message) {
		location.reload(true);
		}
	});
}
	
	$.pageSkip = function(pageNumber) {
		$pageNumber.val(pageNumber);
		$goodsForm.submit();
		return false;
	};
</script>
</head>

<body>

<jsp:include page="/page/shop/home/top.jsp" />  


<!--breadcrumbs区域-->
<div class="breadcrumbs">
	<div class="container">
    	<a href="<%=path %>/home/showShopIndex.do">首页</a>
    	 <c:forEach items="${listMer}" var="itms" varStatus="st">
        <span class="sep">&gt;</span>
        <a href="<%=path %>/home/showShopHomeSecurity.do?type=1&skipName=${itms.id}">${itms.name}</a>
        </c:forEach>        
    </div>
</div>

<!--goods-detail区域-->
<div class="goods-detail">
	<div class="goods-detail-info clearfix">
    	<div class="container">
        	<div class="row">
            	<div class="span13 goods-detail-left-info">
                	<div class="goods-pic-box">
                    	<div class="goods-big-pic" id="goods_big_pic">
                        	<img src="${goodsP.productImageListStore}" alt=""/>
                        </div>
                        <div class="goods-pic-loading"></div>
                        <div class="goods-small-pic clearfix">
                        	<ul id="goodsPicList">
                            	<li class="current">
                                	<img src="${goodsP.productImageListStore}" alt="" _src="${goodsP.productImageListStore}"/>
                                </li>
                                <li>
                                	<img src="${goodsP.productImageListStore}" alt="" _src="${goodsP.productImageListStore}"/>
                                </li>
                                <li>
                                	<img src="${goodsP.productImageListStore}" alt="" _src="${goodsP.productImageListStore}"/>
                                </li>
                                <li >
                                	<img src="${goodsP.productImageListStore}" alt="" _src="${goodsP.productImageListStore}"/>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <div class="span11 goods-batch-img-list-block"></div>
                </div>
                <div class="span7 goods-info-rightbox">
                	<dl class="goods-info-box">
                    	<dt class="goods-info-head">
                        	<dl id="goodsInfoBlock">
                            	<dt id="goodsName" class="goods-name"> ${goodsP.name}</dt>
                                <dd class="goods-subtitle">
                                	<p>${goodsP.title}</p>
                                </dd>
                                <dd class="goods-info-head-price clearfix">
                                	<b class="price">${goodsP.price}</b>
                                    <i>元</i>
                                    <del><span class="marketPrice"></span></del>
                                </dd>
                                <dd id="goodsDetailBtnBox" class="goods-info-head-cart">
                                	<a href="<%=path %>/cart/insertCart.do?productId=${goodsP.id}"" class="add-btn btn-primary">
                                    	<i></i>加入购物车
                                    </a>
                                    <a href="javascript:void(0);" class="goods-btn">
                                    	<i></i>喜欢
                                    </a>
                                </dd>
                                <dd class="goods-info-head-userfaq clearfix">
                                	<ul>
                                    	<li><i></i>评价<b>1828</b></li>
                                        <li class="mid"><i></i>提问<b>82</b></li>
                                        <li><i></i> 满意度<b>99.6%</b></li>
                                    </ul>
                                </dd>
                            </dl>
                        </dt>
                        <dd class="goods-info-foot">
                        	<a href="<%=path %>/home/showShopInquiry.do?keyword=${goodsP.name}"><i></i> 查看更多${goodsP.name}</a>
                        </dd>
                    </dl>
                </div>
            </div>
        </div>
    </div>
    <div id="goodsDetail" class="goods-detail-nav">
    	<div class="container">
        	<ul class="detail-list">
            	<li class="detail-nav current">
                	<a href="javascript:void(0);">详情描述</a>
                </li>
                <li class="detail-nav">
                	<a href="javascript:void(0);">规格参数</a>
                </li>
             <!--    <li class="detail-nav">
                	<a href="javascript:void(0);">评价晒单<i>(1854)</i></a>
                </li>
                <li class="detail-nav last">
                	<a href="javascript:void(0);">商品提问<i>(83)</i></a>
                </li> -->
            </ul>
        </div>
    </div>
    <div id="goodsDesc" class="goods-detail-desc">
    	<div class="container">
        	<div lang="shape-container">
            	<p class="detailBlock">
                	${goodsP.description}
                </p>
            </div>
        </div>
    </div>
    <div id="goodsParam" class="goods-detail-nav-name-block">
    	<div class="container main-block">
        	<div class="border-line"></div>
            <h2 class="nav-name">规格参数</h2>
        </div>
    </div>
    <div class="goods-detail-param">
    	<div class="container">
        	<ul class="param-list">
            	<li class="goods-img">
                	${goodsP.product_parameters}
                </li>
                <!-- <li class="goods-tech-spec">
                	<dl>
                    	<dd>
                        	<ul>
                            	<li>包装内容：10粒/盒，含收纳盒</li>
                                <li>产品型号：AA501</li>
                                <li>电池型号：AA LR6</li>
                                <li>电池类型：碱性电池</li>
                                <li>标称电压：1.5V</li>
                                <li>颜色：彩色</li>
                                <li>商品编号：1154300033</li>
                            </ul>
                        </dd>
                    </dl>
                </li> -->
            </ul>
        </div>
    </div>
   <!--  <div id="goodsComment" class="goods-detail-nav-name-block">
    	<div class="container main-block">
        	<div class="border-line"></div>
            <h2 class="nav-name">评价晒单</h2>
        </div>
    </div>
    <div id="goodsCommentContent" class="goods-detail-comment hasContent">
    	<div class="container">
        	<ul class="main-block">
            	<li class="perent">
                	<div class="per-num">
                    	<i>99.7</i>
						%
                    </div>
                    <div class="per-title">购买后满意</div>
                    <div class="per-amount">
                    	<i></i>
                    </div>
                </li>
            </ul>
        </div>
    </div> -->
</div>
<jsp:include page="/page/shop/home/foot_new.jsp" />
<script>
EventUtil.addHandler(window,'load',function(){
	var oGoodsPicList=document.getElementById('goodsPicList');
	var oGoodsPicImg=document.getElementById('goods_big_pic');
	var oBigImg=oGoodsPicImg.getElementsByTagName('img')[0];
	var aLi=oGoodsPicList.getElementsByTagName('li');
	var len=aLi.length
	var i=0;
	for(i=0;i<len;i++){
		aLi[i].index=i;
		EventUtil.addHandler(aLi[i],'click',function(){
			var listImg=this.getElementsByTagName('img')[0];
			for(var j=0;j<len;j++){
				aLi[j].className='';
			}
			this.className='current';
			oBigImg.src=listImg.getAttribute('_src');
		});
	}
});
</script>


</body>
</html>

