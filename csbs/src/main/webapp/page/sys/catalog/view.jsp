<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!-- admin/catalog/view.jsp by hy -->
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<jsp:include page="/inc/common.jsp" />
<script language="javascript">
// 取消
function closeDialog() {
    window.parent.innerWindowClose();
}
</script>
</head>

<body>
	<div class="listinfo2">
		<form id="frm" name="frm" method="post" >
			<div class="tablelist">
    			<table border="0" cellpadding="0" cellspacing="0"  style="width:100%;table-layout:fixed;">
			    	<thead>
			     		<tr>
			      			<th width="17%" scope="row">字典分类代码</th>
			      			<td width="83%">${catalog.pkid }</td>
			   			 </tr>
			   		</thead>
			    	<tbody>
			    		<tr>
			      			<th width="17%" scope="row">字典分类名</th>
			      			<td width="83%">${catalog.catalogName }</td>
			    		</tr>
			    	</tbody>
					<thead>
			     		<tr>
			      			<th width="17%" scope="row">说明</th>
			      			<td width="83%"><textarea id="note" name="catalog.note" rows="4" cols="60" readonly>${catalog.note }</textarea></td>
			   			 </tr>
			   		</thead>
    			</table>
      		 </div>
		</form>
	</div>
 	<table align="center">
        <tr>
			<td align="center"><div class="generalbtt"><a id="generaltse"; href="javascript:closeDialog();" >关闭</a></div></td>
        </tr>
   </table>
</body>
</html>
