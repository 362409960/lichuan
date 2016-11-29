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
<title>找回密码 </title>
<link href="<%=path %>/css/common.css" rel="stylesheet" type="text/css" />
<link href="<%=path %>/css/default/register.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<%=path %>/js/jquery.min.js"></script>
<script type="text/javascript" src="<%=path %>/js/jquery.validate.js"></script>
<script type="text/javascript" src="<%=path %>/js/common.js"></script>
<script type="text/javascript" src="<%=path %>/js/placeholder.js"></script> 
<script>var contextPath = "${pageContext.request.contextPath}";</script>
<script type="text/javascript">
var InterValObj; //timer变量，控制时间  
var count = 120; //间隔函数，1秒执行  
var curCount;//当前剩余秒数  
var code = ""; //验证码  
var codeLength = 6;//验证码长度 
function sendMessage() {  
    curCount = count;  
    var jbPhone = $("#phone").val();  
    if (jbPhone != "") {  
            // 产生验证码  
            for ( var i = 0; i < codeLength; i++) {  
                code += parseInt(Math.random() * 6).toString();  
            }  
            // 设置button效果，开始计时  
            $("#btnSendCode").attr("disabled", "true");  
            $("#btnSendCode").val("请在" + curCount + "秒内输入验证码");  
            InterValObj = window.setInterval(SetRemainTime, 1000); // 启动计时器，1秒执行一次  
            // 向后台发送处理数据  
            $.ajax({  
                type: "post", 
                dataType: "text", 
                url: contextPath+"/sms/sms.do", 
                data: "jbPhone=" + jbPhone +"&code=" + code,  
                error: function (XMLHttpRequest, textStatus, errorThrown) { 
                },  
                success: function (message){   
                    var data=eval(message);
                    if(data == 'success'){  
                        $("#jbPhoneTip").html("<font color='#339933'>√ 短信验证码已发到您的手机,请查收</font>");  
                    }else if(data == 'error'){  
                        $("#jbPhoneTip").html("<font color='red'>× 短信验证码发送失败，请重新发送</font>");  
                    }else if(data == 'count'){  
                        $("#jbPhoneTip").html("<font color='red'>× 该手机号码今天发送验证码过多</font>");  
                    }  
                }  
            });  
        
    }
  
}  
//判断在一定时间里面是否失效.
function SetRemainTime() {  
    if (curCount == 0) {                  
        window.clearInterval(InterValObj);// 停止计时器  
        $("#btnSendCode").removeAttr("disabled");// 启用按钮  
        $("#btnSendCode").val("重新发送验证码");  
       	$.ajax({
              type: "post", 
                dataType: "text", 
                url: contextPath+"/sms/deleteSms.do", 
                data: "code=" + code,  
                error: function (XMLHttpRequest, textStatus, errorThrown) { 
                },  
                success: function (message){   
                    code="";
                }  
       });
    }else {  
        curCount--;  
        $("#btnSendCode").val("请在" + curCount + "秒内输入验证码");  
    }  
} 
$().ready(function() {   
    //sendMessage();
    var $registerForm = $("#registerForm");	
	 $.validator.setDefaults({      
        submitHandler: function(form) {   
            form.submit();   
       }
    }),
	$registerForm.validate({		
		rules: {
			smscode:  {
				required: true
					 ,remote: {
					    type: "POST",
						url: contextPath+ "/sms/check_sms.do"
						,cache: false
						
					} 
			}
			
		},
		messages: {
			smscode: {
					remote: "短信验证码不正确!"
				}
				
		}
	});
});


</script>
</head>
<body>
<div class="reg bugfix_ie6">
	<div class="logo-area">
            	<a href="##" class="milogo"></a>
            </div>
</div>
<div class="reg">
	<div id="main_container" class="reg-frame">
    	<div class="reg-title">
         <h4>重置密码</h4>
        </div>
        <div>
        <form id="registerForm" action="<%=path %>/password/toEdit.do" method="post">
         <input type="hidden" id="phone" name="phone" value="${phone}"/>
        	<div class="regbox">
            	<div class="reg-step">
                    <div class="inputbg">
                    	<label class="labelbox" for="">
                        	
                        	 <input id="smscode" name="smscode" class="text" maxlength="6" placeholder="请输入短信验证码" />  
                        	 <span><input type="button" id="btnSendCode" name="btnSendCode" style="width: 160px;height: 30px; color: green;"  value="免费获取验证码" onclick="sendMessage()" /></span>
                        </label>
                    </div>
                    <div class="err-tip">
                    	<div class="err-box">
                        	<em class="icon-error"></em>
                            <span>请输入短信验证码</span>
                        </div>
                    </div>                   
                    
                    <div class="fixed-reg">
                    	<input type="submit" value="下一步"  class="btn-reg"/>                     
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
