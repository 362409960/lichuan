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
<title>素材管理</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta content="" name="description">
<meta content="" name="keywords">
<meta content="Cloudring" name="author">
<meta content="Cloudring" name="copyright">
<link rel="shortcut icon" href="<%=path%>/images/sys/icon/icon.png">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/common.css"/>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/main.css"/>
<!-- <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css"> -->
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/page.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/zTreeStyle/zTreeStyle.css"/>
<link rel="stylesheet" type="text/css" href="<%=path%>/css/sys/page.css">
<script type="text/javascript" src="<%=path%>/js/sys/jquery.js"></script>
<script type="text/javascript" src="<%=path%>/js/sys/common.js"></script>
<script type="text/javascript" src="<%=path%>/js/ajaxfileupload.js"></script>
<script type="text/javascript"  src="<%=path%>/layer/layer.js"></script>
<script type="text/javascript" src="<%=path%>/js/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="<%=path%>/js/zTree/jquery.ztree.all.js"></script>
<style type="text/css">
html,body{
	height:100%;
	width:100%;
	overflow:auto;
}
.form_item{
	padding:10px 0;
}
.file{
	position:relative;
	width:100px;
	height:28px;
	overflow:hidden;
}
.file .btn-01{
	position:absolute;
	z-index:1; 
}
.file input[type=file]{
	position:absolute;
	right:0;
	font-size:100px;
	z-index:3; 
	opacity:0;
	filter:alpha(opacity=0);
}
</style>
</head>

