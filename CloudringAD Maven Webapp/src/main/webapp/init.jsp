<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<!DOCTYPE html>

<%
    String path = request.getContextPath();
%>

<html lang="utf-8">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="<%=path%>/css/common-old.css" rel="stylesheet">

<script type="text/javascript" src="<%=path%>/js/jquery.min.js"></script>
<script type="text/javascript" src="<%=path%>/js/jquery.json-2.2.js"></script>
<script type="text/javascript" src="<%=path%>/js/jquery.md5.js"></script>
<script type="text/javascript" src="<%=path%>/js/jquery.cookie.js"></script>

<script type="text/javascript" src="<%=path%>/js/bootstrap.min.js"></script>
<script type="text/javascript" src="<%=path%>/js/placeholder.js"></script>
 <script src="<%=path %>/layer/layer.js"></script>

<script type="text/javascript">
	if(top != self) {  
        if(top.location != self.location) {
            top.location = self.location;  
        }  
    } 
</script>


<style type="text/css">
a.green:hover, a.green:active {
    color: #F60;
}

.wrap-verify {
    float: left;
    position: relative;
    display: inline-block;
    vertical-align: top;
    margin-right: 15px;
}

.wrap-verify s {
    position: absolute;
    right: 10px;
    top: 10px;
    display: none;
    width: 16px;
    height: 16px;
    background: transparent url("<%=path%>/images/login/ico-success-s.png") no-repeat scroll 0% 0%;
}

.wrap-verify .error {
    background: transparent url("<%=path%>/images/login/ico-error-s.png") no-repeat scroll 0% 0%;
}

.layer_boxs_upload .upload_box .upload_btn2 {
    background-position: -31px -126px;
    display: inline-block;
    float: left;
    height: 35px;
    margin-left: 10px;
    width: 70px;
}

</style>


<title>登录-广告系统</title>
</head>

<body>
    <div class="top">
    	<div class="logo">
    	    <img alt="logo" src="<%=path%>/images/login/cloudring.png">
        </div>
    </div>
    <div class="login">
    	<div class="login-sider">
        	<img alt="logo" src="<%=path%>/images/login/loginLeft.png">
        </div>
        <div class="login-main">
        	<form id="loginForm" name="loginForm" method="post" enctype="multipart/form-data">
            	<p>
                	<label for="name">用户代码</label>
                    <input type="text" name="name" id="name" class="inp-01">
                </p>
                <p>
                	<label for="password1">密码</label>
                    <input type="password" name="pwd" id="password1" class="inp-01">
                    <input type="hidden" id="password" name= "password" />
                </p>
                
                <p>
                	<label for="passcode">验证码</label>
                    
                    <span class="wrap-verify">
                        <input id="passcode" name="passcode" class="inp-01 code" maxlength="4" value="" autocomplete="off"  type="text"  placeholder="验证码">
					    <s></s>
					</span>
					
                    <input type="hidden" id="yzCode_verify_flag" name= "yzCode_verify_flag" />
                    
                     <img id="codeimg" src="<%=path%>/RandImage" alt="验证码" class="l" onclick="reload();return false;" height="30" width="70">
                </p>
                
                
                <div class="clearfix"></div>
                <p class="c-box">
                    <!-- <input id="cookieslogin" name="cookieslogin" value="1" checked="checked" autocomplete="off" type="checkbox"> -->
                </p>
                <p><input type="button" value="登录" class="login-btn" id="dlBtn" name="login"></p>
                <!-- <p><a href="javascript:void(0)">忘记密码?</a></p> -->
            </form>
        </div>
    </div>
    <div class="footer">
    	<div class="footer-w">
        	<p>©2003-2016&nbsp;Cloudring&nbsp;版权所有
            	<a href="http://www.cloudring.net">克劳德菱官网</a>
            	粤ICP备11064129号-2    
            </p>
        </div>
    </div>
<script>
$(function(){
	$('.inp-01').focus(function(){
		$(this).addClass('focus');
	}).blur(function(){
		$(this).removeClass('focus');
	});
	$('.inp-01').placeholder();
});
</script>

<script>

