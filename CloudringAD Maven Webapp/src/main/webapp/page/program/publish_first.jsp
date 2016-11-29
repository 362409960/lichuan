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
<link rel="stylesheet" type="text/css" href="<%=path%>/css/sys/page.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/zTreeStyle/zTreeStyle.css"/>
<script type="text/javascript" src="<%=path%>/js/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript"  src="<%=path%>/layer/layer.js"></script>
<style type="text/css">
html,body{
	height:100%;
	width:100%;
	overflow:auto;
}
.boxList input[type=text]{
	width:90%;
}
#CyleTime,#userselfSeting{
	height:100px;
	width:88%;
	overflow-x:hidden;
	overflow-y:auto;
}
.weekplaytimelist li{
	padding:5px 0;
	overflow:auto;
}
.nofloat{
	clear:both;
}
.bgGray{
	background-color:#bfc2cb;
}
.tbDateTime tr.title td{
	background-color:#bfc2cb;
	height:30px;
	line-height:30px;
	padding:0
}
.tbDateTime tr td{
	border-width:1px;
	border-color:#eee #aaa #aaa #eee;
	border-style:solid;
	padding:5px 0;
}
.dataoperating{
	display:none;
}
#pTime{
	border: solid 1px #000;
	text-align: left;
}
.weekplaytimelist li{
	padding: 5px 0;
	overflow:auto;
}
.weekplaytimerow{
	height: 28px;
	padding:2px 4px 0 4px;
}
.pointer{
	cursor:pointer;
}
#name{
	white-space:nowrap;
	overflow:hidden;
	text-overflow:ellipsis;
	max-width: 300px;
}
</style>
</head>

