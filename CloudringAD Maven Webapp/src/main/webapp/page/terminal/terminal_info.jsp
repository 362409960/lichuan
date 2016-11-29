<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/tlds/c.tld" prefix="c"%>
<%@ taglib uri="/WEB-INF/tlds/fmt.tld" prefix="fmt"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta charset="utf-8">
<title>终端信息管理</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta content="" name="description">
<meta content="" name="keywords">
<meta content="Cloudring" name="author">
<meta content="Cloudring" name="copyright">
<link rel="shortcut icon" href="<%=path%>/images/icon/icon.png">
<link href="<%=path%>/css/common.css" rel="stylesheet" type="text/css">
<link href="<%=path%>/css/main.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/page.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/jquery-ui.css">
<link rel="stylesheet" href="<%=path%>/js/zTree/css/zTreeStyle/zTreeStyle.css" type="text/css">
<script type="text/javascript" src="<%=path%>/js/My97DatePicker/WdatePicker.js"></script>
<style type="text/css">
html,body{
	height:100%;
	width:100%;
	overflow:auto;
}
#surveillance_add,.surveillance_del{
	margin-left:30px;
}
.form_item{padding: 5px 0;}
</style>
</head>

<body>
	<jsp:include page="/page/top.jsp" />  
    <div class="container">
    	<form id="aspnetForm" action="<%=path %>/terminalInfo/terminal_search.do" method="post" name="aspnetForm">
    	<input type="hidden" name="pageSize" id="pageSize" value="${terminal.pageSize }">
		<input type="hidden" name="pageNumber" id="pageNumber" value="1">
		<input type="hidden" name="packet" id="packet">
        	<div class="title_Nav">
            	<div class="title_text">
                	<p>
                    	终端管理&gt;
                        <span>终端信息</span>
                    </p>
                </div>
                <div class="title_search">
                	<strong>查询:</strong>
                    <span>终端ID</span>
                    <input type="text" class="inp-90" name="id" value="${terminal.id }" maxlength="32">
                    <span>名称</span>
                    <input type="text" class="inp-90" name="name" value="${terminal.name }" maxlength="50">
                    <span>终端状态</span>
                    <select class="sel-120" name="status">
                    	<c:choose>
                             <c:when test="${empty terminal.status || terminal.status == ''}">
                                 <option value="" selected="selected">请选择</option>
                                 <option value="1" >在线</option>
                                 <option value="0" >离线</option>
                             </c:when>
                             <c:when test="${terminal.status=='1'}">
                                 <option value="" >请选择</option>
                                 <option value="1" selected="selected">在线</option>
                                 <option value="0" >离线</option>
                             </c:when>
                             <c:otherwise>
                                 <option value="" >请选择</option>
                                 <option value="1" >在线</option>
                                 <option value="0" selected="selected">离线</option>
                             </c:otherwise>
                         </c:choose>
                    </select>
                    <span>IP</span>
                    <input type="text" class="inp-90" name="ip" value="${terminal.ip }" maxlength="15">
<!--                     <span>分辨率</span> -->
<!--                     <select class="sel-120"> -->
<!--                     </select> -->
                    <span>状态更新时间</span>
                    <input type="text" id="startDate" name="startDate" value="${terminal.startDate }" class="Wdate"  onClick="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'endDate\')}'})" readonly>
                    -
                    <input type="text" id="endDate" name="endDate" value="${terminal.endDate }" class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'startDate\')}'})"  readonly>
                    <input type="button" class="btn-01" value="搜索" onclick="onSubmit()">
                 </div>	
            </div>
            
            <div class="fl wid_p20">
            	<div class="box">
                	<div class="box_head">
                    	<div class="box_title">
                        	<span class="box_title_text black">分组管理</span>
                            <span class="title_button">
                            	<a id="addLeaf" href="javascript:;" class="title_button_icon">
                                	<img src="<%=path %>/images/icon/new.png" alt="" title="添加">
                                </a>
                                <a id="remove" href="javascript:;" class="title_button_icon" onclick="deleteNode()">
                                	<img src="<%=path %>/images/icon/delete.png" alt="" title="删除">
                                </a>
                                <a id="edit" href="javascript:;" class="title_button_icon" onclick="editNode()">
                                	<img src="<%=path %>/images/icon/edit.png" alt="" title="编辑">
                                </a>
                            </span>
                        </div>
                    </div>
                    <div class="box_body">
                    	<div class="box_content">
            				<div class="content_wrap"> <div class="tree left"  style="overflow:auto;"> <ul id="treeDemo" class="ztree"></ul> </div></div>
                    	</div>
                    </div>
                </div>
            </div>
            <div class="fr wid_p80">
            	<div id="rightFun">
                	<table class="main_white">
                    	<colgroup>
                        	<col width="30%">
                            <col width="70%">
                        </colgroup>
                        <tr>
                        	<td align="left">
                            	<span style="padding-left:15px;">共计</span>
                                <strong class="black">${terminal.total }</strong>
