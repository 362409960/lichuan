<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/tlds/c.tld" prefix="c"%>
<%@ taglib uri="/WEB-INF/tlds/fmt.tld" prefix="fmt"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta charset="utf-8">
<title>文本文件管理器</title>
<link rel="stylesheet" type="text/css" href="<%=path %>/js/common.js">
<style>
.tree
{
	table-layout: fixed;
	border-collapse: collapse;
	width:800px;
}
.tree td
{
	max-width:400px;
	overflow: hidden;
	border: 1px solid #fddfee;
	padding-right: 10px;
}
.tree td span
{
	display: inline-block;
	white-space: nowrap;
	overflow: hidden; 
	text-overflow: ellipsis;
}
</style>
</head>

<body>
	<form name="form1" method="post" action="<%=path %>/terminalInfo/firnware_list.do" id="form1">
	<input type="hidden" id="filePath" name="filePath" value="${parentPath }">
        <table border="0" cellspacing="0" style="font-size:14px;">
            <tbody>
                <tr>
                    <td height="25" style="padding-left:15px;">
                        当前路径:
                        <span id="Label2">${absolutePath }</span>
                   </td>
                   <td>
                        <span style="color: crimson; float: right;"><strong></strong>
                        <input type="image" name="ImageButton1" id="ImageButton1" onclick="submit()" title="返回上一层" src="<%=path %>/images/icon/back.ico" style="height:32px;width:32px;border-width:0px;"></span>
                  </td>
               </tr>
               <tr>
                  <td colspan="2" style="height: 65px">
                    <div style="overflow-x:hidden; overflow-y:auto; width:890px; height:315px; text-align:center; font-size:14px">
                        <table id="Table1" class="tree" border="0">
                            <tbody>
                                <tr>
                                    <td style="background-color:Aqua;width:300px;">文件名称</td>
                                    <td style="background-color:Aqua;width:100px;">类型</td>
                                    <td style="background-color:Aqua;width:100px;">文件大小</td>
                                    <td style="background-color:Aqua;width:200px;">发布时间</td>
                                    <td style="background-color:Aqua;width:100px;">操作</td>
                                </tr>
                                <c:forEach items="${firnwareFiles }" var="firnwareFile">
	                                <tr>
	                                    
	                                    <c:if test="${firnwareFile.isFile == 1 }">
		                                    <td class="tdfileName">
		                                        <span title="${firnwareFile.fileName }">${firnwareFile.fileName }</span>
		                                    </td>
	                                    	<td>${firnwareFile.fileSuffixname }</td>
	                                    	<td align="right">${firnwareFile.fileSize }KB</td>
	                                    	<td><fmt:formatDate value="${firnwareFile.fileUpdateTime }" pattern="yyyy-MM-dd HH:mm"/></td>
	                                    	<td><a href="javascript:void(0)" onclick="select(this)">选择</a></td>
	                                    </c:if>
	                                    <c:if test="${firnwareFile.isFile == 0 }">
	                                    	<td class="tdfileName">
		                                        <span title="${firnwareFile.fileName }"><a href="javascript:void(0)" onclick="findFile('${firnwareFile.absolutePath}')">${firnwareFile.fileName }</a></span>
		                                    </td>
	                                    	<td>文件夹</td>
	                                    	<td align="right"></td>
	                                    	<td><fmt:formatDate value="${firnwareFile.fileUpdateTime }" pattern="yyyy-MM-dd HH:mm"/></td>
	                                    	<td></td>
	                                    </c:if>
	                                </tr>
                                </c:forEach>
                        </tbody>
                    </table>
                </div>
            </td>
         </tr>
      </tbody>
   </table>
  </form>
 <script src="<%=path %>/js/jquery.js"></script>
 <script src="<%=path %>/layer/layer.js"></script>
 <script type="text/javascript">
 	function select(obj){
		var fileName=$.trim($(obj).parents('tr').children('td').eq(0).text());
		var pathName=$.trim($('#Label2').text());
		var oInput= parent.document.getElementById('file_name');
		oInput.value=pathName+'\\'+fileName;
		 var index = parent.layer.getFrameIndex(window.name);
          parent.layer.close(index);
	};
	function submit(){
		if(obj != null){
			alert(obj);
		}
		$("#form1").submit();
	}
	function findFile(path){
		$("#filePath").val(path);
		$("#form1").submit();
	}
 </script>
</body>
</html>