<body>
	<jsp:include page="/page/top.jsp" /> 
    <div class="container">
    	<form id="aspnetForm" action="<%=path%>/publish/toPublishSecond.do" method="post" name="aspnetForm">
    	 <input type="hidden" name="program_id" id="program_id" value="${program_id}" />
    	  <input type="hidden" name="program_name" id="program_name" value="${program_name}" />
    	  <input type="hidden" name="publish_type" id="publish_type" value="0" />
    	  <input type="hidden" name="termainId" id="termainId" />
    	  <input type="hidden" name="modeContent" id="modeContent" />
        	<div id="divNavigate" class="procebox">
            	<span id="projectSet" class="proceto">节目制作</span>
                <span id="publishSet" class="procenow">发布设置</span>
                <span id="publishSuccess" class="procesucnotto">发布成功</span>
            </div>
          <!--   <div class="fl wid_p20">
            	<div class="box"><div id="menuTree" class="ztree"></div></div>
            	
            </div> -->
             <div class="fl wid_p20" >
            	<div class="box" style="overflow: auto;">          
            	 <div class="box_body">
                  	<div class="box_content" style="overflow: auto;">
                  		<div class="content_warp">
                  			<div class="tree left" >
                  				<div id="menuTree" class="ztree"></div>
                  			</div>
                  		</div>
                  	</div>
           		 </div>
            	</div>
            </div>
            
  
                    
                    
            <div class="fr wid_p80">
            	<div id="rightFun">
                	<div class="publish_content">
                    	<div class="publish_content_top">
                        	<div class="publish_content_title">
                            	<div class="publish_content_title_left">
                                	终端信息-已添加终端
                                    <span id="isPlayer">:(0)</span>
                                </div>
                                <div class="right">
                                	<input type="button" value="最大化" class="btn-01" onClick="maximization()">
                                    <input type="button" value="最小化" class="btn-01" onClick="minimize()">
                                    <input type="button" value="还原" class="btn-01" onClick="restore()">
                                </div>
                            </div>
                            <div class="publish_content_list">
                            	<table class="boxList">
                                	<colgroup>
                                    	<col width="5%">                                       
                                        <col width="12%">
                                        <col width="10%">
                                        <col width="12%">
                                        <col width="10%">
                                        <col width="10%">
                                        <col width="8%">
                                        <col width="18%">
                                        <col width="auto">
                                    </colgroup>
                                    <tr>
                                    	<th><input type="checkbox" id="checkAllPlayer"></th>                                       
                                        <th>名称</th>
                                        <th>终端状态</th>
                                        <th>终端IP</th>
                                        <th>分辨率</th>
                                        <th>磁盘剩余空间</th>
                                        <th>版本</th>
                                        <th>所属结构</th>
                                        <th>备注</th>
                                    </tr>
                                    <tr>
                                    	<th>&nbsp;</th>
                                        <th>
                                        	<input type="text" id="txt_PName" placeholder="过滤...">
                                        </th>
                                        <th>
                                        	<select name="status" id="status" >
                                            	<option value="">请选择</option>
                                                <option value="1">在线</option>
                                                <option value="0">离线</option>
                                            </select>
                                        </th>
                                        <th>
                                        	<input type="text"  id="txt_PIp" placeholder="过滤...">
                                        </th>                                        
                                        <th>
                                        	<input type="text" id="txt_PResolution" placeholder="过滤...">
                                        </th>
                                        <th>
                                        	<input type="text" id="txt_DiskSpace" placeholder="过滤...">
                                        </th>
                                        <th>
                                        	<input type="text" id="txt_PVersion" placeholder="过滤...">
                                        </th>
                                        <th>
                                        	<input type="text" id="txt_PSOrg" placeholder="过滤...">
                                        </th>
                                        <th>
                                        	<input type="text" id="txt_PNote" placeholder="过滤...">
                                        </th>
                                        
                                    </tr>
                                </table>
                                <div id="div_Player">
	                                <table id="grdPlayer" class="tbList" style="table-layout:fixed;word-break:break-all;background:#f2f2f2">	
	                                	<colgroup>                                    
	                                    	<col width="5%">                                       
                                        <col width="12%">
                                        <col width="10%">
                                        <col width="12%">
                                        <col width="10%">
                                        <col width="10%">
                                        <col width="8%">
                                        <col width="18%">
                                        <col width="auto">
	                                        </colgroup>                                      
	                                         <c:forEach items="${terminal.rows}" var="it" varStatus="st">
	                                        <tr>
	                                        	<td>
	                                            	<input id="${it.id}" value="${it.id}" name="ckBox" type="checkbox">
	                                            </td>	                                           
	                                            <td >${it.name}</td>
	                                            <td><c:choose><c:when test="${it.status=='0'}">离线</c:when><c:otherwise>在线</c:otherwise> </c:choose></td>
	                                            <td>${it.ip}</td>
	                                            <td>${it.reolution}</td>
	                                            <td>${it.firmware}</td>
	                                            <td>${it.version}</td>
	                                            <td>${it.mechanismName}</td>
	                                            <td>${it.remark}</td>
	                                        </tr>
	                                        </c:forEach>	                                        
	                                    </table>
                                </div>
                            </div>
                        </div>
                        <table class="play_list">
                        	<colgroup>
                            	<col width="90px">
                                <col width="auto">
                                <col width="90px">
                            </colgroup>
                            <tr>
                            	<td><strong class="black">节目列表: </strong></td>
                                <td id="name">${program_name}</td>
                                <td>
                                	<input type="button" value="选择节目" class="btn-01" id="popList">
                                </td>
                            </tr>	
                        </table>
                        <div class="play_info">
                        	节目过期时间:
                            <input type="text" class="Wdate" value="${nowTime}" id="expirationTime" name="expirationTime" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',minDate:'%y-%M-%d HH:mm'})" readonly>
                            
                            <select name="playMode" onChange="showList(this)" id="mode">
                            	<option value="0">垫片播放</option>
                                <option value="1">周期播放</option>
                                <option value="2">自定义播放</option>
                            </select>
                             <span id="spnDefined"  style="display: none;">
                                    <input type="checkbox" name="isEngross" id="isEngross" value="1" />
                                    <label for="isEngross">独占节目</label>
                              </span>
                            <input type="checkbox" id="timePublic" name="timePublic">
                            <label for="timePublic">定时发布</label>
                            <span id="spnPublishDate">
                            	<strong>:</strong>
                                <input type="text" class="Wdate" id="scheduledPublish" name="scheduledPublish" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',minDate:'%y-%M-%d HH:mm'})" readonly title=" 点击设置发布时间 ">                               
                            </span>
                        </div>
                       <div id="PlayMode" class="playmodeContainer">
                        	<div style="margin-top:40px" id="playModeCentext">该节目将在终端长期播放</div>
                        </div>
                        <div id="divCyclePlayMode" class="playmodeContainer hidden">
                        	<div class="left" style="width:12%">
                            	<input type="radio" value="Week" name="rdoCycle" id="rdoWeek" checked="checked">
                                <label for="rdoWeek" class="pointer">按周</label>
                            </div>
                            <div id="CyleTime">
                            	<ul class="weekplaytimelist" id="weekPlayTimeList" mode="view" data="">
                                    <li class="nofloat bgGray">
                                        <div style="width: 10%" class="left"><input type="hidden" class="data"   value="Monday">星期一</div>
                                        <div style="width: 70%" class="left">00:00:00-23:59:59</div>
                                        <div style="" class="left">
                                            <span><a href="#" class="playtimemodify">设置</a></span>
                                            <span class="dataoperating">
                                            	<a class="playtimesave" href="#">保存</a>
                                                <a class="playtimedelete" href="#">删除</a>
                                            </span>
                                        </div>
                                    </li>
                                    <li class="nofloat">
                                        <div style="width: 10%" class="left"><input type="hidden" class="data"   value="Tuesday">星期二</div>
                                        <div style="width: 70%" class="left">00:00:00-23:59:59</div>
                                        <div style="" class="left">
                                            <span><a href="#" class="playtimemodify">设置</a></span>
                                            <span class="dataoperating">
                                            	<a class="playtimesave" href="#">保存</a>
                                                <a class="playtimedelete" href="#">删除</a>
                                            </span>
                                        </div>
                                    </li>
                                    <li class="nofloat bgGray">
                                        <div style="width: 10%" class="left"><input type="hidden" class="data"   value="Wednesday">星期三</div>
                                        <div style="width: 70%" class="left">00:00:00-23:59:59</div>
                                        <div style="" class="left">
                                            <span><a href="#" class="playtimemodify">设置</a></span>
                                            <span class="dataoperating">
                                            	<a class="playtimesave" href="#">保存</a>
                                                <a class="playtimedelete" href="#">删除</a>
                                            </span>
                                        </div>
                                    </li>
                                    <li class="nofloat">
                                        <div style="width: 10%" class="left"><input type="hidden" class="data"   value="Thursday">星期四</div>
                                        <div style="width: 70%" class="left">00:00:00-23:59:59</div>
                                        <div style="" class="left">
                                            <span><a href="#" class="playtimemodify">设置</a></span>
                                            <span class="dataoperating">
                                            	<a class="playtimesave" href="#">保存</a>
                                                <a class="playtimedelete" href="#">删除</a>
                                            </span>
                                        </div>
                                    </li>
                                    <li class="nofloat bgGray">
                                        <div style="width: 10%" class="left"><input type="hidden" class="data"   value="Friday">  星期五</div>
                                        <div style="width: 70%" class="left">00:00:00-23:59:59</div>
                                        <div style="" class="left">
                                            <span><a href="#" class="playtimemodify">设置</a></span>
                                            <span class="dataoperating">
                                            	<a class="playtimesave" href="#">保存</a>
                                                <a class="playtimedelete" href="#">删除</a>
                                            </span>
                                        </div>
                                    </li>
                                    <li class="nofloat">
                                        <div style="width: 10%" class="left"><input type="hidden" class="data"   value="Saturday">星期六</div>
                                        <div style="width: 70%" class="left">00:00:00-23:59:59</div>
                                        <div style="" class="left">
                                            <span><a href="#" class="playtimemodify">设置</a></span>
                                            <span class="dataoperating">
                                            	<a class="playtimesave" href="#">保存</a>
                                                <a class="playtimedelete" href="#">删除</a>
                                            </span>
                                        </div>
                                    </li>
                                    <li class="nofloat bgGray">
                                        <div style="width: 10%" class="left"><input type="hidden" class="data"  value="Sunday">星期日</div>
                                        <div style="width: 70%" class="left">00:00:00-23:59:59</div>
                                        <div style="" class="left">
                                            <span><a href="#" class="playtimemodify">设置</a></span>
                                            <span class="dataoperating">
                                            	<a class="playtimesave" href="#">保存</a>
                                                <a class="playtimedelete" href="#">删除</a>
                                            </span>
                                        </div>
                                    </li>
                                    <li class="clear nofloat"></li> 
                                </ul>
                            </div>
                        </div>
                        <div id="divUserDefinedPlayMode" class="playmodeContainer hidden">
                        	<div class="left" style="width:12%;">
                            	<input type="button" id="btnAddDateTime" value="增加一行" class="btn-01">
                            </div>
                            <div id="userselfSeting">
                            	<table class="tbDateTime">
                                	<colgroup>
                                    	<col width="20%">
                                        <col width="20%">
                                        <col width="25%">
                                        <col width="25%">
                                        <col width="10%">
                                    </colgroup>
                                    <tr class="title">
                                    	<td>开始日期</td>
                                        <td>结束日期</td>
                                        <td>开始时间</td>
                                        <td>结束时间</td>
                                        <td>删除</td>
                                    </tr>
                                    <tr>
                                    	<td><input type="text" name="start" class="Wdate beinging" style="width:100px" onClick="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'%y-%M-%d'})" readonly></td>                                                   
                                        <td><input type="text" name="end" class="Wdate ended" style="width:100px" onClick="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'%y-%M-%d'})" readonly></td>                                                   
                                        <td>
                                        	<select class="sltDTBeginHour">
                                        	<c:forEach begin="00" end="23" step="1" var="hourIndex">
                                        	  <c:choose>
	                                        	  <c:when test="${hourIndex < 10 }"><option value="0${hourIndex }">0${hourIndex}</option></c:when>
	                                        	  <c:otherwise><option value="${hourIndex }">${hourIndex}</option></c:otherwise>
                                        	  </c:choose>                                            	
                                             </c:forEach>
                                            </select>
                                            :
                                            <select class="sltDTBeginMinute">
                                            	<c:forEach begin="00" end="59" step="1" var="minuteIndex">
	                                        	  <c:choose>
		                                        	  <c:when test="${minuteIndex < 10 }"><option value="0${minuteIndex }">0${minuteIndex}</option></c:when>
		                                        	  <c:otherwise><option value="${minuteIndex }">${minuteIndex}</option></c:otherwise>
	                                        	  </c:choose>                                            	
	                                            </c:forEach>
                                            </select>
                                            :
                                            <select class="sltDTBeginSecond">
                                            	<c:forEach begin="00" end="59" step="1" var="secondIndex">
	                                        	  <c:choose>
		                                        	  <c:when test="${secondIndex < 10 }"><option value="0${secondIndex }">0${secondIndex}</option></c:when>
		                                        	  <c:otherwise><option value="${secondIndex }">${secondIndex}</option></c:otherwise>
	                                        	  </c:choose>                                            	
	                                            </c:forEach>
                                            </select>
                                        </td>
                                        <td>
                                        	<select class="sltDTEndHour">                                        	 
                                            <c:forEach begin="00" end="23" step="1" var="hourIndex">
	                                        	  <c:choose>
		                                        	  <c:when test="${hourIndex < 10 }"><option value="0${hourIndex }">0${hourIndex}</option></c:when>
		                                        	  <c:otherwise>
		                                        	    <c:choose>
		                                        	      <c:when test="${hourIndex eq 23 }"> <option value="${hourIndex }" selected="selected">${hourIndex}</option></c:when>
		                                        	      <c:otherwise><option value="${hourIndex }" >${hourIndex}</option></c:otherwise>
		                                        	    </c:choose>		                                        	 
		                                        	  </c:otherwise>		                                        	 
	                                        	  </c:choose>                                            	
                                             </c:forEach>
                                            </select>
                                            :
                                            <select class="sltDTEndMinute">                                         
                                            	<c:forEach begin="00" end="59" step="1" var="minuteIndex">
	                                        	  <c:choose>
		                                        	  <c:when test="${minuteIndex < 10 }"><option value="0${minuteIndex }">0${minuteIndex}</option></c:when>
		                                        	  <c:otherwise> 
			                                        	  <c:choose>
			                                        	      <c:when test="${minuteIndex eq 59 }"> <option value="${minuteIndex }" selected="selected">${minuteIndex}</option></c:when>
			                                        	      <c:otherwise><option value="${minuteIndex }" >${minuteIndex}</option></c:otherwise>
			                                        	    </c:choose>		
		                                        	    </c:otherwise>
	                                        	  </c:choose>                                            	
	                                            </c:forEach>
                                            </select>
                                            :
                                            <select class="sltDTEndSecond">                                               
                                            	<c:forEach begin="00" end="59" step="1" var="secondIndex">
	                                        	  <c:choose>
		                                        	  <c:when test="${secondIndex < 10 }"><option value="0${secondIndex }">0${secondIndex}</option></c:when>
		                                        	  <c:otherwise> 
		                                        	  <c:choose>
			                                        	      <c:when test="${secondIndex eq 59 }"> <option value="${secondIndex }" selected="selected">${secondIndex}</option></c:when>
			                                        	      <c:otherwise><option value="${secondIndex }" >${secondIndex}</option></c:otherwise>
		                                        	    </c:choose>	
		                                        	    </c:otherwise>
	                                        	  </c:choose>                                            	
	                                            </c:forEach>
                                            </select>
                                        </td>
                                        <td><a href="javascript:;" class="del">删除</a></td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                        <div class="layer_btn">
                        	<input type="button" class="btn-01" value="确认发布" onClick="save();">
                            <input type="button" class="btn-01" value="返回" onclick="window.location.href='<%=path%>/program/toProject.do'">
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>
<div class="layer_list" style="display:none;">
	<table class="boxList"  id="boxlist">
    	<colgroup>
        	<col width="10%">
            <col width="15%">
            <col width="10%">
            <col width="10%">
            <col width="10%">
            <col width="7%">
            <col width="10%">
            <col width="auto">
            <col width="10%">
        </colgroup>
        <thead>
        <tr>
        	<th>
            	 <input type="checkbox" id="chkAll" name="chkAll"> 
            </th>
            <th>
            	节目名称<br>
                <input type="text" id="programName"  placeholder="输入名称后,回车即可搜索" title="输入名称后,回车即可搜索">
            </th>
            <th>分辨率</th>
            <th>节目类型</th>
            <th>播放时间</th>
            <th>场景数</th>
            <th>所属机构</th>
            <th>更新时间</th>
            <th>更新人</th>
        </tr>
        </thead>
        <tbody>
         <c:forEach items="${pm.rows}" var="list" varStatus="st">
        <tr>
        	<td style="text-align:center;font-weight:normal;color:#000;">
            	<input type="checkbox" value="${list.id}|${list.program_name}" name="chkItem">
                |
                <a target="" href="javascript:void(0)" onclick="preViewClick('${list.id}')">预览</a>
            </td>
            <td>${list.program_name}</td>
            <td>
            	<a target="_blank" href="javascript:;" >${list.resolution}</a>
            </td>
            <td>${list.program_type}</td>
            <td>${list.play_time}秒</td>
            <td>${list.scenes}</td>
            <td>${list.affiliations}</td>
            <td><fmt:formatDate value="${list.updated}" pattern="yyyy/MM/dd HH:mm:ss"/></td>
            <td>${list.user_name} </td>
        </tr>
        </c:forEach>
        <tr class="main_page">
			<td colspan="9"  style="text-align: right;">
			    <input type="hidden" name="pageNumber" id="pageNumber" value="${pm.pageNumber}" /> 
				<c:forEach var="i" begin="1" end="${pm.pageMax}">
					<c:choose>
						<c:when test="${i==pm.pageNumber}"><span style='color:Red;font-weight:bold'>${i}</span>&nbsp;&nbsp;</c:when>
						<c:otherwise><a href="javascript:$.pageSkip(${i});">${i} </a>&nbsp;&nbsp;</c:otherwise>
					</c:choose>						
				</c:forEach>
			</td>
		</tr>
		</tbody>
    </table>  