$(document).ready(function(){
	$("#passcode").keyup(function(e){
		 var $keyCode=e.keyCode;
		 $("s").css("display","none");
		  var passcode = $("#passcode").val();
		  var upper = passcode.toUpperCase();
		 
		  var len = passcode.length;
		  if(len == 4){
			  $.ajax({
	       			url: "<%=path %>/sys/ajaxVerifyYzCode.do?passcode="+passcode,
	       		 	type: "GET",
	       		 	cache:false,
	       		 	async:true,
	       		 	dataType: "json",
	       		    success:function(jsonData, textStatus) {
	    				if(jsonData.success == 'true'){ 
	    					$("s").removeClass("error");	    					
	    					$("s").css("display","inline");
	    					$("s").addClass("");
	    					$("#yzCode_verify_flag").val("true");
	    				}else if(jsonData.success == 'false'){
	    					$("s").css("display","inline");
	    					$("s").addClass("error");
	    					$("#yzCode_verify_flag").val("false");
	    				}
	    	   		},
	    	   		error:function(textStatus, errorThrown){
	    	   			layer.alert('系统ajax交互错误: ' + errorThrown, {icon:5,title:'提示'});
	    	   		}
	            });
		  }
		  if($keyCode>=37 && $keyCode<=40){
		  	return false;
		  }  
		  $("#passcode").val(upper); 
	});
	
	//键盘点击Enter键提交页面
	$(document).keydown(function(event) {
		if (event.keyCode == 13) {
			$("#dlBtn").click();
		};
	});
	
    $("#dlBtn").click(function(){
    	var name = $("#name").val();
    	if (name == "" || name == null) {
    		layer.alert('用户代码不能为空.', {icon:5,title:'提示'});
    		$("#name").focus();
    		return false;
    	};
    	
    	var tempPassword = $("#password1").val();
    	if (tempPassword.length < 6 || tempPassword.length > 20) {
     	    layer.alert('密码长度为6到20位字母数字下划线等组成！', {icon:5,title:'提示'});
     	   	$("#password1").focus();
    		return false;
    	};
    	var r = /^[\w\_\,\.]{6,20}$/;
		if (!r.test(tempPassword)) {
    		layer.alert('密码格式输入不正确！', {icon:5,title:'提示'});
    		$("#password1").focus();
    		return false;
    	}
    	if (tempPassword == "" || tempPassword == null) {
    		layer.alert('密码不能为空.', {icon:5,title:'提示'});
    		$("#password1").focus();
    		return false;
    	}
    	
    	var yzCode_verify_flag = $("#yzCode_verify_flag").val();
		if(yzCode_verify_flag == null || yzCode_verify_flag == undefined || yzCode_verify_flag == '' || yzCode_verify_flag == 'false' ){
			layer.alert('请输入正确的验证码', {icon:5,title:'提示'});
			$("#passcode").focus();
			return false;
		}
		
		var temp = $.md5(tempPassword);
		$("#password").val(temp);

		$.ajax({
   			url: "<%=path %>/sys/login.do",
   		 	type: "POST",
   		 	cache:false,
   		 	async:true,
   		 	dataType: "json",
   		    data: {"name":name, "password":temp},
   		    success:function(jsonData, textStatus) {
   		    	if(jsonData.success == 'true'){
					var _expires = 1;
					if($("#cookieslogin").is(':checked')){
						_expires = 30;
					}
					//$.cookie('cloudring_login_username', name, {expires: _expires, path: '/'});
					//$.cookie('cloudring_login_password', temp, {expires: _expires, path: '/'});
					//$.cookie('cloudring_login_id', jsonData.id, {expires: _expires, path: '/'});
					//$.cookie('cloudring_isLogin', "1", {expires: 1, path: '/'});
					
					refurbish();
				}else if(jsonData.success == 'none'){
					layer.alert('用户代码或密码错误.', {icon:5,title:'提示'});
					$("#name").focus();
				}else{
					layer.alert('登录失败.', {icon:5,title:'提示'});
				};
	   		},
	   		error:function(textStatus, errorThrown){
	   			layer.alert('系统ajax交互错误: ' + textStatus, {icon:5,title:'提示'});
	   		}
        });
		
    });
    
    
    
});

function reload() {
    var verifyCodeImageUrl = '<%=path%>/RandImage?';
	$("#codeimg").attr("src", verifyCodeImageUrl + (new Date()).getTime());
   // $('#passcode').val('').focus().next().hide();
}

function wjmm(){
	window.location.href='<%=path%>/sys/loginInit.do';
}

String.prototype.Trim = function() {
	return this.replace(/(^\s*)|(\s*$)/g, ""); 
}

//刷新当前页面(ajax返回时候)
function refurbish(){	
	window.location.href='<%=path%>/hs/index.do';
};
</script>


</body>


</html>