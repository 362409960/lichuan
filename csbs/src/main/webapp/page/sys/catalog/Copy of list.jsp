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
		<title>字典分类列表</title>
		<jsp:include page="/inc/common.jsp" />	
		<style>
			html{  overflow-x:hidden; width:100%;}
		</style>
</head>
  
  
<body style="padding: 6px;">
<div class="rightarea">
	<form name="frm" id="frm" action="<%=path %>/admin/catalog/list.do" method="post">
	<ul class="yanshi_search01">
        <table border="0" cellspacing="0" cellpadding="0">
			  <tr>
			  	<td align="left">字典分类代码：</td>
			    <td>
				  <div class="geinputleft">
				     <div class="geinputright">
					    <div class="geinputmid">
						   <input type="text" id="pkid" name="queryDto.pkid" size="10" maxlength="100" value="${queryDto.pkid}"/>
						</div>
				     </div>
				  </div>
				</td>
				
			    <td align="left">&nbsp;&nbsp;字典分类名：</td>
				    <td>
					  <div class="geinputleft">
					     <div class="geinputright">
						    <div class="geinputmid">
							   <input type="text" id="catalog_name" name="queryDto.catalogName" size="10" maxlength="100" value="${queryDto.catalogName}"/>
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
    <input name="" type="button" onclick="preInsert();" href="javascript:void(0)" value="新建"/>
    <input name="" type="button" onclick="batDelete();"  href="javascript:void(0)" value="批量删除"/>
</div>

 <table width="100%" class="yanshi_newul" border="0" cellspacing="1" cellpadding="0">
	<thead>
	  <tr>
	      <td width="5%" valign="middle" class="newsfist" scope="col">
			<input type="checkbox" value="全选" id="all_select" onclick="checkAll();" />
		  </td>
	      <td class="newsfist" width="15%">字典分类代码</td>
	      <td class="newsfist" width="15%">字典分类名</td>
	      <td class="newsfist" width="40%">备注</td>
	      <td class="newsfist" width="25%">操作</td>		    
	  </tr>
	 </thead>

	 <tbody>
	     <s:iterator value="catalogList" var="catalog" status="status" >
	         <tr>
				 <td class="tdbtnlist">
				     <input type="checkbox" name="ids" value="${catalog.pkid}" onclick="selectItem();"/>
	    		 </td>
			 	 <td>${catalog.pkid}</td>
			 	 <td>${catalog.catalogName}</td>
			 	 <td>${catalog.note}</td>
			 	 <td>
			 	    <span class="icon_groupman"><a href="javascript:mngDicData('${catalog.pkid}');"  title="字典数据管理">字典数据管理</a></span>
			 	    <span class="icon_Modify"><a href="javascript:preUpdate('${catalog.pkid}');"  title="修改">修改</a></span>
			 	    <span class="icon_del"><a href="javascript:del('${catalog.pkid}');"  title="删除">删除</a></span>
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
 
function preUpdate(pkId){
	var url="<%=path %>/admin/catalog/preUpdate.do?catalog.pkid="+pkId+"&ts="+(new Date()).getTime();
	openDialog('修改字典数据', url, 600, 360, onCallback);
}
function mngDicData(pkId){
	location = '<s:url value="/admin/catalog/dictionary/" encode="false"/>'+'list.do?dictionary.catalog_id=' + pkId;
}
function preInsert(){
	var url="<%=path%>/admin/sys/catalog/insert.jsp?ts=" + (new Date()).getTime();
	openDialog("新建字典数据", url, 600, 360, onCallback);
}

function onCallback(arg1,arg2){
	refurbish();
}

//刷新当前页面(ajax返回时候)
function refurbish(){
	window.location.href='<%=path%>/admin/catalog/list.do';
}

function del(pkId){
	if (window.confirm("确定要删除字典数据[ "+pkId+" ]吗？")) {
        $.ajax({
        	url: "<%=path %>/admin/catalog/delete.do?catalog.pkid="+pkId,
   		 	type: "GET",
   		 	cache:false,
   		 	async:true,
   		 	dataType: "json",
            success:function(json, textStatus) {
                if (json.code == "0") {
                    alert(json.message);
                } else {
                	alert(json.message);
                }
                
                refurbish();
            },
	   		error:function(){
	   			alert("删除时出现异常！");
	   		}
        });
        
	}
}

 
	// 批量删除
	function batDelete(){
		var checkIds = document.getElementsByName("ids");
		var isCheck = false;
		
		for(var i=0;i<checkIds.length;i++){
			if (checkIds[i].checked){
				isCheck = true;
				if (!confirm("确定要删除字典数据吗?")){
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
		        url: "<%=path %>/admin/catalog/deleteBatch.do",
		   		type: "POST",
		   		cache:false,
		   		async:true,
		   		dataType: "json",
		   		data:{'ids':arr.toString()},
		        success:function(json, textStatus) {
	            if (json.code == "0") {
	            	alert(json.message);
	            } else {
	            	alert(json.message);
	            }
	                
	            refurbish();
	        },
		   	error:function(){
		   	    alert("批量删除时出现异常！");
		   	}
	    });
		}else{
			alert("没有选择项!");
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

</script>

