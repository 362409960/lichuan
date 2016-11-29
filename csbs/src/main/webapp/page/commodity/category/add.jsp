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
<script>var contextPath = "${pageContext.request.contextPath}";</script>
<style type="text/css">
.brands label,.promotions label{
	display:block;
	float:left;
	width:150px;
	padding-right:6px;
}
</style>
<script type="text/javascript">
$().ready(function() {
	var $inputForm = $("#inputForm");
	// 表单验证
	 $.validator.setDefaults({      
        submitHandler: function(form) { 
           $(form).find("input:submit").prop("disabled", true);   
            form.submit();   
       }
    }),
	$inputForm.validate({
		rules: {
			category_name: {
				required: true,						
				remote: {
					url:contextPath+ "/admin/category/checkNname.do",
					cache: false
				} 
			},			
			order_value: "digits"
		},
		messages: {
			category_name: {
				remote: "名称重复，请重新输入。"
			}
		}
	});

});
</script>
</head>

<body>
<div class="breadcrumb"><a href="<%=path%>/index.jsp">首页</a>&raquo;&nbsp;编辑商品分类</div>
<form id="inputForm"  method="post" action="<%=path%>/admin/category/save.do">
	<table class="input">
    	<tr>
        	<th><span class="requiredField">*</span>名称:</th>
            <td><input type="text" id="category_name" name="category_name" class="text"  maxlength="200"></td>
        </tr>
        <tr>
        	<th>上级分类:</th>
            <td>
            	<select name="parent_id">
                	<option value="">顶级分类</option>
                	<c:forEach items="${category}" var="it" varStatus="st">
                	  <option value="${it.id}">${it.category_name}</option>
                	</c:forEach>
                </select>
            </td>
        </tr>
        <tr class="brands">
        	<th>关联品牌:</th>
            <td>
               <c:forEach items="${bMap}" var="m" varStatus="s">
            	<label>
                	<input type="checkbox" name="brandIds" value="${m.key}">${m.value}
                </label>
                </c:forEach>
            </td>
        </tr>
        <tr class="promotions">
        	<th>关联促销:</th>
            <td>
            	<label title="xx">
                	<input type="checkbox" name="promotions" value="1" >满减促销
                </label>
                <label title="xx">
                	<input type="checkbox" name="promotions" value="2">折扣促销
                </label>
                <label title="xx">
                	<input type="checkbox" name="promotions" value="3">返券促销
                </label>
            </td>
        </tr>        
        <tr>
        	<th>页面关键词:</th>
            <td>
            	<input type="text" name="metaKeywords" class="text" value="" maxlength="200">
            </td>
        </tr>
        <tr>
        	<th>页面描述:</th>
            <td>
            	<input type="text" name="metaDescription" class="text" value="" maxlength="200">
            </td>
        </tr>
        <tr>
        	<th>排序:</th>
            <td>
            	<input type="text" name="order_value" class="text" value="" maxlength="9">
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

