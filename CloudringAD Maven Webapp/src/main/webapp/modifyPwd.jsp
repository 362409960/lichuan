<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<% 
    String path = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<title>修改密码</title>
<link type="text/css" rel="stylesheet"  href="<%=path%>/css/login.css" />
<link rel="stylesheet" type="text/css" href="<%=path%>/css/201202/main.css" />
<script type="text/javascript" src="<%=path%>/js/jquery.min.js"></script>
<script type="text/javascript" src="<%=path%>/js/jQuery.md5.js"></script>

<script language="javascript">
//修改
function save(){
		if($("#password").val()!=$("#confirmPassword").val()){
			alert("新密码和确认密码不一致");
			$("#password").select(); 
			$("#password").focus();
			return;
		}
		if($("#password").val().length<6){
			alert("新密码不到6位");
			$("#password").select(); 
			$("#password").focus();
			return;
		}
		
		/** 去掉密码约束条件
		var pwd_Strong=getResult($("#password").val());
		if(pwd_Strong<2){
		   	 alert("密码必须由大小写字母、数字、符号其中二者或以上组成");
		     return false;
		}
		*/
		
		var password = $("#password").val();
		if(password.indexOf("<") > -1 || password.indexOf(">") > -1 || password.indexOf("(") > -1 || password.indexOf(")") > -1 || 
				password.indexOf("\'") > -1 || password.indexOf('\"') > -1 || password.indexOf("../") > -1){
			alert("密码不能包括的特殊字符：<、>、(、)、\\'、"+'\\"、../'+"，请重新输入！");
			return;
		}
     	jQuery.ajax({
             url:"<%=path%>/modifyPwd.do",
             type:"POST",
             cache:false,
             async:false,
             dataType: "json",
             data: {"user.oldPwd":$("#oldPwd").val(),"user.userPassword":$("#password").val()},
             success:function(jsonData) {
    			 jsonData = jQuery.evalJSON(jsonData);

    			 if(jsonData.success == 'ture'){
    				 alert("密码修改成功！");
    				 closeDialog();
    			 }else if(jsonData.success == 'notSame'){
                	 alert("旧密码不对");
                 }else{
    				 alert("密码修改失败！"); 
    			}
             },
             error:function(XMLHttpRequest, textStatus, errorThrown) {
                 alert("修改密码时出现异常！");
             }
         });
}


//定义检测函数 
function getResult(s){
	 var ls = 0;
	 //小写
	 if (s.match(/[a-z]/)){
	  ls++;
	 }
	 //数字
	 if (s.match(/[0-9]/)){
	  ls++;
	 }
	 //大写
	   if (s.match(/[A-Z]/)){
	  ls++;
	 }
	 //符号
	  if (s.match(/(.[^a-z0-9])/ig)){
	  ls++;
	 }
	 return ls
}

// 重置form
function clearfrom() {
    document.all.oldPwd.value="";
    document.all.password.value="";
    document.all.confirmPassword.value="";
}

// 关闭窗口
function closeDialog() {
	window.close();
}
</script>
</head>

<body>
<div class="listinfo">
<form id="frm" name="frm" method="post" class="extendarea">
    <table border="0" cellpadding="0" cellspacing="0" class="formlist" style="width:100%;table-layout:fixed;">
        <tr>
            <th width="120px">旧密码：</th>
            <td>
            	<div class="geinputleft"><div class="geinputright"><div class="geinputmid">
                	<input type="password" id="oldPwd" name="oldPwd"   tip="旧密码" rules="required" maxlength="20"/>
                </div></div></div>
            </td>
            <td><span class="required">*</span></td>
        </tr>
        <tr>
            <th width="120px">新密码：</th>
            <td>
            	<div class="geinputleft"><div class="geinputright"><div class="geinputmid">
               	 	<input type="password" id="password" name="password"   tip="新密码" rules="required" maxlength="20"/>
                </div></div></div>
            </td>
            <td><span class="required">*</span>最短6位，最长20位</td>
        </tr>
        <tr>
            <th width="120px">确认密码：</th>
            <td>
            	<div class="geinputleft"><div class="geinputright"><div class="geinputmid">
                	<input type="password" id="confirmPassword" name="confirmPassword"  tip="确认密码" rules="required" maxlength="20"/>
                </div></div></div>
            </td>
            <td><span class="required">*</span>最短6位，最长20位</td>
        </tr>
    </table>


        	<table  align="center">
        		<tr>
    				 <td><div class="generalbtt"><a  id="generaltse"; onclick="save()" href="#" >保存</a></div></td>
   					 <td><div class="generalbtt"><a  id="generaltse"; onclick="clearfrom();" href="#" >重置</a></div></td>
   					 <td><div class="generalbtt"><a  id="generaltse"; onclick="closeDialog()" href="#" >关闭</a></div></td>
        		</tr>
        	</table>

</form>
</div>
</body>
</html>
