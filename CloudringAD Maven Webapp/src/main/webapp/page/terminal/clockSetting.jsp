<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/tlds/c.tld" prefix="c"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta charset="utf-8">
<title>定时开关机</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta content="" name="description">
<meta content="" name="keywords">
<meta content="Cloudring" name="author">
<meta content="Cloudring" name="copyright">
<link rel="shortcut icon" href="<%=path %>/images/icon/icon.png">
<link rel="stylesheet" type="text/css" href="<%=path %>/css/common.css">
<link rel="stylesheet" type="text/css" href="<%=path %>/css/main.css">
<link rel="stylesheet" href="<%=path %>/css/jquery-ui.css">
<link rel="stylesheet" href="<%=path %>/css/jquery.cxcolor.css">
<style type="text/css">
html,body{
	height:100%;
	width:100%;
	overflow:auto;
}
body{
	background-color:#bfc2cb;
	background-image:none;
}
#time table td{
	padding-left:16px;
	text-align:left
}
#time table td a{
	display:none;
}
#time table .tbListRow > td{
	padding-left:0;
}
#time table .tbListRow td{
	border-color:transparent #aaa #aaa transparent;	
}
#time table .tbListRow td tr td{
	border-bottom:none;
}
.tbListRow{
	display:none;
}
</style>
</head>