<!--                                 <a href="javascript:;">按地图浏览</a> -->
                            </td>
                            <td align="right">
                            	<input type="button" class="btn-01" value="固件升级" id="promote">
<!--                                 <input type="button" class="btn-01" value="选择机构" onclick="chooseOrg()"> -->
                                <input type="button" class="btn-01" value="选择分组" onclick="choosePacket()">
<!--                                 <input type="button" class="btn-01" value="添加新终端" id="addTerminal"> -->
                                <input type="button" class="btn-01" value="解除绑定" onclick="deleteTerminal()">
                            </td>
                        </tr>
                    </table>
                    <div class="table_box">
                        <table class="boxList">
                            <colgroup>
                                <col width="6%">
                                <col width="10%">
                                <col width="14%">
                                <col width="6%">
                                <col width="9%">
                                <col width="9%">
                                <col width="9%">
                                <col width="9%">
                                <col width="7%">
                                <col width="*">
                                <col width="10%">
                            </colgroup>
                            <thead>
                                <tr>
                                    <th>
                                    	<input id="ckAll" type="checkbox" title="全选" name="ckAll">
                                    </th>
                                    <th>终端ID</th>
                                    <th>
                                    	终端名称
                                        <img src="<%=path %>/images/icon/min_up.png" alt="">
                                    </th>
                                    <th>终端状态</th>
                                    <th>终端IP</th>
                                    <th>所属机构</th>
                                    <th>所在分组</th>
                                    <th>分辨率</th>
                                    <th>版本</th>
                                    <th>监视器信息操作</th>
                                    <th>状态更新时间<img src="<%=path %>/images/icon/min_up.png" alt=""></th>
                                </tr>
                            </thead> 
                            <tbody>
                            <c:forEach items="${terminal.rows }" var="term">
                            	<tr>
                                	<th>
                                    	<input type="checkbox" value="${term.id }" name="ckBox" id="ckBox">
                                    </th>
                                    <th>
                                    	${term.id }
                                    </th>
                                    <th>
                                    	<div class="row-w50" style="max-width:150px;"><a title="${term.name }" href="<%=path%>/terminalInfo/terminal_info.do?terminalId=${term.id}&action=search">${term.name }</a></div>	
                                    </th>
                                    <c:if test="${term.status == 1 }">
		                            	<th>在线</th>
		                            </c:if>
		                            <c:if test="${term.status == 0 }">
		                            	<th>离线</th>
		                            </c:if>
                                    <th>${term.ip }</th>
                                    <th title="${term.mechanismName} ">
                                    	<div class="row-w50" style="width: 95px;">${term.mechanismName }</div>
                                    </th>
                                    <th>
                                    	<div class="row-w50"><a title="${term.packetName }" href="javascript:;" onclick="choosePacket('${term.id}')">${term.packetName }</a></div>
                                    </th>
                                    <th>${term.reolution }</th>
                                    <th>${term.version }</th>
                                    <th>
                                    	<a href="javascript:;" onclick="getSureillance('${term.id}')">详情</a>
                                    </th>
                                    <th><fmt:formatDate value="${term.modifyDate }" pattern="yyyy-MM-dd HH:mm"/></th>
                                </tr>
                            </c:forEach>
                            </tbody>            
                        </table>
                    </div>
                </div>
            
            <div class="pagebox">
            	<div class="pageleft">
            		<c:if test="${pageTotal >10 }">
            		<c:if test="${terminal.pageNumber != 1}">
						<a href="javascript:void(0)" onclick="searchByPage('${terminal.pageNumber-1}','${terminal.pageSize}')">上一页</a>
					</c:if>
					
					<c:if test="${terminal.pageNumber != 1 and terminal.pageNumber != 2 and terminal.pageNumber != 3}">
            				<a href="javascript:void(0)" onclick="searchByPage('1','10')">1</a>
            				<span class="disabled">...</span>
           			</c:if>
            		<c:forEach begin="${terminal.pageNumber }" end="${terminal.pageNumber + 2}" step="1" var="pageIndex">
            			<c:if test="${pageIndex == terminal.pageNumber and pageIndex <= pageTotal}">
							<span class="cpb">${pageIndex}</span>
						</c:if>
            			<c:if test="${pageIndex != terminal.pageNumber and pageIndex <= pageTotal}">
							<a href="javascript:void(0)" onclick="searchByPage('${pageIndex}','${terminal.pageSize}')">${pageIndex}</a>
						</c:if>
            		</c:forEach>
            		
            		<c:if test="${terminal.pageNumber <= pageTotal - 3 }">
						<span class="disabled">...</span>
						<a href="javascript:void(0)" onclick="searchByPage('${pageTotal}','${terminal.pageSize}')">${pageTotal}</a>
					</c:if>
            		
            		<c:if test="${terminal.pageNumber != pageTotal}">
						<a href="javascript:void(0)" onclick="searchByPage('${terminal.pageNumber+1}','${terminal.pageSize}')">下一页</a>
					</c:if>
            	</c:if>
            	<c:if test="${pageTotal <= 10 }">
            		<c:if test="${terminal.pageNumber != 1}">
						<a href="javascript:void(0)" onclick="searchByPage('${terminal.pageNumber-1}','${terminal.pageSize}')">上一页</a>
					</c:if>
            		<c:forEach begin="1" end="${pageTotal}" step="1" var="pageIndex">
						<c:if test="${pageIndex == terminal.pageNumber}">
							<span class="cpb">${pageIndex}</span>
						</c:if>
						<c:if test="${pageIndex != terminal.pageNumber}">
							<a href="javascript:void(0)" onclick="searchByPage('${pageIndex}','${terminal.pageSize}')">${pageIndex}</a>
						</c:if>
					</c:forEach>
					<c:if test="${terminal.pageNumber != pageTotal}">
						<a href="javascript:void(0)" onclick="searchByPage('${terminal.pageNumber+1}','${terminal.pageSize}')">下一页</a>
					</c:if>
            	</c:if>	
                </div>
                <div class="pageright">
                	<p>每页</p>
                	<c:choose>
						<c:when test="${terminal.pageSize eq 10}">
							<a href="javascript:void(0)" onclick="searchByPage(1,50)">50</a>
		                    <a href="javascript:void(0)" onclick="searchByPage(1,30)">30</a>
		                    <span>10</span>
						</c:when>
						<c:when test="${terminal.pageSize eq 30}">
							<a href="javascript:void(0)" onclick="searchByPage(1,50)">50</a>
							<span>30</span>
		                    <a href="javascript:void(0)" onclick="searchByPage(1,10)">10</a>
						</c:when>
						<c:otherwise>
							<span>50</span>
							<a href="javascript:void(0)" onclick="searchByPage(1,30)">30</a>
		                    <a href="javascript:void(0)" onclick="searchByPage(1,10)">10</a>
						</c:otherwise>
					</c:choose>
                </div>
            </div>
           </div>
        </form>
    </div>