</div>

<script type="text/javascript" src="<%=path%>/js/sys/jquery.js"></script>
<script type="text/javascript" src="<%=path%>/js/sys/common.js"></script>
<script type="text/javascript"  src="<%=path%>/layer/layer.js"></script>
<script type="text/javascript" src="<%=path%>/js/zTree/jquery.ztree.all.js"></script>
<script type="text/javascript">
var maximization,minimize,restore;
(function(){
	var $publish_content_list=$('.publish_content_list'),
		$playmodeContainer=$('.playmodeContainer'),
		$divPlayer=$('#div_Player'),
		$CyleTime=$('#CyleTime'),
		$userselfSeting=$('#userselfSeting');
	maximization=function(){
		$publish_content_list.css('height','250px');
		$divPlayer.css('height','170px');
		$playmodeContainer.css('height',0);
	};
	minimize=function(){
		$publish_content_list.css({'height':0,'overflow':'hidden'});
		$playmodeContainer.css('height','250px');
		$CyleTime.css('height','180px');
		$userselfSeting.css('height','180px');
	};
	
	restore=function(){
		$publish_content_list.css('height','160px');
		$playmodeContainer.css('height','100px');
		$divPlayer.css('height','80px');
		$CyleTime.css('height','100px');
		$userselfSeting.css('height','100px');
	};
})();
</script>
<script type="text/javascript">
var zTree;
var setting = {
	check: {
		enable: true//复选框显示
	},
	data: {
		simpleData: {
			enable: true
		}
	},
	check:{ 
		enable:true,
		chkboxType : { "Y" : "s", "N" : "ps" }
	},
	callback:{	
		onCheck: onCheck
	}
};
	