<body>
	 <jsp:include page="/page/top.jsp" /> 
    <div class="container">
    	<form id="aspnetForm" action="<%=path%>/material/toSearch.do" method="post" name="aspnetForm">
    	<input type="hidden" id="pageSize" name="pageSize" value="${material.pageSize}" />
    	<input type="hidden" name="pageNumber" id="pageNumber" value="${material.pageNumber}" />
        	<div class="title_Nav">
            	<div class="title_text">
                	<p>
                    	素材管理&gt;
                        <span>素材管理</span>
                    </p>
                </div>
                <div class="title_search">
                	<strong>查询:</strong>
                    <span>素材分类</span>
                    <select class="sel-80" name="typeId">
                    	<option value="">请选择</option>
                    	<c:forEach items="${types}" var="type">
	                    	<option value="${type.id}" <c:if test="${type.id==typeId}">selected</c:if>>${type.name}</option>
                        </c:forEach>                           
                    </select>
                    
                    <span>素材名称</span>
                    <input type="text" class="inp-60" id="name" name="name" value="${material.name}">
                    <span>上传时间</span>
                   	<input type="text" id="startTime" name="startTime" value="${material.startTime}"  class="Wdate"  onClick="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'endTime\')}'})" readonly>-
                    <input type="text" id="endTime" name="endTime"  value="${material.endTime}" class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'startTime\')}'})"  readonly>  
                    <input type="button" class="btn-01" value="搜索" onclick="search()">
                 </div>
            </div>
            
             <div class="fl wid_p20">
            	<div class="box">
                	<div class="box_head">
                    	<div class="box_title">
                        	<span class="box_title_text black">素材分类</span>
                            <span class="title_button">
                            	<a id="addLeaf" href="javascript:;" class="title_button_icon">
                                	<img src="<%=path %>/images/icon/new.png" alt="" title="添加">
                                </a>
                                <a id="remove" href="javascript:;" class="title_button_icon">
                                	<img src="<%=path %>/images/icon/delete.png" alt="" title="删除">
                                </a>
                                <a id="edit" href="javascript:;" class="title_button_icon">
                                	<img src="<%=path %>/images/icon/edit.png" alt="" title="编辑">
                                </a>
                            </span>
                        </div>
                    </div>
                    <div class="box_body">
                    	<div class="box_content">
                    		<div class="content_warp">
                    			<div class="tree left" style="overflow:auto">
                    				<ul id="menuTree" class="ztree"></ul>
                    			</div>
                    		</div>
                    	</div>
                 		<!-- <div id="menuTree" class="ztree"></div> -->
                    </div>
                </div>
            </div> 
            <div class="fr wid_p80">
            	<div id="rightFun">
                	<table class="main_white">
                    	<colgroup>
                        	<col width="30%">
                            <col width="*">
                        </colgroup>
                        <tr>
                        	<td align="left">
                            	<span style="padding-left:15px;">共计</span>
                                <strong class="black">${material.total}</strong>
                            </td>
                            <td align="right">
                            	<!-- <input type="button" class="btn-01" value="大文件上传"> -->
                                <input type="button" class="btn-01" value="上传" id="add">
                                <input type="button" class="btn-01" value="删除" id="del">
                            </td>
                        </tr>
                    </table>
                    <div class="table_box">
                        <table class="boxList">
                            <colgroup>
                                <col width="10%">
                                <col width="30%">
                                <col width="20%">
                                <col width="20%">
                                <col width="20%">
                            </colgroup>
                            <thead>
                                <tr>
                                    <th>
                                    	<input id="ckAll" type="checkbox" title="全选" name="ckAll">
                                    </th>
                                    <th>素材名称</th>
                                    <th>素材分类</th>
                                    <th>文件大小</th>
                                    <th>上传时间</th>
                                </tr>
                            </thead> 
                            <tbody>
                             <c:forEach items="${material.rows}" var="it" varStatus="st">
                            	<tr>
                                	<td style="text-align:center;font-weight:normal;color:#000;">
                                    	<input type="checkbox" value="${it.id}" name="ckBox">
                                    </td>
                                    <th>
                                    	<a title="${it.name}" target="_self" href="<%=path%>/material/toEdit.do?id=${it.id}">
                                    		<div style="width:370px;white-space:nowrap;text-overflow:ellipsis;overflow: hidden;" title="${it.name }" />
												${it.name}
											</div>
                                    	</a>	
                                    </th>
                                    <th>${it.material_type}</th>
                                    <th>${it.file_size}</th>
                                    <th><fmt:formatDate value="${it.upload_time}" pattern="yyyy-MM-dd HH:mm:ss"/></th>
                                </tr>
                                </c:forEach>
                            </tbody>            
                        </table>
                    </div>
                    <div class="pagebox">
                    
            	<!-- <div class="pageleft">
					<c:if test="${material.pageNumber != 1}">
	            			<a href="javascript:void(0)" onclick="pageSkip(${material.pageNumber-1});">上一页</a>
	            	</c:if>	
	           	    <c:forEach var="i" begin="1" end="${material.pageMax}">
						<c:choose>
							<c:when test="${i==material.pageNumber}"><span class="cpb">${i}</span></c:when>
							<c:otherwise><a href="javascript:void(0)" onclick="pageSkip(${i});">${i} </a></c:otherwise>
						</c:choose>						
					</c:forEach>
	            	<c:if test="${material.pageNumber != material.pageMax}">
	            		 <a href="javascript:void(0)" onclick="pageSkip(${material.pageNumber+1});">下一页</a>
	            	</c:if>
				</div> -->
				
				<div class="pageleft">
            		<c:if test="${material.pageMax >10 }">
            		<c:if test="${material.pageNumber != 1}">
	            			<a href="javascript:void(0)" onclick="pageSkip('${material.pageNumber-1}');">上一页</a>
	            	</c:if>
					
					<c:if test="${material.pageNumber != 1 and material.pageNumber != 2 and material.pageNumber != 3}">
            				<a href="javascript:void(0)" onclick="pageSkip('1')">1</a>
            				<span class="disabled">...</span>
           			</c:if>
            		<c:forEach begin="${material.pageNumber }" end="${material.pageNumber + 2}" step="1" var="pageIndex">
            			<c:if test="${pageIndex == material.pageNumber and pageIndex <= material.pageMax}">
							<span class="cpb">${pageIndex}</span>
						</c:if>
            			<c:if test="${pageIndex != material.pageNumber and pageIndex <= material.pageMax}">
							<a href="javascript:void(0)" onclick="pageSkip('${pageIndex}')">${pageIndex}</a>
						</c:if>
            		</c:forEach>
            		
            		<c:if test="${material.pageNumber <= material.pageMax - 3 }">
						<span class="disabled">...</span>
						<a href="javascript:void(0)" onclick="pageSkip('${material.pageMax}')">${material.pageMax}</a>
					</c:if>
            		
            		<c:if test="${material.pageNumber != material.pageMax}">
						<a href="javascript:void(0)" onclick="pageSkip('${material.pageNumber+1}')">下一页</a>
					</c:if>
            	</c:if>
            	<c:if test="${material.pageMax <= 10 }">
            		<c:if test="${material.pageNumber != 1}">
						<a href="javascript:void(0)" onclick="pageSkip('${material.pageNumber-1}')">上一页</a>
					</c:if>
            		<c:forEach begin="1" end="${material.pageMax}" step="1" var="pageIndex">
						<c:if test="${pageIndex == material.pageNumber}">
							<span class="cpb">${pageIndex}</span>
						</c:if>
						<c:if test="${pageIndex != material.pageNumber}">
							<a href="javascript:void(0)" onclick="pageSkip('${pageIndex}')">${pageIndex}</a>
						</c:if>
					</c:forEach>
					<c:if test="${material.pageNumber != material.pageMax}">
						<a href="javascript:void(0)" onclick="pageSkip('${material.pageNumber+1}')">下一页</a>
					</c:if>
            	</c:if>	
                </div>
				
                <div class="pageright">
                	<p>每页</p>             
                   <c:choose>
						<c:when test="${material.pageSize eq 50}">
							<span>50</span>
							<a href="javascript:void(0)" onclick="pageSize(30);">30</a>
							<a href="javascript:void(0)" onclick="pageSize(10);">10</a>
						</c:when>
						<c:when test="${material.pageSize eq 30}">
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
               </div>
        </form>
    </div>
 <div class="layer_terminal" style="display:none; padding-left:5px;">
    <form id="fileForm" action="<%=path%>/material/save.do" method="post" name="fileForm" enctype="multipart/form-data">
    <input type="hidden" name="material_type" id="material_type" />
    <input type="hidden" name="type" id="type" />  
	<div class="form_item">
	   	文件类型：
	   	<div id="menuTree1" class="ztree"></div>	      
	   </div>
	<div class="form_item">
		<div class="file">
	       <input type="button" value="选择文件" class="btn-01">
	       <input type="file" name="file" value="上传"  id="file" onchange="fSubmit();" size="30">
	    </div>
	    
	    <div class="pd15">
	    <div class="br"  style="display:none;" id="progress_all">
        	<ul>
            	<li>
                	<div class="process clearfix" id="process">
						<span class="progress-box">
							<span class="progress-bar" style="width: 0%;" id="progress_bar"></span>
						</span>
                        <span id="progress_percent">0%</span>
                    </div>
                    <div class="info" id="info">已上传：<span id="has_upload">0</span>MB  速度：<span id="upload_speed">0</span>KB/s</div>
                    <div class="info" id="success_info" style="display: none;"></div>
                </li>
            </ul>
        </div>
	    </div>
	   </div>	
	    </form>
	</div>
    <script type="text/javascript"  src="<%=path%>/layer/layer.js"></script>