<body>
<div class="dialomain">
	<form id="aspnetForm" method="post" name="aspnetForm">
	<input type="hidden" id="terminalIds" >
    	<div class="main_nav">
            <span>终端定时开关机设置:</span>
        </div>
       	<div class="blank3"></div>
        <div id="time">
        	<table class="tbList">
            	<colgroup>
                	<col width="20%">
                    <col width="40%">
                    <col width="40%">
                </colgroup>
                <c:if test="${timeSwitchs.size() != 0 }">
                <c:set var="isDoing" value="1"/>
                <c:set var="timeSwitchId" value=""/> 
                <c:forEach items="${timeSwitchs }" var="timeSwitch">
                	<c:if test="${timeSwitch.week == 'Monday' && isDoing == 1}">
                	<c:set var="timeSwitchId" value="${timeSwitch.id }"/> 
                	<c:set var="isDoing" value="0"/> 
	                <tr>
	                	<td>
	                    	<span class="enable_check">
	                   			<c:if test="${timeSwitch.iscycling == 1 }">
	                       			<input type="checkbox" checked  value="Monday">
	                       		</c:if>
	                       		<c:if test="${timeSwitch.iscycling == 0 }">
	                       			<input type="checkbox"  value="Monday">
	                       		</c:if>
	                            <label for="">星期一</label>
	                        </span>
	                    </td>
	                    <td>
	                    	<span>开机</span>
	                        <select class="sel-45 open_hour" >
	                        	<c:forEach begin="00" end="23" step="1" var="hourIndex">
	                        		<c:if test="${hourIndex < 10 }">
	                        			<c:if test="${hourIndex == timeSwitch.powerHour}">
	                        				<option value="0${hourIndex }" selected="selected">0${hourIndex}</option>
	                        			</c:if>
				                        <c:if test="${hourIndex != timeSwitch.powerHour}">
	                        				<option value="0${hourIndex }">0${hourIndex}</option>
	                        			</c:if>			
	                        		</c:if>
	                        		<c:if test="${hourIndex >= 10 }">
	                        			<c:if test="${hourIndex == timeSwitch.powerHour}">
	                        				<option value="${hourIndex }" selected="selected">${hourIndex}</option>
	                        			</c:if>
				                        <c:if test="${hourIndex != timeSwitch.powerHour}">
	                        				<option value="${hourIndex }">${hourIndex}</option>
	                        			</c:if>	
	                        		</c:if>
	                        	</c:forEach>
	                        </select>
	                        <span>:</span>
	                        <select class="sel-45 open_minute" >
	                        	<c:forEach begin="00" end="59" step="1" var="minuteIndex">
	                        		<c:if test="${minuteIndex < 10 }">
	                        			<c:if test="${minuteIndex == timeSwitch.powerMinute}">
	                        				<option value="0${minuteIndex }" selected="selected">0${minuteIndex}</option>
	                        			</c:if>
				                        <c:if test="${minuteIndex != timeSwitch.powerMinute}">
	                        				<option value="0${minuteIndex }">0${minuteIndex}</option>
	                        			</c:if>			
	                        		</c:if>
	                        		<c:if test="${minuteIndex >= 10 }">
	                        			<c:if test="${minuteIndex == timeSwitch.powerMinute}">
	                        				<option value="${minuteIndex }" selected="selected">${minuteIndex}</option>
	                        			</c:if>
				                        <c:if test="${minuteIndex != timeSwitch.powerMinute}">
	                        				<option value="${minuteIndex }">${minuteIndex}</option>
	                        			</c:if>	
	                        		</c:if>
	                        	</c:forEach>
	                        </select>
	                        <a href="javascript:;">应用到全周</a>
	                    </td>
	                    <td>
	                    	<input type="button" class="btn-01 right clock_add" value="添加">
	                    	<span>关机</span>
	                        <select class="sel-45 close_hour">
	                        	<c:forEach begin="00" end="23" step="1" var="hourIndex">
	                        		<c:if test="${hourIndex < 10 }">
	                        			<c:if test="${hourIndex == timeSwitch.shutdownHour}">
	                        				<option value="0${hourIndex }" selected="selected">0${hourIndex}</option>
	                        			</c:if>
				                        <c:if test="${hourIndex != timeSwitch.shutdownHour}">
	                        				<option value="0${hourIndex }">0${hourIndex}</option>
	                        			</c:if>			
	                        		</c:if>
	                        		<c:if test="${hourIndex >= 10 }">
	                        			<c:if test="${hourIndex == timeSwitch.shutdownHour}">
	                        				<option value="${hourIndex }" selected="selected">${hourIndex}</option>
	                        			</c:if>
				                        <c:if test="${hourIndex != timeSwitch.shutdownHour}">
	                        				<option value="${hourIndex }">${hourIndex}</option>
	                        			</c:if>	
	                        		</c:if>
	                        	</c:forEach>
	                        </select>
	                        <span>:</span>
	                        <select class="sel-45 close_minute">
	                        	<c:forEach begin="00" end="59" step="1" var="minuteIndex">
	                        		<c:if test="${minuteIndex < 10 }">
	                        			<c:if test="${minuteIndex == timeSwitch.shutdownMinute}">
	                        				<option value="0${minuteIndex }" selected="selected">0${minuteIndex}</option>
	                        			</c:if>
				                        <c:if test="${minuteIndex != timeSwitch.shutdownMinute}">
	                        				<option value="0${minuteIndex }">0${minuteIndex}</option>
	                        			</c:if>			
	                        		</c:if>
	                        		<c:if test="${minuteIndex >= 10 }">
	                        			<c:if test="${minuteIndex == timeSwitch.shutdownMinute}">
	                        				<option value="${minuteIndex }" selected="selected">${minuteIndex}</option>
	                        			</c:if>
				                        <c:if test="${minuteIndex != timeSwitch.shutdownMinute}">
	                        				<option value="${minuteIndex }">${minuteIndex}</option>
	                        			</c:if>	
	                        		</c:if>
	                        	</c:forEach>
	                        </select>
	                        <a href="javascript:;">应用到全周</a>
	                    </td>
	                </tr>
	                </c:if>
                </c:forEach>
                <tr class="tbListRow" <c:if test="${isDoing == 0 }"> style="display:table-row"</c:if>>
	                <td>&nbsp;</td>
                    <td colspan="2">
                   	<table>
                       	<colgroup>
                      		<col width="50%">
                          	<col width="50%">
                       	</colgroup>
                       	<tbody>
                       	<c:forEach items="${timeSwitchs }" var="timeSwitch">
                        	<c:if test="${timeSwitch.week == 'Monday' && timeSwitchId != timeSwitch.id}">
                        		<tr>
	                        		<td>
	                        		<span>开机</span>
	                        		<select class="sel-45 open_hour" name="${timeSwitch.id }">
	                        			<c:forEach begin="00" end="23" step="1" var="hourIndex">
			                        		<c:if test="${hourIndex < 10 }">
			                        			<c:if test="${hourIndex == timeSwitch.powerHour}">
			                        				<option value="0${hourIndex }" selected="selected">0${hourIndex}</option>
			                        			</c:if>
						                        <c:if test="${hourIndex != timeSwitch.powerHour}">
			                        				<option value="0${hourIndex }">0${hourIndex}</option>
			                        			</c:if>			
			                        		</c:if>
			                        		<c:if test="${hourIndex >= 10 }">
			                        			<c:if test="${hourIndex == timeSwitch.powerHour}">
			                        				<option value="${hourIndex }" selected="selected">${hourIndex}</option>
			                        			</c:if>
						                        <c:if test="${hourIndex != timeSwitch.powerHour}">
			                        				<option value="${hourIndex }">${hourIndex}</option>
			                        			</c:if>	
			                        		</c:if>
			                        	</c:forEach>
	                        		</select>
	                        		<span>:</span>
	                        		<select class="sel-45 open_minute">
                        				<c:forEach begin="00" end="59" step="1" var="minuteIndex">
			                        		<c:if test="${minuteIndex < 10 }">
			                        			<c:if test="${minuteIndex == timeSwitch.powerMinute}">
			                        				<option value="0${minuteIndex }" selected="selected">0${minuteIndex}</option>
			                        			</c:if>
						                        <c:if test="${minuteIndex != timeSwitch.powerMinute}">
			                        				<option value="0${minuteIndex }">0${minuteIndex}</option>
			                        			</c:if>			
			                        		</c:if>
			                        		<c:if test="${minuteIndex >= 10 }">
			                        			<c:if test="${minuteIndex == timeSwitch.powerMinute}">
			                        				<option value="${minuteIndex }" selected="selected">${minuteIndex}</option>
			                        			</c:if>
						                        <c:if test="${minuteIndex != timeSwitch.powerMinute}">
			                        				<option value="${minuteIndex }">${minuteIndex}</option>
			                        			</c:if>	
			                        		</c:if>
			                        	</c:forEach>
	                        		</select>
	                        		</td>
	                        		<td>
	                        		<input type="button" class="btn-01 right clock_del" value="删除">
	                        		<span>关机</span>
			                        <select class="sel-45 close_hour">
			                        	<c:forEach begin="00" end="23" step="1" var="hourIndex">
			                        		<c:if test="${hourIndex < 10 }">
			                        			<c:if test="${hourIndex == timeSwitch.shutdownHour}">
			                        				<option value="0${hourIndex }" selected="selected">0${hourIndex}</option>
			                        			</c:if>
						                        <c:if test="${hourIndex != timeSwitch.shutdownHour}">
			                        				<option value="0${hourIndex }">0${hourIndex}</option>
			                        			</c:if>			
			                        		</c:if>
			                        		<c:if test="${hourIndex >= 10 }">
			                        			<c:if test="${hourIndex == timeSwitch.shutdownHour}">
			                        				<option value="${hourIndex }" selected="selected">${hourIndex}</option>
			                        			</c:if>
						                        <c:if test="${hourIndex != timeSwitch.shutdownHour}">
			                        				<option value="${hourIndex }">${hourIndex}</option>
			                        			</c:if>	
			                        		</c:if>
			                        	</c:forEach>
			                        </select>
			                        <span>:</span>
			                        <select class="sel-45 close_minute">
			                        	<c:forEach begin="00" end="59" step="1" var="minuteIndex">
			                        		<c:if test="${minuteIndex < 10 }">
			                        			<c:if test="${minuteIndex == timeSwitch.shutdownMinute}">
			                        				<option value="0${minuteIndex }" selected="selected">0${minuteIndex}</option>
			                        			</c:if>
						                        <c:if test="${minuteIndex != timeSwitch.shutdownMinute}">
			                        				<option value="0${minuteIndex }">0${minuteIndex}</option>
			                        			</c:if>			
			                        		</c:if>
			                        		<c:if test="${minuteIndex >= 10 }">
			                        			<c:if test="${minuteIndex == timeSwitch.shutdownMinute}">
			                        				<option value="${minuteIndex }" selected="selected">${minuteIndex}</option>
			                        			</c:if>
						                        <c:if test="${minuteIndex != timeSwitch.shutdownMinute}">
			                        				<option value="${minuteIndex }">${minuteIndex}</option>
			                        			</c:if>	
			                        		</c:if>
			                        	</c:forEach>
			                        </select>
	                        		</td>
                        		</tr>
                        	</c:if>
                       	</c:forEach>
                       	</tbody>
                      </table>
                   </td>
                </tr>
                <c:set var="isDoing" value="1"/>
                <c:set var="timeSwitchId" value=""/> 
                <c:forEach items="${timeSwitchs }" var="timeSwitch">
                	<c:if test="${timeSwitch.week == 'Tuesday' && isDoing == 1}">
                	<c:set var="timeSwitchId" value="${timeSwitch.id }"/> 
                	<c:set var="isDoing" value="0"/> 
	                <tr>
	                	<td>
	                    	<span class="enable_check">
	                   			<c:if test="${timeSwitch.iscycling == 1 }">
	                       			<input type="checkbox" checked  value="Tuesday">
	                       		</c:if>
	                       		<c:if test="${timeSwitch.iscycling == 0 }">
	                       			<input type="checkbox"  value="Tuesday">
	                       		</c:if>
	                            <label for="">星期二</label>
	                        </span>
	                    </td>
	                     <td>
	                    	<span>开机</span>
	                        <select class="sel-45 open_hour" >
	                        	<c:forEach begin="00" end="23" step="1" var="hourIndex">
	                        		<c:if test="${hourIndex < 10 }">
	                        			<c:if test="${hourIndex == timeSwitch.powerHour}">
	                        				<option value="0${hourIndex }" selected="selected">0${hourIndex}</option>
	                        			</c:if>
				                        <c:if test="${hourIndex != timeSwitch.powerHour}">
	                        				<option value="0${hourIndex }">0${hourIndex}</option>
	                        			</c:if>			
	                        		</c:if>
	                        		<c:if test="${hourIndex >= 10 }">
	                        			<c:if test="${hourIndex == timeSwitch.powerHour}">
	                        				<option value="${hourIndex }" selected="selected">${hourIndex}</option>
	                        			</c:if>
				                        <c:if test="${hourIndex != timeSwitch.powerHour}">
	                        				<option value="${hourIndex }">${hourIndex}</option>
	                        			</c:if>	
	                        		</c:if>
	                        	</c:forEach>
	                        </select>
	                        <span>:</span>
	                        <select class="sel-45 open_minute">
	                        	<c:forEach begin="00" end="59" step="1" var="minuteIndex">
	                        		<c:if test="${minuteIndex < 10 }">
	                        			<c:if test="${minuteIndex == timeSwitch.powerMinute}">
	                        				<option value="0${minuteIndex }" selected="selected">0${minuteIndex}</option>
	                        			</c:if>
				                        <c:if test="${minuteIndex != timeSwitch.powerMinute}">
	                        				<option value="0${minuteIndex }">0${minuteIndex}</option>
	                        			</c:if>			
	                        		</c:if>
	                        		<c:if test="${minuteIndex >= 10 }">
	                        			<c:if test="${minuteIndex == timeSwitch.powerMinute}">
	                        				<option value="${minuteIndex }" selected="selected">${minuteIndex}</option>
	                        			</c:if>
				                        <c:if test="${minuteIndex != timeSwitch.powerMinute}">
	                        				<option value="${minuteIndex }">${minuteIndex}</option>
	                        			</c:if>	
	                        		</c:if>
	                        	</c:forEach>
	                        </select>
	                        <a href="javascript:;">应用到全周</a>
	                    </td>
	                    <td>
	                    	<input type="button" class="btn-01 right clock_add" value="添加">
	                    	<span>关机</span>
	                        <select class="sel-45 close_hour">
	                        	<c:forEach begin="00" end="23" step="1" var="hourIndex">
	                        		<c:if test="${hourIndex < 10 }">
	                        			<c:if test="${hourIndex == timeSwitch.shutdownHour}">
	                        				<option value="0${hourIndex }" selected="selected">0${hourIndex}</option>
	                        			</c:if>
				                        <c:if test="${hourIndex != timeSwitch.shutdownHour}">
	                        				<option value="0${hourIndex }">0${hourIndex}</option>
	                        			</c:if>			
	                        		</c:if>
	                        		<c:if test="${hourIndex >= 10 }">
	                        			<c:if test="${hourIndex == timeSwitch.shutdownHour}">
	                        				<option value="${hourIndex }" selected="selected">${hourIndex}</option>
	                        			</c:if>
				                        <c:if test="${hourIndex != timeSwitch.shutdownHour}">
	                        				<option value="${hourIndex }">${hourIndex}</option>
	                        			</c:if>	
	                        		</c:if>
	                        	</c:forEach>
	                        </select>
	                        <span>:</span>
	                        <select class="sel-45 close_minute">
	                        	<c:forEach begin="00" end="59" step="1" var="minuteIndex">
	                        		<c:if test="${minuteIndex < 10 }">
	                        			<c:if test="${minuteIndex == timeSwitch.shutdownMinute}">
	                        				<option value="0${minuteIndex }" selected="selected">0${minuteIndex}</option>
	                        			</c:if>
				                        <c:if test="${minuteIndex != timeSwitch.shutdownMinute}">
	                        				<option value="0${minuteIndex }">0${minuteIndex}</option>
	                        			</c:if>			
	                        		</c:if>
	                        		<c:if test="${minuteIndex >= 10 }">
	                        			<c:if test="${minuteIndex == timeSwitch.shutdownMinute}">
	                        				<option value="${minuteIndex }" selected="selected">${minuteIndex}</option>
	                        			</c:if>
				                        <c:if test="${minuteIndex != timeSwitch.shutdownMinute}">
	                        				<option value="${minuteIndex }">${minuteIndex}</option>
	                        			</c:if>	
	                        		</c:if>
	                        	</c:forEach>
	                        </select>
	                        <a href="javascript:;">应用到全周</a>
	                    </td>
	                </tr>
	                </c:if>
                </c:forEach>
                <tr class="tbListRow" <c:if test="${isDoing == 0 }"> style="display:table-row"</c:if>>
	                <td>&nbsp;</td>
                    <td colspan="2">
                   	<table>
                       	<colgroup>
                      		<col width="50%">
                          	<col width="50%">
                       	</colgroup>
                       	<tbody>
                       	<c:forEach items="${timeSwitchs }" var="timeSwitch">
                        	<c:if test="${timeSwitch.week == 'Tuesday' && timeSwitchId != timeSwitch.id}">
                        		<tr>
	                        		<td>
	                        		<span>开机</span>
	                        		<select class="sel-45 open_hour" name="${timeSwitch.id }">
	                        			<c:forEach begin="00" end="23" step="1" var="hourIndex">
			                        		<c:if test="${hourIndex < 10 }">
			                        			<c:if test="${hourIndex == timeSwitch.powerHour}">
			                        				<option value="0${hourIndex }" selected="selected">0${hourIndex}</option>
			                        			</c:if>
						                        <c:if test="${hourIndex != timeSwitch.powerHour}">
			                        				<option value="0${hourIndex }">0${hourIndex}</option>
			                        			</c:if>			
			                        		</c:if>
			                        		<c:if test="${hourIndex >= 10 }">
			                        			<c:if test="${hourIndex == timeSwitch.powerHour}">
			                        				<option value="${hourIndex }" selected="selected">${hourIndex}</option>
			                        			</c:if>
						                        <c:if test="${hourIndex != timeSwitch.powerHour}">
			                        				<option value="${hourIndex }">${hourIndex}</option>
			                        			</c:if>	
			                        		</c:if>
			                        	</c:forEach>
	                        		</select>
	                        		<span>:</span>
	                        		<select class="sel-45 open_minute">
                        				<c:forEach begin="00" end="59" step="1" var="minuteIndex">
			                        		<c:if test="${minuteIndex < 10 }">
			                        			<c:if test="${minuteIndex == timeSwitch.powerMinute}">
			                        				<option value="0${minuteIndex }" selected="selected">0${minuteIndex}</option>
			                        			</c:if>
						                        <c:if test="${minuteIndex != timeSwitch.powerMinute}">
			                        				<option value="0${minuteIndex }">0${minuteIndex}</option>
			                        			</c:if>			
			                        		</c:if>
			                        		<c:if test="${minuteIndex >= 10 }">
			                        			<c:if test="${minuteIndex == timeSwitch.powerMinute}">
			                        				<option value="${minuteIndex }" selected="selected">${minuteIndex}</option>
			                        			</c:if>
						                        <c:if test="${minuteIndex != timeSwitch.powerMinute}">
			                        				<option value="${minuteIndex }">${minuteIndex}</option>
			                        			</c:if>	
			                        		</c:if>
			                        	</c:forEach>
	                        		</select>
	                        		</td>
	                        		<td>
	                        		<input type="button" class="btn-01 right clock_del" value="删除">
	                        		<span>关机</span>
			                        <select class="sel-45 close_hour">
			                        	<c:forEach begin="00" end="23" step="1" var="hourIndex">
			                        		<c:if test="${hourIndex < 10 }">
			                        			<c:if test="${hourIndex == timeSwitch.shutdownHour}">
			                        				<option value="0${hourIndex }" selected="selected">0${hourIndex}</option>
			                        			</c:if>
						                        <c:if test="${hourIndex != timeSwitch.shutdownHour}">
			                        				<option value="0${hourIndex }">0${hourIndex}</option>
			                        			</c:if>			
			                        		</c:if>
			                        		<c:if test="${hourIndex >= 10 }">
			                        			<c:if test="${hourIndex == timeSwitch.shutdownHour}">
			                        				<option value="${hourIndex }" selected="selected">${hourIndex}</option>
			                        			</c:if>
						                        <c:if test="${hourIndex != timeSwitch.shutdownHour}">
			                        				<option value="${hourIndex }">${hourIndex}</option>
			                        			</c:if>	
			                        		</c:if>
			                        	</c:forEach>
			                        </select>
			                        <span>:</span>
			                        <select class="sel-45 close_minute">
			                        	<c:forEach begin="00" end="59" step="1" var="minuteIndex">
			                        		<c:if test="${minuteIndex < 10 }">
			                        			<c:if test="${minuteIndex == timeSwitch.shutdownMinute}">
			                        				<option value="0${minuteIndex }" selected="selected">0${minuteIndex}</option>
			                        			</c:if>
						                        <c:if test="${minuteIndex != timeSwitch.shutdownMinute}">
			                        				<option value="0${minuteIndex }">0${minuteIndex}</option>
			                        			</c:if>			
			                        		</c:if>
			                        		<c:if test="${minuteIndex >= 10 }">
			                        			<c:if test="${minuteIndex == timeSwitch.shutdownMinute}">
			                        				<option value="${minuteIndex }" selected="selected">${minuteIndex}</option>
			                        			</c:if>
						                        <c:if test="${minuteIndex != timeSwitch.shutdownMinute}">
			                        				<option value="${minuteIndex }">${minuteIndex}</option>
			                        			</c:if>	
			                        		</c:if>
			                        	</c:forEach>
			                        </select>
	                        		</td>
                        		</tr>
                        	</c:if>
                       	</c:forEach>
                       	</tbody>
                      </table>
                   </td>
                </tr>
                <c:set var="isDoing" value="1"/>
                <c:set var="timeSwitchId" value=""/> 
                <c:forEach items="${timeSwitchs }" var="timeSwitch">
                	<c:if test="${timeSwitch.week == 'Wednesday' && isDoing == 1}">
                	<c:set var="timeSwitchId" value="${timeSwitch.id }"/> 
                	<c:set var="isDoing" value="0"/> 
	                <tr>
	                	<td>
	                    	<span class="enable_check">
	                   			<c:if test="${timeSwitch.iscycling == 1 }">
	                       			<input type="checkbox" checked  value="Wednesday"> 
	                       		</c:if>
	                       		<c:if test="${timeSwitch.iscycling == 0 }">
	                       			<input type="checkbox"  value="Wednesday">
	                       		</c:if>
	                            <label for="">星期三</label>
	                        </span>
	                    </td>
	                     <td>
	                    	<span>开机</span>
	                        <select class="sel-45 open_hour" >
	                        	<c:forEach begin="00" end="23" step="1" var="hourIndex">
	                        		<c:if test="${hourIndex < 10 }">
	                        			<c:if test="${hourIndex == timeSwitch.powerHour}">
	                        				<option value="0${hourIndex }" selected="selected">0${hourIndex}</option>
	                        			</c:if>
				                        <c:if test="${hourIndex != timeSwitch.powerHour}">
	                        				<option value="0${hourIndex }">0${hourIndex}</option>
	                        			</c:if>			
	                        		</c:if>
	                        		<c:if test="${hourIndex >= 10 }">
	                        			<c:if test="${hourIndex == timeSwitch.powerHour}">
	                        				<option value="${hourIndex }" selected="selected">${hourIndex}</option>
	                        			</c:if>
				                        <c:if test="${hourIndex != timeSwitch.powerHour}">
	                        				<option value="${hourIndex }">${hourIndex}</option>
	                        			</c:if>	
	                        		</c:if>
	                        	</c:forEach>
	                        </select>
	                        <span>:</span>
	                        <select class="sel-45 open_minute">
	                        	<c:forEach begin="00" end="59" step="1" var="minuteIndex">
	                        		<c:if test="${minuteIndex < 10 }">
	                        			<c:if test="${minuteIndex == timeSwitch.powerMinute}">
	                        				<option value="0${minuteIndex }" selected="selected">0${minuteIndex}</option>
	                        			</c:if>
				                        <c:if test="${minuteIndex != timeSwitch.powerMinute}">
	                        				<option value="0${minuteIndex }">0${minuteIndex}</option>
	                        			</c:if>			
	                        		</c:if>
	                        		<c:if test="${minuteIndex >= 10 }">
	                        			<c:if test="${minuteIndex == timeSwitch.powerMinute}">
	                        				<option value="${minuteIndex }" selected="selected">${minuteIndex}</option>
	                        			</c:if>
				                        <c:if test="${minuteIndex != timeSwitch.powerMinute}">
	                        				<option value="${minuteIndex }">${minuteIndex}</option>
	                        			</c:if>	
	                        		</c:if>
	                        	</c:forEach>
	                        </select>
	                        <a href="javascript:;">应用到全周</a>
	                    </td>
	                    <td>
	                    	<input type="button" class="btn-01 right clock_add" value="添加">
	                    	<span>关机</span>
	                        <select class="sel-45 close_hour">
	                        	<c:forEach begin="00" end="23" step="1" var="hourIndex">
	                        		<c:if test="${hourIndex < 10 }">
	                        			<c:if test="${hourIndex == timeSwitch.shutdownHour}">
	                        				<option value="0${hourIndex }" selected="selected">0${hourIndex}</option>
	                        			</c:if>
				                        <c:if test="${hourIndex != timeSwitch.shutdownHour}">
	                        				<option value="0${hourIndex }">0${hourIndex}</option>
	                        			</c:if>			
	                        		</c:if>
	                        		<c:if test="${hourIndex >= 10 }">
	                        			<c:if test="${hourIndex == timeSwitch.shutdownHour}">
	                        				<option value="${hourIndex }" selected="selected">${hourIndex}</option>
	                        			</c:if>
				                        <c:if test="${hourIndex != timeSwitch.shutdownHour}">
	                        				<option value="${hourIndex }">${hourIndex}</option>
	                        			</c:if>	
	                        		</c:if>
	                        	</c:forEach>
	                        </select>
	                        <span>:</span>
	                        <select class="sel-45 close_minute">
	                        	<c:forEach begin="00" end="59" step="1" var="minuteIndex">
	                        		<c:if test="${minuteIndex < 10 }">
	                        			<c:if test="${minuteIndex == timeSwitch.shutdownMinute}">
	                        				<option value="0${minuteIndex }" selected="selected">0${minuteIndex}</option>
	                        			</c:if>
				                        <c:if test="${minuteIndex != timeSwitch.shutdownMinute}">
	                        				<option value="0${minuteIndex }">0${minuteIndex}</option>
	                        			</c:if>			
	                        		</c:if>
	                        		<c:if test="${minuteIndex >= 10 }">
	                        			<c:if test="${minuteIndex == timeSwitch.shutdownMinute}">
	                        				<option value="${minuteIndex }" selected="selected">${minuteIndex}</option>
	                        			</c:if>
				                        <c:if test="${minuteIndex != timeSwitch.shutdownMinute}">
	                        				<option value="${minuteIndex }">${minuteIndex}</option>
	                        			</c:if>	
	                        		</c:if>
	                        	</c:forEach>
	                        </select>
	                        <a href="javascript:;">应用到全周</a>
	                    </td>
	                </tr>
	                </c:if>
                </c:forEach>
                <tr class="tbListRow" <c:if test="${isDoing == 0 }"> style="display:table-row"</c:if>>
	                <td>&nbsp;</td>
                    <td colspan="2">
                   	<table>
                       	<colgroup>
                      		<col width="50%">
                          	<col width="50%">
                       	</colgroup>
                       	<tbody>
                       	<c:forEach items="${timeSwitchs }" var="timeSwitch">
                        	<c:if test="${timeSwitch.week == 'Wednesday' && timeSwitchId != timeSwitch.id}">
                        		<tr>
	                        		<td>
	                        		<span>开机</span>
	                        		<select class="sel-45 open_hour" name="${timeSwitch.id }">
	                        			<c:forEach begin="00" end="23" step="1" var="hourIndex">
			                        		<c:if test="${hourIndex < 10 }">
			                        			<c:if test="${hourIndex == timeSwitch.powerHour}">
			                        				<option value="0${hourIndex }" selected="selected">0${hourIndex}</option>
			                        			</c:if>
						                        <c:if test="${hourIndex != timeSwitch.powerHour}">
			                        				<option value="0${hourIndex }">0${hourIndex}</option>
			                        			</c:if>			
			                        		</c:if>
			                        		<c:if test="${hourIndex >= 10 }">
			                        			<c:if test="${hourIndex == timeSwitch.powerHour}">
			                        				<option value="${hourIndex }" selected="selected">${hourIndex}</option>
			                        			</c:if>
						                        <c:if test="${hourIndex != timeSwitch.powerHour}">
			                        				<option value="${hourIndex }">${hourIndex}</option>
			                        			</c:if>	
			                        		</c:if>
			                        	</c:forEach>
	                        		</select>
	                        		<span>:</span>
	                        		<select class="sel-45 open_minute">
                        				<c:forEach begin="00" end="59" step="1" var="minuteIndex">
			                        		<c:if test="${minuteIndex < 10 }">
			                        			<c:if test="${minuteIndex == timeSwitch.powerMinute}">
			                        				<option value="0${minuteIndex }" selected="selected">0${minuteIndex}</option>
			                        			</c:if>
						                        <c:if test="${minuteIndex != timeSwitch.powerMinute}">
			                        				<option value="0${minuteIndex }">0${minuteIndex}</option>
			                        			</c:if>			
			                        		</c:if>
			                        		<c:if test="${minuteIndex >= 10 }">
			                        			<c:if test="${minuteIndex == timeSwitch.powerMinute}">
			                        				<option value="${minuteIndex }" selected="selected">${minuteIndex}</option>
			                        			</c:if>
						                        <c:if test="${minuteIndex != timeSwitch.powerMinute}">
			                        				<option value="${minuteIndex }">${minuteIndex}</option>
			                        			</c:if>	
			                        		</c:if>
			                        	</c:forEach>
	                        		</select>
	                        		</td>
	                        		<td>
	                        		<input type="button" class="btn-01 right clock_del" value="删除">
	                        		<span>关机</span>
			                        <select class="sel-45 close_hour">
			                        	<c:forEach begin="00" end="23" step="1" var="hourIndex">
			                        		<c:if test="${hourIndex < 10 }">
			                        			<c:if test="${hourIndex == timeSwitch.shutdownHour}">
			                        				<option value="0${hourIndex }" selected="selected">0${hourIndex}</option>
			                        			</c:if>
						                        <c:if test="${hourIndex != timeSwitch.shutdownHour}">
			                        				<option value="0${hourIndex }">0${hourIndex}</option>
			                        			</c:if>			
			                        		</c:if>
			                        		<c:if test="${hourIndex >= 10 }">
			                        			<c:if test="${hourIndex == timeSwitch.shutdownHour}">
			                        				<option value="${hourIndex }" selected="selected">${hourIndex}</option>
			                        			</c:if>
						                        <c:if test="${hourIndex != timeSwitch.shutdownHour}">
			                        				<option value="${hourIndex }">${hourIndex}</option>
			                        			</c:if>	
			                        		</c:if>
			                        	</c:forEach>
			                        </select>
			                        <span>:</span>
			                        <select class="sel-45 close_minute">
			                        	<c:forEach begin="00" end="59" step="1" var="minuteIndex">
			                        		<c:if test="${minuteIndex < 10 }">
			                        			<c:if test="${minuteIndex == timeSwitch.shutdownMinute}">
			                        				<option value="0${minuteIndex }" selected="selected">0${minuteIndex}</option>
			                        			</c:if>
						                        <c:if test="${minuteIndex != timeSwitch.shutdownMinute}">
			                        				<option value="0${minuteIndex }">0${minuteIndex}</option>
			                        			</c:if>			
			                        		</c:if>
			                        		<c:if test="${minuteIndex >= 10 }">
			                        			<c:if test="${minuteIndex == timeSwitch.shutdownMinute}">
			                        				<option value="${minuteIndex }" selected="selected">${minuteIndex}</option>
			                        			</c:if>
						                        <c:if test="${minuteIndex != timeSwitch.shutdownMinute}">
			                        				<option value="${minuteIndex }">${minuteIndex}</option>
			                        			</c:if>	
			                        		</c:if>
			                        	</c:forEach>
			                        </select>
	                        		</td>
                        		</tr>
                        	</c:if>
                       	</c:forEach>
                       	</tbody>
                      </table>
                   </td>
                </tr>
                <c:set var="isDoing" value="1"/>
                <c:set var="timeSwitchId" value=""/> 
                <c:forEach items="${timeSwitchs }" var="timeSwitch">
                	<c:if test="${timeSwitch.week == 'Thursday' && isDoing == 1}">
                	<c:set var="timeSwitchId" value="${timeSwitch.id }"/> 
                	<c:set var="isDoing" value="0"/> 
	                <tr>
	                	<td>
	                    	<span class="enable_check">
	                   			<c:if test="${timeSwitch.iscycling == 1 }">
	                       			<input type="checkbox" checked  value="Thursday">
	                       		</c:if>
	                       		<c:if test="${timeSwitch.iscycling == 0 }">
	                       			<input type="checkbox"  value="Thursday">
	                       		</c:if>
	                            <label for="">星期四</label>
	                        </span>
	                    </td>
	                     <td>
	                    	<span>开机</span>
	                        <select class="sel-45 open_hour" >
	                        	<c:forEach begin="00" end="23" step="1" var="hourIndex">
	                        		<c:if test="${hourIndex < 10 }">
	                        			<c:if test="${hourIndex == timeSwitch.powerHour}">
	                        				<option value="0${hourIndex }" selected="selected">0${hourIndex}</option>
	                        			</c:if>
				                        <c:if test="${hourIndex != timeSwitch.powerHour}">
	                        				<option value="0${hourIndex }">0${hourIndex}</option>
	                        			</c:if>			
	                        		</c:if>
	                        		<c:if test="${hourIndex >= 10 }">
	                        			<c:if test="${hourIndex == timeSwitch.powerHour}">
	                        				<option value="${hourIndex }" selected="selected">${hourIndex}</option>
	                        			</c:if>
				                        <c:if test="${hourIndex != timeSwitch.powerHour}">
	                        				<option value="${hourIndex }">${hourIndex}</option>
	                        			</c:if>	
	                        		</c:if>
	                        	</c:forEach>
	                        </select>
	                        <span>:</span>
	                        <select class="sel-45 open_minute">
	                        	<c:forEach begin="00" end="59" step="1" var="minuteIndex">
	                        		<c:if test="${minuteIndex < 10 }">
	                        			<c:if test="${minuteIndex == timeSwitch.powerMinute}">
	                        				<option value="0${minuteIndex }" selected="selected">0${minuteIndex}</option>
	                        			</c:if>
				                        <c:if test="${minuteIndex != timeSwitch.powerMinute}">
	                        				<option value="0${minuteIndex }">0${minuteIndex}</option>
	                        			</c:if>			
	                        		</c:if>
	                        		<c:if test="${minuteIndex >= 10 }">
	                        			<c:if test="${minuteIndex == timeSwitch.powerMinute}">
	                        				<option value="${minuteIndex }" selected="selected">${minuteIndex}</option>
	                        			</c:if>
				                        <c:if test="${minuteIndex != timeSwitch.powerMinute}">
	                        				<option value="${minuteIndex }">${minuteIndex}</option>
	                        			</c:if>	
	                        		</c:if>
	                        	</c:forEach>
	                        </select>
	                        <a href="javascript:;">应用到全周</a>
	                    </td>
	                    <td>
	                    	<input type="button" class="btn-01 right clock_add" value="添加">
	                    	<span>关机</span>
	                        <select class="sel-45 close_hour">
	                        	<c:forEach begin="00" end="23" step="1" var="hourIndex">
	                        		<c:if test="${hourIndex < 10 }">
	                        			<c:if test="${hourIndex == timeSwitch.shutdownHour}">
	                        				<option value="0${hourIndex }" selected="selected">0${hourIndex}</option>
	                        			</c:if>
				                        <c:if test="${hourIndex != timeSwitch.shutdownHour}">
	                        				<option value="0${hourIndex }">0${hourIndex}</option>
	                        			</c:if>			
	                        		</c:if>
	                        		<c:if test="${hourIndex >= 10 }">
	                        			<c:if test="${hourIndex == timeSwitch.shutdownHour}">
	                        				<option value="${hourIndex }" selected="selected">${hourIndex}</option>
	                        			</c:if>
				                        <c:if test="${hourIndex != timeSwitch.shutdownHour}">
	                        				<option value="${hourIndex }">${hourIndex}</option>
	                        			</c:if>	
	                        		</c:if>
	                        	</c:forEach>
	                        </select>
	                        <span>:</span>
	                        <select class="sel-45 close_minute">
	                        	<c:forEach begin="00" end="59" step="1" var="minuteIndex">
	                        		<c:if test="${minuteIndex < 10 }">
	                        			<c:if test="${minuteIndex == timeSwitch.shutdownMinute}">
	                        				<option value="0${minuteIndex }" selected="selected">0${minuteIndex}</option>
	                        			</c:if>
				                        <c:if test="${minuteIndex != timeSwitch.shutdownMinute}">
	                        				<option value="0${minuteIndex }">0${minuteIndex}</option>
	                        			</c:if>			
	                        		</c:if>
	                        		<c:if test="${minuteIndex >= 10 }">
	                        			<c:if test="${minuteIndex == timeSwitch.shutdownMinute}">
	                        				<option value="${minuteIndex }" selected="selected">${minuteIndex}</option>
	                        			</c:if>
				                        <c:if test="${minuteIndex != timeSwitch.shutdownMinute}">
	                        				<option value="${minuteIndex }">${minuteIndex}</option>
	                        			</c:if>	
	                        		</c:if>
	                        	</c:forEach>
	                        </select>
	                        <a href="javascript:;">应用到全周</a>
	                    </td>
	                </tr>
	                </c:if>
                </c:forEach>
                <tr class="tbListRow" <c:if test="${isDoing == 0 }"> style="display:table-row"</c:if>>
	                <td>&nbsp;</td>
                    <td colspan="2">
                   	<table>
                       	<colgroup>
                      		<col width="50%">
                          	<col width="50%">
                       	</colgroup>
                       	<tbody>
                       	<c:forEach items="${timeSwitchs }" var="timeSwitch">
                        	<c:if test="${timeSwitch.week == 'Thursday' && timeSwitchId != timeSwitch.id}">
                        		<tr>
	                        		<td>
	                        		<span>开机</span>
	                        		<select class="sel-45 open_hour" name="${timeSwitch.id }">
	                        			<c:forEach begin="00" end="23" step="1" var="hourIndex">
			                        		<c:if test="${hourIndex < 10 }">
			                        			<c:if test="${hourIndex == timeSwitch.powerHour}">
			                        				<option value="0${hourIndex }" selected="selected">0${hourIndex}</option>
			                        			</c:if>
						                        <c:if test="${hourIndex != timeSwitch.powerHour}">
			                        				<option value="0${hourIndex }">0${hourIndex}</option>
			                        			</c:if>			
			                        		</c:if>
			                        		<c:if test="${hourIndex >= 10 }">
			                        			<c:if test="${hourIndex == timeSwitch.powerHour}">
			                        				<option value="${hourIndex }" selected="selected">${hourIndex}</option>
			                        			</c:if>
						                        <c:if test="${hourIndex != timeSwitch.powerHour}">
			                        				<option value="${hourIndex }">${hourIndex}</option>
			                        			</c:if>	
			                        		</c:if>
			                        	</c:forEach>
	                        		</select>
	                        		<span>:</span>
	                        		<select class="sel-45 open_minute">
                        				<c:forEach begin="00" end="59" step="1" var="minuteIndex">
			                        		<c:if test="${minuteIndex < 10 }">
			                        			<c:if test="${minuteIndex == timeSwitch.powerMinute}">
			                        				<option value="0${minuteIndex }" selected="selected">0${minuteIndex}</option>
			                        			</c:if>
						                        <c:if test="${minuteIndex != timeSwitch.powerMinute}">
			                        				<option value="0${minuteIndex }">0${minuteIndex}</option>
			                        			</c:if>			
			                        		</c:if>
			                        		<c:if test="${minuteIndex >= 10 }">
			                        			<c:if test="${minuteIndex == timeSwitch.powerMinute}">
			                        				<option value="${minuteIndex }" selected="selected">${minuteIndex}</option>
			                        			</c:if>
						                        <c:if test="${minuteIndex != timeSwitch.powerMinute}">
			                        				<option value="${minuteIndex }">${minuteIndex}</option>
			                        			</c:if>	
			                        		</c:if>
			                        	</c:forEach>
	                        		</select>
	                        		</td>
	                        		<td>
	                        		<input type="button" class="btn-01 right clock_del" value="删除">
	                        		<span>关机</span>
			                        <select class="sel-45 close_hour">
			                        	<c:forEach begin="00" end="23" step="1" var="hourIndex">
			                        		<c:if test="${hourIndex < 10 }">
			                        			<c:if test="${hourIndex == timeSwitch.shutdownHour}">
			                        				<option value="0${hourIndex }" selected="selected">0${hourIndex}</option>
			                        			</c:if>
						                        <c:if test="${hourIndex != timeSwitch.shutdownHour}">
			                        				<option value="0${hourIndex }">0${hourIndex}</option>
			                        			</c:if>			
			                        		</c:if>
			                        		<c:if test="${hourIndex >= 10 }">
			                        			<c:if test="${hourIndex == timeSwitch.shutdownHour}">
			                        				<option value="${hourIndex }" selected="selected">${hourIndex}</option>
			                        			</c:if>
						                        <c:if test="${hourIndex != timeSwitch.shutdownHour}">
			                        				<option value="${hourIndex }">${hourIndex}</option>
			                        			</c:if>	
			                        		</c:if>
			                        	</c:forEach>
			                        </select>
			                        <span>:</span>
			                        <select class="sel-45 close_minute">
			                        	<c:forEach begin="00" end="59" step="1" var="minuteIndex">
			                        		<c:if test="${minuteIndex < 10 }">
			                        			<c:if test="${minuteIndex == timeSwitch.shutdownMinute}">
			                        				<option value="0${minuteIndex }" selected="selected">0${minuteIndex}</option>
			                        			</c:if>
						                        <c:if test="${minuteIndex != timeSwitch.shutdownMinute}">
			                        				<option value="0${minuteIndex }">0${minuteIndex}</option>
			                        			</c:if>			
			                        		</c:if>
			                        		<c:if test="${minuteIndex >= 10 }">
			                        			<c:if test="${minuteIndex == timeSwitch.shutdownMinute}">
			                        				<option value="${minuteIndex }" selected="selected">${minuteIndex}</option>
			                        			</c:if>
						                        <c:if test="${minuteIndex != timeSwitch.shutdownMinute}">
			                        				<option value="${minuteIndex }">${minuteIndex}</option>
			                        			</c:if>	
			                        		</c:if>
			                        	</c:forEach>
			                        </select>
	                        		</td>
                        		</tr>
                        	</c:if>
                       	</c:forEach>
                       	</tbody>
                      </table>
                   </td>
                </tr>
                <c:set var="isDoing" value="1"/>
                <c:set var="timeSwitchId" value=""/> 
                <c:forEach items="${timeSwitchs }" var="timeSwitch">
                	<c:if test="${timeSwitch.week == 'Friday' && isDoing == 1}">
                	<c:set var="timeSwitchId" value="${timeSwitch.id }"/> 
                	<c:set var="isDoing" value="0"/> 
	                <tr>
	                	<td>
	                    	<span class="enable_check">
	                   			<c:if test="${timeSwitch.iscycling == 1 }">
	                       			<input type="checkbox" checked  value="Friday">
	                       		</c:if>
	                       		<c:if test="${timeSwitch.iscycling == 0 }">
	                       			<input type="checkbox"  value="Friday">
	                       		</c:if>
	                            <label for="">星期五</label>
	                        </span>
	                    </td>
	                    <td>
	                    	<span>开机</span>
	                        <select class="sel-45 open_hour" >
	                        	<c:forEach begin="00" end="23" step="1" var="hourIndex">
	                        		<c:if test="${hourIndex < 10 }">
	                        			<c:if test="${hourIndex == timeSwitch.powerHour}">
	                        				<option value="0${hourIndex }" selected="selected">0${hourIndex}</option>
	                        			</c:if>
				                        <c:if test="${hourIndex != timeSwitch.powerHour}">
	                        				<option value="0${hourIndex }">0${hourIndex}</option>
	                        			</c:if>			
	                        		</c:if>
	                        		<c:if test="${hourIndex >= 10 }">
	                        			<c:if test="${hourIndex == timeSwitch.powerHour}">
	                        				<option value="${hourIndex }" selected="selected">${hourIndex}</option>
	                        			</c:if>
				                        <c:if test="${hourIndex != timeSwitch.powerHour}">
	                        				<option value="${hourIndex }">${hourIndex}</option>
	                        			</c:if>	
	                        		</c:if>
	                        	</c:forEach>
	                        </select>
	                        <span>:</span>
	                        <select class="sel-45 open_minute">
	                        	<c:forEach begin="00" end="59" step="1" var="minuteIndex">
	                        		<c:if test="${minuteIndex < 10 }">
	                        			<c:if test="${minuteIndex == timeSwitch.powerMinute}">
	                        				<option value="0${minuteIndex }" selected="selected">0${minuteIndex}</option>
	                        			</c:if>
				                        <c:if test="${minuteIndex != timeSwitch.powerMinute}">
	                        				<option value="0${minuteIndex }">0${minuteIndex}</option>
	                        			</c:if>			
	                        		</c:if>
	                        		<c:if test="${minuteIndex >= 10 }">
	                        			<c:if test="${minuteIndex == timeSwitch.powerMinute}">
	                        				<option value="${minuteIndex }" selected="selected">${minuteIndex}</option>
	                        			</c:if>
				                        <c:if test="${minuteIndex != timeSwitch.powerMinute}">
	                        				<option value="${minuteIndex }">${minuteIndex}</option>
	                        			</c:if>	
	                        		</c:if>
	                        	</c:forEach>
	                        </select>
	                        <a href="javascript:;">应用到全周</a>
	                    </td>
	                    <td>
	                    	<input type="button" class="btn-01 right clock_add" value="添加">
	                    	<span>关机</span>
	                        <select class="sel-45 close_hour">
	                        	<c:forEach begin="00" end="23" step="1" var="hourIndex">
	                        		<c:if test="${hourIndex < 10 }">
	                        			<c:if test="${hourIndex == timeSwitch.shutdownHour}">
	                        				<option value="0${hourIndex }" selected="selected">0${hourIndex}</option>
	                        			</c:if>
				                        <c:if test="${hourIndex != timeSwitch.shutdownHour}">
	                        				<option value="0${hourIndex }">0${hourIndex}</option>
	                        			</c:if>			
	                        		</c:if>
	                        		<c:if test="${hourIndex >= 10 }">
	                        			<c:if test="${hourIndex == timeSwitch.shutdownHour}">
	                        				<option value="${hourIndex }" selected="selected">${hourIndex}</option>
	                        			</c:if>
				                        <c:if test="${hourIndex != timeSwitch.shutdownHour}">
	                        				<option value="${hourIndex }">${hourIndex}</option>
	                        			</c:if>	
	                        		</c:if>
	                        	</c:forEach>
	                        </select>
	                        <span>:</span>
	                        <select class="sel-45 close_minute">
	                        	<c:forEach begin="00" end="59" step="1" var="minuteIndex">
	                        		<c:if test="${minuteIndex < 10 }">
	                        			<c:if test="${minuteIndex == timeSwitch.shutdownMinute}">
	                        				<option value="0${minuteIndex }" selected="selected">0${minuteIndex}</option>
	                        			</c:if>
				                        <c:if test="${minuteIndex != timeSwitch.shutdownMinute}">
	                        				<option value="0${minuteIndex }">0${minuteIndex}</option>
	                        			</c:if>			
	                        		</c:if>
	                        		<c:if test="${minuteIndex >= 10 }">
	                        			<c:if test="${minuteIndex == timeSwitch.shutdownMinute}">
	                        				<option value="${minuteIndex }" selected="selected">${minuteIndex}</option>
	                        			</c:if>
				                        <c:if test="${minuteIndex != timeSwitch.shutdownMinute}">
	                        				<option value="${minuteIndex }">${minuteIndex}</option>
	                        			</c:if>	
	                        		</c:if>
	                        	</c:forEach>
	                        </select>
	                        <a href="javascript:;">应用到全周</a>
	                    </td>
	                </tr>
	                </c:if>
                </c:forEach>
                <tr class="tbListRow" <c:if test="${isDoing == 0 }"> style="display:table-row"</c:if>>
	                <td>&nbsp;</td>
                    <td colspan="2">
                   	<table>
                       	<colgroup>
                      		<col width="50%">
                          	<col width="50%">
                       	</colgroup>
                       	<tbody>
                       	<c:forEach items="${timeSwitchs }" var="timeSwitch">
                        	<c:if test="${timeSwitch.week == 'Friday' && timeSwitchId != timeSwitch.id}">
                        		<tr>
	                        		<td>
	                        		<span>开机</span>
	                        		<select class="sel-45 open_hour" name="${timeSwitch.id }">
	                        			<c:forEach begin="00" end="23" step="1" var="hourIndex">
			                        		<c:if test="${hourIndex < 10 }">
			                        			<c:if test="${hourIndex == timeSwitch.powerHour}">
			                        				<option value="0${hourIndex }" selected="selected">0${hourIndex}</option>
			                        			</c:if>
						                        <c:if test="${hourIndex != timeSwitch.powerHour}">
			                        				<option value="0${hourIndex }">0${hourIndex}</option>
			                        			</c:if>			
			                        		</c:if>
			                        		<c:if test="${hourIndex >= 10 }">
			                        			<c:if test="${hourIndex == timeSwitch.powerHour}">
			                        				<option value="${hourIndex }" selected="selected">${hourIndex}</option>
			                        			</c:if>
						                        <c:if test="${hourIndex != timeSwitch.powerHour}">
			                        				<option value="${hourIndex }">${hourIndex}</option>
			                        			</c:if>	
			                        		</c:if>
			                        	</c:forEach>
	                        		</select>
	                        		<span>:</span>
	                        		<select class="sel-45 open_minute">
                        				<c:forEach begin="00" end="59" step="1" var="minuteIndex">
			                        		<c:if test="${minuteIndex < 10 }">
			                        			<c:if test="${minuteIndex == timeSwitch.powerMinute}">
			                        				<option value="0${minuteIndex }" selected="selected">0${minuteIndex}</option>
			                        			</c:if>
						                        <c:if test="${minuteIndex != timeSwitch.powerMinute}">
			                        				<option value="0${minuteIndex }">0${minuteIndex}</option>
			                        			</c:if>			
			                        		</c:if>
			                        		<c:if test="${minuteIndex >= 10 }">
			                        			<c:if test="${minuteIndex == timeSwitch.powerMinute}">
			                        				<option value="${minuteIndex }" selected="selected">${minuteIndex}</option>
			                        			</c:if>
						                        <c:if test="${minuteIndex != timeSwitch.powerMinute}">
			                        				<option value="${minuteIndex }">${minuteIndex}</option>
			                        			</c:if>	
			                        		</c:if>
			                        	</c:forEach>
	                        		</select>
	                        		</td>
	                        		<td>
	                        		<input type="button" class="btn-01 right clock_del" value="删除">
	                        		<span>关机</span>
			                        <select class="sel-45 close_hour">
			                        	<c:forEach begin="00" end="23" step="1" var="hourIndex">
			                        		<c:if test="${hourIndex < 10 }">
			                        			<c:if test="${hourIndex == timeSwitch.shutdownHour}">
			                        				<option value="0${hourIndex }" selected="selected">0${hourIndex}</option>
			                        			</c:if>
						                        <c:if test="${hourIndex != timeSwitch.shutdownHour}">
			                        				<option value="0${hourIndex }">0${hourIndex}</option>
			                        			</c:if>			
			                        		</c:if>
			                        		<c:if test="${hourIndex >= 10 }">
			                        			<c:if test="${hourIndex == timeSwitch.shutdownHour}">
			                        				<option value="${hourIndex }" selected="selected">${hourIndex}</option>
			                        			</c:if>
						                        <c:if test="${hourIndex != timeSwitch.shutdownHour}">
			                        				<option value="${hourIndex }">${hourIndex}</option>
			                        			</c:if>	
			                        		</c:if>
			                        	</c:forEach>
			                        </select>
			                        <span>:</span>
			                        <select class="sel-45 close_minute">
			                        	<c:forEach begin="00" end="59" step="1" var="minuteIndex">
			                        		<c:if test="${minuteIndex < 10 }">
			                        			<c:if test="${minuteIndex == timeSwitch.shutdownMinute}">
			                        				<option value="0${minuteIndex }" selected="selected">0${minuteIndex}</option>
			                        			</c:if>
						                        <c:if test="${minuteIndex != timeSwitch.shutdownMinute}">
			                        				<option value="0${minuteIndex }">0${minuteIndex}</option>
			                        			</c:if>			
			                        		</c:if>
			                        		<c:if test="${minuteIndex >= 10 }">
			                        			<c:if test="${minuteIndex == timeSwitch.shutdownMinute}">
			                        				<option value="${minuteIndex }" selected="selected">${minuteIndex}</option>
			                        			</c:if>
						                        <c:if test="${minuteIndex != timeSwitch.shutdownMinute}">
			                        				<option value="${minuteIndex }">${minuteIndex}</option>
			                        			</c:if>	
			                        		</c:if>
			                        	</c:forEach>
			                        </select>
	                        		</td>
                        		</tr>
                        	</c:if>
                       	</c:forEach>
                       	</tbody>
                      </table>
                   </td>
                </tr>
                <c:set var="isDoing" value="1"/>
                <c:set var="timeSwitchId" value=""/> 
                <c:forEach items="${timeSwitchs }" var="timeSwitch">
                	<c:if test="${timeSwitch.week == 'Saturday' && isDoing == 1}">
                	<c:set var="timeSwitchId" value="${timeSwitch.id }"/> 
                	<c:set var="isDoing" value="0"/> 
	                <tr>
	                	<td>
	                    	<span class="enable_check">
	                   			<c:if test="${timeSwitch.iscycling == 1 }">
	                       			<input type="checkbox" checked  value="Saturday">
	                       		</c:if>
	                       		<c:if test="${timeSwitch.iscycling == 0 }">
	                       			<input type="checkbox"  value="Saturday">
	                       		</c:if>
	                            <label for="">星期六</label>
	                        </span>
	                    </td>
	                    <td>
	                    	<span>开机</span>
	                        <select class="sel-45 open_hour" >
	                        	<c:forEach begin="00" end="23" step="1" var="hourIndex">
	                        		<c:if test="${hourIndex < 10 }">
	                        			<c:if test="${hourIndex == timeSwitch.powerHour}">
	                        				<option value="0${hourIndex }" selected="selected">0${hourIndex}</option>
	                        			</c:if>
				                        <c:if test="${hourIndex != timeSwitch.powerHour}">
	                        				<option value="0${hourIndex }">0${hourIndex}</option>
	                        			</c:if>			
	                        		</c:if>
	                        		<c:if test="${hourIndex >= 10 }">
	                        			<c:if test="${hourIndex == timeSwitch.powerHour}">
	                        				<option value="${hourIndex }" selected="selected">${hourIndex}</option>
	                        			</c:if>
				                        <c:if test="${hourIndex != timeSwitch.powerHour}">
	                        				<option value="${hourIndex }">${hourIndex}</option>
	                        			</c:if>	
	                        		</c:if>
	                        	</c:forEach>
	                        </select>
	                        <span>:</span>
	                        <select class="sel-45 open_minute">
	                        	<c:forEach begin="00" end="59" step="1" var="minuteIndex">
	                        		<c:if test="${minuteIndex < 10 }">
	                        			<c:if test="${minuteIndex == timeSwitch.powerMinute}">
	                        				<option value="0${minuteIndex }" selected="selected">0${minuteIndex}</option>
	                        			</c:if>
				                        <c:if test="${minuteIndex != timeSwitch.powerMinute}">
	                        				<option value="0${minuteIndex }">0${minuteIndex}</option>
	                        			</c:if>			
	                        		</c:if>
	                        		<c:if test="${minuteIndex >= 10 }">
	                        			<c:if test="${minuteIndex == timeSwitch.powerMinute}">
	                        				<option value="${minuteIndex }" selected="selected">${minuteIndex}</option>
	                        			</c:if>
				                        <c:if test="${minuteIndex != timeSwitch.powerMinute}">
	                        				<option value="${minuteIndex }">${minuteIndex}</option>
	                        			</c:if>	
	                        		</c:if>
	                        	</c:forEach>
	                        </select>
	                        <a href="javascript:;">应用到全周</a>
	                    </td>
	                    <td>
	                    	<input type="button" class="btn-01 right clock_add" value="添加">
	                    	<span>关机</span>
	                        <select class="sel-45 close_hour">
	                        	<c:forEach begin="00" end="23" step="1" var="hourIndex">
	                        		<c:if test="${hourIndex < 10 }">
	                        			<c:if test="${hourIndex == timeSwitch.shutdownHour}">
	                        				<option value="0${hourIndex }" selected="selected">0${hourIndex}</option>
	                        			</c:if>
				                        <c:if test="${hourIndex != timeSwitch.shutdownHour}">
	                        				<option value="0${hourIndex }">0${hourIndex}</option>
	                        			</c:if>			
	                        		</c:if>
	                        		<c:if test="${hourIndex >= 10 }">
	                        			<c:if test="${hourIndex == timeSwitch.shutdownHour}">
	                        				<option value="${hourIndex }" selected="selected">${hourIndex}</option>
	                        			</c:if>
				                        <c:if test="${hourIndex != timeSwitch.shutdownHour}">
	                        				<option value="${hourIndex }">${hourIndex}</option>
	                        			</c:if>	
	                        		</c:if>
	                        	</c:forEach>
	                        </select>
	                        <span>:</span>
	                        <select class="sel-45 close_minute">
	                        	<c:forEach begin="00" end="59" step="1" var="minuteIndex">
	                        		<c:if test="${minuteIndex < 10 }">
	                        			<c:if test="${minuteIndex == timeSwitch.shutdownMinute}">
	                        				<option value="0${minuteIndex }" selected="selected">0${minuteIndex}</option>
	                        			</c:if>
				                        <c:if test="${minuteIndex != timeSwitch.shutdownMinute}">
	                        				<option value="0${minuteIndex }">0${minuteIndex}</option>
	                        			</c:if>			
	                        		</c:if>
	                        		<c:if test="${minuteIndex >= 10 }">
	                        			<c:if test="${minuteIndex == timeSwitch.shutdownMinute}">
	                        				<option value="${minuteIndex }" selected="selected">${minuteIndex}</option>
	                        			</c:if>
				                        <c:if test="${minuteIndex != timeSwitch.shutdownMinute}">
	                        				<option value="${minuteIndex }">${minuteIndex}</option>
	                        			</c:if>	
	                        		</c:if>
	                        	</c:forEach>
	                        </select>
	                        <a href="javascript:;">应用到全周</a>
	                    </td>
	                </tr>
	                </c:if>
                </c:forEach>
                <tr class="tbListRow" <c:if test="${isDoing == 0 }"> style="display:table-row"</c:if>>
	                <td>&nbsp;</td>
                    <td colspan="2">
                   	<table>
                       	<colgroup>
                      		<col width="50%">
                          	<col width="50%">
                       	</colgroup>
                       	<tbody>
                       	<c:forEach items="${timeSwitchs }" var="timeSwitch">
                        	<c:if test="${timeSwitch.week == 'Saturday' && timeSwitchId != timeSwitch.id}">
                        		<tr>
	                        		<td>
	                        		<span>开机</span>
	                        		<select class="sel-45 open_hour" name="${timeSwitch.id }">
	                        			<c:forEach begin="00" end="23" step="1" var="hourIndex">
			                        		<c:if test="${hourIndex < 10 }">
			                        			<c:if test="${hourIndex == timeSwitch.powerHour}">
			                        				<option value="0${hourIndex }" selected="selected">0${hourIndex}</option>
			                        			</c:if>
						                        <c:if test="${hourIndex != timeSwitch.powerHour}">
			                        				<option value="0${hourIndex }">0${hourIndex}</option>
			                        			</c:if>			
			                        		</c:if>
			                        		<c:if test="${hourIndex >= 10 }">
			                        			<c:if test="${hourIndex == timeSwitch.powerHour}">
			                        				<option value="${hourIndex }" selected="selected">${hourIndex}</option>
			                        			</c:if>
						                        <c:if test="${hourIndex != timeSwitch.powerHour}">
			                        				<option value="${hourIndex }">${hourIndex}</option>
			                        			</c:if>	
			                        		</c:if>
			                        	</c:forEach>
	                        		</select>
	                        		<span>:</span>
	                        		<select class="sel-45 open_minute">
                        				<c:forEach begin="00" end="59" step="1" var="minuteIndex">
			                        		<c:if test="${minuteIndex < 10 }">
			                        			<c:if test="${minuteIndex == timeSwitch.powerMinute}">
			                        				<option value="0${minuteIndex }" selected="selected">0${minuteIndex}</option>
			                        			</c:if>
						                        <c:if test="${minuteIndex != timeSwitch.powerMinute}">
			                        				<option value="0${minuteIndex }">0${minuteIndex}</option>
			                        			</c:if>			
			                        		</c:if>
			                        		<c:if test="${minuteIndex >= 10 }">
			                        			<c:if test="${minuteIndex == timeSwitch.powerMinute}">
			                        				<option value="${minuteIndex }" selected="selected">${minuteIndex}</option>
			                        			</c:if>
						                        <c:if test="${minuteIndex != timeSwitch.powerMinute}">
			                        				<option value="${minuteIndex }">${minuteIndex}</option>
			                        			</c:if>	
			                        		</c:if>
			                        	</c:forEach>
	                        		</select>
	                        		</td>
	                        		<td>
	                        		<input type="button" class="btn-01 right clock_del" value="删除">
	                        		<span>关机</span>
			                        <select class="sel-45 close_hour">
			                        	<c:forEach begin="00" end="23" step="1" var="hourIndex">
			                        		<c:if test="${hourIndex < 10 }">
			                        			<c:if test="${hourIndex == timeSwitch.shutdownHour}">
			                        				<option value="0${hourIndex }" selected="selected">0${hourIndex}</option>
			                        			</c:if>
						                        <c:if test="${hourIndex != timeSwitch.shutdownHour}">
			                        				<option value="0${hourIndex }">0${hourIndex}</option>
			                        			</c:if>			
			                        		</c:if>
			                        		<c:if test="${hourIndex >= 10 }">
			                        			<c:if test="${hourIndex == timeSwitch.shutdownHour}">
			                        				<option value="${hourIndex }" selected="selected">${hourIndex}</option>
			                        			</c:if>
						                        <c:if test="${hourIndex != timeSwitch.shutdownHour}">
			                        				<option value="${hourIndex }">${hourIndex}</option>
			                        			</c:if>	
			                        		</c:if>
			                        	</c:forEach>
			                        </select>
			                        <span>:</span>
			                        <select class="sel-45 close_minute">
			                        	<c:forEach begin="00" end="59" step="1" var="minuteIndex">
			                        		<c:if test="${minuteIndex < 10 }">
			                        			<c:if test="${minuteIndex == timeSwitch.shutdownMinute}">
			                        				<option value="0${minuteIndex }" selected="selected">0${minuteIndex}</option>
			                        			</c:if>
						                        <c:if test="${minuteIndex != timeSwitch.shutdownMinute}">
			                        				<option value="0${minuteIndex }">0${minuteIndex}</option>
			                        			</c:if>			
			                        		</c:if>
			                        		<c:if test="${minuteIndex >= 10 }">
			                        			<c:if test="${minuteIndex == timeSwitch.shutdownMinute}">
			                        				<option value="${minuteIndex }" selected="selected">${minuteIndex}</option>
			                        			</c:if>
						                        <c:if test="${minuteIndex != timeSwitch.shutdownMinute}">
			                        				<option value="${minuteIndex }">${minuteIndex}</option>
			                        			</c:if>	
			                        		</c:if>
			                        	</c:forEach>
			                        </select>
	                        		</td>
                        		</tr>
                        	</c:if>
                       	</c:forEach>
                       	</tbody>
                      </table>
                   </td>
                </tr>
                <c:set var="isDoing" value="1"/>
                <c:set var="timeSwitchId" value=""/> 
                <c:forEach items="${timeSwitchs }" var="timeSwitch">
                	<c:if test="${timeSwitch.week == 'Sunday' && isDoing == 1}">
                	<c:set var="timeSwitchId" value="${timeSwitch.id }"/> 
                	<c:set var="isDoing" value="0"/> 
	                <tr>
	                	<td>
	                    	<span class="enable_check">
	                   			<c:if test="${timeSwitch.iscycling == 1 }">
	                       			<input type="checkbox" checked  value="Sunday">
	                       		</c:if>
	                       		<c:if test="${timeSwitch.iscycling == 0 }">
	                       			<input type="checkbox"  value="Sunday">
	                       		</c:if>
	                            <label for="">星期天</label>
	                        </span>
	                    </td>
	                    <td>
	                    	<span>开机</span>
	                        <select class="sel-45 open_hour" >
	                        	<c:forEach begin="00" end="23" step="1" var="hourIndex">
	                        		<c:if test="${hourIndex < 10 }">
	                        			<c:if test="${hourIndex == timeSwitch.powerHour}">
	                        				<option value="0${hourIndex }" selected="selected">0${hourIndex}</option>
	                        			</c:if>
				                        <c:if test="${hourIndex != timeSwitch.powerHour}">
	                        				<option value="0${hourIndex }">0${hourIndex}</option>
	                        			</c:if>			
	                        		</c:if>
	                        		<c:if test="${hourIndex >= 10 }">
	                        			<c:if test="${hourIndex == timeSwitch.powerHour}">
	                        				<option value="${hourIndex }" selected="selected">${hourIndex}</option>
	                        			</c:if>
				                        <c:if test="${hourIndex != timeSwitch.powerHour}">
	                        				<option value="${hourIndex }">${hourIndex}</option>
	                        			</c:if>	
	                        		</c:if>
	                        	</c:forEach>
	                        </select>
	                        <span>:</span>
	                        <select class="sel-45 open_minute">
	                        	<c:forEach begin="00" end="59" step="1" var="minuteIndex">
	                        		<c:if test="${minuteIndex < 10 }">
	                        			<c:if test="${minuteIndex == timeSwitch.powerMinute}">
	                        				<option value="0${minuteIndex }" selected="selected">0${minuteIndex}</option>
	                        			</c:if>
				                        <c:if test="${minuteIndex != timeSwitch.powerMinute}">
	                        				<option value="0${minuteIndex }">0${minuteIndex}</option>
	                        			</c:if>			
	                        		</c:if>
	                        		<c:if test="${minuteIndex >= 10 }">
	                        			<c:if test="${minuteIndex == timeSwitch.powerMinute}">
	                        				<option value="${minuteIndex }" selected="selected">${minuteIndex}</option>
	                        			</c:if>
				                        <c:if test="${minuteIndex != timeSwitch.powerMinute}">
	                        				<option value="${minuteIndex }">${minuteIndex}</option>
	                        			</c:if>	
	                        		</c:if>
	                        	</c:forEach>
	                        </select>
	                        <a href="javascript:;">应用到全周</a>
	                    </td>
	                    <td>
	                    	<input type="button" class="btn-01 right clock_add" value="添加">
	                    	<span>关机</span>
	                        <select class="sel-45 close_hour">
	                        	<c:forEach begin="00" end="23" step="1" var="hourIndex">
	                        		<c:if test="${hourIndex < 10 }">
	                        			<c:if test="${hourIndex == timeSwitch.shutdownHour}">
	                        				<option value="0${hourIndex }" selected="selected">0${hourIndex}</option>
	                        			</c:if>
				                        <c:if test="${hourIndex != timeSwitch.shutdownHour}">
	                        				<option value="0${hourIndex }">0${hourIndex}</option>
	                        			</c:if>			
	                        		</c:if>
	                        		<c:if test="${hourIndex >= 10 }">
	                        			<c:if test="${hourIndex == timeSwitch.shutdownHour}">
	                        				<option value="${hourIndex }" selected="selected">${hourIndex}</option>
	                        			</c:if>
				                        <c:if test="${hourIndex != timeSwitch.shutdownHour}">
	                        				<option value="${hourIndex }">${hourIndex}</option>
	                        			</c:if>	
	                        		</c:if>
	                        	</c:forEach>
	                        </select>
	                        <span>:</span>
	                        <select class="sel-45 close_minute">
	                        	<c:forEach begin="00" end="59" step="1" var="minuteIndex">
	                        		<c:if test="${minuteIndex < 10 }">
	                        			<c:if test="${minuteIndex == timeSwitch.shutdownMinute}">
	                        				<option value="0${minuteIndex }" selected="selected">0${minuteIndex}</option>
	                        			</c:if>
				                        <c:if test="${minuteIndex != timeSwitch.shutdownMinute}">
	                        				<option value="0${minuteIndex }">0${minuteIndex}</option>
	                        			</c:if>			
	                        		</c:if>
	                        		<c:if test="${minuteIndex >= 10 }">
	                        			<c:if test="${minuteIndex == timeSwitch.shutdownMinute}">
	                        				<option value="${minuteIndex }" selected="selected">${minuteIndex}</option>
	                        			</c:if>
				                        <c:if test="${minuteIndex != timeSwitch.shutdownMinute}">
	                        				<option value="${minuteIndex }">${minuteIndex}</option>
	                        			</c:if>	
	                        		</c:if>
	                        	</c:forEach>
	                        </select>
	                        <a href="javascript:;">应用到全周</a>
	                    </td>
	                </tr>
	                </c:if>
                </c:forEach>
                <tr class="tbListRow" <c:if test="${isDoing == 0 }"> style="display:table-row"</c:if>>
	                <td>&nbsp;</td>
                    <td colspan="2">
                   	<table>
                       	<colgroup>
                      		<col width="50%">
                          	<col width="50%">
                       	</colgroup>
                       	<tbody>
                       	<c:forEach items="${timeSwitchs }" var="timeSwitch">
                        	<c:if test="${timeSwitch.week == 'Sunday' && timeSwitchId != timeSwitch.id}">
                        		<tr>
	                        		<td>
	                        		<span>开机</span>
	                        		<select class="sel-45 open_hour" name="${timeSwitch.id }">
	                        			<c:forEach begin="00" end="23" step="1" var="hourIndex">
			                        		<c:if test="${hourIndex < 10 }">
			                        			<c:if test="${hourIndex == timeSwitch.powerHour}">
			                        				<option value="0${hourIndex }" selected="selected">0${hourIndex}</option>
			                        			</c:if>
						                        <c:if test="${hourIndex != timeSwitch.powerHour}">
			                        				<option value="0${hourIndex }">0${hourIndex}</option>
			                        			</c:if>			
			                        		</c:if>
			                        		<c:if test="${hourIndex >= 10 }">
			                        			<c:if test="${hourIndex == timeSwitch.powerHour}">
			                        				<option value="${hourIndex }" selected="selected">${hourIndex}</option>
			                        			</c:if>
						                        <c:if test="${hourIndex != timeSwitch.powerHour}">
			                        				<option value="${hourIndex }">${hourIndex}</option>
			                        			</c:if>	
			                        		</c:if>
			                        	</c:forEach>
	                        		</select>
	                        		<span>:</span>
	                        		<select class="sel-45 open_minute">
                        				<c:forEach begin="00" end="59" step="1" var="minuteIndex">
			                        		<c:if test="${minuteIndex < 10 }">
			                        			<c:if test="${minuteIndex == timeSwitch.powerMinute}">
			                        				<option value="0${minuteIndex }" selected="selected">0${minuteIndex}</option>
			                        			</c:if>
						                        <c:if test="${minuteIndex != timeSwitch.powerMinute}">
			                        				<option value="0${minuteIndex }">0${minuteIndex}</option>
			                        			</c:if>			
			                        		</c:if>
			                        		<c:if test="${minuteIndex >= 10 }">
			                        			<c:if test="${minuteIndex == timeSwitch.powerMinute}">
			                        				<option value="${minuteIndex }" selected="selected">${minuteIndex}</option>
			                        			</c:if>
						                        <c:if test="${minuteIndex != timeSwitch.powerMinute}">
			                        				<option value="${minuteIndex }">${minuteIndex}</option>
			                        			</c:if>	
			                        		</c:if>
			                        	</c:forEach>
	                        		</select>
	                        		</td>
	                        		<td>
	                        		<input type="button" class="btn-01 right clock_del" value="删除">
	                        		<span>关机</span>
			                        <select class="sel-45 close_hour">
			                        	<c:forEach begin="00" end="23" step="1" var="hourIndex">
			                        		<c:if test="${hourIndex < 10 }">
			                        			<c:if test="${hourIndex == timeSwitch.shutdownHour}">
			                        				<option value="0${hourIndex }" selected="selected">0${hourIndex}</option>
			                        			</c:if>
						                        <c:if test="${hourIndex != timeSwitch.shutdownHour}">
			                        				<option value="0${hourIndex }">0${hourIndex}</option>
			                        			</c:if>			
			                        		</c:if>
			                        		<c:if test="${hourIndex >= 10 }">
			                        			<c:if test="${hourIndex == timeSwitch.shutdownHour}">
			                        				<option value="${hourIndex }" selected="selected">${hourIndex}</option>
			                        			</c:if>
						                        <c:if test="${hourIndex != timeSwitch.shutdownHour}">
			                        				<option value="${hourIndex }">${hourIndex}</option>
			                        			</c:if>	
			                        		</c:if>
			                        	</c:forEach>
			                        </select>
			                        <span>:</span>
			                        <select class="sel-45 close_minute">
			                        	<c:forEach begin="00" end="59" step="1" var="minuteIndex">
			                        		<c:if test="${minuteIndex < 10 }">
			                        			<c:if test="${minuteIndex == timeSwitch.shutdownMinute}">
			                        				<option value="0${minuteIndex }" selected="selected">0${minuteIndex}</option>
			                        			</c:if>
						                        <c:if test="${minuteIndex != timeSwitch.shutdownMinute}">
			                        				<option value="0${minuteIndex }">0${minuteIndex}</option>
			                        			</c:if>			
			                        		</c:if>
			                        		<c:if test="${minuteIndex >= 10 }">
			                        			<c:if test="${minuteIndex == timeSwitch.shutdownMinute}">
			                        				<option value="${minuteIndex }" selected="selected">${minuteIndex}</option>
			                        			</c:if>
						                        <c:if test="${minuteIndex != timeSwitch.shutdownMinute}">
			                        				<option value="${minuteIndex }">${minuteIndex}</option>
			                        			</c:if>	
			                        		</c:if>
			                        	</c:forEach>
			                        </select>
	                        		</td>
                        		</tr>
                        	</c:if>
                       	</c:forEach>
                       	</tbody>
                      </table>
                   </td>
                </tr>
                </c:if>
                <c:if test="${timeSwitchs.size() == 0 }">
                <tr>
                	<td>
                    	<span class="enable_check">
                        	<input type="checkbox" checked  value="Monday">
                            <label for="">星期一</label>
                        </span>
                    </td>
                     <td>
                    	<span>开机</span>
                        <select class="sel-45 open_hour" >
                     		<c:forEach begin="00" end="23" step="1" var="hourIndex">
	                       		<c:if test="${hourIndex < 10 }">
                       				<option value="0${hourIndex }">0${hourIndex}</option>
	                       		</c:if>
	                       		<c:if test="${hourIndex >= 10 }">
	                       			<option value="${hourIndex }">${hourIndex}</option>
	                       		</c:if>
                        	</c:forEach>
                      	</select>
                      	<span>:</span>
                      	<select class="sel-45 open_minute">
                     		<c:forEach begin="00" end="59" step="1" var="minuteIndex">
                        		<c:if test="${minuteIndex < 10 }">
                       				<option value="0${minuteIndex }">0${minuteIndex}</option>
                        		</c:if>
                        		<c:if test="${minuteIndex >= 10 }">
                        			<option value="${minuteIndex }">${minuteIndex}</option>
                        		</c:if>
                        	</c:forEach>
                     	</select>
                        <a href="javascript:;">应用到全周</a>
                    </td>
                    <td>
                    	<input type="button" class="btn-01 right clock_add" value="添加">
                    	<span>关机</span>
                        <select class="sel-45 close_hour" >
                       		<c:forEach begin="00" end="23" step="1" var="hourIndex">
	                        	<c:if test="${hourIndex < 10 }">
                        			<option value="0${hourIndex }">0${hourIndex}</option>
	                        	</c:if>
	                        	<c:if test="${hourIndex >= 10 }">
	                        		<option value="${hourIndex }">${hourIndex}</option>
	                        	</c:if>
	                        </c:forEach>
                       	</select>
                      	<span>:</span>
                       	<select class="sel-45 close_minute">
                     		<c:forEach begin="00" end="59" step="1" var="minuteIndex">
                        		<c:if test="${minuteIndex < 10 }">
                       				<option value="0${minuteIndex }">0${minuteIndex}</option>
                        		</c:if>
                        		<c:if test="${minuteIndex >= 10 }">
                        			<option value="${minuteIndex }">${minuteIndex}</option>
                        		</c:if>
                        	</c:forEach>
                       	</select>
                        <a href="javascript:;">应用到全周</a>
                    </td>
                </tr>
                <tr class="tbListRow">
	                <td>&nbsp;</td>
                    <td colspan="2">
                   	<table>
                       	<colgroup>
                           	<col width="50%">
                               <col width="50%">
                           </colgroup>
                       </table>
                   </td>
                </tr>
                <tr>
                	<td>
                    	<span class="enable_check">
                        	<input type="checkbox" checked  value="Tuesday">
                            <label for="">星期二</label>
                        </span>
                    </td>
                     <td>
                    	<span>开机</span>
                        <select class="sel-45 open_hour" >
                       		<c:forEach begin="00" end="23" step="1" var="hourIndex">
	                        	<c:if test="${hourIndex < 10 }">
                        			<option value="0${hourIndex }">0${hourIndex}</option>
	                        	</c:if>
	                        	<c:if test="${hourIndex >= 10 }">
	                        		<option value="${hourIndex }">${hourIndex}</option>
	                        	</c:if>
	                        </c:forEach>
                       	</select>
                      	<span>:</span>
                       	<select class="sel-45 open_minute">
                     		<c:forEach begin="00" end="59" step="1" var="minuteIndex">
                        		<c:if test="${minuteIndex < 10 }">
                       				<option value="0${minuteIndex }">0${minuteIndex}</option>
                        		</c:if>
                        		<c:if test="${minuteIndex >= 10 }">
                        			<option value="${minuteIndex }">${minuteIndex}</option>
                        		</c:if>
                        	</c:forEach>
                       	</select>
                        <a href="javascript:;">应用到全周</a>
                    </td>
                    <td>
                    	<input type="button" class="btn-01 right clock_add" value="添加">
                    	<span>关机</span>
                        <select class="sel-45 close_hour" >
                       		<c:forEach begin="00" end="23" step="1" var="hourIndex">
	                        	<c:if test="${hourIndex < 10 }">
                        			<option value="0${hourIndex }">0${hourIndex}</option>
	                        	</c:if>
	                        	<c:if test="${hourIndex >= 10 }">
	                        		<option value="${hourIndex }">${hourIndex}</option>
	                        	</c:if>
	                        </c:forEach>
                       	</select>
                      	<span>:</span>
                       	<select class="sel-45 close_minute">
                     		<c:forEach begin="00" end="59" step="1" var="minuteIndex">
                        		<c:if test="${minuteIndex < 10 }">
                       				<option value="0${minuteIndex }">0${minuteIndex}</option>
                        		</c:if>
                        		<c:if test="${minuteIndex >= 10 }">
                        			<option value="${minuteIndex }">${minuteIndex}</option>
                        		</c:if>
                        	</c:forEach>
                       	</select>
                        <a href="javascript:;">应用到全周</a>
                    </td>
                </tr>
                <tr class="tbListRow">
	                <td>&nbsp;</td>
                    <td colspan="2">
                   	<table>
                       	<colgroup>
                           	<col width="50%">
                               <col width="50%">
                           </colgroup>
                       </table>
                   </td>
                </tr>
                <tr>
                	<td>
                    	<span class="enable_check">
                        	<input type="checkbox" checked  value="Wednesday">
                            <label for="">星期三</label>
                        </span>
                    </td>
                     <td>
                    	<span>开机</span>
                        <select class="sel-45 open_hour" >
                       		<c:forEach begin="00" end="23" step="1" var="hourIndex">
	                        	<c:if test="${hourIndex < 10 }">
                        			<option value="0${hourIndex }">0${hourIndex}</option>
	                        	</c:if>
	                        	<c:if test="${hourIndex >= 10 }">
	                        		<option value="${hourIndex }">${hourIndex}</option>
	                        	</c:if>
	                        </c:forEach>
                       	</select>
                      	<span>:</span>
                       	<select class="sel-45 open_minute">
                     		<c:forEach begin="00" end="59" step="1" var="minuteIndex">
                        		<c:if test="${minuteIndex < 10 }">
                       				<option value="0${minuteIndex }">0${minuteIndex}</option>
                        		</c:if>
                        		<c:if test="${minuteIndex >= 10 }">
                        			<option value="${minuteIndex }">${minuteIndex}</option>
                        		</c:if>
                        	</c:forEach>
                       	</select>
                        <a href="javascript:;">应用到全周</a>
                    </td>
                    <td>
                    	<input type="button" class="btn-01 right clock_add" value="添加">
                    	<span>关机</span>
                        <select class="sel-45 close_hour" >
                       		<c:forEach begin="00" end="23" step="1" var="hourIndex">
	                        	<c:if test="${hourIndex < 10 }">
                        			<option value="0${hourIndex }">0${hourIndex}</option>
	                        	</c:if>
	                        	<c:if test="${hourIndex >= 10 }">
	                        		<option value="${hourIndex }">${hourIndex}</option>
	                        	</c:if>
	                        </c:forEach>
                       	</select>
                      	<span>:</span>
                       	<select class="sel-45 close_minute">
                     		<c:forEach begin="00" end="59" step="1" var="minuteIndex">
                        		<c:if test="${minuteIndex < 10 }">
                       				<option value="0${minuteIndex }">0${minuteIndex}</option>
                        		</c:if>
                        		<c:if test="${minuteIndex >= 10 }">
                        			<option value="${minuteIndex }">${minuteIndex}</option>
                        		</c:if>
                        	</c:forEach>
                       	</select>
                        <a href="javascript:;">应用到全周</a>
                    </td>
                </tr>
                <tr class="tbListRow">
	                <td>&nbsp;</td>
                    <td colspan="2">
                   	<table>
                       	<colgroup>
                           	<col width="50%">
                               <col width="50%">
                           </colgroup>
                       </table>
                   </td>
                </tr>
                <tr>
                	<td>
                    	<span class="enable_check">
                        	<input type="checkbox" checked  value="Thursday">
                            <label for="">星期四</label>
                        </span>
                    </td>
                     <td>
                    	<span>开机</span>
                        <select class="sel-45 open_hour" >
                       		<c:forEach begin="00" end="23" step="1" var="hourIndex">
	                        	<c:if test="${hourIndex < 10 }">
                        			<option value="0${hourIndex }">0${hourIndex}</option>
	                        	</c:if>
	                        	<c:if test="${hourIndex >= 10 }">
	                        		<option value="${hourIndex }">${hourIndex}</option>
	                        	</c:if>
	                        </c:forEach>
                       	</select>
                      	<span>:</span>
                       	<select class="sel-45 open_minute">
                     		<c:forEach begin="00" end="59" step="1" var="minuteIndex">
                        		<c:if test="${minuteIndex < 10 }">
                       				<option value="0${minuteIndex }">0${minuteIndex}</option>
                        		</c:if>
                        		<c:if test="${minuteIndex >= 10 }">
                        			<option value="${minuteIndex }">${minuteIndex}</option>
                        		</c:if>
                        	</c:forEach>
                       	</select>
                        <a href="javascript:;">应用到全周</a>
                    </td>
                    <td>
                    	<input type="button" class="btn-01 right clock_add" value="添加">
                    	<span>关机</span>
                        <select class="sel-45 close_hour" >
                       		<c:forEach begin="00" end="23" step="1" var="hourIndex">
	                        	<c:if test="${hourIndex < 10 }">
                        			<option value="0${hourIndex }">0${hourIndex}</option>
	                        	</c:if>
	                        	<c:if test="${hourIndex >= 10 }">
	                        		<option value="${hourIndex }">${hourIndex}</option>
	                        	</c:if>
	                        </c:forEach>
                       	</select>
                      	<span>:</span>
                       	<select class="sel-45 close_minute">
                     		<c:forEach begin="00" end="59" step="1" var="minuteIndex">
                        		<c:if test="${minuteIndex < 10 }">
                       				<option value="0${minuteIndex }">0${minuteIndex}</option>
                        		</c:if>
                        		<c:if test="${minuteIndex >= 10 }">
                        			<option value="${minuteIndex }">${minuteIndex}</option>
                        		</c:if>
                        	</c:forEach>
                       	</select>
                        <a href="javascript:;">应用到全周</a>
                    </td>
                </tr>
                <tr class="tbListRow">
	                <td>&nbsp;</td>
                    <td colspan="2">
                   	<table>
                       	<colgroup>
                           	<col width="50%">
                               <col width="50%">
                           </colgroup>
                       </table>
                   </td>
                </tr>
                <tr>
                	<td>
                    	<span class="enable_check">
                        	<input type="checkbox" checked  value="Friday">
                            <label for="">星期五</label>
                        </span>
                    </td>
                     <td>
                    	<span>开机</span>
                        <select class="sel-45 open_hour" >
                       		<c:forEach begin="00" end="23" step="1" var="hourIndex">
	                        	<c:if test="${hourIndex < 10 }">
                        			<option value="0${hourIndex }">0${hourIndex}</option>
	                        	</c:if>
	                        	<c:if test="${hourIndex >= 10 }">
	                        		<option value="${hourIndex }">${hourIndex}</option>
	                        	</c:if>
	                        </c:forEach>
                       	</select>
                      	<span>:</span>
                       	<select class="sel-45 open_minute">
                     		<c:forEach begin="00" end="59" step="1" var="minuteIndex">
                        		<c:if test="${minuteIndex < 10 }">
                       				<option value="0${minuteIndex }">0${minuteIndex}</option>
                        		</c:if>
                        		<c:if test="${minuteIndex >= 10 }">
                        			<option value="${minuteIndex }">${minuteIndex}</option>
                        		</c:if>
                        	</c:forEach>
                       	</select>
                        <a href="javascript:;">应用到全周</a>
                    </td>
                    <td>
                    	<input type="button" class="btn-01 right clock_add" value="添加">
                    	<span>关机</span>
                        <select class="sel-45 close_hour" >
                       		<c:forEach begin="00" end="23" step="1" var="hourIndex">
	                        	<c:if test="${hourIndex < 10 }">
                        			<option value="0${hourIndex }">0${hourIndex}</option>
	                        	</c:if>
	                        	<c:if test="${hourIndex >= 10 }">
	                        		<option value="${hourIndex }">${hourIndex}</option>
	                        	</c:if>
	                        </c:forEach>
                       	</select>
                      	<span>:</span>
                       	<select class="sel-45 close_minute">
                     		<c:forEach begin="00" end="59" step="1" var="minuteIndex">
                        		<c:if test="${minuteIndex < 10 }">
                       				<option value="0${minuteIndex }">0${minuteIndex}</option>
                        		</c:if>
                        		<c:if test="${minuteIndex >= 10 }">
                        			<option value="${minuteIndex }">${minuteIndex}</option>
                        		</c:if>
                        	</c:forEach>
                       	</select>
                        <a href="javascript:;">应用到全周</a>
                    </td>
                </tr>
                <tr class="tbListRow">
	                <td>&nbsp;</td>
                    <td colspan="2">
                   	<table>
                       	<colgroup>
                           	<col width="50%">
                               <col width="50%">
                           </colgroup>
                       </table>
                   </td>
                </tr>
                <tr>
                	<td>
                    	<span class="enable_check">
                        	<input type="checkbox" checked  value="Saturday">
                            <label for="">星期六</label>
                        </span>
                    </td>
                    <td>
                    	<span>开机</span>
                        <select class="sel-45 open_hour" >
                       		<c:forEach begin="00" end="23" step="1" var="hourIndex">
	                        	<c:if test="${hourIndex < 10 }">
                        			<option value="0${hourIndex }">0${hourIndex}</option>
	                        	</c:if>
	                        	<c:if test="${hourIndex >= 10 }">
	                        		<option value="${hourIndex }">${hourIndex}</option>
	                        	</c:if>
	                        </c:forEach>
                       	</select>
                      	<span>:</span>
                       	<select class="sel-45 open_minute">
                     		<c:forEach begin="00" end="59" step="1" var="minuteIndex">
                        		<c:if test="${minuteIndex < 10 }">
                       				<option value="0${minuteIndex }">0${minuteIndex}</option>
                        		</c:if>
                        		<c:if test="${minuteIndex >= 10 }">
                        			<option value="${minuteIndex }">${minuteIndex}</option>
                        		</c:if>
                        	</c:forEach>
                       	</select>
                        <a href="javascript:;">应用到全周</a>
                    </td>
                    <td>
                    	<input type="button" class="btn-01 right clock_add" value="添加">
                    	<span>关机</span>
                        <select class="sel-45 close_hour" >
                       		<c:forEach begin="00" end="23" step="1" var="hourIndex">
	                        	<c:if test="${hourIndex < 10 }">
                        			<option value="0${hourIndex }">0${hourIndex}</option>
	                        	</c:if>
	                        	<c:if test="${hourIndex >= 10 }">
	                        		<option value="${hourIndex }">${hourIndex}</option>
	                        	</c:if>
	                        </c:forEach>
                       	</select>
                      	<span>:</span>
                       	<select class="sel-45 close_minute">
                     		<c:forEach begin="00" end="59" step="1" var="minuteIndex">
                        		<c:if test="${minuteIndex < 10 }">
                       				<option value="0${minuteIndex }">0${minuteIndex}</option>
                        		</c:if>
                        		<c:if test="${minuteIndex >= 10 }">
                        			<option value="${minuteIndex }">${minuteIndex}</option>
                        		</c:if>
                        	</c:forEach>
                       	</select>
                        <a href="javascript:;">应用到全周</a>
                    </td>
                </tr>
                <tr class="tbListRow">
	                <td>&nbsp;</td>
                    <td colspan="2">
                   	<table>
                       	<colgroup>
                           	<col width="50%">
                               <col width="50%">
                           </colgroup>
                       </table>
                   </td>
                </tr>
                <tr>
                	<td>
                    	<span class="enable_check">
                        	<input type="checkbox" checked  value="Sunday">
                            <label for="">星期日</label>
                        </span>
                    </td>
                    <td>
                    	<span>开机</span>
                        <select class="sel-45 open_hour" >
                       		<c:forEach begin="00" end="23" step="1" var="hourIndex">
	                        	<c:if test="${hourIndex < 10 }">
                        			<option value="0${hourIndex }">0${hourIndex}</option>
	                        	</c:if>
	                        	<c:if test="${hourIndex >= 10 }">
	                        		<option value="${hourIndex }">${hourIndex}</option>
	                        	</c:if>
	                        </c:forEach>
                       	</select>
                      	<span>:</span>
                       	<select class="sel-45 open_minute">
                     		<c:forEach begin="00" end="59" step="1" var="minuteIndex">
                        		<c:if test="${minuteIndex < 10 }">
                       				<option value="0${minuteIndex }">0${minuteIndex}</option>
                        		</c:if>
                        		<c:if test="${minuteIndex >= 10 }">
                        			<option value="${minuteIndex }">${minuteIndex}</option>
                        		</c:if>
                        	</c:forEach>
                       	</select>
                        <a href="javascript:;">应用到全周</a>
                    </td>
                    <td>
                    	<input type="button" class="btn-01 right clock_add" value="添加">
                    	<span>关机</span>
                        <select class="sel-45 close_hour" >
                       		<c:forEach begin="00" end="23" step="1" var="hourIndex">
	                        	<c:if test="${hourIndex < 10 }">
                        			<option value="0${hourIndex }">0${hourIndex}</option>
	                        	</c:if>
	                        	<c:if test="${hourIndex >= 10 }">
	                        		<option value="${hourIndex }">${hourIndex}</option>
	                        	</c:if>
	                        </c:forEach>
                       	</select>
                      	<span>:</span>
                       	<select class="sel-45 close_minute">
                     		<c:forEach begin="00" end="59" step="1" var="minuteIndex">
                        		<c:if test="${minuteIndex < 10 }">
                       				<option value="0${minuteIndex }">0${minuteIndex}</option>
                        		</c:if>
                        		<c:if test="${minuteIndex >= 10 }">
                        			<option value="${minuteIndex }">${minuteIndex}</option>
                        		</c:if>
                        	</c:forEach>
                       	</select>
                        <a href="javascript:;">应用到全周</a>
                    </td>
                </tr>
                <tr class="tbListRow">
	                <td>&nbsp;</td>
                    <td colspan="2">
                   	<table>
                       	<colgroup>
                           	<col width="50%">
                               <col width="50%">
                           </colgroup>
                       </table>
                   </td>
                </tr>
                </c:if>
            </table>
        </div>
    	<div class="main_white" style="text-align:right; line-height:32px;">
            <input type="button" class="btn-01" value="保存" onclick="onSubmit()">
            <input type="button" class="btn-01" value="取消" onclick="onClose()">
        </div>
    </form>
