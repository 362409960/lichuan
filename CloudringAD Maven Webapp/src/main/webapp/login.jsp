<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="/WEB-INF/tlds/c.tld" prefix="c"%>

<%
    String path = request.getContextPath();
%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>用户登录</title>
<link type="text/css" rel="stylesheet"  href="<%=path%>/css/login.css" />
<script>var contextPath = "${pageContext.request.contextPath}";</script>
<script type="text/javascript" src="<%=path%>/js/jquery.min.js"></script>
<script type="text/javascript" src="<%=path%>/js/jquery.md5.js"></script>
<script type="text/javascript" src="<%=path%>/js/loginscript.js"></script>


</head>
<body>
 
	<div id="login">
		<div id="top">
			<div id="top_left">
				<img src="images/login_03.gif" />
			</div>
			<div id="top_center"></div>
		</div>

		<div id="center">
			<div id="center_left"></div>
			<div id="center_middle">
				<form id="frm" name="frm" method="post" action="<%=path%>/sys/login.do">
					<div class="user">
						用&nbsp;&nbsp;户 <input type="text" id="usercode" name="usercode" maxlength="20" />
					</div>
					<div class="user">
						密&nbsp;&nbsp;码 <input type="password" id="password" name="password" maxlength="20"/>
					</div>
					<div class="user">
						验&nbsp;&nbsp;证 <input type="text" style="width: 65px;" name="safecode" maxlength="6"/>
						<img src="" style="padding-bottom: 0px;" width="50px" height="20px" name="safecode_img" alt="验证码" title="点击换一张..."/>
					</div>
					<div id="btn">
						<input type="button" onclick="login()" value="登录" class="btn" />
                        <input type="reset" value="清空" class="btn" />
                        
                        <input type="button" onclick="loginInit()"  value="智慧家庭" class="btn" />
					</div>
				</form>
				<div style="margin-top: 20px;"><center><span name="loginTips">登录提示</span></center></div>
			</div>
			<div id="center_right"></div>
		</div>
		<div id="down">
			<div id="down_left">
				<div id="inf">
					<span class="inf_text"></span><span class="copyright"></span>
				</div>
			</div>
			<div id="down_center"></div>
		</div>
	</div>
	
	<form id="twofrm" name="twofrm" method="post">
	
	</form>
	
</body>
</html>

<script type="text/javascript">
    function loginInit(){
		document.twofrm.action = "<%=path%>/smart/loginInit.do";
		document.twofrm.submit();
    }
    
    function login(){
    	var tempPassword = $("#password").val();
    	var temp = $.md5(tempPassword);
    	var usercode = $("#usercode").val();

    	$.ajax({
            type: "post",
            url: contextPath + "/sys/login.do",
            data:{usercode:usercode,password: temp},
            dataType: "text",
            success: function (data) {
            	
            	window.location.href="index.jsp";
            	
            	return true;
            },
            error: function (XMLHttpRequest, textStatus,errorThrown) {
                alert(errorThrown);
                return false;
            }
        });
    }
    
    
</script>



