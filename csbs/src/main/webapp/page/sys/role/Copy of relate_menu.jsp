<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>

<%String path = request.getContextPath();%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!-- admin/role/relate_menu.jsp by hy -->
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
    	var checkMenu = "${roleVO.create_user}";

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

//取得选中的菜单id 
function getMenuIds(){
	//取得所有选中的节点，返回节点对象的集合
	var menu = jQuery.tree.plugins.checkbox.get_checked();
	//得到节点的id，拼接成字符串
	var str="";
	for(i=0; i<menu.size(); i++){
		str += menu[i].id;
		if(i < menu.size()-1){
            str += ",";
        }
	}
	//写回表单
	$("#menuIds").val(str);
} 

function save(){
	getMenuIds();
	
    var params = $("#frm").serializeObject();
    $.ajax({
		url : "<%=path%>/admin/role/relateMenu.do",
		type: "POST",
		cache:false,
		async:true,
		dataType: "json",
		data: params,
		success:function(jsonData, textStatus) {
			 jsonData = jQuery.evalJSON(jsonData);
			 if(jsonData.success == 'ture'){
				 alert("用户分配角色成功！");
				 window.parent.callFunc();
				 closeDialog();
			 }else{
				 alert("用户分配角色失败，请重试."); 
			}
		},
		error:function(XMLHttpRequest, textStatus, errorThrown) {
            alert("用户分配角色出现异常！");
        }
    });
}

// 关闭窗口
function closeDialog() {
    window.parent.innerWindowClose();
}

function nodeClick(a,b,c) {

}

</script>
</head>

<body>
<form id="frm" name="frm" method="post" class="extendarea">
	<input type="hidden" id="id" name="roleVO.id"  value="${roleVO.id}" />
	<input type="hidden" id="menuIds" name="roleVO.role_name"  />
	<s:token />
	
 	<div class="w001"><div class="titlehead">菜单操作</div>
 		<table width="100%" border="0" cellspacing="0" cellpadding="0">
   			<tr>
    			<td valign="top">&nbsp;</td>
    			<td height="30">
    				<table width="50%" border="0" cellspacing="0" cellpadding="0">
  						<tr>
    						<td><div class="generalbtt"><a id="generaltse"; href="javascript:save();">保存</a></div></td>
    						<td><div class="generalbtt"><a id="generaltse"; href="javascript:closeDialog();">关闭</a></div></td>
  						</tr>
					</table>
				</td>
  			</tr>
  		</table>
 	</div>
	<div class="w001"><div class="titlehead">角色基本信息</div>
   		<div class="listinfo2" > 
   			<table border="0"  cellpadding="0" cellspacing="0"  style="width:95%;">
        		<tr>
           			 <td width="10%">角色名：</td>
            		 <td width="40%">${roleVO.role_name}</td>
            		 <td width="12%">角色KEY：</td>
            		 <td width="38%">${roleVO.role_key}</td>
        		</tr>
    		</table>
    	</div>
    </div>
    <div class="w001"><div class="titlehead">关联菜单</div>
    	<div style="text-align:left;margin-left:5px;">
       		 <a href="javascript:jQuery.tree.focused().open_all('#0')"><span class="itembody">+全部展开</span></a>
        			&nbsp;&nbsp;&nbsp;&nbsp;
        	 <a href="javascript:jQuery.tree.focused().close_all('#0')"><span class="itembody">-全部收起</span></a>
    	</div>
    	<div id="tree" style="width:90%;height:200px;overflow:auto;overflow-x:hidden;margin-top:2px;margin-left:2px;"></div>
    </div>
</form>
</body>
</html>
