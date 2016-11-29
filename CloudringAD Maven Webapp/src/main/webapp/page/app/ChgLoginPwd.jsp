<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="/WEB-INF/tlds/c.tld" prefix="c"%>
<%	
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"+ request.getServerName() + ":" + request.getServerPort()+ path + "/";
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
	<link rel="stylesheet" type="text/css" href="../../css/easyui.css">
	<link rel="stylesheet" type="text/css" href="../../css/icon.css">
	<link rel="stylesheet" type="text/css" href="../../css/demo.css">
	<script type="text/javascript" src="../../js/jquery.min.js"></script>
	<script type="text/javascript" src="../../js/jquery.easyui.min.js"></script>
	<link href="../../css/main.css" rel="stylesheet" type="text/css" />
</head>

<body>
<div id="right_top">
  	<div id="loginout">
    	<div id="loginoutimg"><img src="../../images/loginout.gif" /></div>
    	<span class="logintext">退出系统</span>	 
  	</div>
</div>
<div id="right_font">
  	<img src="../../images/main_14.gif"/> 您现在所在的位置：首页 → 应用功能 → 
  	<span class="bfont">更改密码</span>
</div>
<div style="margin:20px 0;" align="center"></div>
 	<div id="tb" align="center" style="width:80%; margin-bottom:10px">
    <form id="modifyPwdForm" method="post">
    	<table class="tableForm">
	    	<tr>
			    <th>原密码</th>
			    <td><input name="password" type="password" value="${user.password}" class="easyui-validatebox" required missingMessage="必须输入原密码" /></td>
			</tr>
			<tr>
			    <th>新密码</th>
			    <td><input name="newpwd" id="newpwd" type="password" class="easyui-validatebox" required missingMessage="请填写新密码" /></td>
			</tr>
			<tr>
			    <th>重复</th>
			    <td><input name="recpwd" id="recpwd" type="password" class="easyui-validatebox" required="true" missingMessage="请再次填写新密码" validType="eqPassword['#newpwd']" /></td>
			</tr>
			<tr>
			    <td align="center">
			    	<input name="btn" type="submit" class="easyui-button" value="修改"/>
			    </td>
			</tr>
		</table>
    </form>
</div>
<script language="javascript">
	var contextPath = "${pageContext.request.contextPath}";
	$.extend($.fn.validatebox.defaults.rules, { 
	    eqPassword : {
		    validator : function(value, param) {
			    return $(param[0]).val() == value;
		    },
			message : '两次输入的密码不一致！'
		}
	});

	//登陆按钮点击事件
	$("form").submit(function () {
	    //if (checkUserName() && checkPassword() && ok_validate_code){
	    $.ajax({
	        type: "post",
	        url: contextPath + "/user/updPwd.do",
	        data:{newpwd:$("#newpwd").val()},
	        success: function (data) {
	        	if(data){
	        		$.messager.alert('提示框','修改成功','info');
	        		alert("修改成功！");
	        		return true;
	        	}else{
	        		$.messager.alert('提示框','修改失败','info');
	        		alert("修改失败！");
	        		return false;
	        	}
	        },
	        error: function (XMLHttpRequest, textStatus,errorThrown) {
	            alert(errorThrown);
	            return false;
	        }
	    });
	     // }
	   // return false;
 	});
// 	var password = $("#recpwd").val();
// 	$('form').form('submit',{
//         url: contextPath + "/user/updPwd.do",
//         success: function(result){
//          	alert(data);
//         	alert("修改成功！");
//         	return true;
//        	}
//     });

</script>
</body>
</html>
