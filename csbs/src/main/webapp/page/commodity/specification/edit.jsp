<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/tlds/c.tld" prefix="c"%>
<%@ taglib uri="/WEB-INF/tlds/fmt.tld" prefix="fmt"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>管理中心——Cloudring Shop</title>
<meta content="Cloudring" name="author">
<meta content="Cloudring" name="copyright">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/deafult/common.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/deafult/main.css">
<script type="text/javascript" src="<%=path%>/js/jquery.min.js"></script>
<script type="text/javascript" src="<%=path%>/js/jquery.validate.js"></script>
<script type="text/javascript">
$().ready(function() {
    var $inputForm = $("#inputForm");
	var $addOptionButton = $("#addOptionButton");
	var $optionTable = $("#optionTable");
	
	
	// 增加可选项
	$addOptionButton.click(function() {
		$optionTable.append(
'<tr> <td> <input type="text" name="options" class="text" maxlength="200" \/> <\/td> <td> <a href="javascript:;" class="remove">[删除]<\/a> <\/td> <\/tr>'		);
	});
	
	// 删除可选项
	$optionTable.on("click", "a.remove", function() {
		if ($optionTable.find("tr").size() <= 2) {
			alert("删除失败，必须至少保留一项");
			return false;
		}
		$(this).closest("tr").remove();
	});
	
	// 表单验证
	 $.validator.setDefaults({      
        submitHandler: function(form) { 
           $(form).find("input:submit").prop("disabled", true);   
            form.submit();   
       }
    }),
	// 表单验证
	$inputForm.validate({
		rules: {
			productCategoryId: "required",
			group_name: "required",
			order_value: "digits",
			options: "required"
		}
	});


});
</script>
</head>

<body>
<div class="breadcrumb"><a href="<%=path%>/index.jsp">首页</a>&raquo;&nbsp;编辑规格</div>
<form id="inputForm"  method="post" action="<%=path%>/admin/specification/edit.do">
<input type="hidden" name="id" id="id" value="${spec.id}"/>
	<table class="input">
    	<tr>
        	<th>绑定分类:</th>
            <td>
            	<select name="productCategoryId">
                	<c:forEach items="${category}" var="it" varStatus="st">
                           <c:choose>
                             <c:when test="${it.id==spec.id}"> <option value="${it.id}" selected="selected">${it.category_name}</option></c:when>
                             <c:otherwise><option value="${it.id}">${it.category_name}</option></c:otherwise>
                           </c:choose>
                	 
                	</c:forEach>
                </select>
            </td>
        </tr>
        <tr>
        	<th><span class="requiredField">*</span>名称:</th>
            <td><input type="text" name="group_name" class="text" value="${spec.group_name}" maxlength="200"></td>
        </tr>
        <tr>
        	<th>排序:</th>
            <td><input type="text" name="order_value" class="text" value="${spec.order_value}" maxlength="9"></td>
        </tr>
        <tr>
        	<th>&nbsp;</th>
            <td><a id="addOptionButton" class="button" href="javascript:;">增加可选项</a></td>
        </tr>
        <tr>
        	<th>&nbsp;</th>
            <td>
            	<table id="optionTable" class="item">
                	<tr>
                    	<th>可选项</th>
                        <th>操作</th>
                    </tr>
                    <c:forEach items="${spec.options}" var="it" varStatus="st">
                    <tr>
                    	<td>
                        	<input type="text" name="options" class="text" value="${it}" maxlength="200">
                        </td>
                        <td>
                        	<a class="remove" href="javascript:;">[删除]</a>
                        </td>
                    </tr>
                    </c:forEach>
                </table>
            </td>
        </tr>
        <tr>
        	<th>&nbsp;</th>
            <td>
            	<input type="submit" class="button" value="确 定">
                <input type="button" class="button" value="返 回" onClick="history.back();return false;">
            </td>
        </tr>
    </table>
</form>

</body>
</html>