<div class="layer_promote" style="display:none;">
	<div class="form_item">
    	<div class="form_title">文件：</div>
        <div class="form_input">
        	<input type="text" readonly id="file_name">
            <input type="button" value="浏览" class="btn-01" id="browsingFiles">
            <input type="button" value="上传" class="btn-01" id="fileUnload">
        </div>
    </div>
	<div class="form_item">
    	<div class="form_title">版本：</div>
        <div class="form_input">
        	<input type="text" id="file_version" maxlength="20">
            <div class="c888">范例: 20130520</div>
        </div>
    </div>
</div>

<div class="layer_terminal" style="display:none">
	<div class="form_item">
    	<div class="form_title">终端IP：</div>
        <div class="form_input">
        	<input type="text" name="" id="ip">
        </div>
    </div>
	<div class="form_item">
    	<div class="form_title">终端名称：</div>
        <div class="form_input">
			<input type="text" name="" value="新终端_1345" id="name" maxlength="50">
        </div>
    </div>
    <div class="form_item">
    	<div class="form_title">注册IP：</div>
        <div class="form_input">
			<select>
            	<option>自定义</option>
            </select>
        </div>
    </div>
</div>

<div class="layer_file" style="display:none; padding-left:5px;">
	<div class="form_item">
        <input type="file" value="选择文件" class="btn-01" id="zipFile" name="zipFile" accept="application/x-zip-compressed" style="width: 250px;">
    </div>
    <div class="form_item" style="text-align:center">
    	上传进度：<span id="progress_percent">0%</span>
    	<input type="button" value="上传" class="btn-01"  onclick="uploadFile()">
    </div>
