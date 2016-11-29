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
<title>CLOUDRING-用户注册 </title>
<meta name="author" content="" />
<meta name="copyright" content="" />
<link href="../css/shop/common.css" rel="stylesheet" type="text/css" />
<link href="../css/default/register.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="../js/jquery.min.js"></script>
<script type="text/javascript" src="../js/shop/jquery.validate.js"></script>
<script type="text/javascript" src="../js/jQuery.md5.js"></script>
 <script type="text/javascript" src="../js/shop/common.js"></script>  
<script type="text/javascript" src="../js/placeholder.js"></script>  
<script>var contextPath = "${pageContext.request.contextPath}";</script>
<script type="text/javascript">
$().ready(function() {
    $("img[name='safecode_img']").click(function (event) {
    	 $(this).attr("src", contextPath + "/safecode/create_sc.do?K=" + Math.random());
    });
    $("img[name='safecode_img']").click();//界面加载完成时就点击一次图片
	var $registerForm = $("#registerForm");		
	
	$.validator.setDefaults({      
        submitHandler: function(form) {   
            form.submit();   
       }
    }),
	
	// 表单验证
	$registerForm.validate({		
		rules: {
			mobile: {
			        required: true,
					pattern: /^1[3|4|5|7|8]\d{9}$/,
					remote: {
					url: contextPath+ "/register/check_phone.do"
					,cache: false
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
				safecode: {
					remote: "验证码不正确!"
				}
				,mobile: {
					remote: "手机已经被使用,请重新输入新的号码!"
				}
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
        <form id="registerForm" action="<%=path %>/register/toSms.do" method="post">
        	<div class="regbox">
            	<div class="reg-step">
                    <div class="inputbg">
                    	<label class="labelbox" for="">
                        	<input type="tel" placeholder="请输入手机号码" data-type="PH" name="mobile" id="mobile"/>
                        </label>
                    </div>
                    <div class="err-tip">
                    	<div class="err-box">
                        	<em class="icon-error"></em>
                        </div>
                    </div>
                    <div class="inputbg">
                    	<label class="labelbox" for="">
                        	<input type="text" class="code" placeholder="图片验证码" autocomplete="off" name="safecode"/>
                        </label>
                        <img src="" class="code-img" name="safecode_img" alt="验证码" title="点击换一张..."/>                        
                    </div>
                    <div class="err-tip">
                    	<div class="err-box">
                        	<em class="icon-error"></em>
                        </div>
                    </div>
                    
                    <div class="fixed-reg">
                    	<input type="submit" value="立即注册"  class="btn-reg"/>
                      <!--   <p class="msg">
      						点击“立即注册”，即表示您同意并愿意遵守小米
      						<a title="用户协议" target="_blank" href="javascript:void(0);">用户协议</a>
                            和
      						<a title="隐私政策" target="_blank" href="javascript:void(0);">隐私政策</a>
      					</p> -->
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
