<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="page" uri="/WEB-INF/tlds/paginated.tld"%>
<%@ taglib uri="/WEB-INF/tlds/c.tld" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<%String path = request.getContextPath();%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<jsp:include page="/inc/common.jsp" />

<script language="javascript">
$(document).ready(function() { 
    // 初始化菜单树
    $("#tree").tree({
        plugins: {checkbox:{}},
        data:{
            type:"json",
            async:false,
            opts:{
                method:"POST",
                url:"<%=path%>/treeBuild.do"
            }
        },
        ui:{
            theme_name:"checkbox"
        },
        lang :{
            loading :"加载中 ..."
        }
    });

    //初始化原有菜单权限
    $("#tree").ajaxStop(function(){
    	//得到服务器传过来的原有权限id的字符串，格式自定义，我的格式为"0001,0002,xxx"
    	var checkMenu = "${menuIds}";
    	//分割字符串成数组
    	var array = checkMenu.split(",");
    	for(var i=0;i<array.length;i++){
    		if(array[i]!=''){
        		if($("#"+array[i]+"").children("ul:eq(0)").length <= 0){
	     			//设置原有权限菜单处于选中状态，其中$("#0001")为id为0001的节点。
	     			jQuery.tree.plugins.checkbox.check($("#"+array[i]+""));
        		}
    		}	
      	}
    });
     

});

//修改
function save(){
	getMenuIds();
	
	var checkIds = document.getElementsByName("roleIds");
	var arr = new Array();
	for(var n=0;n<checkIds.length;n++){
		if (checkIds[n].checked){
			arr.push(checkIds[n].value);
		}
	}
	$("#tempRoleIds").val(arr.toString());
	
	
	
    var params = $("#frm").serializeObject();
    $.ajax({
		url : "<%=path%>/admin/user/grantRole.do",
		type: "POST",
		cache:false,
		async:true,
		dataType: "json",
		data: params,
		success:function(jsonData) {
			 jsonData = jQuery.evalJSON(jsonData);
			 if(jsonData.success == 'ture'){
				 alert("保存成功！");
				 window.parent.callFunc();
				 closeDialog();
			 }else{
				 alert("保存失败！"); 
			}
         },
		error:function(XMLHttpRequest, textStatus, errorThrown) {
            alert("操作出现异常！");
        }
    });
}



//取得选中的菜单id 
function getMenuIds(){
	//取得所有选中的节点，返回节点对象的集合
	var menu = jQuery.tree.plugins.checkbox.get_checked();
	//得到节点的id，拼接成字符串
	var str="";
	if(menu.size() > 0){
		str = menu[0].parentNode.parentNode.id+",";
	}
	for(i=0; i<menu.size(); i++){
		str += menu[i].id;
		if(i < menu.size()-1){
            str += ",";
        }
	}
	//写回表单
	$("#menuIds").val(str);
} 

// 关闭窗口
function closeDialog() {
    window.parent.innerWindowClose();
}
</script>
 
</head>

<body>
<form id="frm" name="frm" method="post" class="extendarea">
    <s:token />
	<input type="hidden" id="id" name="sysUserVO.id"  value="${sysUserVO.id}" />
	<input type="hidden" id="menuIds" name="menuIds"/>
	<input type="hidden" id="tempRoleIds" name="tempRoleIds"/>
   <div class="w001">
      <div class="titlehead">用户基本信息</div>
         <div class="tablelist">
    		<table border="0" cellpadding="0" cellspacing="0" style="width:100%;">
        		<tr>
            		<td align="left" valign="top">
                		<table border="0" cellpadding="0" cellspacing="0" class="formlist" style="width:100%;table-layout:fixed;">
                   			 <tr>
                        		<td>用户账号</td>
                        		<td>${sysUserVO.userCode}</td>
                       			<td>显示名</td>
                        		<td>${sysUserVO.userName}</td>
                    		</tr>
 
                		</table>
           			 </td>
        		</tr>
   		  </table>
   		</div>
   		
   		<div class="titlehead">用户分配权限</div>
   		
   		<table border="0" cellpadding="0" cellspacing="0" style="width:100%;">
       		 
       		 <tr>
            	<td align="left" valign="top">权限菜单<br/>
            		<div align="left">
            			<div id="tree" ></div>
            		</div>
            	</td>
            	
            	<td align="center" valign="top">配角色列表<br/>
                	<table>
                		<tr>
                			<th>选择</th>
                			<th>角色</th>
                		</tr>
                			<s:iterator value="allRoles" status="stuts">
                	 			<tr>
                	 				<td>
                	 					<input type="checkbox" id ="roleIds" name="roleIds" value="${id}" ${role_key=="1"?"checked=\"checked\"":"" }/>
                	 				</td>
                	 				<td>${role_name}</td>
                	 			</tr>
							</s:iterator>
                	</table>
           		 </td>
       		 </tr>
       		 
        	 <tr>
        		<td colspan="2" align="center">
        			<table width="165" border="0" cellspacing="0" cellpadding="0">
	        			<tr>
	        				<td >
	        					<div class="generalbtt"><a id="generaltse"; href="javascript:save();">保存</a></div>
	        				</td>
	        				<td>
	        					<div class="generalbtt"><a id="generaltse"; href="javascript:closeDialog();" >关闭</a></div>
	        				</td>
	        			</tr>
        			</table>
        		</td>
        	</tr>
        	
    	</table>

    </div>
</form>
</body>
</html>