</div>
<script type="text/javascript" src="<%=path %>/js/jquery.js"></script>
<script type="text/javascript" src="<%=path%>/js/common.js"></script>
<script type="text/javascript" src="<%=path%>/layer/layer.js"></script>
<script type="text/javascript" src="<%=path%>/js/jquery-ui.js"></script>
<script type="text/javascript" src="<%=path%>/js/zTree/jquery.ztree.core.min.js"></script>
<script type="text/javascript" src="<%=path%>/js/zTree/jquery.ztree.excheck.min.js"></script>
<script type="text/javascript" src="<%=path%>/js/zTree/jquery.ztree.exedit.min.js"></script>
<script type="text/javascript" src="<%=path%>/js/jquery.ajaxfileupload.js"></script>
<script type="text/javascript">
$("#v_index").removeClass("visiting");
 $("#v_program").removeClass("visiting");
$("#v_terminal").addClass("visiting");
$("#v_sys").removeClass("visiting");
$("#v_mater").removeClass("visiting");
var setting = {
	    treeNodeKey : "id",
	    treeNodeParentKey : "pId",
	    async : true, 
		view: {
			selectedMulti: false
		},
		edit: {
			enable: false,
			showRemoveBtn: false,
			showRenameBtn: false
		},
		check:{ 
			enable:true,
			chkboxType : { "Y" : "s", "N" : "ps" }
		},
		data: {
			keep: {
				parent:false,
				leaf:false
			},
			simpleData: {
				enable: true
			}
		},
		callback: {
			beforeRename: beforeRename,
			onDblClick: zTreeOnClick
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
            layer.alert('请求失败', {icon:5,title:'提示'});
        },  
        success:function(data){ //请求成功后处理函数。    
        	zNodes = eval(data.packets);   //把后台封装好的简单Json格式赋给treeNodes  
        }  
    });  
});  

//双击根据分组查询
function zTreeOnClick(event, treeId, treeNode) {
	var packetIds ='';
	packetIds = getAllChildrenNodes(treeNode,packetIds);
    $("#packet").val(packetIds);
	onSubmit();
};

function getAllChildrenNodes(treeNode,result){
	if(treeNode.id == '0'){
		return result;
	}
	if (treeNode.isParent){
		var act = $.fn.zTree.getZTreeObj("treeDemo").transformToArray(treeNode);
		for(var i=0;i<act.length;i++)
		{
		$.fn.zTree.getZTreeObj("treeDemo").selectNode(act[i],true);
		var MyNode = $.fn.zTree.getZTreeObj("treeDemo").getSelectedNodes();
		if(i >= act.length-1){
			result += MyNode[0].id;
		}else{
			result += MyNode[0].id+",";
		}
		
		}
	}else{
		result = treeNode.id;
	}
  return result;
}




function beforeRename(treeId, treeNode, newName) {
	if ($.trim(newName).length == 0) {
		layer.alert('节点名称不能为空.', {icon:5,title:'提示'});
		return false;
	}
	if($.trim(newName).length >= 50){
		layer.alert('节点名称过长.', {icon:5,title:'提示'});
		return false;
	}
	
    $.ajax({
    	enable: true,
        async : false,  
        cache:false,  
        type: 'POST',  
        dataType : "json",
        data:{id:treeNode.id, pId:treeNode.pId, name:newName},
        url: "<%=path%>/packet/packet_update.do",
        error: function () {//请求失败处理函数  
            layer.alert('请求失败', {icon:5,title:'提示'});
        },  
        success:function(data){ //请求成功后处理函数。   
            //alert("修改后： "+data.packets);
            zNodes = eval(data.packets);   //把后台封装好的简单Json格式赋给treeNodes  
            var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
            treeObj.refresh();
            
            window.location.reload();
        }  
    });
	
	return true;
}

