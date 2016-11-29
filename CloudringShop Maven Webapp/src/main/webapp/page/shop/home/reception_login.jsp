<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="cloud.shop.common.Constants" %>
<%@page import="cloud.shop.goods.entity.Customer" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>会员登录 </title>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<link href="<%=path%>/css/default/login.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<%=path%>/js/jquery.min.js"></script>
<script type="text/javascript" src="<%=path%>/js/shop/jquery.validate.js"></script>
<script type="text/javascript" src="<%=path%>/js/jQuery.md5.js"></script>
<script type="text/javascript" src="<%=path%>/js/shop/common.js"></script>
<script type="text/javascript" src="<%=path%>/js/placeholder.js"></script>
<script>var contextPath = "${pageContext.request.contextPath}";</script>
<script type="text/javascript">
$().ready(function() {

	var $loginForm = $("#loginForm");
	var $username = $("#username");
	var $password = $("#password");	
	
	var $submit = $("input:submit");
	
	 // 表单验证、记住用户名
	$loginForm.validate({
		rules: {
			username: "required",
			password: "required"
		},
		submitHandler: function(form) {
				
			var enPassword = $.md5($password.val());
			$.ajax({
				url: $loginForm.attr("action"),
				type: "post",
				data: {
					username: $username.val(),
					enPassword: enPassword
				},
				dataType: "json",
				cache: false,
				beforeSend: function() {
					$submit.prop("disabled", true);
				},
				success: function(message) {
				   var msg=eval(message);
					$submit.prop("disabled", false);
					if (msg.type == "success") {
								location.href = contextPath+"/home/showShopIndex.do";
					} else {
					
					 var span=$("#error_tip"); 
					 var error=$("#error");
					  error.empty();
					  span.css("display","block");						 
					    if(msg.error=="1")
					    {
					      error.text("用户名不对");
					      document.getElementById("username").focus(); 
					      
					    }else if(msg.error=="2")
					    {
					    error.text("密码错误");
					     document.getElementById("password").focus(); 
					     
					    }
					}
				},
				error:function(message){
				   alert(msg.error);
				}
			});
			
		}
	}); 

});
</script>
</head>
<body>
<div class="login">
    	<div class="l-content">
        	<div id="logo" class="logo">
            	<a href="javascript:void(0)">
                	<img src="<%=path%>/images/default/cioudring.png" alt="logo" />
                </a>
            </div>
            <h1 class="login-title">
            	<span id="message_login_title">Cloudring账号登录</span>
            </h1>
            <div id="login-display">
            	
            </div>
            <div class="form-container">
            	<div class="login-area" id="login_area">
                	<form id="loginForm"  action="<%=path%>/login/login.do" method="post">
                    	<div class="shake-area" id="shake_area">
                        	<div id="enter_user" class="enter-area">
                        	  <input type="text" id="username" name="username" class="enter-item" maxlength="200"  autocomplete="off" placeholder="手机号码/智慧账号"/>
                                
                            </div>
                            <div class="enter-area">
                                 <input type="password" id="password" name="password" class="enter-item" maxlength="200" autocomplete="off" placeholder="密码"/>                           	
                                
                            </div>
                        </div>
                        <div  class="error-tip" id="error_tip">
                         	<em class="error-ico"></em>
                             <span class="error-msg" id="error">&nbsp;</span>
                      </div>
                        <input type="submit" value="立即登录" id="submit" class="button orange"/>
                        <div class="forget clearfix">
                        	<div class="link-area">
                                <a id="forget_pwd" href="<%=path %>/password/find.do">忘记密码?</a>
                                <div id="third_area" class="button hide"><a href="<%=path %>/register/showShopRegister.do">注册智慧账号</a></div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>            
        </div>
        <div class="footer">
            <div class="footer-w">
                <p>©2003-2015&nbsp;Cloudring&nbsp;版权所有
                    <a href="javascipt:void(0)">克劳德菱官网</a>
                    粤ICP备11064129号-2    
                </p>
            </div>
        </div>        
    </div>
	<script>
    $(function(){
        $('.enter-item').placeholder();
    })
    </script>
</body>
</html>
