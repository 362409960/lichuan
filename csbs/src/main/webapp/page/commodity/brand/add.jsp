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
<script type="text/javascript" src="<%=path%>/js/common.js"></script>
<script type="text/javascript" src="<%=path%>/js/sys/jquery.validate.js"></script>
<script type="text/javascript" src="<%=path%>/ckeditor/ckeditor.js"></script>
<script type="text/javascript">
$().ready(function() {
	var $inputForm = $("#inputForm");
	var $type = $("#type");
	var $logo = $("#file");
	
	$type.change(function() {
		if ($(this).val() == "text") {
			$logo.prop("disabled", true).closest("tr").hide();
		} else {
			$logo.prop("disabled", false).closest("tr").show();
		}
	});
	
	// 表单验证
	 $.validator.setDefaults({      
        submitHandler: function(form) { 
           $(form).find("input:submit").prop("disabled", true);   
            form.submit();   
       }
    }),
	$inputForm.validate({
		rules: {
			brand_name: "required",
			file: "required",
			url: {
				pattern: /^(http:\/\/|https:\/\/|ftp:\/\/|mailto:|\/|#).*$/i
			},
			order_value: "digits"
		}
	});

});
</script>

</head>

<body>
<div class="breadcrumb"><a href="<%=path%>/index.jsp">首页</a>&raquo;&nbsp;添加品牌</div>
<form id="inputForm"  method="post" action="<%=path%>/admin/band/save.do" enctype="multipart/form-data">
	<table class="input">
    	<tr>
        	<th><span class="requiredField">*</span>名称：</th>
            <td><input type="text" name="brand_name" class="text" maxlength="200"></td>
        </tr>
        <tr>
        	<th>类型：</th>
            <td>
            	<select id="type" name="type">
                	<option value="text">文本</option>
                    <option value="image">图片</option>
                </select>
            </td>
        </tr>
        <tr class="hidden">
				<th>
					logo:
				</th>
				<td>
					<span class="fieldSet">
						<!-- <input type="text" id="logo" name="logo" class="text" maxlength="200" disabled="disabled" /> -->
						 <input type="file" name=file accept="image/*" id="file" size="30" />
						<!-- <a href="javascript:;" id="filePicker" class="button">选择文件</a> -->
					</span>
				</td>
			</tr>
        
      	<tr>
        	<th>网址：</th>
            <td><input type="text" name="url" class="text" maxlength="200"></td>
        </tr>  
        <tr>
        	<th>排序：</th>
            <td><input type="text" name="order_value" class="text" value="" maxlength="9"></td>
        </tr>
        <tr>
        	<th>介绍：</th>
            <td>
            	<textarea id="introduction" name="introduction" class="editor"></textarea>            
				 <script>
				     CKEDITOR.replace( 'introduction' );
				  </script>
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