//树的数据初始化
var zNodes;  
$(function(){  
    $.ajax({  
    	enable: true,
        async : false,  
        cache:false,  
        type: 'POST',  
        dataType : "json",  
        url: "<%=path%>/packet/packet_list.do",//请求的action路径  
        error: function () {//请求失败处理函数  
            alert('请求失败');  
        },  
        success:function(data){ //请求成功后处理函数。    
        	zNodes = eval(data.packets);   //把后台封装好的简单Json格式赋给treeNodes          	
        	zTree = $.fn.zTree.init($("#menuTree"), setting, zNodes);
        	zTree.expandAll(true);//节点展开
        }  
    });  
});  
function onCheck(e, treeId, treeNode) {
       var nodes = zTree.getCheckedNodes();
       var ids = "";
       for(var i=0; i<nodes.length; i++){
		tmpNode = nodes[i];
		if(i!=nodes.length-1){
			ids += tmpNode.id+",";
		}else{
			ids += tmpNode.id;
		}
	}
    var tbody= $("#grdPlayer");  
	 $.ajax({
           type: "post",
           url: contextPath + "/publish/termianlState.do",
           data:{ids:ids},
           dataType: "json",
           success: function (data) {
	           var jsonObj=data;	            
	           tbody.html("");
	           var html="<colgroup><col width=\"5%\"><col width=\"12%\"><col width=\"10%\"><col width=\"12%\"><col width=\"10%\"><col width=\"10%\"><col width=\"8%\">";
	           html+="<col width=\"18%\"> <col width=\"auto\"></colgroup>  ";	           
	           $.each(jsonObj, function (i, item) {
			       html+="<tr><td><input id="+item.id+" value="+item.id+" name=\"ckBox\" type=\"checkbox\"></td><td>"+item.name+"</td>";			    
			      if(item.status=='0'){html+="<td>离线</td>";}else{html+="<td>在线</td>";}
			      html+="<td>"+item.ip+"</td> <td>"+item.reolution+"</td><td>"+item.firmware+"</td><td>"+item.version+"</td><td>"+item.mechanismName+"</td><td>"+item.remark+"</td></tr>";
	     	  });
	     	  tbody.append(html);   
           },
           error: function (XMLHttpRequest, textStatus,errorThrown) {
               alert(errorThrown);
               return false;
           }
    });
}

var quickFindParam = [];
var quickFind = function (event, o, i) {
            var evt = event || window.event;
            var code = evt.which || evt.keyCode;
            quickFindParam[i] = $(o).val();
            var nodes = zTree.getCheckedNodes();
	       var ids = "";
	       for(var i=0; i<nodes.length; i++){
			tmpNode = nodes[i];
			if(i!=nodes.length-1){
				ids += tmpNode.id+",";
			}else{
				ids += tmpNode.id;
			}
		}
	    var quick="";
		 for(var i=0; i<quickFindParam.length; i++){
		        var tmp="";
		      	if(quickFindParam[i]==undefined){
		      	   tmp="";
		      	}else{
		      		tmp=quickFindParam[i];
		      	}			
			if(i!=quickFindParam.length-1){
				quick += tmp+",";
			}else{
				quick += tmp;
			}
		}
	 var tbody= $("#grdPlayer");  
	 $.ajax({
           type: "post",
           url: contextPath + "/publish/termianlStatuState.do",
           data:{ids:ids,quickFindParam:quick},
           dataType: "json",
           success: function (data) {
	           var jsonObj=data;	            
	           tbody.html("");
	           var html="<colgroup><col width=\"5%\"><col width=\"12%\"><col width=\"10%\"><col width=\"12%\"><col width=\"10%\"><col width=\"10%\"><col width=\"8%\">";
	           html+="<col width=\"18%\"> <col width=\"auto\"></colgroup>  ";	           
	           $.each(jsonObj, function (i, item) {
			       html+="<tr><td><input id="+item.id+" value="+item.id+" name=\"ckBox\" type=\"checkbox\"></td><td>"+item.name+"</td>";			    
			      if(item.status=='0'){html+="<td>离线</td>";}else{html+="<td>在线</td>";}
			      html+="<td>"+item.ip+"</td> <td>"+item.reolution+"</td><td>"+item.firmware+"</td><td>"+item.version+"</td><td>"+item.mechanismName+"</td><td>"+item.remark+"</td></tr>";
	     	  });
	     	  tbody.append(html);   
           },
           error: function (XMLHttpRequest, textStatus,errorThrown) {
               alert(errorThrown);
               return false;
           }
    }); 
};
$("#txt_PName").keyup(function (event) { quickFind(event, this, 0); });
$("#status").change(function (event) { quickFind(event, this, 1); });
$("#txt_PIp").keyup(function (event) { quickFind(event, this, 2); });
$("#txt_PResolution").keyup(function (event) { quickFind(event, this, 3); });
$("#txt_DiskSpace").keyup(function (event) { quickFind(event, this, 4); });
$("#txt_PVersion").keyup(function (event) { quickFind(event, this, 5); });
$("#txt_PSOrg").keyup(function (event) { quickFind(event, this, 6); });
$("#txt_PNote").keyup(function (event) { quickFind(event, this, 7); });
 

