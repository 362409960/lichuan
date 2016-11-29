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
<title>节目发布</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta content="" name="description">
<meta content="" name="keywords">
<meta content="Cloudring" name="author">
<meta content="Cloudring" name="copyright">
<link rel="shortcut icon" href="<%=path%>/images/sys/icon/icon.png">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/sys/common.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/sys/main.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/sys/default.css">
<style type="text/css">
html,body{
	height:100%;
	width:100%;
	overflow:auto;
}
.boxList input[type=text]{
	width:90%;
}
.tbBorder
{
    border-left: 1px #eee solid;
    border-top: 1px #eee outset;
    border-bottom: 2px #eee inset;
    border-collapse: collapse;
    height: 30px;
    line-height: 30px;
    background-color: #bfc2cb;
    height: 36px;
}
.tbBorder tr td
{
    border-right: 2px #eee inset;
    height: 20px;
    line-height: 20px;
}
</style>

</head>

<body>
		<jsp:include page="/page/top.jsp" /> 
    <div class="container">
    	<form id="aspnetForm" action="<%=path%>/publish/toPublishFirst.do" method="post" name="aspnetForm">
        	<div id="divNavigate" class="procebox">
            	<span id="projectSet" class="procesucnotto">节目制作</span>
                <span id="publishSet" class="proceto">发布设置</span>
                <span id="publishSuccess" class="procenow">发布成功</span>
            </div>
            <div id="divProject">
            	<table class="boxList">
                	<colgroup>
                    	<col width="18%">
                        <col width="auto">
                        <col width="18%">
                        <col width="18%">
                        <col width="18%">
                    </colgroup>
                    <tr>
                    	<th><strong class="black">${publish.task_id}</strong></th>
                        <th>节目名称</th>
                        <th>节目类型</th>
                        <th>场景数</th>
                        <th>播放时间</th>
                    </tr>
                    <c:forEach items="${prorgam}" var="it"  varStatus="st">
					<tr>
                    	<th><a id="btn_preview" href="javascript:void(0)" onclick="preViewClick('${it.id}')" >预览</a></th>
                        <th>${it.program_name}</th>
                        <th>${it.program_type}</th>
                        <th>${it.scenes}</th>
                        <th>${it.play_time} 秒</th>
                    </tr>  
                    </c:forEach>                
                </table>
            </div>
            <div class="main_title">
            	发布信息
            </div>
            <table class="detailTable">
            	<colgroup>
                	<col width="10%">
                    <col width="10%">
                    <col width="16%">
                    <col width="16%">
                    <col width="16%">
                    <col width="11%">
                    <col width="auto">
                </colgroup>
                <tr>
                	<th>播放模式</th>
                    <th>是否独占</th>
                    <th>即时发布</th>
                    <th>申请时间</th>
                    <th>过期时间</th>
                    <th>申请人</th>
                    <th>备注</th>
                </tr>
                <tr>
                	<th>垫片播放</th>
                    <th>否</th>
                    <th><fmt:formatDate value="${publish.publish_time}" pattern="yyyy-MM-dd HH:mm"/></th>
                    <th><fmt:formatDate value="${publish.publish_time}" pattern="yyyy-MM-dd HH:mm"/></th>
                    <th><fmt:formatDate value="${publish.expiration}" pattern="yyyy-MM-dd HH:mm"/></th>
                    <th>${publish.publish_user}</th>
                    <th>&nbsp;</th>
                </tr>
            </table>
            <div class="release">
            	<div class="release_nav">
                	<ul>
                    	<li class="active">播放日程</li>
                        <li>终端列表</li>
                        <li>组列表</li>
                    </ul>
                </div>
                <div class="release_list">
                	<div class="release_tab">
                	    <c:choose> 
                	      <c:when test="${publish.playMode eq 0}">
	                	      <div class="release_tab_list" style="display: block;">
	                        	<p style="margin-top:40px;">该发布单中节目将在终端长期播放</p>
	                       	 </div>
                	      </c:when>
                	      <c:when test="${publish.playMode eq 1}">
                	          <div class="release_tab_list"  style="width: auto; border-left: solid 1px #CACAC8;display: block; ">
                                <table style="width: 100%; height: 28px;" border="0" cellspacing="0" cellpadding="2"
                                    class="tbList">
                                    <tr class="tbBorder" style="height: 28px;">
                                        <td style="width: 70%;" align="center">
                                            <span>按周为周期的日期</span>
                                        </td>
                                        <td style="width: 15%;" align="center">
                                            	开始时间
                                        </td>
                                        <td style="width: 15%;" align="center">
                                            	结束时间
                                        </td>
                                    </tr>
                                      <c:forEach items="${publish.timeVOlist}" var="it" varStatus="st">
                                    <tr>
                                      <td>${it.date}</td>
                                      <td>${it.startTime}</td>
                                      <td>${it.endTime}</td>                                    
                                    </tr>
                                    </c:forEach>
                                </table>
                               <!-- <div style="height: 60px; width: 100%; overflow-x: hidden; overflow-y: scroll;">
                                    <table id="showCycleDataInfoTable" style="width: 100%; border-collapse: collapse;"
                                        border="0" cellspacing="0" cellpadding="2" class="tbList">
                                    </table>
                                </div>  -->
                            </div>
                	      </c:when>
                	      <c:otherwise>
                	      	 <div  class="release_tab_list" style="width: auto; border-left: solid 1px #CACAC8; display: block;">
                                <table style="width: 100%;" border="0" cellspacing="0" cellpadding="2" class="tbList">
                                    <tr class="tbBorder" style="height: 28px;">
                                        <td style="width: 25%;" align="center">
                                            	开始日期
                                        </td>
                                        <td style="width: 25%;" align="center">
                                           	         结束日期
                                        </td>
                                        <td style="width: 25%;" align="center">
                                            	开始时间
                                        </td>
                                        <td style="width: 25%;" align="center">
                                            	结束时间
                                        </td>
                                    </tr>
                                       <c:forEach items="${publish.timeVOlist}" var="it" varStatus="st">
                                    <tr>
                                      <td>${it.startDate}</td>
                                      <td>${it.endDate}</td>
                                      <td>${it.startTime}</td>
                                      <td>${it.endTime}</td>
                                    </tr>
                                    </c:forEach>
                                </table>
                               <!-- <div style="height: 55px; width: 100%; overflow-x: hidden; overflow-y: scroll;">
                                    <table id="showDataInfoTable" style="width: 100%; border-collapse: collapse;" border="0"
                                        cellspacing="0" cellpadding="2" class="tbList">
                                    </table>
                                </div> -->
                            </div>
                	      
                	      </c:otherwise>
                	    </c:choose>
                    	
                       
                           
                        
                        <div class="release_tab_list">
                        	<ul>
                            	<li>${terminal.name}</li>
                            </ul>   
                        </div>
                        <div class="release_tab_list">
                        	<p style="margin-top:40px;">该发布单未设置发布到组</p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="main_title">
            	审批历史
            </div>
            <div class="history_list">
            	<table class="detailTable">
                    <colgroup>
                        <col width="20%">
                        <col width="15%">
                        <col width="15%">
                        <col width="*">
                    </colgroup>
                    <tr>
                        <td><fmt:formatDate value="${publish.publish_time}" pattern="yyyy-MM-dd HH:mm"/></td>
                        <td>${publish.publish_user}</td>
                        <td><c:choose>
                            <c:when test="${publish.state=='0'}">审批未通过</c:when>
                            <c:otherwise>审批通过</c:otherwise>
                        </c:choose></td>
                        <td>&nbsp;</td>
                    </tr>
                </table>
            </div>
            <div class="layer_btn">
            	<input type="button" value="重新发布" class="btn-01" id="republish">
               <!--  <input type="button" value="下载状态" class="btn-01"> -->
                <input type="button" value="返回" class="btn-01" onclick="window.location.href='<%=path%>/publish/toPublish.do'">
            </div>
        </form>
    </div>
