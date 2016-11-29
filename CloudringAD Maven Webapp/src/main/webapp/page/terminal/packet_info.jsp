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
<title>分组信息</title>
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
.treeMode{
	width:100%;
	height:230px;
	overflow-x:hidden;
	overflow-y:auto;
	background-color:#fff
}
</style>
</head>

<body>
<div class="dialomain">
	<form method="post" name="">
    	<table class="main_nav">
            <tr>
            	<th>
                	<strong class="black">选择分组:</strong>
                </th> 
           </tr>
        </table>
        <div class="treeMode">
        	<div class="tree left"  style="overflow:auto;"> <ul id="treeDemo" class="ztree"></ul> </div>
        </div>
        <div class="detailbutton" style="text-align:left">
            <input type="button" class="btn-01" value="提交" onclick="onSubmit()">
        </div>
    </form>
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
			enable:false,
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
		}
	};
	

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



$(document).ready(function(){
	$.fn.zTree.init($("#treeDemo"), setting, zNodes).expandAll(true);
});





//提交按钮验证
function onSubmit(){
	var ids = "${terminalIds}";
	
	var zTree = $.fn.zTree.getZTreeObj("treeDemo"),
	nodes = zTree.getSelectedNodes(),
	treeNode = nodes[0],packet = treeNode.id;
	if (nodes.length == 0) {
		layerAlter("提示","请先选择一个节点");
		return;
	}
	if(packet == 0){
		packet = null;
	}
	
	$.ajax({
	    type: "post", 
	    dataType: "json", 
	    url: "<%=path %>/terminalInfo/terminal_packet_update.do", 
	    data: {"ids":ids,"packet":packet}, 
	    success: function(data) {
	    	if(data.message != 1){
	    		layer.alert('修改失败', {icon:5,title:'提示'});
	    	}else{
    			layer.alert('修改成功!', {icon:1,title:'提示'},function(index){
    				parent.location = "<%=path%>/terminalInfo/terminal_list.do";
        			parent.layer.close(index);
    		 	});
    			
	    	}
	    }, 
	    error: function(err) {
	    	layer.alert(err, {icon:5,title:'提示'});
	    } 
	});
	
}


</script>
</body>
</html>