</div>
<script src="<%=path %>/js/jquery.js"></script>
<script type="text/javascript" src="<%=path%>/js/common.js"></script>
<script type="text/javascript" src="<%=path%>/layer/layer.js"></script>
<script type="text/javascript">
$(function(){
	var $tbListRow=$(".tbListRow");
	$tbListRow.each(function(index, element) {
		var $this=$(this);
		var $addRow=$this.find('tr');
		var len=$addRow.length;
		if(len==0){
			$this.hide();
		}
	});
});


/*添加*/
var $clockAdd=$('.clock_add');
var $time=$('#time');
$clockAdd.bind('click',function(){
	var $this=$(this);
	var $tr=$this.parents('tr');
	var $tbListRow=$tr.next('.tbListRow');
	var $table= $tbListRow.find('table');
	
	var hourSelect = "";
	for ( var int = 0; int < 23; int++) {
		if(int < 10){
			hourSelect += "<option value='0"+int+"'>0"+int+"</option>";
		}else{
			hourSelect += "<option value='"+int+"'>"+int+"</option>";
		}
	}
	
	var minuteSelect = "";
	for ( var int = 0; int < 59; int++) {
		if(int < 10){
			minuteSelect += "<option value='0"+int+"'>0"+int+"</option>";
		}else{
			minuteSelect += "<option value='"+int+"'>"+int+"</option>";
		}
	}
	
	var otr=$('<tr><td><span>开机&nbsp;</span><select class="sel-45 open_hour">'+hourSelect+'</select><span>:</span>'+
	'&nbsp;<select class="sel-45 open_minute">'+minuteSelect+'</select>'
	+'</td><td><input type="button" class="btn-01 right clock_del" value="删除"><span>关机&nbsp;</span>'+'<select class="sel-45 close_hour">'+hourSelect+'</select><span>:</span>&nbsp;<select class="sel-45 close_minute">'+
	minuteSelect
	+'</select>'
	+'</td></tr>');
	$table.append(otr);
	$tbListRow.show();
	$(".open_hour").append(setHourSelect);
	$(".open_minute").append(setMinuteSelect);
	$(".close_hour").append(setHourSelect);
	$(".close_minute").append(setMinuteSelect);
});

