<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="page" uri="/WEB-INF/tlds/paginated.tld"%>
<%@ taglib uri="/WEB-INF/tlds/c.tld" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<%String path = request.getContextPath();%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">


<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>系统管理员列表</title>
		<jsp:include page="/inc/common.jsp" />	
		<style>
			html{  overflow-x:hidden; width:100%;}
		</style>
</head>
  
  
<body style="padding: 6px;">
<div class="rightarea">
	<form name="frm" id="frm" action="<%=path %>/admin/user/list.do" method="post">
	<ul class="yanshi_search01">
        <table border="0" cellspacing="0" cellpadding="0">
			  <tr>
			  	<td align="left">账号：</td>
			    <td>
				  <div class="geinputleft">
				     <div class="geinputright">
					    <div class="geinputmid">
						   <input type="text" id="userCode" name="queryDto.userCode" size="10" maxlength="100" value="${queryDto.userCode}"/>
						</div>
				     </div>
				  </div>
				</td>
				
			    <td align="left">&nbsp;&nbsp;显示名：</td>
				    <td>
					  <div class="geinputleft">
					     <div class="geinputright">
						    <div class="geinputmid">
							   <input type="text" id="userName" name="queryDto.userName" size="10" maxlength="100" value="${queryDto.userName}"/>
							</div>
					     </div>
					  </div>
				</td>

				<td>
			    	<div class="yanshi_newinput1">
			    		&nbsp;&nbsp;&nbsp;&nbsp;<input name="sbtinput" type="submit"  value="查询" />
			    	</div>
			    </td>
				
			  </tr>
		  </table>
    </ul>
<div class="pic_border">
 <div class="top_pic_border_left"><div  class="top_pic_border_right"><Div class="border_bg"></Div></div></div>
<Div class="mid_boder1">
<div class="yanshi_newinput1">
    <input name="" type="button" onclick="preInsert();" href="javascript:void(0)" value="新建用户"/>
    <input name="" type="button" onclick="batInitPassowrd();"  href="javascript:void(0)" value="初始密码"/>
    <!-- 
    <input name="" type="button" onclick="grantRole();" href="javascript:void(0)" value="赋权限"/>
     -->
</div>

 <table width="100%" class="yanshi_newul" border="0" cellspacing="1" cellpadding="0">
	<thead>
	  <tr>
	      <td width="5%" valign="middle" class="newsfist" scope="col">
			<input type="checkbox" value="全选" id="all_select" onclick="checkAll();" />
		  </td>
	      <td class="newsfist" width="10%">账号</td>
	      <td class="newsfist" width="15%">用户名称</td>
	      <td class="newsfist" width="15%">创建时间</td>
	      <td class="newsfist" width="20%">上次登录IP</td>
	      <td class="newsfist" width="15%">上次登录时间</td>
	      <td class="newsfist" width="5%">状态</td>
	      <td class="newsfist" width="15%">操作</td>		    
	  </tr>
	 </thead>

	 <tbody>
	     <s:iterator value="sysUserList" var="user" status="status" >
	         <tr>
				 <td class="tdbtnlist">
				     <input type="checkbox" name="ids" value="${user.id}" onclick="selectItem();"/>
	    		 </td>
			 	 <td>${user.userCode}</td>
			 	 <td>${user.userName}</td>
			 	 <td><s:date name="createTime" format="yyyy-MM-dd HH:mm:ss"/></td>
			 	 <td>${user.lastLoginIp}</td>			 	  
			 	 <td><s:date name="lastLoginTime" format="yyyy-MM-dd HH:mm:ss"/></td>
			 	 <td>
			 	     <c:choose>
			 	        <c:when test="${user.state=='0'}">正常</c:when>
			 	        <c:otherwise>注销</c:otherwise>
			 	     </c:choose>
			 	 </td>
			 	 <td>
			 	    <span class="icon_chakan"><a href="javascript:showView('${user.id}');"  title="查看详情">查看详情</a></span>
			 	    <span class="icon_Modify"><a href="javascript:preUpdate('${user.id}');"  title="修改">修改</a></span>
			 	    <span class="icon_chushimima"><a href="javascript:initPassword('${user.id}');"  title="初始密码">初始密码</a></span>
			 	    <span class="icon_userfenpei"><a href="javascript:relateRole('${user.id}');"  title="分配权限">分配权限</a></span>
			 	    <span class="icon_del"><a href="javascript:del('${user.id}','${user.userCode}');"  title="删除">删除</a></span>
			 	 </td>
			 </tr>
		</s:iterator>
	</tbody>
</table>

</Div>
	<div class="bottom_pic_border_left"><div  class="bottom_pic_border_right"><Div class="border_bg1"></Div></div></div>
</div>
</form>

 <page:paginated id="1"/>
 </div>
 
 
 <jsp:include page="/inc/dialog.jsp" />
</body>
</html>

