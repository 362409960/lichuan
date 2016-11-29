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
<title>节目管理</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta content="" name="description">
<meta content="" name="keywords">
<meta content="Cloudring" name="author">
<meta content="Cloudring" name="copyright">
<link rel="shortcut icon" href="<%=path%>/images/sys/icon/icon.png">
<link href="<%=path%>/css/sys/common.css" rel="stylesheet" type="text/css">
<link href="<%=path%>/css/sys/main.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/sys/page.css">
<script type="text/javascript" src="<%=path%>/js/sys/jquery.js"></script>
<script type="text/javascript" src="<%=path%>/js/sys/common.js"></script>
<script type="text/javascript" src="<%=path%>/js/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript"  src="<%=path%>/layer/layer.js"></script>
<style type="text/css">
html,body{
	height:100%;
	width:100%;
	overflow:auto;
}
</style>
</head>

<body>
	<jsp:include page="/page/top.jsp" /> 
    <div class="container">
    	<form id="aspnetForm" action="<%=path%>/program/toProjectSearch.do" method="post" name="aspnetForm">
    	<input type="hidden" id="pageSize" name="pageSize" value="${program.pageSize}" />
    	<input type="hidden" name="pageNumber" id="pageNumber" value="${program.pageNumber}" /> 
        	<div class="title_Nav">
            	<div class="title_text">
                	<p>
                    	节目管理&gt;
                        <span>管理</span>
                    </p>
                </div>
                <div class="title_search">
                	<strong>查询:</strong>
                    <span>节目名称</span>
                    <input type="text" class="inp-90" id="program_name" name="program_name" value="${program.program_name}">
                    <span>创建时间</span>
                    <input type="text" id="startTime" name="startTime" value="${program.startTime}"  class="Wdate"  onClick="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'endTime\')}'})" readonly>-
                    <input type="text" id="endTime" name="endTime"  value="${program.endTime}" class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'startTime\')}'})"  readonly>                    
                    <input type="button" class="btn-01" value="搜索" onclick="search()">
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
                    	<span  style="padding-left:15px;">搜索共计:</span>
                        <strong>${program.total};</strong>
                        <a href="<%=path%>/removeTerminalProgram/toList.do" style="margin-left:24px;">删除终端节目</a>
                    </td>
                    <td align="right">
                    	<input type="button" class="btn-01" value="新建" id="add">
                        <input type="button" class="btn-01" value="删除" id="del">
                        <!-- <input type="button" class="btn-01" value="导入"> -->
                    </td>
                </tr>
            </table>
            <div class="table_box">
            	<table class="boxList" cellpadding="2">
                	<colgroup>
                    	<col width="5%">
                        <col width="13%">
                        <col width="15%">
                        <col width="9%">
                        <col width="11%">
                        <col width="5%">
                        <col width="7%">
                        <col width="11%">
                        <col width="9%">
                        <col width="15%">
                    </colgroup>
                    <thead>
                    	<tr>
                        	<th>
                            	<input id="ckAll" type="checkbox" title="全选" name="ckAll">
                            </th>
                            <th>操作</th>
                            <th>节目名称 </th>
                            <th>预览</th>
                            <th>节目说明</th>
                            <th>场景数</th>
                            <th>播放时间</th>
                            <th>更新时间</th>
                            <th>分辨率</th>
                            <th>所属机构</th>
                        </tr>
                    </thead>
                    <tbody>
                      <c:forEach items="${program.rows}" var="it" varStatus="st">
                    	<tr>
                        	<td style="text-align:center;font-weight:normal;color:#000;">
                            	<input id="pgid" type="checkbox" value="${it.id}" name="ckBox">
                            </td>
                            <c:if test="${it.scenes eq 0}"><td>编辑 |发布</td></c:if>
                            <c:if test="${it.scenes != 0}">
                            <td>
                            	<a class="aLink" target="_self" href="<%=path%>/program/toProgramDetailsEdit.do?id=${it.id}">编辑</a>
                                |
                                <a href="<%=path%>/publish/toPublishFirst.do?id=${it.id}">发布</a>
                               <!--  |
                                <a class="dc" href="javascript:;">导出</a> -->
                            </td>
                            </c:if>
                            <td>
                            	<span title="${it.program_name}">${it.program_name}</span>
                            </td>
                            <td>
                            	<a target="" href="javascript:;" onclick="preViewClick('${it.id}')" >
                                	<img src="<%=path%>/images/sys/icon/play.jpg" alt="">
                                </a>
                            </td>
                            <td>${it.program_type}</td>
                            <td>${it.scenes}</td>
                            <td>
                            	<span title="${it.play_time}秒">${it.play_time}秒</span>
                            </td>
                            <td><fmt:formatDate value="${it.create_time}" pattern="yy-MM-dd HH:mm"/></td>
                            <td>${it.resolution}</td>
                            <td><span title="${it.affiliations}">${it.affiliations}</span></td>
                        </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
             <div class="pagebox">
            	<!-- <div class="pageleft">
	            	<c:if test="${program.pageNumber != 1}">
	            			<a href="javascript:void(0)" onclick="pageSkip(${program.pageNumber-1});">上一页</a>
	            	</c:if>	
	           	    <c:forEach var="i" begin="1" end="${program.pageMax}">
						<c:choose>
							<c:when test="${i==program.pageNumber}"><span class="cpb">${i}</span></c:when>
							<c:otherwise><a href="javascript:void(0)" onclick="pageSkip(${i});">${i} </a></c:otherwise>
						</c:choose>						
					</c:forEach>
	            	<c:if test="${program.pageNumber != program.pageMax}">
	            		 <a href="javascript:void(0)" onclick="pageSkip(${program.pageNumber+1});">下一页</a>
	            	</c:if>
				</div> -->
				
				
				<div class="pageleft">
            		<c:if test="${program.pageMax >10 }">
            		<c:if test="${program.pageNumber != 1}">
	            			<a href="javascript:void(0)" onclick="pageSkip('${program.pageNumber-1}')">上一页</a>
	            	</c:if>
					
					<c:if test="${program.pageNumber != 1 and program.pageNumber != 2 and program.pageNumber != 3}">
            				<a href="javascript:void(0)" onclick="pageSkip('1')">1</a>
            				<span class="disabled">...</span>
           			</c:if>
            		<c:forEach begin="${program.pageNumber }" end="${program.pageNumber + 2}" step="1" var="pageIndex">
            			<c:if test="${pageIndex == program.pageNumber and pageIndex <= program.pageMax}">
							<span class="cpb">${pageIndex}</span>
						</c:if>
            			<c:if test="${pageIndex != program.pageNumber and pageIndex <= program.pageMax}">
							<a href="javascript:void(0)" onclick="pageSkip('${pageIndex}')">${pageIndex}</a>
						</c:if>
            		</c:forEach>
            		
            		<c:if test="${program.pageNumber <= program.pageMax - 3 }">
						<span class="disabled">...</span>
						<a href="javascript:void(0)" onclick="pageSkip('${program.pageMax}')">${program.pageMax}</a>
					</c:if>
            		
            		<c:if test="${program.pageNumber != program.pageMax}">
						<a href="javascript:void(0)" onclick="pageSkip('${program.pageNumber+1}')">下一页</a>
					</c:if>
            	</c:if>
            	<c:if test="${program.pageMax <= 10 }">
            		<c:if test="${program.pageNumber != 1}">
						<a href="javascript:void(0)" onclick="pageSkip('${program.pageNumber-1}')">上一页</a>
					</c:if>
            		<c:forEach begin="1" end="${program.pageMax}" step="1" var="pageIndex">
						<c:if test="${pageIndex == program.pageNumber}">
							<span class="cpb">${pageIndex}</span>
						</c:if>
						<c:if test="${pageIndex != program.pageNumber}">
							<a href="javascript:void(0)" onclick="pageSkip('${pageIndex}')">${pageIndex}</a>
						</c:if>
					</c:forEach>
					<c:if test="${program.pageNumber != program.pageMax}">
						<a href="javascript:void(0)" onclick="pageSkip('${program.pageNumber+1}')">下一页</a>
					</c:if>
            	</c:if>	
                </div>
				
				
                <div class="pageright">
                	<p>每页</p>             
                   	<c:choose>
						<c:when test="${program.pageSize eq 30}">
							<span>30</span>
							<a href="javascript:void(0)" onclick="pageSize(10);">10</a>
							<a href="javascript:void(0)" onclick="pageSize(5);">5</a>
						</c:when>
						<c:when test="${program.pageSize eq 10}">
						   <a href="javascript:void(0)" onclick="pageSize(30);">30</a>
						   <span>10</span>
						   <a href="javascript:void(0)" onclick="pageSize(5);">5</a>
						</c:when>
						<c:otherwise>
							<a href="javascript:void(0)" onclick="pageSize(30);">30</a>
							<a href="javascript:void(0)" onclick="pageSize(10);">10</a>
							<span>5</span>
						</c:otherwise>					
					</c:choose>
				</div>
            </div>
        </form>
    </div>

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
/*全选按钮*/
	$('#ckAll').click(function(){
		var _this=this;
		var oCheckbox=$('.table_box').find("input[type=checkbox]");
		oCheckbox.each(function(index, element) {
			$(this).attr('checked',_this.checked);
		});
		console.log(_this.checked);
	});	
	 var ckBox=$('.table_box td').find('input[type=checkbox]');	
	ckBox.each(function(index, element) {
        $(element).click(function(){
			if($('.table_box td').find('input[type=checkbox]:checked').length==ckBox.length){
				$('#ckAll').attr('checked',true);	
			}else{
				$('#ckAll').attr('checked',false);
			}
		});
    });
	 
	
	//点击删除按钮
	$('#del').click(function(){	
	layer.confirm('确定要删除吗？',{icon:3,title:'提示'}, function(index){
		 if($('.table_box td').find('input[type=checkbox]:checked').length==0){			
			layerAlter("提示","请选择要删除的消息");    
		}else{
		var message='';
		  $(".table_box td").each(function(){
			    if($(this).find("input[type=checkbox]:checked").val() != undefined)
			    {
			      message+=$(this).find("input[type=checkbox]:checked").val()+',';	
			    }
			});
			var ids=message.substring(0,message.length-1);			
			  $.ajax({
	            type: "post",
	            url: contextPath + "/program/deleteById.do",
	            data:{ids:ids},
	            dataType: "json",
	            success: function (data) {	            
	               window.location.reload(true);	               
	            },
	            error: function (XMLHttpRequest, textStatus,errorThrown) {
	                alert(errorThrown);
	                return false;
	            }
       		 });
			}			
		}, function(index){
		  layer.closeAll(index);
		});	  
	});
	$('#add').click(function(){
	    window.location.href = contextPath + '/program/toMake.do'; 
	});
});

