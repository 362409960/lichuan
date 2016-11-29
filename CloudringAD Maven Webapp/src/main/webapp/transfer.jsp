<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<% 
    String path = request.getContextPath();
%>


 <head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <script type="text/javascript" src="<%=path%>/js/jquery.min.js"></script>
</head>

 <script type="text/javascript">
$(document).ready(function(){
	document.transfer.submit();
});
</script>


<html>
<body>
    <form name="transfer" action="logout.do"></form>
</body>
</html>