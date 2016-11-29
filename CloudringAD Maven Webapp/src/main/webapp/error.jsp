<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="/WEB-INF/tlds/c.tld" prefix="c"%>
<%@ taglib uri="/WEB-INF/tlds/fmt.tld" prefix="fmt"%>

<%
    Object errorMessage = request.getAttribute("errorMessage");

    if(errorMessage != null && !"".equals(errorMessage.toString().trim())){%>
    	<script>
    	    alert("<%=errorMessage%>");
    	</script>
    <%}

%>


<script> 
</script>