function pageSkip(pageNumber) {
	$pageNumber.val(pageNumber);
	$listForm.submit();
	return false;
}

function pageSize(pageSize) {
	$pageSize.val(pageSize);
	$pageNumber.val(1);
	$listForm.submit();
	return false;
}

function preViewClick(id) {	
	var url_pattern = contextPath + '/program/toSearchPreview.do?id=' + id;
	 //window.location.href=url_pattern;
	 window.open(url_pattern);

}  

function search(){
    var program_name=trim($("#program_name").val());  
    $("#program_name").val(program_name);
    var startTime=$("#startTime").val();
    var endTime=$("#endTime").val();
    if(check(startTime,endTime)){
      $listForm.submit();
	 return false;
    }
   
}
function trim(str) {
	// 删除左右两端的空格
	return str.replace(/(^\s*)|(\s*$)/g, "");
}
//验证日期（判断结束日期是否大于开始日期）日期格式为YY—MM—DD  
  function check(startTime,endTime){              
      if(startTime.length>0 && endTime.length>0){     
          var startTmp=startTime.split("-");  
          var endTmp=endTime.split("-");  
          var sd=new Date(startTmp[0],startTmp[1],startTmp[2]);  
          var ed=new Date(endTmp[0],endTmp[1],endTmp[2]);  
          if(sd.getTime()>ed.getTime()){   
              //alert("开始日期不能大于结束日期");   
              layerAlter("提示","开始日期不能大于结束日期");     
              return false;     
          }     
      }     
      return true;     
  }    
</script>
