<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/tlds/c.tld" prefix="c"%>
<%@ taglib uri="/WEB-INF/tlds/fmt.tld" prefix="fmt"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>


<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>节目制作</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta content="" name="description">
<meta content="" name="keywords">
<meta content="Cloudring" name="author">
<meta content="Cloudring" name="copyright">
<link rel="shortcut icon" href="<%=path%>/images/sys/icon/icon.png">
<link href="<%=path%>/css/sys/common.css" rel="stylesheet" type="text/css">
<link href="<%=path%>/css/sys/main.css" rel="stylesheet" type="text/css">
<style type="text/css">
html,body{
	height:100%;
	width:100%;
	overflow:auto;
}
.title_Nav p span.title_span{
	font-size:13px;
	color:#000;
	font-weight:bold;
	font-family: Helvetica, sans-serif, 宋体;
	padding:0 30px;
}
</style>
</head>

<body>
	<jsp:include page="/page/top.jsp" />
    <div class="container">
    	<form id="aspnetForm" action="#" method="post" name="aspnetForm">
        	<div class="title_Nav">
            	<div class="title_text">
                	<p>
                    	<span style="font-size:12px;color:red;" title="${program.program_name}"><b>节目名称:&nbsp;${program.program_name}</b></span>
                        <span class="title_span">创建人:&nbsp;&nbsp;${program.user_name}</span>
              			<span class="title_span">终端所属机构:&nbsp;&nbsp;${program.affiliations}</span>
                    </p>
                </div>
            </div>
            <div class="blank3"></div>
            <table class="main_white">
            	<colgroup>
                	<col width="50%">
                    <col width="50%">
                </colgroup>
            	<tr>
                	<td align="left">
						&nbsp;
                    </td>
                    <td align="right">
                        <input type="button" class="btn-01" value="新建页面" id="add">
                        <c:if test="${pDetailsList.size()>0}"> 
                         	<input type="button" class="btn-01" value="预览" id="preView">
                       		 <input type="button" class="btn-01" value="发布" id="publish">
                         </c:if>
                         <c:if test="${pDetailsList.size()<0}"> 
                         	<input type="button" class="btn-01" value="预览"  disabled="disabled">
                       		 <input type="button" class="btn-01" value="发布" disabled="disabled" >
                         </c:if>
                        <input type="button" class="btn-01" value="返回" onclick="window.location.href='<%=path%>/program/toProject.do'">
                    </td>
                </tr>
            </table>
            <div class="table_box">
            	<table class="boxList" cellpadding="2">
                	<colgroup>
                    	<col width="10%">
                        <col width="15%">
                        <col width="15%">
                        <col width="15%">
                        <col width="15%">
                        <col width="15%">
                        <col width="15%">
                    </colgroup>
                    <thead>
                    	<tr>
                            <th>播放顺序</th>
                            <th>操作</th>
                            <th>页面名称</th>
                            <th>预览</th>
                            <th>更新时间</th>
                            <th>更新人</th>
                            <th>播放时间</th>
                        </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${pDetailsList}" var="it" varStatus="st">
                    	<tr>
                        	<th>
                            	${st.index + 1}
                            </th>
                            <th>
                            	<a class="aLink" target="_self" href="<%=path%>/program/toEdit.do?id=${it.id}">编辑</a>
                                |
                                <a href="javascript:;" onclick="deleteDetails('${it.id}')">删除</a>
                            </th>
                            <td>
                            	<span title="${it.scenes}">${it.scenes}</span>
                            </td>
                            <th>
                            	<a target="" href="javascript:void(0)" onclick="preViewClick('${it.id}')">
                                	<img src="<%=path%>/images/sys/icon/play.jpg" alt="">
                                </a>
                            </th>
                            <th><fmt:formatDate value="${it.create_time}" pattern="yyyy-MM-dd HH:mm"/></th>
                            <th>${it.creater_user}</th>
                            <th>${it.play_time}秒</th>
                        </tr>
                        </c:forEach>                       
                    </tbody>
                </table>
            </div>         
        </form>
    </div>
<script type="text/javascript" src="<%=path%>/js/sys/jquery.js"></script>
<script type="text/javascript" src="<%=path%>/js/sys/common.js"></script>
<script type="text/javascript"  src="<%=path%>/layer/layer.js"></script>
</body>
</html>
<script type="text/javascript">
var contextPath = "${pageContext.request.contextPath}";
var $listForm=$("#aspnetForm");
var $pageNumber=$("#pageNumber");
var $pageSize=$("#pageSize");
$(document).ready(function(){

 $("#v_index").removeClass("visiting");
 $("#v_program").addClass("visiting");
$("#v_terminal").removeClass("visiting");
$("#v_sys").removeClass("visiting");
$("#v_mater").removeClass("visiting");

   $('#add').click(function(){
         window.location.href = contextPath + '/program/toMake.do'; 
   });
   $('#publish').click(function(){
         window.location.href = contextPath + '/publish/toPublishFirst.do?id=${program.id}'; 
   });
   $('#preView').click(function(){ 
        var url_pattern = contextPath + '/program/toSearchPreview.do?id=${program.id}';
	   var iWidth = 1024; // 弹出窗口的宽度;
	   var iHeight = 768; // 弹出窗口的高度;	
	   window.open(url_pattern, "", "height=" + iHeight + ",width=" + iWidth + ",location=no,menubar=no,resizable=yes,status=no,toolbar=no,titlebar=no,scrollbars=yes", "");
   });
});

function deleteDetails(id){

layer.confirm('确定要删除吗？',{icon:3,title:'提示'}, function(index){
$.ajax({
          type: "post",
          url: contextPath + "/program/deleteDetails.do",
          data:{id:id},
          dataType: "json",
          success: function (data) {	            
             window.location.reload(true);	               
          },
          error: function (XMLHttpRequest, textStatus,errorThrown) {
              alert(errorThrown);
              return false;
          }
    });
},function(index){ layer.closeAll(index);});

}
function preViewClick(id) {	
	var url_pattern = contextPath + '/program/toSearchSonPreview.do?id=' + id;
	var iWidth = 1024; // 弹出窗口的宽度;
	var iHeight = 768; // 弹出窗口的高度;	
	 window.open(url_pattern, "", "height=" + iHeight + ",width=" + iWidth + ",location=no,menubar=no,resizable=yes,status=no,toolbar=no,titlebar=no,scrollbars=yes", "");

}
</script>