</script>
<script>
var contextPath = "${pageContext.request.contextPath}";
var prom_id='${program_id}';
var prom_name='${program_name}';

function showList(obj){
	var $playmodeContainer=$('.playmodeContainer');
	var $index=obj.selectedIndex;
	$playmodeContainer.addClass('hidden');
	$playmodeContainer.eq($index).removeClass('hidden');
	if('0'==$("#mode").val()){
	      $("#spnDefined").css("display","none");
	}else{
	     $("#spnDefined").css("display","");
	}
}
;(function(){
	var otimePublic=document.getElementById('timePublic');
	var ospnPublishDate=document.getElementById('spnPublishDate');
	var opopList=document.getElementById('popList');
	var grdPlayer=document.getElementById('grdPlayer');
	var oTr=grdPlayer.getElementsByTagName('tr');
	var $playmodeContainer=$('.playmodeContainer');
	var $tbDateTime=$('.tbDateTime');
	var $btnAddDateTime=$('#btnAddDateTime');
	var currentColor='597fbe';
	
	
	otimePublic.onclick=judeState;
	function judeState(){
		var status=this.checked;
		if(status){
			ospnPublishDate.style.display='inline';
		}else{
			ospnPublishDate.style.display='none';
		}
	}
	opopList.onclick=showList;
	function showList(){
		var index=layer.open({
			type:1,
			btn:[ '追加', '添加','取消'],
			title:['选择节目','font-size:14px;font-weight:bold'],
			shadeClose: true,
			shade: 0.8,
			area:['930px','auto'],
			content:$('.layer_list'),
			 btn1 : function() {
			 	var prom_ids=$("#program_id").val();
				var prom_names=$("#program_name").val();
			  	var msg_id='';
			  	var msg_name='';
				  $(".layer_list td").each(function(){
					    if($(this).find("input[type=checkbox]:checked").val() != undefined)
					    {
					     var msg=$(this).find("input[type=checkbox]:checked").val();					   
					      var str=msg.indexOf("|");					      
					      msg_id+=msg.substring(0,str)+',';	
					      msg_name+=msg.substring(str+1,msg.length)+'/';					    
					    }
					});
				var ids=msg_id.substring(0,msg_id.length-1);	
				var names=msg_name.substring(0,msg_name.length-1);	
				var pro_id=removeArrayRepeatId(ids,prom_ids);
				var pro_name=removeArrayRepeatName(names,prom_names);	
			    $("#program_id").val(pro_id);
			    $("#program_name").val(pro_name);
			    $("#name").text(pro_name);
			}, 
			btn2 : function() {
			var msg_id='';
			  	var msg_name='';
				  $(".layer_list td").each(function(){
					    if($(this).find("input[type=checkbox]:checked").val() != undefined){
					     var msg=$(this).find("input[type=checkbox]:checked").val();					   
					      var str=msg.indexOf("|");					      
					      msg_id+=msg.substring(0,str)+',';	
					      msg_name+=msg.substring(str+1,msg.length)+'/';					    
					    }
					});
				var ids=msg_id.substring(0,msg_id.length-1);	
				var names=msg_name.substring(0,msg_name.length-1);		
			    $("#program_id").val(ids);
			    $("#program_name").val(names);
			    $("#name").text(names);
			}
		}); 
	}
	
	for(var i=0,len=oTr.length;i<len;i++){
		oTr[i].onmouseover=fnOver;
		oTr[i].onmouseout=fnOut;
	}
	
	function fnOver(){
		currentColor=this.style.backgroundColor;
		this.style.backgroundColor='#597fbe';
		this.style.color='white';
	}
	function fnOut(){
		this.style.backgroundColor=currentColor;
		this.style.color='black';
	}
	$playmodeContainer.delegate('.del','click',function(){
		$(this).parents('tr').remove();
	});
	
	$playmodeContainer.delegate('.playtimemodify','click',function(){
		var $this=$(this);
		var $thisParent=$this.parent('span');
		$thisParent.hide();
		$thisParent.next('.dataoperating').show();
		var $editorContainer = $('<p id="pTime"></p>');
		var timeSting=$this.parents('.left').prev('.left').html();
		if(timeSting){
			var timeArr=timeSting.split(',');
			var $html='';
			for(var i=0,len=timeArr.length;i<len;i++){
				var playtimeRow = $('<p class="weekplaytimerow"></p>');
				var $rowValue=timeArr[i];
				var $ymd=$rowValue.split('-')[0];
				var $hms=$rowValue.split('-')[1];
				var $rowYear=$ymd.split(':')[0];
				var $rowMon=$ymd.split(':')[1];
				var $rowDate=$ymd.split(':')[2];
				var $rowHour=$hms.split(':')[0];
				var $rowMin=$hms.split(':')[1];
				var $rowSecond=$hms.split(':')[2];			
				$html=createSelect(24,$rowYear,'start-hour')+':'+createSelect(60,$rowMon,'start-min')+':'+createSelect(60,$rowDate,'start-second')+':'+
				createSelect(24,$rowHour,'end-hour')+':'+createSelect(60,$rowMin,'end-min')+':'+createSelect(60,$rowSecond,'end-second');
				playtimeRow.append($html);
				$('<a></a>').text('删除').click(function () {
					$(this).parents('.weekplaytimerow').remove();
				}).addClass('pointer').appendTo(playtimeRow);
				if(i==0){
					$('<a style="margin-left:10px;">+增加时间段</a>').click(function(){
						var playtimeRow = $('<p class="weekplaytimerow"></p>');
						var $weekPlayTimeRow=$('.weekplaytimerow');
						var $lastLen=$weekPlayTimeRow.length-1;
						
						var $lastHour=$weekPlayTimeRow.eq($lastLen).find('.end-hour').val();
						var $lastMin=$weekPlayTimeRow.eq($lastLen).find('.end-min').val();
						var $lastSec=$weekPlayTimeRow.eq($lastLen).find('.end-second').val();
						
						var $html=createSelect(24,$lastHour,'start-hour')+':'+createSelect(60,$lastMin,'start-min')+':'+createSelect(60,$lastSec,'start-second')+':'+
				createSelect(24,23,'end-hour')+':'+createSelect(60,59,'end-min')+':'+createSelect(60,59,'end-second');
						playtimeRow.append($html);
						$editorContainer.append(playtimeRow);
						 $('<a></a>').text('删除').click(function () {
							$(playtimeRow).remove();
						}).addClass('pointer').appendTo(playtimeRow);
					}).addClass('pointer').appendTo(playtimeRow);	
				}
				$editorContainer.append(playtimeRow);
			}
		}else{
			var playtimeRow = $('<p class="weekplaytimerow"></p>');
			$html=createSelect(24,0,'start-hour')+':'+createSelect(60,0,'start-min')+':'+createSelect(60,0,'start-second')+':'+
				 createSelect(24,23,'end-hour')+':'+createSelect(60,59,'end-min')+':'+createSelect(60,59,'end-second');
			playtimeRow.append($html);
			$('<a></a>').text('删除').click(function () {
				$(playtimeRow).remove();
			}).addClass('pointer').appendTo(playtimeRow);
			
			$('<a style="margin-left:10px;">+增加时间段</a>').click(function(){
				var playtimeRow = $('<p class="weekplaytimerow"></p>');
				var $weekPlayTimeRow=$('.weekplaytimerow');
				var $lastLen=$weekPlayTimeRow.length-1;
				
				var $lastHour=$weekPlayTimeRow.eq($lastLen).find('.end-hour').val();
				var $lastMin=$weekPlayTimeRow.eq($lastLen).find('.end-min').val();
				var $lastSec=$weekPlayTimeRow.eq($lastLen).find('.end-second').val();
				
				var $html=createSelect(24,$lastHour,'start-hour')+':'+createSelect(60,$lastMin,'start-min')+':'+createSelect(60,$lastSec,'start-second')+':'+
		createSelect(24,23,'end-hour')+':'+createSelect(60,59,'end-min')+':'+createSelect(60,59,'end-second');
				playtimeRow.append($html);
				$editorContainer.append(playtimeRow);
				 $('<a></a>').text('删除').click(function () {
					$(playtimeRow).remove();
				}).addClass('pointer').appendTo(playtimeRow);
			}).addClass('pointer').appendTo(playtimeRow);

			$editorContainer.append(playtimeRow);
		}
		$this.parents('.left').prev('.left').append($editorContainer);
	});
	$playmodeContainer.delegate('.playtimesave','click',function(){
		var $that=$(this);
		var $pTime=$that.parents('li').find('#pTime');
		var $weekplaytimerow=$pTime.find('.weekplaytimerow');
		var $timePlace=$that.parents('.left').prev('.left');
		var $str='';
		var bFlag=false;
		if($weekplaytimerow.length!=0){
			var succLen=$weekplaytimerow.length;
			$weekplaytimerow.each(function(index,element){
				var $this=$(this);
				var startHour=$this.find('.start-hour').val();
				var startMinute=$this.find('.start-min').val();
				var startSecond=$this.find('.start-second').val();
				var endHour=$this.find('.end-hour').val();
				var endMinute=$this.find('.end-min').val();
				var endSecond=$this.find('.end-second').val();
				var $playTimeRow=$(this).prev('.weekplaytimerow');
				var $prevHour=$playTimeRow.find('.end-hour').val();
				var $prevMin=$playTimeRow.find('.end-min').val();
				var $prevSec=$playTimeRow.find('.end-second').val();			
				var startTime=new Date();
				startTime.setHours(startHour);
				startTime.setMinutes(startMinute);
				startTime.setSeconds(startSecond);
				var endTime=new Date();
				endTime.setHours(endHour);
				endTime.setMinutes(endMinute);
				endTime.setSeconds(endSecond);
				var prevTime=new Date();
				prevTime.setHours($prevHour);
				prevTime.setMinutes($prevMin);
				prevTime.setSeconds($prevSec);
				var startTimeStamp=startTime.getTime();
				var endTimeStamp=endTime.getTime();
				var prevTimeStamp=prevTime.getTime();
				if($playTimeRow[0]){
				    if(prevTimeStamp >= startTimeStamp){
						succLen--;
						//alert('开始时间必须早已结束时间!');
						layerAlter("提示","开始时间必须早已结束时间!");
						return false;
					}
				}
				if(startTimeStamp >= endTimeStamp){
					succLen--;
					//alert('开始时间必须早已结束时间!');
					layerAlter("提示","开始时间必须早已结束时间!");
					return false;
				}
			});

			if(succLen==$weekplaytimerow.length){
				$that.parent('span').hide().prev('span').show();
				$html='';
				$weekplaytimerow.each(function(index,element){
					var $this=$(this);
					var startHour=$this.find('.start-hour').val();
					var startMinute=$this.find('.start-min').val();
					var startSecond=$this.find('.start-second').val();
					var endHour=$this.find('.end-hour').val();
					var endMinute=$this.find('.end-min').val();
					var endSecond=$this.find('.end-second').val();
					$html+=startHour+':'+startMinute+':'+startSecond+'-'+endHour+':'+endMinute+':'+endSecond+',';
				});
				$html=$html.substring(0,$html.lastIndexOf(','));
				$timePlace.html($html);
			}
		}else{
			$timePlace.html('');
			$pTime.hide();
			$that.parent('span').hide().prev('span').show();
		}
	});

	$playmodeContainer.delegate('.playtimedelete','click',function(){
		var $this=$(this);
		$this.parents('span').hide();
		$this.parents('span').prev('span').show();
		$this.parents('.left').prev('.left').html('');
	});
	

	$btnAddDateTime.bind('click',function(){
		var $tr='<tr><td><input type="text" name="start" class="Wdate beinging" style="width:100px" onClick="WdatePicker({dateFmt:\'yyyy-MM-dd\',minDate:\'%y-%M-%d\'})" readonly></td><td><input type="text" name="end" class="Wdate ended" style="width:100px" onClick="WdatePicker({dateFmt:\'yyyy-MM-dd\',minDate:\'%y-%M-%d\'})" readonly></td><td>'+
                 createSelect(24,0,'sltDTBeginHour')+" : "+createSelect(60,0,'sltDTBeginMinute')+" : "+createSelect(60,0,'sltDTBeginSecond')+'</td><td>'+
				 createSelect(24,23,'sltDTEndHour')+' : '+createSelect(60,59,'sltDTEndMinute')+' : '+createSelect(60,59,'sltDTEndSecond')+'</td><td><a href="javascript:;" class="del">删除</a></td></tr>';
		$tbDateTime.append($tr);
	});
	
	
	var $checkAllPlayer=$('#checkAllPlayer');
	var $aCheckBox=$(':checkbox[name=ckBox]');
	var $isPlayer=$('#isPlayer');
    var $contentList=$('.publish_content_list');
	
	$contentList.delegate(':checkbox[name=ckBox]','click',function(){
		var $this=$(this);
		var $aCheckBox=$(':checkbox[name=ckBox]');
		var $aChLen=$(':checkbox[name=ckBox]:checked').length;
		var $aBox=$aCheckBox.length;
		if($aChLen==$aBox){
			$checkAllPlayer.attr('checked',this.checked);
		}else{
			$checkAllPlayer.removeAttr('checked');
		}
		$aChLen > 0 ? $isPlayer.html('&gt;<b>播放终端:'+$aChLen+'</b>'): $isPlayer.html(':(0)');
		if($aChLen > 0){
				var msg_id='';
			    $("#div_Player td").each(function(){
				    if($(this).find("input[type=checkbox]:checked").val() != undefined){				    
				      msg_id+=$(this).find("input[type=checkbox]:checked").val()+',';
				    }
				});
				var ids=msg_id.substring(0,msg_id.length-1);						
				$("#publish_type").val("0");	
				$("#termainId").val(ids);	 
			}
	});
	
	$contentList.delegate('#checkAllPlayer','click',function(){
		var $aCheckBox=$(':checkbox[name=ckBox]');
		var _this=this;
		$aCheckBox.each(function(index, element) {
            $(this).attr('checked',_this.checked);
        });
		var $aChLen=$(':checkbox[name=ckBox]:checked').length;
		$aChLen > 0 ? $isPlayer.html('&gt;<b>播放终端:'+$aChLen+'</b>'): $isPlayer.html(':(0)');
		if($aChLen > 0){
				var msg_id='';
			    $("#div_Player td").each(function(){
				    if($(this).find("input[type=checkbox]:checked").val() != undefined){				    
				      msg_id+=$(this).find("input[type=checkbox]:checked").val()+',';
				    }
				});
				var ids=msg_id.substring(0,msg_id.length-1);						
				$("#publish_type").val("0");	
				$("#termainId").val(ids);	 
			}
	});
	
	
//分页	
$.pageSkip = function(pageNumber) {
    var tbody= $("#boxlist tbody");  
      var programName=trim($("#programName").val());
	 $.ajax({
           type: "post",
           url: contextPath + "/publish/pageQuery.do",
           data:{pageNumber:pageNumber,programName:programName},
           dataType: "json",
           success: function (data) {
	           var pm=data[0].pm;	            
	           tbody.html("");
	           var html="";
	           var rows=pm.rows;          
	           $.each(rows, function (i, item) {
			        html+="<tr><td style=\"text-align:center;font-weight:normal;color:#000;\"><input type=\"checkbox\" value="+item.id+"|"+item.program_name+" name=\"chkItem\">|";
					html+=" <a target=\"\" href=\"javascript:void(0)\" onclick=\"preViewClick(\'"+item.id+"\')\">预览</a></td>";
					html+="<td>"+item.program_name+"</td><td><a target=\"_blank\" href=\"javascript:;\" >"+item.resolution+"</a></td>";
					html+="<td>"+item.program_type+"</td><td>"+item.play_time+"秒</td><td>"+item.scenes+"</td><td>"+item.affiliations+"</td>";
					html+=" <td>"+item.view_time+"</td><td>"+item.user_name+"</td></tr>";
	     	  });
				html+="<tr class=\"main_page\"><td colspan=\"9\"  style=\"text-align: right;\">";
				for(var i=1;i<=pm.pageMax;i++){
				    if(i==pm.pageNumber){
				    html+="<span style='color:Red;font-weight:bold'>"+i+"</span>&nbsp;&nbsp;" ;
				    }else{
				    html+="<a href=\"javascript:$.pageSkip("+i+");\">"+i+"</a>&nbsp;&nbsp;";
				    }
				}
	            tbody.append(html);                       
           },
           error: function (XMLHttpRequest, textStatus,errorThrown) {
               alert(errorThrown);
               return false;
           }
    });
	
};

$(document).keydown(function(event) {
		if (event.keyCode == 13) {
			$("#programName").click();
		}
	});

	$("#programName").click(function() {
	    var tbody= $("#boxlist tbody"); 
	    var programName=trim($("#programName").val());
		$.ajax({
           type: "post",
           url: contextPath + "/publish/pageQuery.do",
           data:{pageNumber:1,programName:programName},
           dataType: "json",
           success: function (data) {
	           var pm=data[0].pm;	            
	           tbody.html("");
	           var html="";
	           var rows=pm.rows;          
	           $.each(rows, function (i, item) {
			        html+="<tr><td style=\"text-align:center;font-weight:normal;color:#000;\"><input type=\"checkbox\" value="+item.id+"|"+item.program_name+" name=\"chkItem\">|";
					html+=" <a target=\"\" href=\"javascript:void(0)\" onclick=\"preViewClick(\'"+item.id+"\')\">预览</a></td>";
					html+="<td>"+item.program_name+"</td><td><a target=\"_blank\" href=\"javascript:;\" >"+item.resolution+"</a></td>";
					html+="<td>"+item.program_type+"</td><td>"+item.play_time+"秒</td><td>"+item.scenes+"</td><td>"+item.affiliations+"</td>";
					html+=" <td>"+item.view_time+"</td><td>"+item.user_name+"</td></tr>";
	     	  });
				html+="<tr class=\"main_page\"><td colspan=\"9\"  style=\"text-align: right;\">";
				for(var i=1;i<=pm.pageMax;i++){
				    if(i==pm.pageNumber){
				    html+="<span style='color:Red;font-weight:bold'>"+i+"</span>&nbsp;&nbsp;" ;
				    }else{
				    html+="<a href=\"javascript:$.pageSkip("+i+");\">"+i+"</a>&nbsp;&nbsp;";
				    }
				}
	            tbody.append(html);                       
           },
           error: function (XMLHttpRequest, textStatus,errorThrown) {
               alert(errorThrown);
               return false;
           }
    });
	});
})();

 $(document).ready(function(){
  $("#v_index").removeClass("visiting");
 $("#v_program").addClass("visiting");
$("#v_terminal").removeClass("visiting");
$("#v_sys").removeClass("visiting");
$("#v_mater").removeClass("visiting");
 
	$('#chkAll').click(function(){
		var _this=this;
		var oCheckbox=$('.layer_list').find("input[type=checkbox]");
		oCheckbox.each(function(index, element) {
			$(this).attr('checked',_this.checked);
		});
	});	
	
	 var ckBox=$('.layer_list td').find('input[type=checkbox]');	
	ckBox.each(function(index, element) {
        $(element).click(function(){
			if($('.layer_list td').find('input[type=checkbox]:checked').length==ckBox.length){
				$('#chkAll').attr('checked',true);	
			}else{
				$('#chkAll').attr('checked',false);
			}
		});
    });

}); 