//增加分组
var newCount = 1;
function add(e) {
	var zTree = $.fn.zTree.getZTreeObj("treeDemo"),
	isParent = e.data.isParent,

	nodes = zTree.getSelectedNodes(),
	treeNode = nodes[0];

	if (treeNode) {
	
	    var newNode = {id:null, pId:treeNode.id, isParent:isParent, name:"new node" + (newCount++)};
	    newNode = zTree.addNodes(treeNode, newNode, true);

		if (newNode) {
			zTree.editName(newNode[0]);
		} else {
			layer.alert('叶子节点被锁定，无法增加子节点', {icon:5,title:'提示'});
			return (false);
		}
	} else {
	    layer.alert('不能增加顶级节点，请选择父节点', {icon:5,title:'提示'});
	    return (false);
	}
};

//修改分组
function edit() {
	var zTree = $.fn.zTree.getZTreeObj("treeDemo"),
	nodes = zTree.getSelectedNodes(),
	treeNode = nodes[0];
	if (nodes.length == 0) {
		layer.alert('请先选择一个节点', {icon:5,title:'提示'});
		return;
	}
	if (treeNode.id == 0) {
		layer.alert('不能修改根节点', {icon:5,title:'提示'});
		return;
	}
	zTree.editName(treeNode);
};

//删除一个分组
function remove(e) {
	var zTree = $.fn.zTree.getZTreeObj("treeDemo");
	var nodes = zTree.getCheckedNodes();
	
	var tmpNode;
	var ids = "";
	for(var i=0; i<nodes.length; i++){
		tmpNode = nodes[i];
		if(tmpNode.name == '系统缺省分组'){
		    layer.alert('你选择的是系统缺省分组,不能删除.', {icon:5,title:'提示'});
		    return;
		}
		if(i!=nodes.length-1){
			ids += tmpNode.id+",";
		}else{
			ids += tmpNode.id;
		}
	}
	
	if (ids.length == 0) {
		layer.alert('请先选择一个节点', {icon:5,title:'提示'});
		return;
	}
	layer.confirm("确定要删除吗？",{icon: 3, title:'提示'},function(index){
		$.ajax({
			url : "<%=path%>/packet/packet_delete.do",
			type: "POST",
			cache:false,
			async:true,
			dataType: "json",
			data:{"packetIds":ids},
			success:function(data) {
				if(data.message == 1){
					layer.alert('删除成功！', {icon:1,title:'提示'},function(index){
						window.location.href = '<%=path%>/terminalInfo/terminal_list.do';
	    		 	});
				}else{
					layer.alert('删除失败！', {icon:5,title:'提示'});
				}
	        },
			error:function(XMLHttpRequest, textStatus, errorThrown) {
				layer.alert('请求失败', {icon:5,title:'提示'});
	        }
	    });
	});
};


$(document).ready(function(){
	//树的初始化
	$.fn.zTree.init($("#treeDemo"), setting, zNodes).expandAll(true);
	$("#addLeaf").bind("click", {isParent:false}, add);
	$("#edit").bind("click", edit);
	$("#remove").bind("click", remove);
});



//分页按钮
function searchByPage(pageNumber,pageSize){
	$("#pageNumber").val(pageNumber);
	$("#pageSize").val(pageSize);
	$("#aspnetForm").submit();
}


//提交按钮验证
function onSubmit(){
	$("#aspnetForm").submit();
}


//文件选择
$("#browsingFiles").click(function (){
	layer.open({
		type:2,
		title:['文本文件管理器','font-size:14px;font-weight:bold'],
		shadeClose: true,
		shade: 0.8,
		area:['930px','500px'],
		content:'<%=path %>/terminalInfo/firnware_list.do',
	});
});

