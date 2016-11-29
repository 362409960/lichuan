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
<link href="<%=path%>/css/sys/common.css" rel="stylesheet" type="text/css">
<link href="<%=path%>/css/sys/main.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/sys/page.css">
<script type="text/javascript" src="<%=path%>/js/sys/jquery.js"></script>
<script type="text/javascript" src="<%=path%>/js/sys/common.js"></script>
<script type="text/javascript"  src="<%=path%>/layer/layer.js"></script>
<script type="text/javascript" src="<%=path%>/js/My97DatePicker/WdatePicker.js"></script>

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
    	<form id="aspnetForm" action="<%=path%>/publish/toPublishSearch.do" method="post" name="aspnetForm">
    		<input type="hidden" id="pageSize" name="pageSize" value="${publish.pageSize}" />
    	    <input type="hidden" name="pageNumber" id="pageNumber" value="${publish.pageNumber}" /> 
        	<div class="title_Nav">
            	<div class="title_text">
                	<p>
                    	节目管理&gt;
                        <span>发布</span>
                    </p>
                </div>
                <div class="title_search">
                	<strong>查询:</strong>
                    <span>发布单号</span>
                    <input type="text" class="inp-90" id="task_id" name="task_id" value="${publish.task_id}">
                    <span>节目名称</span>
                    <input type="text" class="inp-90" id="program_name"  name="program_name" value="${publish.program_name}">
                    <span>发布时间</span>
                    <input type="text" class="Wdate" id="startTime" name="startTime"  value="${publish.startTime}" onClick="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'endTime\')}'})" readonly>-
                    <input type="text" id="endTime" name="endTime" value="${publish.endTime}" onClick="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'startTime\')}'})" class="Wdate" readonly>
                  <!--   <span>状态</span>
                    <select class="sel-120">
                    	<option>请选择</option>
                        <option value="0">审批中</option>
                        <option value="1">已审批</option>
                    </select> -->
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
                    	<span  style="padding-left:15px;">共计:</span>
                        <strong>${publish.total};</strong>
                    </td>
                    <td align="right">
                    	<input type="button" class="btn-01" value="新建发布" id="add">
                        <input type="button" class="btn-01" value="删除" id="del">
                    </td>
                </tr>
            </table>
            <div class="table_box">
            	<table class="boxList" cellpadding="2">
                	<colgroup>
                    	<col width="5%">
                        <col width="7%">
                        <col width="11%">
                        <col width="24%">
                        <col width="13%">
                        <col width="13%">
                        <col width="11%">
                        <col width="16%">
                    </colgroup>
                    <thead>
                    	<tr>
                        	<th>
                            	<input id="ckAll" type="checkbox" title="全选" name="ckAll">
                            </th>
                            <th>操作</th>
                            <th>发布单号</th>
                            <th>节目名称</th>
                            <th>过期时间</th>
                            <th>发布时间</th>
                            <th>状态</th>
                            <th>所属机构</th>
                        </tr>
                    </thead>
                    <tbody>
                      <c:forEach items="${publish.rows}" var="it" varStatus="st"> 
                    	
                        <tr style="height:28px;">
                            <td style="text-align:center;font-weight:normal;color:#000;">
                                <input name="ckBox" value="${it.id}" type="checkbox" />
                            </td>
                            <td style="text-align:center;font-weight:normal;color:#000;">
                                <a href="<%=path%>/publish/view.do?id=${it.id}&state=${it.state}" class="underLine">
                                    	查看
                                </a>
                            </td>
                            <td>
                                ${it.task_id}
                            </td>                          
                            <td>
                             	 ${it.program_name}
                            </td>
                            <td>                              
                                <fmt:formatDate value="${it.expiration}" pattern="yy-MM-dd HH:mm"/>
                            </td>
                            <td>                                
                                <fmt:formatDate value="${it.publish_time}" pattern="yy-MM-dd HH:mm"/>
                            </td>
                            <td>
                                <c:choose>
                                 <c:when test="${it.state=='0'}">审批中</c:when>
                                 <c:otherwise>已审批</c:otherwise>
                                </c:choose>
                                	
                            </td>
                            <td>
                                	${it.affiliations}
                            </td>
                        </tr>

                    </c:forEach> 
                    </tbody>             
                </table>
            </div>
            <div class="pagebox">
            	<!-- <div class="pageleft">	            	
					<c:if test="${publish.pageNumber != 1}">
	            			<a href="javascript:void(0)" onclick="pageSkip(${publish.pageNumber-1});">上一页</a>
	            	</c:if>	
	           	    <c:forEach var="i" begin="1" end="${publish.pageMax}">
						<c:choose>
							<c:when test="${i==publish.pageNumber}"><span class="cpb">${i}</span></c:when>
							<c:otherwise><a href="javascript:void(0)" onclick="pageSkip(${i});">${i} </a></c:otherwise>
						</c:choose>						
					</c:forEach>
	            	<c:if test="${publish.pageNumber != publish.pageMax}">
	            		 <a href="javascript:void(0)" onclick="pageSkip(${publish.pageNumber+1});">下一页</a>
	            	</c:if>
				</div> -->
				
				<div class="pageleft">
            		<c:if test="${publish.pageMax >10 }">
            		<c:if test="${publish.pageNumber != 1}">
	            			<a href="javascript:void(0)" onclick="pageSkip('${publish.pageNumber-1}');">上一页</a>
	            	</c:if>
					
					<c:if test="${publish.pageNumber != 1 and publish.pageNumber != 2 and publish.pageNumber != 3}">
            				<a href="javascript:void(0)" onclick="pageSkip('1')">1</a>
            				<span class="disabled">...</span>
           			</c:if>
            		<c:forEach begin="${publish.pageNumber }" end="${publish.pageNumber + 2}" step="1" var="pageIndex">
            			<c:if test="${pageIndex == publish.pageNumber and pageIndex <= publish.pageMax}">
							<span class="cpb">${pageIndex}</span>
						</c:if>
            			<c:if test="${pageIndex != publish.pageNumber and pageIndex <= publish.pageMax}">
							<a href="javascript:void(0)" onclick="pageSkip('${pageIndex}')">${pageIndex}</a>
						</c:if>
            		</c:forEach>
            		
            		<c:if test="${publish.pageNumber <= publish.pageMax - 3 }">
						<span class="disabled">...</span>
						<a href="javascript:void(0)" onclick="pageSkip('${publish.pageMax}')">${publish.pageMax}</a>
					</c:if>
            		
            		<c:if test="${publish.pageNumber != publish.pageMax}">
						<a href="javascript:void(0)" onclick="pageSkip('${publish.pageNumber+1}')">下一页</a>
					</c:if>
            	</c:if>
            	<c:if test="${publish.pageMax <= 10 }">
            		<c:if test="${publish.pageNumber != 1}">
						<a href="javascript:void(0)" onclick="pageSkip('${publish.pageNumber-1}')">上一页</a>
					</c:if>
            		<c:forEach begin="1" end="${publish.pageMax}" step="1" var="pageIndex">
						<c:if test="${pageIndex == publish.pageNumber}">
							<span class="cpb">${pageIndex}</span>
						</c:if>
						<c:if test="${pageIndex != publish.pageNumber}">
							<a href="javascript:void(0)" onclick="pageSkip('${pageIndex}')">${pageIndex}</a>
						</c:if>
					</c:forEach>
					<c:if test="${publish.pageNumber != publish.pageMax}">
						<a href="javascript:void(0)" onclick="pageSkip('${publish.pageNumber+1}')">下一页</a>
					</c:if>
            	</c:if>	
                </div>
				
                <div class="pageright">
                	<p>每页</p>             
                   <c:choose>
						<c:when test="${publish.pageSize eq 50}">
							<span>50</span>
							<a href="javascript:void(0)" onclick="pageSize(30);">30</a>
							<a href="javascript:void(0)" onclick="pageSize(10);">10</a>
						</c:when>
						<c:when test="${publish.pageSize eq 30}">
						   <a href="javascript:void(0)" onclick="pageSize(50);">50</a>
						   <span>30</span>
						   <a href="javascript:void(0)" onclick="pageSize(10);">10</a>
						</c:when>
						<c:otherwise>
							<a href="javascript:void(0)" onclick="pageSize(50);">50</a>
							<a href="javascript:void(0)" onclick="pageSize(30);">30</a>
							<span>10</span>
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
				//	alert('请选择要删除的消息');
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
			            url: contextPath + "/publish/deleteById.do",
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
	},function(index){ layer.closeAll(index);});
		
		
	});
	$('#add').click(function(){
	    window.location.href = contextPath + '/publish/toPublishFirst.do'; 
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

function search(){
    var program_name=trim($("#program_name").val());  
    $("#program_name").val(program_name);
    var task_id=trim($("#task_id").val());
    $("#task_id").val(task_id);
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