function save(){
    var $form=$("#aspnetForm");
    var name=$("#name").text();
    var mode=$("#mode").val();
    var scheduledPublish=$("#scheduledPublish").val();
    var expirationTime=$("#expirationTime").val();
    var isPlayer=$("#isPlayer").text();
    if(expirationTime == null || trim(expirationTime) == ''){     	
     	layerAlter("提示","节目过期时间不能为空");
	      return false;
    }
    if ($('#timePublic').attr('checked')) {
           if (scheduledPublish == null || trim(scheduledPublish) == '') {	     
	      layerAlter("提示","定时发布时间不能为空");
	      return false;
	    }else{
		     if(!checkAheadNowDate(scheduledPublish)){
	          // alert("定时发布时间必须大于等于当前时间");
	            layer.alert('定时发布时间必须大于等于当前时间');
	           return false;
	    	}
	    }
	   
    }
    if(':(0)'==isPlayer){
     layerAlter("提示","请选择终端");
      return false;      
    }
    if (name == null || trim(name) == '') {
     // alert("节目不能为空。");
      layerAlter("提示","节目不能为空。");
      return false;
    }
    if("0"==mode){     
       $("#modeContent").val($("#playModeCentext").text());     
    }else if("1"==mode){
       var $objTime=[];
    	var $weekPlayTimeList=$("#weekPlayTimeList .nofloat");
    	$weekPlayTimeList.each(function(index,element){
    	   var $subObj={}; 
    		var $this=$(this);
    		var $time=$this.find(".left:eq(1)").html();
    		var $date=$this.find(".left:eq(0)").find(".data").val();
    		if($time !=null && $date!=undefined){
    			$subObj[''+$date+'']=$time;
    			$objTime.push($subObj);
    		}
    	});
 	 var modeContent = JSON.stringify($objTime);    	
     $("#modeContent").val(modeContent);
    }else{    	
     var $tr=$('.tbDateTime').find('tr:not(".title")'); 
     var $objTime=[];
     var startSnap; //上一td的结束日期
     $tr.each(function(i, element){
        var $this=$(this);
        var $subObj={}; 
        var $begin=$this.find('.beinging').val();
        var $end=$this.find('.ended').val(); 
        if($begin==null || trim($begin) == '' ){
           //alert("请选择开始日期");
             layerAlter("提示","请选择开始日期");
           return false;
        }
        if($end==null || trim($end) == '' ){
          //alert("开始日期必须早已结束日期!");
          layerAlter("提示","开始日期必须早已结束日期!");
           return false;
        }
        if($begin >= $end){				
			//alert('开始日期必须早已结束日期!');
			layerAlter("提示","开始日期必须早已结束日期!");
			return false;
		}
		if(i>0){
		    if($begin <= startSnap){
		       // alert('开始日期必须早已结束日期!');
		        layerAlter("提示","开始日期必须早已结束日期!");
			   return false;
		    }
		}
		startSnap=$end;
        var $sltDTBeginHour=$this.find('.sltDTBeginHour').val();
        var $sltDTBeginMinute=$this.find('.sltDTBeginMinute').val();
        var $sltDTBeginSecond=$this.find('.sltDTBeginSecond').val();
        var $sltDTEndHour=$this.find('.sltDTEndHour').val();
        var $sltDTEndMinute=$this.find('.sltDTEndMinute').val();
        var $sltDTEndSecond=$this.find('.sltDTEndSecond').val();        
        $subObj['startTime']=$begin+" "+$sltDTBeginHour+":"+$sltDTBeginMinute+":"+$sltDTBeginSecond;
		$subObj['endTime']=$end+" "+$sltDTEndHour+":"+$sltDTEndMinute+":"+$sltDTEndSecond;
       $objTime.push($subObj);
     });
      var modeContent = JSON.stringify($objTime);    
     $("#modeContent").val(modeContent);     
    }
    if(!checkAheadNowDate(expirationTime)){
         
            layerAlter("提示","节目过期时间必须大于等于当前时间");
           return false;
    }
    $form.submit();
}
function checkAheadNowDate(beginTime){
    var now = new Date();
    var year = new Date().getFullYear();
     var month = new Date().getMonth()+1;
     var Minutes=now.getMinutes();     
     var Hours = now.getHours();
     if (month<10){month="0"+month;}
     var today=new Date().getDate();
     if (today<10){ today="0"+today; }
     if(Minutes<10){Minutes="0"+Minutes;}
     if(Hours<10){Hours="0"+Hours;}    
     var nowTime = year + "-" + month + "-" + today+' '+Hours + ":" + Minutes;
    if (beginTime < nowTime) {         
         return false;
     }
     return true;
 }

