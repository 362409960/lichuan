<%@ page language="java" pageEncoding="utf-8" %>

<% 
    String path = request.getContextPath();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title>管理中心——Cloudring Shop</title>
<meta content="Cloudring" name="author">
<meta content="Cloudring" name="copyright">
<link rel="shortcut icon" href="images/icon.png">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/deafult/common.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/deafult/main.css">
<script type="text/javascript" src="<%=path%>/js/jquery.min.js"></script>
<style>
* {
	font: 12px 'microsoft yahei', Arial, sans-serif;
}
html, body {
	width: 100%;
	height: 100%;
 overflowhidden;
}
</style>
<script type="text/javascript">
	if(parent && parent.frames.length>0){
		top.location.href = "index.jsp";
	}
</script>
</head>

<body>
<table class="main">
  <tr>
    <th class="logo"> <a href="<%=path%>/index.jsp"> <img alt="Cloudring-Shop" src="<%=path%>/images/header_logo.gif"> </a> </th>
    <th> <div id="nav" class="nav">
        <ul>
          <li><a href="#product">商品</a></li>
          <li><a href="#order">订单</a></li>
          <li><a href="#member">会员</a></li>
          <li><a href="#content">内容</a></li>
          <li><a href="#marketing">营销</a></li>
          <li><a href="#statistic">统计</a></li>
          <li><a href="#system">系统</a></li>
          <li><a href="/" target="_blank">首页</a></li>
        </ul>
      </div>     
        <div class="link"> <a href="##" target="_blank">官方网站</a>| <a href="##" target="_blank">交流论坛</a>| <a href="##" target="_blank">关于我们</a> </div>
      <div class="link"> <strong><%=request.getSession().getAttribute("username")%></strong> 您好！ <a href="##" target="iframe" >[账户设置]</a> <a href="<%=path%>//sys/logout.do" target="_top">[注销]</a> </div>
    </th>
  </tr>
  <tr>
    <td id="menu" class="menu"><dl id="product" class="default">
        <dt>商品管理</dt>
        <dd> <a href="<%=path%>/admin/product/toList.do" target="iframe">商品管理</a> </dd>
        <dd> <a href="<%=path%>/admin/invManag/toList.do" target="iframe">库存管理</a> </dd>
        <dd> <a href="<%=path%>/admin/category/toList.do" target="iframe">商品分类</a> </dd>
        <dd> <a href="<%=path%>/admin/parameters/toList.do" target="iframe">商品参数</a> </dd>
        <dd> <a href="<%=path%>/admin/attributes/toList.do" target="iframe">商品属性</a> </dd>
        <dd> <a href="<%=path%>/admin/specification/toList.do" target="iframe">规格管理</a> </dd>
        <dd> <a href="<%=path%>/admin/band/toList.do" target="iframe">品牌管理</a> </dd>
        <dd> <a href="<%=path%>/admin/arrivalNotice/toList.do" target="iframe">到货通知</a> </dd>
      </dl>
      <dl id="order">
        <dt>订单管理</dt>
        <dd> <a href="<%=path%>/admin/order/order_list.do" target="iframe">订单管理</a> </dd>
        <dd> <a href="<%=path%>/admin/payment/payment_list.do" target="iframe">收款管理</a> </dd>
        <dd> <a href="<%=path%>/admin/rerund/rerund_list.do" target="iframe">退款管理</a> </dd>
        <dd> <a href="<%=path%>/admin/shipping/shipping_list.do" target="iframe">发货管理</a> </dd>
        <dd> <a href="<%=path%>/admin/reship/reship_list.do" target="iframe">退货管理</a> </dd>
        <dd> <a href="<%=path%>/admin/delivery/delivery_list.do" target="iframe">发货点管理</a> </dd>
        <dd> <a href="<%=path%>/admin/template/template_list.do" target="iframe">快递单模板</a> </dd>
      </dl>
      <dl id="member">
        <dt>会员管理</dt>
        <dd> <a href="##" target="iframe">会员管理</a> </dd>
        <dd> <a href="##" target="iframe">会员等级</a> </dd>
        <dd> <a href="##" target="iframe">会员注册项</a> </dd>
        <dd> <a href="##" target="iframe">积分管理</a> </dd>
        <dd> <a href="##" target="iframe">预存款</a> </dd>
        <dd> <a href="##" target="iframe">评论管理</a> </dd>
        <dd> <a href="##" target="iframe">咨询管理</a> </dd>
        <dd> <a href="##" target="iframe">消息配置</a> </dd>
      </dl>
      <dl id="content">
        <dt>内容管理</dt>
        <dd> <a href="##" target="iframe">导航管理</a> </dd>
        <dd> <a href="##" target="iframe">文章管理</a> </dd>
        <dd> <a href="##" target="iframe">文章分类</a> </dd>
        <dd> <a href="##" target="iframe">标签管理</a> </dd>
        <dd> <a href="##" target="iframe">友情链接</a> </dd>
        <dd> <a href="##" target="iframe">广告位</a> </dd>
        <dd> <a href="##" target="iframe">广告管理</a> </dd>
        <dd> <a href="##" target="iframe">模板管理</a> </dd>
        <dd> <a href="##" target="iframe">主题设置</a> </dd>
        <dd> <a href="##" target="iframe">缓存管理</a> </dd>
        <dd> <a href="##" target="iframe">静态化管理</a> </dd>
        <dd> <a href="##" target="iframe">索引管理</a> </dd>
      </dl>
      <dl id="marketing">
        <dt>营销管理</dt>
        <dd> <a href="##" target="iframe">促销管理</a> </dd>
        <dd> <a href="##" target="iframe">优惠券管理</a> </dd>
        <dd> <a href="##" target="iframe">SEO设置</a> </dd>
        <dd> <a href="##" target="iframe">Sitemap管理</a> </dd>
      </dl>
      <dl id="statistic">
        <dt>统计报表</dt>
        <dd> <a href="##" target="iframe">访问统计</a> </dd>
        <dd> <a href="##" target="iframe">统计设置</a> </dd>
        <dd> <a href="##" target="iframe">会员统计</a> </dd>
        <dd> <a href="##" target="iframe">订单统计</a> </dd>
        <dd> <a href="##" target="iframe">会员排名</a> </dd>
        <dd> <a href="##" target="iframe">商品排名</a> </dd>
      </dl>
      <dl id="system">
        <dt>系统设置</dt>
        <dd> <a href="##" target="iframe">系统设置</a> </dd>
        <dd> <a href="##" target="iframe">地区管理</a> </dd>
        <dd> <a href="##" target="iframe">支付方式</a> </dd>
        <dd> <a href="##" target="iframe">配送方式</a> </dd>
        <dd> <a href="##" target="iframe">物流公司</a> </dd>
        <dd> <a href="##" target="iframe">支付插件</a> </dd>
        <dd> <a href="##" target="iframe">存储插件</a> </dd>
        <dd> <a href="##" target="iframe">登录插件</a> </dd>
        <dd> <a href="##" target="iframe">管理员</a> </dd>
        <dd> <a href="##" target="iframe">角色管理</a> </dd>
        <dd> <a href="##" target="iframe">发送消息</a> </dd>
        <dd> <a href="##" target="iframe">消息列表</a> </dd>
        <dd> <a href="##" target="iframe">草稿箱</a> </dd>
        <dd> <a href="##" target="iframe">日志管理</a> </dd>
      </dl></td>
    <td><iframe id="iframe" frameborder="0" name="iframe" src="main.jsp"></iframe></td>
  </tr>
</table>

<script>
$(function(){
	var $nav=$('#nav a:not(:last)');
	var $menu=$('#menu dl');
	var $menuItem=$('#menu a');
	
	$nav.click(function(){
		var $this=$(this);
		$nav.removeClass('current');
		$this.addClass('current');
		var $currentMenu=$($this.attr('href'));
		//$menu.hide();
		$currentMenu.addClass('default')
					.siblings('dl')
					.removeClass();
		return false;
	});
	
	$menuItem.click(function(){
		var $this=$(this);
		$menuItem.removeClass('current');
		$this.addClass('current');
	});
});
</script>
</body>
</html>
