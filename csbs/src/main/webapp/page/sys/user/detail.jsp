<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="/WEB-INF/tlds/c.tld" prefix="c"%>

<% String path = request.getContextPath();%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>用户详情</title>
	<jsp:include page="/inc/common.jsp" />
	
<style type="text/css">
    html{overflow-x:hidden; width:100%;}
</style>

</head>
<body> 
<div class="w001">
<form id="frm" name="frm" method="post" action="<%=path %>/admin/user/detail.do" target="_parent">
<input type="hidden" name="sysUserVO.id" id="id" value="${sysUserVO.id}" />
<s:token />

<table width="100%" border="0" cellpadding="0" cellspacing="1" class="yanshi_newu2">

<tr>
    <td align="center" width="80px">账号</td>
	<td class="shurukang_abv" width="310px">
		<div class="geinputleft3">
		<div class="geinputright">
		<div class="geinputmid3">
		    <input type="text" name="sysUserVO.userCode" id="userCode" value="${sysUserVO.userCode}" readonly="true"/> 
		</div>
		</div>
		</div>
	</td>
	<td>&nbsp;<span class="required">*</span></td>
</tr>


<tr>
    <td align="center" width="80px">用户名称</td>
	<td class="shurukang_abv" width="310px">
		<div class="geinputleft3">
		<div class="geinputright">
		<div class="geinputmid3">
		    <input type="text" name="sysUserVO.userName" id="userName" value="${sysUserVO.userName}" readonly="true"/> 
		</div>
		</div>
		</div>
	</td>
	<td>&nbsp;<span class="required">*</span></td>
</tr>


<tr>
	<td align="left" >&nbsp;&nbsp;状态&nbsp;</td>
	    <td class="shurukang_abv" >
              <div class="geinputleft">
                  <div class="geinputright">
                      <div class="geinputmid">
					<select id="state" name="sysUserVO.state" class="yanshiselect" readonly="true">
					    <option value="0" <c:if test="${sysUserVO.state == '0'}"> selected="selected" </c:if> >正常</option>
					    <option value="1" <c:if test="${sysUserVO.state == '1'}"> selected="selected" </c:if> >注销</option>
					</select>
		        </div>
		    </div>
		</div>
	    </td>
	    <td>&nbsp;</td>
</tr>



<tr>
    <td align="center" width="80px">邮箱</td>
	<td class="shurukang_abv" width="310px">
		<div class="geinputleft3">
		<div class="geinputright">
		<div class="geinputmid3">
		    <input type="text" name="sysUserVO.email" id="email" value="${sysUserVO.email}" readonly="true"/> 
		</div>
		</div>
		</div>
	</td>
	<td>&nbsp;</td>
</tr>

 

<tr>
    <td align="center" width="80px">电话</td>
	<td class="shurukang_abv" width="310px">
		<div class="geinputleft3">
		<div class="geinputright">
		<div class="geinputmid3">
		    <input type="text" name="sysUserVO.phone" id="phone" value="${sysUserVO.phone}" readonly="true"/> 
		</div>
		</div>
		</div>
	</td>
	<td>&nbsp;</td>
</tr>
 
</table>

<br />
<table width="100%" border="0" cellpadding="0" cellspacing="0" >
     <tr>
    	<td align="center" ><div class="generalbtt"><a id="generaltse"; href="javascript:closeDialog();" >退出</a></div></td>
    </tr>
</table>

</form>
</div>
 <jsp:include page="/inc/dialog.jsp" />
</body>
</html>


<script type="text/javascript">
	// 关闭窗口
	function closeDialog() {
	    window.parent.innerWindowClose();
	}
</script>


