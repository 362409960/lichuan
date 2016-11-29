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
<title>普通模板</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta content="" name="description">
<meta content="" name="keywords">
<meta content="Cloudring" name="author">
<meta content="Cloudring" name="copyright">
<link rel="shortcut icon" href="<%=path%>/images/sys/icon/icon.png">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/sys/common.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/sys/main.css">
<%-- <link rel="stylesheet" type="text/css" href="<%=path%>/css/sys/jquery-ui.css"> --%>
<link rel="stylesheet" type="text/css" href="<%=path%>/css/sys/page.css">
<script type="text/javascript" src="<%=path%>/js/My97DatePicker/WdatePicker.js"></script>

<style type="text/css">
html,body{
	height:100%;
	width:100%;
	overflow:auto;
}
.tabs td ul{
	padding-left:20px;
}
.tabs td ul li{
	float:left
}
.tabs td ul li a{
	padding:5px 10px;
	border:solid 1px #ccc;
	background-color:#eee
}
.tabs td ul li:first-child a{
	border-right-width:0;
}
.tabs td ul li a.current{
	background-color:#fff;
}
</style>
</head>

<body>
	<jsp:include page="/page/top.jsp" /> 
    <div class="container">
    	<form id="aspnetForm" action="<%=path%>/template/toSearch.do" method="post" name="aspnetForm">
    	<input type="hidden" id="pageSize" name="pageSize" value="${template.pageSize}" />
    	<input type="hidden" name="pageNumber" id="pageNumber" value="${template.pageNumber}" />
        	<div class="title_Nav">
            	<div class="title_text">
                	<p>
                    	 素材管理&gt;
                        <span class="title_NowPage">普通模板</span>
                    </p>
                </div>
                <div class="title_search">
                	<strong>查询:</strong>
                    <span>名称</span>
                    <input type="text" class="inp-60" style="width: 180px;" id="name" name="name" value="${template.name }">
                    <span>分辨率</span>
                    <select name="resolution">
                    	<option value="">请选择</option>
                        <option <c:if test="${template.resolution eq '1024*768'}">selected</c:if> value="1024*768">1024*768</option>
                        <option <c:if test="${template.resolution eq '1280*720'}">selected</c:if> value="1280*720">1280*720</option>
                        <option <c:if test="${template.resolution eq '1366*768'}">selected</c:if> value="1366*768">1366*768</option>
                        <option <c:if test="${template.resolution eq '1920*1080'}">selected</c:if> value="1920*1080">1920*1080</option>
                    </select>
                    <span>上传时间</span>
                   <input type="text" id="startTime" name="startTime" value="${template.startTime}"  class="Wdate"  onClick="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'endTime\')}'})" readonly>-
                    <input type="text" id="endTime" name="endTime"  value="${template.endTime}" class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'startTime\')}'})"  readonly>  
                    <input type="button" class="btn-01" value="搜索" onclick="search()">
                 </div>		
            </div>
            <div class="blank3"></div>
            <div class="tabs">
                <table class="main_white">
                    <colgroup>
                        <col width="50%">
                        <col width="50%">
                    </colgroup>
                    <tr>
                        <td align="left">
                            <ul>
                                <li _title="普通模板"><a href="<%=path%>/template/toList.do" class="current">普通模板(${template.total})</a></li>
                                <li _title="背景模板"><a href="<%=path%>/templateBackGround/toList.do">背景模板(${totalBackground})</a></li>
                            </ul>
                        </td>
                        <td align="right">
                            <input type="button" class="btn-01" value="新建" id="add">
                            <input type="button" class="btn-01" value="删除" id="del">
                        </td>
                    </tr>
                </table>
                <div class="table_box">
                    <table class="boxList">
                        <colgroup>
                            <col width="5%">
                            <col width="35%">
                           <%--  <col width="30%"> --%>
                            <col width="40%">
                            <col width="40%">
                        </colgroup>
                        <thead>
                            <tr>
                                <th>
                                    <input id="ckAll" type="checkbox" title="全选" name="ckAll">
                                </th>
                                <th>
                                    名称
                                    <img src="<%=path%>/images/sys/icon/min_up.png" alt="">
                                </th>
                               <!--  <th>模板路径</th> -->
                                <th>分辨率</th>
                                <th>
                                    创建时间
                                    <img src="<%=path%>/images/sys/icon/min_up.png" alt="">
                                </th>
                            </tr>
                        </thead> 
                        <tbody>
                        <c:forEach items="${template.rows}" var="it" varStatus="st">
                            <tr>
                               	<td style="text-align:center;font-weight:normal;color:#000;">
                                   	<input type="checkbox" value="${it.id}" name="ckBox">
                                   </td>
                                   <th>
                                   	<a  target="_self" href="<%=path%>/template/toEdit.do?id=${it.id}">${it.name}</a>	
                                   </th>                                
                                   <th>${it.resolution}</th>
                                   <th><fmt:formatDate value="${it.create_date}" pattern="yyyy-MM-dd HH:mm:ss"/></th>
                              </tr>
                              </c:forEach>
                        </tbody>            
                    </table>
                </div>
                   <div class="pagebox">
            	<!-- <div class="pageleft">
					<c:if test="${template.pageNumber != 1}">
	            			<a href="javascript:void(0)" onclick="pageSkip(${template.pageNumber-1});">上一页</a>
	            	</c:if>	
	           	    <c:forEach var="i" begin="1" end="${template.pageMax}">
						<c:choose>
							<c:when test="${i==template.pageNumber}"><span class="cpb">${i}</span></c:when>
							<c:otherwise><a href="javascript:void(0)" onclick="pageSkip(${i});">${i} </a></c:otherwise>
						</c:choose>						
					</c:forEach>
	            	<c:if test="${template.pageNumber != template.pageMax}">
	            		 <a href="javascript:void(0)" onclick="pageSkip(${template.pageNumber+1});">下一页</a>
	            	</c:if>
				</div> -->
				
				<div class="pageleft">
            		<c:if test="${template.pageMax >10 }">
            		<c:if test="${template.pageNumber != 1}">
	            			<a href="javascript:void(0)" onclick="pageSkip('${template.pageNumber-1}');">上一页</a>
	            	</c:if>
					
					<c:if test="${template.pageNumber != 1 and template.pageNumber != 2 and template.pageNumber != 3}">
            				<a href="javascript:void(0)" onclick="pageSkip('1')">1</a>
            				<span class="disabled">...</span>
           			</c:if>
            		<c:forEach begin="${template.pageNumber }" end="${template.pageNumber + 2}" step="1" var="pageIndex">
            			<c:if test="${pageIndex == template.pageNumber and pageIndex <= template.pageMax}">
							<span class="cpb">${pageIndex}</span>
						</c:if>
            			<c:if test="${pageIndex != template.pageNumber and pageIndex <= template.pageMax}">
							<a href="javascript:void(0)" onclick="pageSkip('${pageIndex}')">${pageIndex}</a>
						</c:if>
            		</c:forEach>
            		
            		<c:if test="${template.pageNumber <= template.pageMax - 3 }">
						<span class="disabled">...</span>
						<a href="javascript:void(0)" onclick="pageSkip('${template.pageMax}')">${template.pageMax}</a>
					</c:if>
            		
            		<c:if test="${template.pageNumber != template.pageMax}">
						<a href="javascript:void(0)" onclick="pageSkip('${template.pageNumber+1}')">下一页</a>
					</c:if>
            	</c:if>
            	<c:if test="${template.pageMax <= 10 }">
            		<c:if test="${template.pageNumber != 1}">
						<a href="javascript:void(0)" onclick="pageSkip('${template.pageNumber-1}')">上一页</a>
					</c:if>
            		<c:forEach begin="1" end="${template.pageMax}" step="1" var="pageIndex">
						<c:if test="${pageIndex == template.pageNumber}">
							<span class="cpb">${pageIndex}</span>
						</c:if>
						<c:if test="${pageIndex != template.pageNumber}">
							<a href="javascript:void(0)" onclick="pageSkip('${pageIndex}')">${pageIndex}</a>
						</c:if>
					</c:forEach>
					<c:if test="${template.pageNumber != template.pageMax}">
						<a href="javascript:void(0)" onclick="pageSkip('${template.pageNumber+1}')">下一页</a>
					</c:if>
            	</c:if>	
                </div>
				
                <div class="pageright">
                	<p>每页</p>             
                   	<c:choose>
						<c:when test="${template.pageSize eq 50}">
							<span>50</span>
							<a href="javascript:void(0)" onclick="pageSize(30);">30</a>
							<a href="javascript:void(0)" onclick="pageSize(10);">10</a>
						</c:when>
						<c:when test="${template.pageSize eq 30}">
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
 $("#v_program").removeClass("visiting");
$("#v_terminal").removeClass("visiting");
$("#v_sys").removeClass("visiting");
$("#v_mater").addClass("visiting");

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

	$('#add').click(function(){
	     window.location.href = contextPath + '/template/toAdd.do'; 
	});
	//点击删除按钮
	$('#del').click(function(){
	layer.confirm('确定要删除吗？',{icon:3,title:'提示'}, function(index){ if($('.table_box td').find('input[type=checkbox]:checked').length==0){
				//alert('请选择要删除的消息');
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
		            url: contextPath + "/template/deleteById.do",
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
			}},function(index){ layer.closeAll(index);});
	 
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
    var name=trim($("#name").val());  
    $("#name").val(name);
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