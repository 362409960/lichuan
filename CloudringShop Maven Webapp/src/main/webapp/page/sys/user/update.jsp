<%@ page language="java" pageEncoding="utf-8"%>

<%@ taglib uri="/WEB-INF/tlds/c.tld" prefix="c"%>

<% String path = request.getContextPath();%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>修改用户信息</title>

	
<style type="text/css">
    html{overflow-x:hidden; width:100%;}
</style>

</head>
<body> 
<div class="w001">
<form id="frm" name="frm" method="post" action="<%=path %>/admin/user/update.do" target="_parent">
<input type="hidden" name="sysUserVO.id" id="id" value="${sysUserVO.id}" />
<s:token />

<table width="100%" border="0" cellpadding="0" cellspacing="1" class="yanshi_newu2">

<tr>
    <td align="center" width="80px">账号</td>
	<td class="shurukang_abv" width="310px">
		<div class="geinputleft3">
		<div class="geinputright">
		<div class="geinputmid3">
		    <input type="text" name="sysUserVO.userCode" id="userCode" value="${sysUserVO.userCode}" readonly="true"/> 
		</div>
		</div>
		</div>
	</td>
	<td>&nbsp;<span class="required">*</span></td>
</tr>


<tr>
    <td align="center" width="80px">用户名称</td>
	<td class="shurukang_abv" width="310px">
		<div class="geinputleft3">
		<div class="geinputright">
		<div class="geinputmid3">
		    <input type="text" name="sysUserVO.userName" id="userName" value="${sysUserVO.userName}" /> 
		</div>
		</div>
		</div>
	</td>
	<td>&nbsp;<span class="required">*</span></td>
</tr>


<tr>
	<td align="left" >&nbsp;&nbsp;状态&nbsp;</td>
	    <td class="shurukang_abv" >
              <div class="geinputleft">
                  <div class="geinputright">
                      <div class="geinputmid">
					<select id="state" name="sysUserVO.state" class="yanshiselect">
					    <option value="0" <c:if test="${sysUserVO.state == '0'}"> selected="selected" </c:if> >正常</option>
					    <option value="1" <c:if test="${sysUserVO.state == '1'}"> selected="selected" </c:if> >注销</option>
					</select>
		        </div>
		    </div>
		</div>
	    </td>
	    <td>&nbsp;</td>
</tr>



<tr>
    <td align="center" width="80px">邮箱</td>
	<td class="shurukang_abv" width="310px">
		<div class="geinputleft3">
		<div class="geinputright">
		<div class="geinputmid3">
		    <input type="text" name="sysUserVO.email" id="email" value="${sysUserVO.email}" /> 
		</div>
		</div>
		</div>
	</td>
	<td>&nbsp;</td>
</tr>

 

<tr>
    <td align="center" width="80px">电话</td>
	<td class="shurukang_abv" width="310px">
		<div class="geinputleft3">
		<div class="geinputright">
		<div class="geinputmid3">
		    <input type="text" name="sysUserVO.phone" id="phone" value="${sysUserVO.phone}"/> 
		</div>
		</div>
		</div>
	</td>
	<td>&nbsp;</td>
</tr>
 
</table>

<br />
<table width="100%" border="0" cellpadding="0" cellspacing="0" >
     <tr>
    	<td align="center" ><div class="generalbtt"><a id="generaltse"; href="javascript:save()" >保存</a></div></td>
    	<td align="center" ><div class="generalbtt"><a id="generaltse"; href="javascript:closeDialog();" >关闭</a></div></td>
    </tr>
</table>

</form>
</div>

</body>
</html>

<script type="text/javascript">

    function save(v){
		var userName = $("#userName").val();
		if(userName == null || userName == ''){
			alert("请输入用户名称");
			$("#userName").focus();
			return;
		}

        //email phone 暂时不验证
		

		var params = $("#frm").serializeObject();
		$.ajax({
		 url: "<%=path %>/admin/user/update.do",
		 type: "POST",
		 cache:false,
		 async:true,
		 dataType: "json",
		 data: params,
		 success:function(jsonData) {
			 jsonData = jQuery.evalJSON(jsonData);
			 if(jsonData.success == 'ture'){
				 alert("修改用户信息成功！");
				 window.parent.callFunc();
				 closeDialog();
			 }else{
				 alert("修改用户信息失败！"); 
			}
         },
         error:function(){
         alert("修改用户信息保存时出现异常！");
     }
	});
	
	
}
    
    // 关闭窗口
    function closeDialog() {
        window.parent.innerWindowClose();
    }

	function isEmpty( str ){
		if ( str == "" ) return true;
		var regu = /^[ ]+$/;
		var re = new RegExp(regu);
		return re.test(str);
	}
</script>

