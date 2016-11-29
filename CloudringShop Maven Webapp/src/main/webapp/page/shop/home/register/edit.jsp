<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>


<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>会员注册 </title>
<link href="<%=path %>/css/common.css" rel="stylesheet" type="text/css" />
<link href="<%=path %>/css/default/register.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<%=path %>/js/jquery.min.js"></script>
<script type="text/javascript" src="<%=path %>/js/jquery.validate.js"></script>
<script type="text/javascript" src="<%=path %>/js/common.js"></script>
<script type="text/javascript" src="<%=path %>/js/placeholder.js"></script> 
<script>var contextPath = "${pageContext.request.contextPath}";</script>
<script type="text/javascript">

$().ready(function() { 
    var $registerForm = $("#registerForm");	
	 $.validator.setDefaults({      
        submitHandler: function(form) {   
            form.submit();   
       }
    }),
	$registerForm.validate({		
		rules: {
			password: {
				required: true,
				minlength: 6
			},
			rePassword: {
				required: true,
				equalTo: "#password"
			},
			
		}
	});
});


</script>
</head>
<body>
<div class="reg bugfix_ie6">
	<div class="logo-area clearfix">
    	<a href="javascript:void(0);" class="fl"><img src="../images/default/logo.png" alt=""/></a>
    </div>
</div>
<div class="reg">
	<div id="main_container" class="reg-frame">
    	<div class="reg-title">
        	<h4 class="title-big">注册智慧帐号</h4>
        </div>
        <div>
        <form id="registerForm" action="<%=path %>/register/submit.do" method="post">
         <input type="hidden" id="mobile" name="mobile" value="${mobile}"/>
        	<div class="regbox">
            	<div class="reg-step">
                    <div class="inputbg">
                    	<label class="labelbox" for="">
                        	<input type="password" id="password" name="password" class="text" maxlength="20" autocomplete="off" placeholder="请输入新密码" />
                        </label>
                    </div>
                    <div class="err-tip">
                    	<div class="err-box">
                        	<em class="icon-error"></em>
                            <span>请输入手机号码</span>
                        </div>
                    </div>   
                    <div class="inputbg">
                    	<label class="labelbox" for="">
                        	<input type="password" name="rePassword" class="text" maxlength="20" autocomplete="off" placeholder="请再次输入新密码 " />
                        </label>
                    </div>
                    <div class="err-tip">
                    	<div class="err-box">
                        	<em class="icon-error"></em>
                            <span>请输入手机号码</span>
                        </div>
                    </div>                
                    
                    <div class="fixed-reg">
                    	<input type="submit" value="提交"  class="btn-reg"/>                     
                    </div>
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
<script>
	$(function(){
		$('.labelbox > input').placeholder();
	})
</script>
</body>
</html>
