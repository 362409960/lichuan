<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="/WEB-INF/tlds/c.tld" prefix="c"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
   
  </head>
  
  <body>
        <p>session 失效，请重新登录.</p>
   
  </body>
</html>
 <script type="text/javascript">
          if(top != self) {  
            if(top.location != self.location) {  
                top.location ="tologin.jsp";  
            }  
        } 
 </script>