//文件上传页面
$("#fileUnload").click(function(){
	$("#zipFile").val("");
	$("#progress_percent").text("0%");
	fileIndex=layer.open({
		type:1,
		title:['文件上传','font-size:14px;font-weight:bold'],
		shadeClose: true,
		shade: 0.8,
		area:['300px','auto'],
		content:$('.layer_file')
	});
});
//文件上传
function uploadFile(){
	var zipFile = $("#zipFile").val();
	if(zipFile == ''){
		layer.alert('请选择文件', {icon:5,title:'提示'});
		return;
	};
	
	var index1=zipFile.lastIndexOf(".");  
	var index2=zipFile.length;
	var fileType = zipFile.substring(index1,index2);
	
	if(fileType != ".zip"){
		layer.alert('请上传后缀为zip的文件', {icon:5,title:'提示'});
		return;
	}
	oTimer = setInterval("getProgress()", 10);
	$.ajaxFileUpload({
        url: '<%=path %>/terminalInfo/firnware_upload.do', 
        type: 'post',
        secureuri: false, //一般设置为false
        fileElementId: 'zipFile', // 上传文件的id、name属性名
        dataType: 'json', //返回值类型，一般设置为json、application/json
        success: function(data, status){
        	window.clearInterval(oTimer);
        	layer.alert('上传成功', {icon:1,title:'提示'});
        },
        error: function(data, status, e){
            layer.alert(e, {icon:5,title:'提示'});
        }
    });
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
        },
        error: function(err) {
        	
        }
    });
}


var fileIndex;

//固件升级
$("#promote").click(function(){
	var ids = "";
	$('input[name="ckBox"]:checked').each(function(i, dom){
		if (i != $('input[name="ckBox"]:checked').length - 1){
			ids += $(this).val()+",";    
        }
		else{
			ids += $(this).val();
		}    
	});
	if(ids == ""){
		layerAlter("提示","请先选择要操作的终端!");
		return;
	};
	$("#file_name").val("");
	layer.open({
		type:1,
		title:['固件升级','font-size:14px;font-weight:bold'],
		 btn: ['确定','取消'], //按钮
		shadeClose: true,
		shade: 0.8,
		area:['550px','auto'],
		content:$('.layer_promote'),
		btn1:function(){
			var apkUrl = $("#file_name").val();
			if(apkUrl == ""){
				layer.alert('请选择文件', {icon:5,title:'提示'});
				return;
			}
			var apkName = $("#file_version").val();
			if(apkName == ""){
				layer.alert('请输入版本号', {icon:5,title:'提示'});
				return;
			}
			$.ajax({
			    type: "post", 
			    dataType: "json", 
			    url: "<%=path %>/terminalCommand/firmwareUpgrade.do", 
			    data: {"ids":ids,"version":apkName,"firmwareUrl":apkUrl}, 
			    success: function(data) {
			    	if(data.message != 1){
			    		layer.alert('固件升级失败', {icon:5,title:'提示'});
			    	}else{
			    		layer.alert('固件升级成功', {icon:1,title:'提示'},function(index){
			    			window.location="<%=path%>/terminalInfo/terminal_list.do";
		    		 	});
			    	}
			    }, 
			    error: function(err) {
			    	layer.alert(err, {icon:5,title:'提示'});
			    } 
			});
		}
	});
});


//选择机构
// function chooseOrg(){
// 	var ids = "";
// 	$('input[name="ckBox"]:checked').each(function(i, dom){  
// 		if (i != $('input[name="ckBox"]:checked').length - 1){
// 			ids += $(this).val()+",";    
//         }
// 		else{
// 			ids += $(this).val();
// 		}    
// 	});
// 	if(ids == ""){
// 		layerAlter("提示","请选择 播放终端");
// 		return;
// 	}
// }

//选择分组
function choosePacket(obj){
var terminalIds="";
	$('input[name="ckBox"]:checked').each(function(i, dom){  
		if (i != $('input[name="ckBox"]:checked').length - 1){
			terminalIds += $(this).val()+",";    
        }
		else{
			terminalIds += $(this).val();
		}  
	});
	if(obj != undefined){
		terminalIds = obj;
	}
	if(terminalIds == ""){
		layer.alert('请选择 播放终端', {icon:5,title:'提示'});
		return;
	}
	
	layer.open({
		type: 2,
	    title: '',
	    shadeClose: false,
	    shade:  [0.8],
	    maxmin: false, //开启最大化最小化按钮
	    area: ['1024px', '350px'],
	    content: '<%=path%>/packet/packet_page.do?terminalIds='+terminalIds
	});
	
// 	window.showModalDialog("<%=path%>/page/terminal/packet_info.jsp",window,"dialogHeight:350px;dialogWidth:1024px;center:yes;status:no;scroll:no");
}

