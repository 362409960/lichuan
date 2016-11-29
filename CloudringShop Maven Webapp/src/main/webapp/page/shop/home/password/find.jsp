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
  $("img[name='safecode_img']").click(function (event) {
    	 $(this).attr("src", contextPath + "/safecode/create_sc.do?K=" + Math.random());
    });
    $("img[name='safecode_img']").click();//界面加载完成时就点击一次图片 

	var $passwordForm = $("#passwordForm");	
	// 表单验证
	
	 $.validator.setDefaults({      
        submitHandler: function(form) {   
            form.submit();   
       }
    }),
	$passwordForm.validate({
		rules: {
			name: {
				required: true,
				pattern: /^[0-9a-zA-Z_\u4e00-\u9fa5]+$/,
				minlength: 2,				
				remote: {
					url:contextPath+ "/register/check_username_no.do",
					cache: false
				} 
			},
			safecode:  {
				required: true
					 ,remote: {
					    type: "POST",
						url: contextPath+ "/safecode/check_sc.do"
						,cache: false
					} 
			}
		},
		messages: {
			name: {
				pattern: "只允许包含中文、英文、数字、下划线",
				remote: "用户名不对，请重新输入。"
			},safecode: {
					remote: "验证码不正确!"
				}
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
            <form id="passwordForm" method="post" action="<%=path %>/password/edit.do">
            	<div class="regbox">
                	<h5>请输入注册的手机号码或Cloudring帐号：</h5>
                    <div class="inputbg">
                    	<label class="labelbox labelbox-user" for="user">
                        	<input id="name" type="text"  placeholder="手机号码/Cloudring帐号" autocomplete="off" name="name"/>
                        </label>
                    </div>
                    <div class="inputbg inputcode">
                    	<label class="labelbox labelbox-code">
                        	<input type="text" placeholder="图片验证码" name="safecode" class="code" id="safecode"/>
                        </label>
                         <img src="" class="code-img" name="safecode_img" alt="验证码" title="点击换一张..."/>   
                    </div>
                    <div class="fixed-bot">
                    	<input type="submit" value="下一步" class="btn_forget" id="sumbit_button"/>
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