function trim(str) {
	// 删除左右两端的空格
	return str.replace(/(^\s*)|(\s*$)/g, "");
}

function preViewClick(id) {	
	var url_pattern = contextPath + '/program/toSearchPreview.do?id=' + id;
	var iWidth = 1024; // 弹出窗口的宽度;
	var iHeight = 768; // 弹出窗口的高度;	
	 window.open(url_pattern, "", "height=" + iHeight + ",width=" + iWidth + ",location=no,menubar=no,resizable=yes,status=no,toolbar=no,titlebar=no,scrollbars=yes", "");
}
//比较数组重复数据里面的重复数据
function removeArrayRepeatId(arry, repeat) {
	var arr = arry.split(',');
	var new_arr = [];
	arr.push(repeat);
	for ( var i = 0; i < arr.length; i++) {
		var items = arr[i];	
		if($.inArray(items,new_arr)==-1) {
			new_arr.push(items);
		}	
	}
   var result=new_arr.join(",");  
  return result;
}
function removeArrayRepeatName(arry, repeat) {
	var arr = arry.split("/");
	var new_arr = [];
	arr.push(repeat);
	for ( var i = 0; i < arr.length; i++) {
		var items = arr[i];		
		if($.inArray(items,new_arr)==-1) {
			new_arr.push(items);
		}	
	}
   var result=new_arr.join("/");  
  return result;
}


function createSelect(len,selectIndex,sClass){
	var len=len||60;
	var selectIndex=selectIndex||0;
	var sClass=sClass||'';
	var oDiv=document.createElement('div');
	var oSelect=document.createElement('select');
	if(sClass){
		oSelect.className=sClass;
	}
	var oFragment = document.createDocumentFragment();
	for(var i=0;i<len;i++){
		var option=document.createElement('option');
		option.value=i<10 ? '0'+i : i;
		option.text=i<10 ? '0'+i : i;
		if(selectIndex==i){
			option.setAttribute('selected','true');
		}
		oFragment.appendChild(option);
	}
	oSelect.appendChild(oFragment);
	oDiv.appendChild(oSelect);
	return oDiv.innerHTML;
}
function toDouble(num){
	if(num<10){
		num='0'+num;
	}
	return num;
}
</script>
</body>
</html>