// 删除终端
function deleteTerminal(){
	var ids = "";
	$('input[name="ckBox"]:checked').each(function(i, dom){  
		if (i != $('input[name="ckBox"]:checked').length - 1){
			ids += $(this).val()+",";    
        }
		else{
			ids += $(this).val();
		}
	});
	if(ids == ""){
		layer.alert('请先选择要解除绑定的终端!', {icon:5,title:'提示'});
		return;
	}
	layer.confirm('确定要解除绑定吗？',{icon: 3, title:'提示'},function(index){
		$.ajax({
		    type: "post", 
		    dataType: "json", 
		    url: "<%=path %>/terminalInfo/terminal_delete.do", 
		    data: {"ids":ids}, 
		    success: function(data) {
		    	if(data.erron != 1){
		    		layer.alert('终端解除绑定失败', {icon:5,title:'提示'});
		    	}else{
		    		layer.alert('终端解除绑定成功', {icon:1,title:'提示'},function(index){
		    			window.location="<%=path%>/terminalInfo/terminal_list.do";
	    		 	});
		    	}
		    }, 
		    error: function(err) {
		    	layer.alert(err, {icon:5,title:'提示'});
		    } 
		});
	});
	
}


//新增终端
$("#addTerminal").click(function (){
	layer.open({
		type:1,
		title:['添加新终端','font-size:14px;font-weight:bold'],
		 btn: ['确定','取消'], //按钮
		shadeClose: true,
		shade: 0.8,
		area:['550px','auto'],
		content:$('.layer_terminal'),
		btn1:function(){
			var name = $("#name").val();
			var ip = $("#ip").val();
			if(ip == ""){
				layer.alert('请输入终端IP!', {icon:5,title:'提示'});
				return;
			}
			
			var ipReg = /^((25[0-5]|2[0-4]\d|[01]?\d\d?)($|(?!\.$)\.)){4}$/;
			if(!ipReg.test(ip)){
				layer.alert('非法IP输入!', {icon:5,title:'提示'});
				return;
			}
			
			if(name == ""){
				layer.alert('请输入终端名称!', {icon:5,title:'提示'});
				return;
			}
			var inIp = "";
			$.ajax({
			    type: "post", 
			    dataType: "json", 
			    url: "<%=path %>/terminalInfo/terminal_add.do", 
			    data: {"ip":ip,"name":name,"inIp":inIp}, 
			    success: function(data) {
			    	if(data.message != 1){
			    		layer.alert('终端新增失败', {icon:5,title:'提示'});
			    	}else{
			    		layer.alert('终端新增成功', {icon:1,title:'提示'},function(index){
			    			window.location="<%=path%>/terminalInfo/terminal_list.do";
		    		 	});
			    	}
			    }, 
			    error: function(err) {
			    	layer.alert(err, {icon:5,title:'提示'});
			    } 
			});
		}
	});
});

//详情
function getSureillance(terminalId){
	
	layer.open({
		type: 2,
	    title: '',
	    shadeClose: false,
	    shade:  [0.8],
	    maxmin: false, //开启最大化最小化按钮
	    area: ['1024px', '350px'],
	    content: '<%=path%>/surveillance/surveillance_page.do?terminalId='+terminalId
	});
	
// 	if(navigator.userAgent.indexOf("Chrome") >0 ){
// 		var winOption = "modal=yes,height=350,width=1024,top=50,left=50,toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,fullscreen=0";
// 	    window.open("<%=path%>/page/terminal/surveillance_info.jsp",window, winOption);
// 	}else{
// 		window.showModalDialog("<%=path%>/page/terminal/surveillance_info.jsp",window,"dialogHeight:350px;dialogWidth:1024px;center:yes;status:no;scroll:no");
// 	} 
};


//全选
$(document).ready(function(e) {
    $('#ckAll').click(function(){
		var _this=this;
		var oCheckbox=$('.table_box').find("input[type=checkbox]");
		oCheckbox.each(function(index, element) {
			$(this).attr('checked',_this.checked);
		});
		console.log(_this.checked);
	});	
    var $aCheckBox=$("[name='ckBox']");
    $aCheckBox.each(function(index, element){
    	var $this=$(this);
    	$this.bind('click',function(){
    		var $aChLen=$(':checkbox[name=ckBox]:checked').length;
    		var $aBox=$aCheckBox.length;
    		if($aChLen==$aBox){
    			$("#ckAll").attr('checked',this.checked);
    		}else{
    			$("#ckAll").removeAttr('checked');
    		}
    	});
    });
});
</script>
</body>
</html>
