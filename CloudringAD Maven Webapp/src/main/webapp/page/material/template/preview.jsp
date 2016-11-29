<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/tlds/c.tld" prefix="c"%>
<%@ taglib uri="/WEB-INF/tlds/fmt.tld" prefix="fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!doctype html>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta charset="utf-8">
<title>节目预览</title>
 <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>


<link rel="shortcut icon" href="<%=path%>/images/sys/icon/icon.png">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/sys/common.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/sys/main.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/sys/editor.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/sys/TweenMax.css">


<link rel="stylesheet" href="<%=path%>/css/sys/default.css">
<link rel="stylesheet" href="<%=path%>/css/sys/jquery.cxcolor.css">
<link rel="stylesheet" href="<%=path%>/css/sys/jquery.contextmenu.css">

<style>

.div{
width:100%;
	height:100%;
}
.ui-widget-content{
border:none
}
 iframe {
    height: 100%;
    width: 100%;
} 
.media{height: 100%}
img{width:100%;height:100%}
.clock > img{width:auto; height:auto}
video{width:100%;height:100%}
</style>
</head>

<body>	
	${text} 
<script type="text/javascript" src="<%=path%>/js/sys/jquery.js"></script>
<script type="text/javascript" src="<%=path%>/js/sys/jquery-ui.js"></script>
<script type="text/javascript" src="<%=path%>/js/sys/video.js"></script>
<script type="text/javascript" src="<%=path%>/js/sys/jquery.cycle.js"></script>
<script type="text/javascript" src="<%=path%>/js/sys/delaunay.js"></script>
<script type="text/javascript" src="<%=path%>/js/sys/TweenMax.js"></script>
<script type="text/javascript" src="<%=path%>/js/sys/picture.js"></script>
<script type="text/javascript" src="<%=path%>/js/sys/clock2.js"></script>
<script type="text/javascript" src="<%=path%>/js/sys/jqueryRorate.js"></script>
<script type="text/javascript" src="<%=path%>/js/sys/clock.js"></script>
<script type="text/javascript" src="<%=path%>/js/sys/clock_word.js"></script>
<script type="text/javascript" src="<%=path%>/js/sys/jquery.media.js"></script>
<script>
$(function(){
	$('a.media').media({width:800, height:600}); 
	var $ifame=$('.iframe');
	$ifame.each(function(){
		var $this=$(this);
		var $source=$this.parents('.page').attr('data-src');
		$this.attr('src',$source);
	});
});
</script>
</body>
</html>
