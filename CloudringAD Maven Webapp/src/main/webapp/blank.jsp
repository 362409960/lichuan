<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>



<%
    Object obj = request.getSession().getAttribute(cloud.app.common.Constants.SESSION_LOGIN_USER);
    String path = request.getContextPath();
    
    if("" == obj){%>
       <script type="text/javascript">
           top.location = "<%=path%>/transfer.jsp";
       </script>
    <%
    }
    if (null == obj) {%>
       <script type="text/javascript">
           top.location = "<%=path%>/transfer.jsp";
       </script>
    <%
    }
%>


