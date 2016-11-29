<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="/WEB-INF/tlds/c.tld" prefix="c"%>


<% 
    String path = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>菜单界面</title>
<link rel="stylesheet" type="text/css" href="<%=path%>/css/201202/main.css" />
<script type="text/javascript" src="<%=path%>/js/jquery.min.js"></script>

<style>
body {
    overflow-x:hidden;overflow-y:hidden;
}
</style>
</head>

<script language="JavaScript" type="text/JavaScript">
function showSubMenu(parentName,menuName,obj){
	//导航栏信息显示
	parent.parent.frames["banner"].document.getElementById("top_menuLevel1").innerHTML = parentName+"&nbsp;&gt;&nbsp;";
	parent.parent.frames["banner"].document.getElementById("top_menuLevel2").innerHTML = menuName;

	var obj1=parent.parent.frames["serv"];
	if(obj1!='undefined'&&obj1!=null){
		var myParm= obj1.document.getElementById("common.parm").value;	
		myParm=myParm.split(',');
		var urlParm="";
    	for(var i=0;i<myParm.length;i++){
        	if(myParm[i]!=''){ 
        		if(urlParm.indexOf(myParm[i]) < 0){
	        		if(i==0){
	            		urlParm="&"+myParm[i];
	                }else{
	                	urlParm=urlParm+"&"+myParm[i];
	                }
        		}
            }
        }
    	
    	if(urlParm!=''){
    		if(obj.href.indexOf(urlParm) < 0){
    			obj.href = obj.href + urlParm;
    		}
        }
    }
}
</script>

<body >
<div class="sme_mainl" id="menu" style="position: absolute;height: 96%;overflow: auto;overflow-x:hidden;">
    	<div class="sme_mainltit">栏目结构</div>
    	<c:forEach items="${menuList}" var="menu" varStatus="st" >
    	    
    	    <c:choose>
    	        <c:when test="${st.first}">
    	               <c:choose>
    	                   <c:when test="${st.last}">
    	                       <div class="sme_mininav sme_mininav_s">
    	                           <p><img height="16px" src="<%=path%>/${menu.menuImgUrl}" />${menu.name}</p>
    	                           <ul>
    	                               <c:forEach items="${menu.subMenuList}" var="sbuMenu" varStatus="subst">
    	                                   <c:choose>
    	                                       <c:when test="${subst.last}">
    	                                           <li><img src="<%=path%>/images/201202/mininav__09.gif" /><a title="${sbuMenu.name}" href="<%=path%>/${sbuMenu.url}" target="main" onclick="showSubMenu('${sbuMenu.parentName}','${sbuMenu.name}',this)"><img src="<%=path%>/${sbuMenu.menuImgUrl}" />${sbuMenu.name}</a></li>
    	                            		   </c:when>
			    	                           <c:otherwise>
			    	                               <li><img src="<%=path%>/images/201202/mininav__09.jpg" /><a title="${sbuMenu.name}" href="<%=path%>/${sbuMenu.url}" target="main" onclick="showSubMenu('${sbuMenu.parentName}','${sbuMenu.name}',this)"><img src="<%=path%>/${sbuMenu.menuImgUrl}" />${sbuMenu.name}</a></li>
			    	                           </c:otherwise>
    	                                   </c:choose>
    	                               </c:forEach>
    	                           </ul>
    	                       </div>
    	                   </c:when>
    	                   <c:otherwise>
		        				<div class="sme_mininav sme_mininav_g">
		        					<p><img height="16px" src="<%=path%>/${menu.menuImgUrl}" />${menu.name}</p>
		            				<ul>
										<c:forEach items="${menu.subMenuList}" var="sbuMenu" varStatus="subst">
										    <li><img src="<%=path%>/images/201202/mininav__09.jpg" /><a title="${sbuMenu.name}" href="<%=path%>/${sbuMenu.url}" target="main" onclick="showSubMenu('${sbuMenu.parentName}','${sbuMenu.name}',this)" ><img src="<%=path%>/${sbuMenu.menuImgUrl}" />${sbuMenu.name}</a></li>
										</c:forEach>
										
									</ul>
		        				</div>
    	                   </c:otherwise>
    	               </c:choose>     
    	        </c:when>
    	        
    	        <c:when test="${st.last}">
    	            <div class="sme_mininav sme_mininav_t">
    	                <p><img height="16px" src="<%=path%>/${menu.menuImgUrl}" /><span class="on">${menu.name}</span></p>
    	                <ul>
    	                    <c:forEach items="${menu.subMenuList}" var="sbuMenu" varStatus="subst">
    	                        <c:choose>
    	                            <c:when test="${subst.last}">
    	                                <li><img src="<%=path%>/images/201202/mininav__09.gif" /><a title="${sbuMenu.name}" href="<%=path%>/${sbuMenu.url}"  target="main" onclick="showSubMenu('${sbuMenu.parentName}','${sbuMenu.name}',this)"><img src="<%=path%>/${sbuMenu.menuImgUrl}" />${sbuMenu.name}</a></li>
    	                            </c:when>
    	                            <c:otherwise>
    	                                <li><img src="<%=path%>/images/201202/mininav__09.jpg" /><a title="${sbuMenu.name}" href="<%=path%>/${sbuMenu.url}"  target="main" onclick="showSubMenu('${sbuMenu.parentName}','${sbuMenu.name}',this)"><img src="<%=path%>/${sbuMenu.menuImgUrl}" />${sbuMenu.name}</a></li>
    	                            </c:otherwise>
    	                        </c:choose>
    	                    </c:forEach>
    	                </ul>
    	            </div>
    	        </c:when>
    	        
    	        <c:otherwise>
    	            <div class="sme_mininav">
    	                <p><img height="16px" src="<%=path%>/${menu.menuImgUrl}" />${menu.name}</p>
    	                <ul>
    	                    <c:forEach items="${menu.subMenuList}" var="sbuMenu" varStatus="subst">
    	                        <li><img src="<%=path%>/images/201202/mininav__09.jpg" /><a title="${sbuMenu.name}" href="<%=path%>/${sbuMenu.url}"  target="main" onclick="showSubMenu('${sbuMenu.parentName}','${sbuMenu.name}',this)"><img src="<%=path%>/${sbuMenu.menuImgUrl}" />${sbuMenu.name}</a></li>
    	                    </c:forEach>
    	                </ul>
    	            </div>
    	        </c:otherwise>
    	        
 
    	        
    	    </c:choose>
    	    
    	</c:forEach>
    	 
 </div>
<!-- footer end-->
<script type="text/javascript">
$(function(){
	$('#menu div.sme_mininav p').click(function(){
		$(this).parent().siblings().find('ul').hide();
		$(this).parent().siblings().find('p').removeClass('on');
		if($(this).attr('class')!='on'){
			$(this).next().show();
			$(this).addClass('on');
		}else{
			$(this).next().hide();
			$(this).removeClass('on');
		}
	});
});
</script>
</body>
</html>
