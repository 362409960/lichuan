<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>用户登录</title>
<link type="text/css" rel="stylesheet"  href="./css/login.css" />
<script type="text/javascript" src="./js/jquery.min.js"></script>
<script>var contextPath = "${pageContext.request.contextPath}";</script>
<script type="text/javascript" src="./js/loginscript.js"></script>
<script type="text/javascript" src="./js/jQuery.md5.js"></script>

<script type="text/javascript" src="./ckeditor/ckeditor.js"></script>

<script type="text/javascript">
CKEDITOR.replace('content',{
	skin:'kama',
	language : 'zh-cn'
});
</script>


</head>
<body>

<!-- 
   <div>
   
				<tr>
					<td colspan="2">
						<textarea name="editor1" id="editor1" rows="10" cols="5">
				            This is my textarea to be replaced with CKEditor.
				        </textarea>
				        <script>
				            // Replace the <textarea id="editor1"> with a CKEditor
				            // instance, using default configuration.
				           	CKEDITOR.replace( 'editor1' );
				        </script>
					</td>
				</tr>
   
   </div>
 -->


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
				<form>
					<div class="user">
						用&nbsp;&nbsp;户 <input type="text" name="usercode" maxlength="20" />
					</div>
					<div class="user">
						密&nbsp;&nbsp;码 <input type="password" name="password" maxlength="20"/>
					</div>
					<div class="user">
						验&nbsp;&nbsp;证 <input type="text" style="width: 65px;" name="safecode" maxlength="6"/>
						<img src="" style="padding-bottom: 0px;" width="50px" height="20px" name="safecode_img" alt="验证码" title="点击换一张..."/>
					</div>
					<div id="btn">
						<input type="submit" value="登录" class="btn" /> <input type="reset" value="清空" class="btn" />
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
</body>
</html>