<script type="text/javascript">
function showView(id){
	var url="<%=path %>/admin/user/view.do?sysUserVO.id="+id+"&ts="+(new Date()).getTime();
	openDialog('查看详情', url , 600, 360, null);
}
function preUpdate(id){
	var url="<%=path %>/admin/user/preUpdate.do?sysUserVO.id="+id+"&ts="+(new Date()).getTime();
	openDialog('修改用户信息', url, 600, 360, onCallback);
}
function relateRole(id){
	var url="<%=path %>/admin/user/preRelateRole.do?sysUserVO.id="+id+"&ts="+(new Date()).getTime();
	openDialog('分配权限', url, 600, 480, onCallback);
}
function preInsert(){
	var url="<%=path %>/admin/user/preInsert.do?ts="+(new Date()).getTime();
	openDialog("新建用户", url, 600, 360, onCallback);
}

function onCallback(arg1,arg2){
	refurbish();
}

//刷新当前页面(ajax返回时候)
function refurbish(){
	window.location.href='<%=path %>/admin/user/list.do';
}

function del(id, userCode){
	if (window.confirm("确定要删除用户[ "+userCode+" ]吗？")) {
        $.ajax({
        	url: "<%=path %>/admin/user/delete.do?sysUserVO.id="+id,
   		 	type: "GET",
   		 	cache:false,
   		 	async:true,
   		 	dataType: "json",
	   		success:function(jsonData) {
	   			jsonData = jQuery.evalJSON(jsonData);
				if(jsonData.success == 'ture'){
					alert("删除成功！");
					refurbish();
				}else{
					alert("删除失败！"); 
				}
	   		},
	   		error:function(){
	   			alert("删除时出现异常！");
	   		}
        });
        
	}
}


function checkAll(){
	var ids = document.getElementsByName("ids");
	if(ids!=null){
		var temp = document.getElementById("all_select");
		for(var i=0;i<ids.length;i++){
		   ids[i].checked = temp.checked;
		}
	}
}

function selectItem(){
	var ids = document.getElementsByName("ids");
	if(ids!=null){
	   var count = ids.length; 
	   var idsCount = 0;
	  for(var i=0;i<ids.length;i++){		  
         if(ids[i].checked){
            idsCount++;
         }			   
     }
     document.getElementById("all_select").checked = (count==idsCount);
    }
}

//初始化密码
function initPassword(id){
	if (!confirm("确定要初始化密码?")){
		return;
	}
	
	$.ajax({
			url: "<%=path %>/admin/user/initPssword.do",
		 	type: "POST",
		 	cache:false,
		 	async:true,
		 	dataType: "json",
		 	data:{'ids':id},
   		success:function(jsonData) {
   			jsonData = jQuery.evalJSON(jsonData);
			if(jsonData.success == 'ture'){
				alert("初始化密码成功！密码为：111111");
				refurbish();
			}else{
				alert("初始化密码失败！"); 
			}
   		},
   		error:function(){
   			alert("初始化密码时出现异常！");
   		}
    });
}

// 批量初始化密码
function batInitPassowrd(){
	var checkIds = document.getElementsByName("ids");
	var isCheck = false;
	
	for(var i=0;i<checkIds.length;i++){
		if (checkIds[i].checked){
			isCheck = true;
			if (!confirm("确定要初始化密码?")){
				return;
			}else{
				break;
			}
		}
	}
	
	var arr = new Array();
	if(isCheck == true){
		for(var n=0;n<checkIds.length;n++){
			if (checkIds[n].checked){
				arr.push(checkIds[n].value);
			}
		}
		
		$.ajax({
   			url: "<%=path %>/admin/user/initPssword.do",
   		 	type: "POST",
   		 	cache:false,
   		 	async:true,
   		 	dataType: "json",
   		 	data:{'ids':arr.toString()},
	   		success:function(jsonData) {
	   			jsonData = jQuery.evalJSON(jsonData);
				if(jsonData.success == 'ture'){
					alert("初始化密码成功！密码为：111111");
					refurbish();
				}else{
					alert("初始化密码失败！"); 
				}
	   		},
	   		error:function(){
	   			alert("初始化密码时出现异常！");
	   		}
        });
		
	}else{
		alert("没有选择项!");
	}
	
}


//批量授权
function grantRole(){
	var checkIds = document.getElementsByName("ids");
	var isCheck = false;

	for(var i=0;i<checkIds.length;i++){
		if (checkIds[i].checked){
			isCheck = true;
			if (!confirm("确定要批量授权吗?")){
				return;
			}else{
				break;
			}
		}
	}
	
	var arr = new Array();
	if(isCheck == true){
		for(var n=0;n<checkIds.length;n++){
			if (checkIds[n].checked){
				arr.push(checkIds[n].value);
			}
		}
		
		var url="<%=path %>/admin/user/preGrant.do?sysUserVO.id="+pks+"&ts="+(new Date()).getTime();
		openDialog("新建用户", url, 600, 360, onCallback);
		
	}else{
		alert("没有选择项!");
	}
	
}

</script>

