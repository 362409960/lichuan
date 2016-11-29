<%@ page language="java" pageEncoding="utf-8" %>

<% 
    String path = request.getContextPath();
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>Cloud云后台管理平台</title>
		<meta http-equiv="pragma" content="no-cache" />
		<meta http-equiv="cache-control" content="no-cache" />
		<meta http-equiv="expires" content="0" />
		<meta http-equiv="keywords" content="Cloud云后台管理平台" />
		<meta http-equiv="description" content="主页" />
		<script type="text/javascript">
			if(parent && parent.frames.length>0){
				top.location.href = "index.jsp";
			}
		</script>
		<link rel="shortcut icon" href="favicon.ico" />
	</head>
 
	<frameset rows="60,38,*,38"  frameborder="no" border="0" framespacing="0" id="frame1">
		<frame name="top" scrolling="no" noresize src="top.jsp" frameborder="0" />
		<frame name="banner" scrolling="no" noresize src="banner.jsp" frameborder="0" />
		<frameset cols="192,*" frameborder="no" border="0" framespacing="0" id="frame2">
			<frame id="leftmenu" name="leftmenu" scrolling="auto" src="<%=path%>/menu/leftMenu.do"  noresize frameborder="0" />
			<frame id="main" name="main" scrolling="auto" src="" frameborder="0" />
		</frameset>
		<frame name="footFrame" scrolling="no" noresize src="foot.jsp" frameborder="0" />
	</frameset>
</html>