</body>
</html>

<script type="text/javascript">
var contextPath = "${pageContext.request.contextPath}";
var $listForm=$("#aspnetForm");
var $pageNumber=$("#pageNumber");
var $pageSize=$("#pageSize");


 $("#v_index").removeClass("visiting");
 $("#v_program").removeClass("visiting");
$("#v_terminal").removeClass("visiting");
$("#v_sys").removeClass("visiting");
$("#v_mater").addClass("visiting");
var zTree;
var zTree1;
var setting = {
	check:{
		enable:true,//复选框显示
		chkboxType : { "Y" : "s", "N" : "ps" }
	},
	data: {
		simpleData: {
			enable: true
		}
	},
	callback:{
		beforeRename: beforeRename,
		onDblClick: clickNode//双击事件
	}
};

var setting1 = {
	check: {
		enable: false//复选框显示
	},
	data: {
		simpleData: {
			enable: true
		}
	},
	callback:{
		onClick:clickNode1//点击节点触发的事件
	}
};


var zTreeNodes;
$(document).ready(function(){
	var zn = '${mList}';
	zTreeNodes = eval(zn);
	zTree = $.fn.zTree.init($("#menuTree"), setting, zTreeNodes);
	zTree1 = $.fn.zTree.init($("#menuTree1"), setting1, zTreeNodes);
	//zTree.setting.check.chkboxType = { "Y" : "s", "N" : "ps" };//点击子节点，不选中父节点
	zTree1.expandAll(true);//节点展开
	zTree.expandAll(true);//节点展开
	
	$("#addLeaf").bind("click", {isParent:false}, add);
	$("#edit").bind("click", edit);
	$("#remove").bind("click", remove);
	
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
	
	
layer.confirm('确定要删除吗？',{icon:3,title:'提示'}, function(index){if($('.table_box td').find('input[type=checkbox]:checked').length==0){
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
	            url: contextPath + "/material/deleteById.do",
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

	
	$('#add').click(function(){
		   var index=layer.open({
			type:1,
			title:['文件上传','font-size:14px;font-weight:bold'],
			//btn: ['上传', '取消'],
			btn: ['关闭'],
			shadeClose: true,
			shade: 0.8,
			area:['400px','430px'],
			content:$('.layer_terminal'),
			yes : function() {
				layer.closeAll();
				window.location.href = '<%=request.getContextPath()%>/material/toList.do';
			}
		});

	});

});

function pageSkip(pageNumber) {
	$pageNumber.val(pageNumber);
	$listForm.submit();
	return false;
}

function pageSize(pageSize) {
	$pageSize.val(pageSize);
	$("#pageNumber").val("1");
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
              layerAlter("提示","开始日期不能大于结束日期");    
              return false;     
          }     
      }     
      return true;     
  } 

function beforeRename(treeId, treeNode, newName) {
	if (newName.length == 0) {
		layerAlter("提示","节点名称不能为空");
		var zTree = $.fn.zTree.getZTreeObj("menuTree");
		setTimeout(function(){zTree.editName(treeNode)}, 10);
		return false;
	}
    $.ajax({
    	enable: true,
        async : false,  
        cache:false,  
        type: 'POST',  
        dataType : "json",
        data:{id:treeNode.id, pId:treeNode.pId, type:treeNode.type,name:newName},
        url: "<%=path%>/material/update_material.do", 
        success:function(data){ //请求成功后处理函数。   
            zTreeNodes = eval(data);   //把后台封装好的简单Json格式赋给treeNodes  
            var treeObj = $.fn.zTree.getZTreeObj("menuTree");
            treeObj.refresh();
            window.location.reload();
        },
        error:function(XMLHttpRequest, textStatus, errorThrown) {//请求失败处理函数  
           	layerAlter("提示","操作出现异常！");
        }
    });
	return true;
}

var newCount = 1;
function add(e) {
	var zTree = $.fn.zTree.getZTreeObj("menuTree"),
	isParent = e.data.isParent,

	nodes = zTree.getSelectedNodes(),
	treeNode = nodes[0];
	if(treeNode.id=='0'){
		layerAlter("提示","不能增加顶级节点，请选择父节点");
		return (false);
	}
	if (treeNode) {
	    var newNode = {id:null, pId:treeNode.id, isParent:isParent, type:treeNode.type, name:"new node" + (newCount++)};
	    newNode = zTree.addNodes(treeNode, newNode, true);
		
		if (newNode) {
			zTree.editName(newNode[0]);
		} else {
			layerAlter("提示","叶子节点被锁定，无法增加子节点");
			return (false);
		}
	} else {
	    layerAlter("提示","能增加顶级节点，请选择父节点");
	    return (false);
	}
};

function edit() {
	var zTree = $.fn.zTree.getZTreeObj("menuTree");
	nodes = zTree.getSelectedNodes();
	treeNode = nodes[0];
	
	if(treeNode.id=="0"){
		layerAlter("提示","父节点不能删除!");
		return;
	}
	if (nodes.length == 0) {
		layerAlter("提示","请先选择一个节点");
		return;
	}
	zTree.editName(treeNode);
};

function remove() {
	var zTree = $.fn.zTree.getZTreeObj("menuTree");
	nodes = zTree.getCheckedNodes();
	treeNode = nodes[0];
	if (nodes.length == 0) {
		layerAlter("提示","请先选择一个节点");
		return;
	}
	if(treeNode.pId == 0 || treeNode.pId == null){
	    layerAlter("提示","父节点不能删除!");
	    return;
	}
	
	var ids = "";
	for(var i=0; i<nodes.length; i++){
		tmpNode = nodes[i];
		if(i!=nodes.length-1){
			ids += tmpNode.id+",";
		}else{
			ids += tmpNode.id;
		}
	}
	
	layer.confirm('确定要删除吗？', {btn: ['确定','取消']},  //按钮
		function(index){
			$.ajax({
				url : "<%=request.getContextPath()%>/material/delete_material.do?typeIds="+ids,
				type: "POST",
				cache:false,
				async:true,
				dataType: "json",
				success:function(data) {
					if(data=="true"){
						zTree.removeNode(nodes[0]);
						window.location.href = '<%=request.getContextPath()%>/material/toList.do';
						layerAlter("提示","删除成功！");
					}else{
						layerAlter("提示","删除失败！");
					}
		        },
				error:function(XMLHttpRequest, textStatus, errorThrown) {
		            layerAlter("提示","操作出现异常！");
		        }
		    });
    	}
	);
	
}


	//节点双击赋值查询
	function clickNode(e,treeId,treeNode){
		window.location.href = '<%=path%>/material/toList.do?typeId='+treeNode.id+'&typePId='+treeNode.pId;
	}
	
	//节点单击赋值查询
	function clickNode1(e,treeId,treeNode){
        $("#type").val(treeNode.type);
        $("#material_type").val(treeNode.id);
	}
	
	
	var oTimer = null;
	function getProgress() {
		var now = new Date();
	    $.ajax({
	        type: "post",
	        dataType: "json",
	        url: "<%=path%>/file/progress.do",
	        data: now.getTime(),
	        success: function(data) {
	        	$("#progress_percent").text(data[0].percent);
	            $("#progress_bar").width(data[0].percent);
	            $("#has_upload").text(data[0].mbRead);
	            $("#upload_speed").text(data[0].speed);
	        },
	        error: function(err) {
	        	$("#progress_percent").text("Error");
	        }
	    });
	}
	

	
	function showInfo(){
		$("#process").show();
		$("#cancel").show();
		$("#info").show();
		$("#success_info").hide();
	    //文件名
	   	fileName = $("#file").val().split('/').pop().split('\\').pop();
	    //进度和百分比
	    $("#progress_percent").text("0%");
	    $("#progress_bar").width("0%");
	    $("#progress_all").show();
	  
	    oTimer = setInterval("getProgress()", 10);
	    ajaxFileUpload();
	    //document.getElementById("upload_form").submit();
	    window.document.getElementById("file").disabled = true;
	}
	
	/**
	 * 上传文件
	 */
	 function fSubmit(){
		var type=$("#type").val();
		var filepath=$("#file").val();
		if(filepath.length>50){
	 		///alert("文件名长度不能大于50位！");
	 		layerAlter("提示","文件名长度不能大于50位！");
	 		return false;
	 	}
		var extStart=filepath.lastIndexOf(".");
        var ext=filepath.substring(extStart,filepath.length).toUpperCase();
        if(type==null||type==''){
        	//清空file文件上传域
        	$("#file").after($("#file").clone().val("")); 
        	$("#file").remove();
        	//alert("请选择文件类型！");
        	layerAlter("提示","请选择文件类型！");
            return false;
        }else{
        	if("video"==type){
  	        	if(ext!=".MP4"/* &&ext!=".AVI"&&ext!=".MKV" */){
  				 	//alert("视频限于mp4/* ,avi,mkv */格式");
  				 	layerAlter("提示","视频限于mp4格式");
  				  	return false;
  				}else{
  					showInfo();
  				  	return false;
  				}
  	        }else if("image"==type){
  	        	if(ext!=".BMP"&&ext!=".PNG"&&ext!=".GIF"&&ext!=".JPG"&&ext!=".JPEG"){
  				 	//alert("图片限于png,gif,jpeg,jpg格式");
  				 	layerAlter("提示","图片限于png,gif,jpeg,jpg格式");
  				 	return false;
  				}else{
  					showInfo();
  				  	return false;                 
  				}
          	}else if("doc"==type){
          	  if(ext!=".PDF"&&ext!=".DOCX"&&ext!=".DOC"&&ext!=".PPTX"&&ext!=".PPT"&&ext!=".XLSX"&&ext!=".XLS"){
  				 	//alert("文本限于pdf,office文件格式");
  				 	layerAlter("提示","文本限于pdf,office文件格式");
  				 	return false;
  				}else{
  					showInfo();
  				  	return false;                 
  				}     
          	}
          	else  if("music"==type){  
          	if(ext!=".MP3"&&ext!=".WAV"&&ext!=".FLAC"&&ext!=".APE"){
  				 	//alert("音乐限于mp3,wav文件格式");
  				 	 layerAlter("提示","音乐限于mp3,wav文件格式"); 
  				 	return false;
  				}else{
  					showInfo();
  				  	return false;                 
  				}      
          	}
        }
       	if(filepath==null||filepath==''){
             //alert("文件不能为空。");
             layerAlter("提示","文件不能为空。");    
             return false;
        }else{
          	
       	}
	}

	
	/**
	 * 上传文件
	 */
	function ajaxFileUpload() {
		var type = $("#material_type").val();
	    $.ajaxFileUpload({
	        url: '<%=path%>/material/saveFile.do',
	        secureuri: false,
	        fileElementId: 'file',
	        dataType: 'json',
	        data: {
	            materialType: type,
	            id: 'id'
	        },
	        success: function(data, status) {
            	window.clearInterval(oTimer);
                if (data.status == 'success') {
                	$("#info").hide();
                	$("#success_info").show();
                	$("#success_info").text(fileName + "\t上传成功");
                	$("#process").hide();
                	$("#cancel").hide();
                	$("#file").val("");
                	window.document.getElementById("file").disabled = false;
                	//上传进度和上传速度清0
                	$("#has_upload").text("0");
                    $("#upload_speed").text("0");
                    $("#progress_percent").text("0%");
                    $("#progress_bar").width("0%");
                } else{
                	$("#progress_all").hide();
                	$("#file").val("");
                	alert("上传错误！");
                }
	        },
	        error: function(data, status, e) {
	            alert(e);
	        }
	    })
	    return false;
	}
</script>

