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
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/common.css"/>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/main.css"/>
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
			enable: true//复选框显示
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
		
		$("#v_index").removeClass("visiting");
	 	$("#v_program").removeClass("visiting");
		$("#v_terminal").removeClass("visiting");
		$("#v_sys").addClass("visiting");
		$("#v_mater").removeClass("visiting");
		
		var zTreeNodes = eval('${zTreeNodes}');
		zTree = $.fn.zTree.init($("#menuTree"), setting, zTreeNodes);
		zTree.expandAll(true);//节点展开
		zTree.setting.check.chkboxType = { "Y" : "s", "N" : "ps" };//点击子节点，不选中父节点
	});
	
	//节点单击赋值显示
	function clickNode(event, treeId, treeNode) {
		window.location.href = '<%=request.getContextPath()%>/admin/department/detailsDepartment.do?id='+treeNode.id;
	};
	
	//添加
	function addDepartment() {
		window.location.href = '<%=request.getContextPath()%>/admin/department/detailsDepartment.do?action=1';
    }
	
	//删除
	function deleteNode(){
		var nodes = zTree.getCheckedNodes();
		var tmpNode;
		var ids = "";
		for(var i=0; i<nodes.length; i++){
			tmpNode = nodes[i];
			if(i!=nodes.length-1){
				ids += tmpNode.id+",";
			}else{
				ids += tmpNode.id;
			}
		}
		if(nodes!=""){
			layer.confirm('确定要删除吗？',{icon: 3, title:'提示'},function(index){
					$.ajax({
						url : "<%=request.getContextPath()%>/admin/department/deleteNode.do?ids="+ids,
						type: "POST",
						cache:false,
						async:true,
						dataType: "json",
						success:function(data) {
							if(data=="true"){
								layer.alert('删除成功', {icon:1,title:'提示'},function(index){
									window.location.href = '<%=request.getContextPath()%>/admin/department/listDepartment.do';
				    		 	});
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
			
		}else{
			layerAlter("提示","请选择要删除的机构！");
		}
		
	}
    
</script>

</head>

<body>
	<jsp:include page="/page/top.jsp" />
    <div class="blank9"></div>
    <div class="container">
    	<div class="title_Nav">
        	<div class="title_text">
            	<p>
                	 系统设置&gt;
                    <span>机构管理</span>
                </p>
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
                	<span style="padding-left:15px;">共计：</span>
                    <strong class="black">${total};</strong>
                </td>
                <td align="right">
                	<input type="button" class="btn-01" value="新建" onclick="addDepartment();" />
                    <input type="button" class="btn-01" value="删除" onclick="deleteNode();" />
                </td>
            </tr>
        </table>
        <div class="table_box">
        	<div id="menuTree" class="ztree"></div>
        </div>
    </div>
</body>
</html>
