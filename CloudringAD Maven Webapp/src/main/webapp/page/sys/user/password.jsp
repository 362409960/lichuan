<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<% 
    String path = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta charset="utf-8">
<title>密码修改</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta content="" name="description">
<meta content="" name="keywords">
<meta content="Cloudring" name="author">
<meta content="Cloudring" name="copyright">
<link rel="shortcut icon" href="<%=request.getContextPath()%>/images/icon/icon.png"/>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common.js"></script>
<script type="text/javascript"  src="<%=path%>/layer/layer.js"></script>
<style type="text/css">
html,body{
	height:100%;
	width:100%;
	overflow:auto;
}
</style>
<script type="text/javascript">
	function updatePwd(){
		var id = $("[name='id']").val();
		var oldPassword = $("[name='oldPassword']").val();
		var password = $("[name='password']").val();
		var newsPwd = $("[name='newsPwd']").val();
		var r = /^[\w\_\,\.]{6,20}$/;
		
		if(oldPassword==""){
			layerAlter("提示","请输入旧密码！");
			return false;
		}
		if(password==""){
			layerAlter("提示","请输入新密码！");
			return false;
		}
		if(newsPwd == ""){
			layerAlter("提示","请再次输入新密码！");
			return false;
		}
		if(password!=newsPwd){
			layerAlter("提示","两次输入的密码不一致！");
			return false;
		}
		if (oldPassword.length < 6 || oldPassword.length > 20) {
     	   	layerAlter("提示","密码长度为6到20位字母数字下划线等组成！");
    		return false;
    	}
		if (!r.test(oldPassword)) {
    		layerAlter("提示","密码格式输入不正确！");
    		return false;
    	}
		if (password.length < 6 || password.length > 20) {
     	   	layerAlter("提示","密码长度为6到20位字母数字下划线等组成！");
    		return false;
    	}
		if (!r.test(password)) {
    		layerAlter("提示","密码格式输入不正确！");
    		return false;
    	}
		if (newsPwd.length < 6 || newsPwd.length > 20) {
     	   	layerAlter("提示","新密码长度为6到20位字母数字下划线等组成！");
    		return false;
    	}
		if (!r.test(newsPwd)) {
    		layerAlter("提示","新密码格式输入不正确！");
    		return false;
    	}
		
		$.ajax({
			url: "<%=path%>/admin/user/updatPwd.do?t=" + Math.random()+"&id="+id+"&newsPwd="+newsPwd+"&oldPassword="+oldPassword,
			type: "POST",
			cache:false,
			async:true,
			dataType: "json",
	        success: function(data){
	        	if(data=="true"){
	        		layer.alert('修改成功！', {icon:1,title:'提示'},function(index){
	        			window.close();
	        		});
				}else{
					layerAlter("提示","修改密码失败！");
				}
	        },
			error:function(){
	            layerAlter("提示","获取数据出现异常！");
	        }
		});
	}
    
</script>

</head>

<body>
	<table class="detailTable">
		<tr>
        	<td>输入旧密码:</td>
            <td>
            	<input type="hidden" id="id" name="id" value="${id }" />
            	<input type="password" id="oldPassword" name="oldPassword" />
            </td>
        </tr>
        <tr>
        	<td>输入新密码:</td>
            <td>
            	<input type="password" id="password" name="password" />
            </td>
        </tr>
        <tr>
            <td>确认新密码:</td>
            <td>
            	<input type="password" id="newsPwd" name="newsPwd" />
            </td>
        </tr>
        <tr>
        	<td colspan="2">
            	<input type="button" value="提交" onclick="updatePwd();" />
            </td>
         </tr>
     </table>
</body>
</html>