<script type="text/javascript" src="<%=path%>/js/sys/jquery.js"></script>
<script type="text/javascript" src="<%=path%>/js/sys/common.js"></script>
<script type="text/javascript"  src="<%=path%>/layer/layer.js"></script>
<script>
var contextPath = "${pageContext.request.contextPath}";
$(function(){

 $("#v_index").removeClass("visiting");
 $("#v_program").addClass("visiting");
$("#v_terminal").removeClass("visiting");
$("#v_sys").removeClass("visiting");
$("#v_mater").removeClass("visiting");

	var $li=$('.release_nav').find('li');
	var $tabList=$('.release_tab_list');
	$li.bind('click',function(){
		var $this=$(this);
		$li.removeClass('active');
		$this.addClass('active');
		var $index=$this.index();
		$tabList.hide();
		$tabList.eq($index).show();
	});
	//重发
	$('#republish').click(function(){
	    window.location.href = contextPath + '/publish/toPublishFirst.do?id=${prorgam_id}&termainId=${terminal_id}'; 
	});
	
});
function preViewClick(id) {	
	var url_pattern = contextPath + '/program/toSearchPreview.do?id=' + id;
	var iWidth = 1024; // 弹出窗口的宽度;
	var iHeight = 768; // 弹出窗口的高度;	
	 window.open(url_pattern, "", "height=" + iHeight + ",width=" + iWidth + ",location=no,menubar=no,resizable=yes,status=no,toolbar=no,titlebar=no,scrollbars=yes", "");

}
</script>
</body>
</html>
