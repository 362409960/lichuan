<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="/WEB-INF/tlds/c.tld" prefix="c"%>
<%@page import="cloud.shop.common.Constants" %>
<%@page import="cloud.shop.goods.entity.Customer" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>找回密码 </title>
<link href="<%=path%>/css/shop/common.css" rel="stylesheet" type="text/css" />
<link href="<%=path%>/css/default/login.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<%=path%>/js/jquery.min.js"></script>
<script type="text/javascript" src="<%=path%>/js/shop/jquery.validate.js"></script>
<script type="text/javascript" src="<%=path%>/js/jQuery.md5.js"></script>
<script type="text/javascript" src="<%=path%>/js/shop/common.js"></script>
<script>var contextPath = "${pageContext.request.contextPath}";</script>
<script type="text/javascript">
$().ready(function() {


	var $passwordForm = $("#passwordForm");	
	var $submit = $("input:submit");
	var $phone = $("#phone");
	var $password = $("#password");
	// 表单验证
	$passwordForm.validate({
		rules: {
			
			password: {
				required: true,
				minlength: 6
			},
			rePassword: {
				required: true,
				equalTo: "#password"
			}
			
		},
		submitHandler: function(form) {
		  var enpassword=$.md5($password.val());		
			$.ajax({
				url: $passwordForm.attr("action"),
				type: "POST",
				data: {
						enpassword:enpassword,
						phone:$phone.val()
					},
				dataType: "json",
				cache: false,
				beforeSend: function() {
					$submit.prop("disabled", true);
				},
				success: function(message) {
					$.message(message);
					if (message.type == "success") {
						setTimeout(function() {
							$submit.prop("disabled", false);
							location.href = contextPath+"/home/showShopIndex.do";
						}, 1000);
					} else {
						$submit.prop("disabled", false);
						$safecode.val("");
						$safecode_img.attr("src", contextPath + "/safecode/create_sc.do?K=" + Math.random());
					}
				}
			});
		}
	});

});
</script>
</head>
<body>


<div class="f-pass">
    	<div class="reset-frame">
        	<div class="logo-area">
            	<a href="##" class="milogo"></a>
            </div>
            <div class="title-item">
                <h4>重置密码</h4>
            </div>
            <form id="passwordForm" method="post" action="<%=path %>/password/updatePassword.do">
              <input type="hidden" id="phone" name="phone" value="${phone}"/>
            	<div class="regbox">
                	<h5>请输入新密码：</h5>
                    <div class="inputbg">
                    	<label class="labelbox labelbox-user" for="">
                        	<input type="password" id="password" name="password" class="text" maxlength="20" autocomplete="off" placeholder="请输入新密码" />
                        </label>
                    </div>
                    <h5>请再次输入新密码：</h5>
                    <div class="inputbg">
                    	<label class="labelbox labelbox-user" for="">
                        	<input type="password" name="rePassword" class="text" maxlength="20" autocomplete="off" placeholder="请再次输入新密码 " />
                        </label>
                    </div>
                    <div class="fixed-bot">
                    	<input type="submit" value="提交" class="btn_forget" id="sumbit_button"/>
                    </div>
                </div>
            </form>
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
</body>
</html>