/*删除*/
$time.delegate('.clock_del','click',function(){
	var $this=$(this);
	var $rowList=$this.parents('.tbListRow');
	var $addRow=$rowList.find('tr');
	var $targetRow=$this.parent().parent();
	var len=$addRow.length;
	if(len==1){
		$rowList.hide();
	}
	$targetRow.remove();
});



function onSubmit(){
	var terminalIds = "${ids}";
	
	var flag = true;
	/*获值*/
	var $objTime=[];
	
	var $aChecked=$time.find(':checkbox');
	$aChecked.each(function(index, element) {
		if(!flag){
			return;
		}
        var $this=$(this);
        var $iscycling;
        if(this.checked){
        	$iscycling = "1";
        }else{
        	$iscycling = "0";
        }
        
		var $week = $this.val();
		
		var $td=$this.parents('td').nextAll('td');
		var $open_hour=$td.find('.open_hour').val();
		var $open_minute=$td.find('.open_minute').val();
		var $close_hour=$td.find('.close_hour').val();
		var $close_minute=$td.find('.close_minute').val();
		
		if($iscycling == '1'){
			if($open_hour == $close_hour){
				if($open_minute == $close_minute){
					layer.alert('提示：定时开关机时间间隔必须在3分钟以上', {icon:5,title:'提示'});
					flag = false;
					return;
				}
				
				if($close_minute < $open_minute){
					layer.alert('提示：定时开机时间需小于关机时间', {icon:5,title:'提示'});
					flag = false;
					return;
				}
				
				if(($close_minute - $open_minute) < 3){
					layer.alert('提示：定时开关机时间间隔必须在3分钟以上', {icon:5,title:'提示'});
					flag = false;
					return;
				}
			}
			
			if($open_hour > $close_hour){
				layer.alert('提示：定时开机时间需小于关机时间', {icon:5,title:'提示'});
				flag = false;
				return;
			}
		}
		
		var $subObj={};
		$subObj['iscycling']=$iscycling;
		$subObj['week']=$week;
		$subObj['powerHour']=$open_hour;
		$subObj['powerMinute']=$open_minute;
		$subObj['shutdownHour']=$close_hour;
		$subObj['shutdownMinute']=$close_minute;
		$objTime.push($subObj);
		
		
		var $subRow = $this.parents('tr').next('.tbListRow').find('tr');	
		$subRow.each(function(index, element) {
			$this=$(this);
			var $subObj_row={};
			var $open_hour_row=$this.find('.open_hour').val();
			var $open_minute_row=$this.find('.open_minute').val();
			var $close_hour_row=$this.find('.close_hour').val();
			var $close_minute_row=$this.find('.close_minute').val();
			
			if($iscycling == '1' && $open_hour_row == $open_hour){
				if($open_minute_row == $open_minute){
					layer.alert('提示：开机时间数据重复', {icon:5,title:'提示'});
					flag = false;
					return;
				}
			}
			
			if($iscycling == '1' && $close_hour_row == $close_hour){
				if($close_minute_row == $close_minute){
					layer.alert('提示：关机时间数据重复', {icon:5,title:'提示'});
					flag = false;
					return;
				}
			}
			
			
			if($iscycling == '1' ){
				if($open_hour_row == $close_hour_row){
					if($close_minute_row == $open_minute_row){
						layer.alert('提示：定时开关机时间间隔必须在3分钟以上', {icon:5,title:'提示'});
						flag = false;
						return;
					}
					
					if($close_minute_row < $open_minute_row ){
						layer.alert('提示：定时开机时间需小于关机时间', {icon:5,title:'提示'});
						flag = false;
						return;
					}
					
					if($close_minute_row - $open_minute_row < 3){
						layer.alert('提示：定时开关机时间间隔必须在3分钟以上', {icon:5,title:'提示'});
						flag = false;
						return;
					}
				}
				
				if($open_hour_row > $close_hour_row){
					layer.alert('提示：定时开机时间需小于关机时间', {icon:5,title:'提示'});
					flag = false;
					return;
				}
			}
			
			$subObj_row['iscycling']=$iscycling;
			$subObj_row['week']=$week;
			$subObj_row['powerHour']=$open_hour_row;
			$subObj_row['powerMinute']=$open_minute_row;
			$subObj_row['shutdownHour']=$close_hour_row;
			$subObj_row['shutdownMinute']=$close_minute_row;
			$objTime.push($subObj_row);
           });

	});
	
	if(!flag){
		return;
	}
	
	var timeSwitchs = JSON.stringify($objTime);
	$.ajax({
	    type: "post", 
	    dataType: "json", 
	    url: "<%=path %>/timeSwitch/timeSwitch_update.do", 
	    data: {"terminalIds":terminalIds,"timeSwitchs":timeSwitchs}, 
	    success: function(data) {
	    	if(data.message != 1){
	    		layer.alert('命令设置失败', {icon:5,title:'提示'});
	    	}else{
	    		layer.alert('命令设置成功', {icon:1,title:'提示'},function(index){
	    			parent.location = parent.location;
    	    		parent.layer.close(index);
    		 	});
	    	}
	    }, 
	    error: function(err) {
	    	alert(err);
	    } 
	});
}

function onClose(){
	var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
	parent.layer.close(index);
}
</script>
</body>
</html>
