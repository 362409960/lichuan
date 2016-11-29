<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<% 
    String path = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta charset="utf-8">
<title>机构</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta content="" name="description">
<meta content="" name="keywords">
<meta content="Cloudring" name="author">
<meta content="Cloudring" name="copyright">
<link rel="shortcut icon" href="<%=request.getContextPath()%>/images/icon/icon.png"/>
<!-- <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/zTree/zTreeStyle.css"/> -->
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/zTreeStyle/zTreeStyle.css"/>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common.js"></script>
<!-- <script type="text/javascript" src="<%=path%>/js/zTree/jquery.ztree-2.6.min.js"></script> -->
<script type="text/javascript" src="<%=path%>/js/zTree/jquery.ztree.all.js"></script>
<script type="text/javascript"  src="<%=path%>/layer/layer.js"></script>
<style type="text/css">
html,body{
	height:100%;
	width:100%;
	overflow:auto;
}
</style>
<script type="text/javascript">
	var zTree;
	
	var setting = {
		check: {
			enable: false
		},
		data: {
			simpleData: {
				enable: true
			}
		},
		callback:{
			onClick:clickNode//点击节点触发的事件
		}
	};
	
	$(document).ready(function() {
		var zTreeNodes = eval('${zTreeNodes}');
		zTree = $.fn.zTree.init($("#menuTree"), setting, zTreeNodes);
		zTree.expandAll(true);//节点展开
		zTree.setting.check.chkboxType = { "Y" : "s", "N" : "ps" };
	});
	
	//节点单击赋值显示
	function clickNode(event, treeId, treeNode) {
		var value = treeNode.id+","+treeNode.name;
		
		if(navigator.userAgent.indexOf("Chrome") >0){//谷歌浏览器
			window.opener.document.getElementById("departmentid").value=treeNode.id;
	        window.opener.document.getElementById("departmentname").value=treeNode.name;
        }else{
        	window.returnValue=value;
        }
		window.close();
    }
	
	function selectValues(){
		var nodes = zTree.getCheckedNodes();
		if(nodes.length>1){
			layerAlter("提示","请选择单个机构！");
		}
		var tmpNode;
		var ids = "";
		for(var i=0; i<nodes.length; i++){
			tmpNode = nodes[i];
			if(i!=nodes.length-1){
				ids += tmpNode.id+","+tmpNode.name;
			}else{
				ids +=  tmpNode.id+","+tmpNode.name;
			}
		}
	}
    
</script>

</head>

<body style="overflow:scroll;overflow-x:hidden">
	<div>
		<div id="menuTree" class="ztree"></div> 
		<!-- <input type="button" value="提交" onclick="selectValues();"/> -->
	</div>
	
</body>
</html>
