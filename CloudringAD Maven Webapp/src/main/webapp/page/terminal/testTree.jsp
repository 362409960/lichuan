<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/tlds/c.tld" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>   
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<HTML>
<HEAD>
	<TITLE> ZTREE DEMO - addNodes / editName / removeNode / removeChildNodes</TITLE>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 

	<link rel="shortcut icon" href="<%=path%>/images/icon/icon.png">
	<link href="<%=path%>/css/main.css" rel="stylesheet" type="text/css">
	<link href="<%=path%>/css/common.css" rel="stylesheet" type="text/css">
	<link rel="stylesheet" type="text/css" href="<%=path%>/css/page.css">
	<link rel="stylesheet" type="text/css" href="<%=path%>/css/jquery-ui.css"> 
	<style type="text/css">
	html,body{
		height:100%;
		width:100%;
		overflow:hidden;
	}
	</style>
 
	<link rel="stylesheet" href="<%=path%>/js/zTree/css/zTreeStyle/zTreeStyle.css" type="text/css">
	
	<script type="text/javascript" src="<%=path%>/js/zTree/jquery-1.4.4.min.js"></script>
	<script type="text/javascript" src="<%=path%>/js/zTree/jquery.ztree.core.min.js"></script>
	<script type="text/javascript" src="<%=path%>/js/zTree/jquery.ztree.excheck.min.js"></script>
	<script type="text/javascript" src="<%=path%>/js/zTree/jquery.ztree.exedit.min.js"></script>



</HEAD>

<BODY>

<jsp:include page="/page/top.jsp" />
    <div class="container">
    	<form id="aspnetForm" action="<%=path %>/terminalInfo/terminal_search.do" method="post" name="aspnetForm">
    	<input type="hidden" name="pageSize" id="pageSize" value="5">
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
                    <input type="text" class="inp-60" name="id" value="${terminal.id }">
                    <span>名称</span>
                    <input type="text" class="inp-60" name="name" value="${terminal.name }">
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
                    <input type="text" class="inp-90" name="ip" value="${terminal.ip }">
                    <span>分辨率</span>
                    <select class="sel-120">
                    </select>
                    <span>状态更新时间</span>
                    <input type="text" readonly class="inp-70 datepicker" name="startDate" value="${terminal.startDate }">
                    -
                    <input type="text" readonly class="inp-70 datepicker" name="endDate" value="${terminal.endDate }">
                    <input type="button" class="btn-01" value="搜索" onclick="onSubmit()">
                 </div>	
            </div>
            
            <div class="fl wid_p20">
            	<div class="box">
                	<div class="box_head">
                    	<div class="box_title">
                        	<span class="box_title_text black">分组管理</span>
                            <span class="title_button">
                                <a id="addLeaf" href="#" title="增加叶子节点" onclick="return false;"><img title="添加" alt="" src="<%=path%>/images/sys/icon/new.png"></a>
                                <a id="remove" href="#" title="删除节点" onclick="return false;"><img title="删除" alt="" src="<%=path%>/images/sys/icon/delete.png"></a>
                                <a id="edit" href="#" title="编辑名称" onclick="return false;"><img title="编辑" alt="" src="<%=path%>/images/sys/icon/edit.png"></a>
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
                            <col width="*">
                        </colgroup>
                        <tr>
                        	<td align="left">
                            	<span style="padding-left:15px;">共计</span>
                                <strong class="black">${terminal.total }</strong>
                                <a href="javascript:;">按地图浏览</a>
                            </td>
                            <td align="right">
                            	<input type="button" class="btn-01" value="固件升级" id="promote">
                                <input type="button" class="btn-01" value="选择机构" onclick="chooseOrg()">
                                <input type="button" class="btn-01" value="选择分组" onclick="choosePacket()">
                                <input type="button" class="btn-01" value="添加新终端" id="addTerminal">
                                <input type="button" class="btn-01" value="删除" onclick="deleteTerminal()">
                            </td>
                        </tr>
                    </table>
                    <div class="table_box">
                        <table class="boxList">
                            <colgroup>
                                <col width="6%">
                                <col width="10%">
                                <col width="14%">
                                <col width="10%">
                                <col width="10%">
                                <col width="10%">
                                <col width="10%">
                                <col width="10%">
                                <col width="8%">
                                <col width="12%">
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
                                    <th>状态更新时间<img src="<%=path %>/images/icon/min_up.png" alt=""></th>
                                </tr>
                            </thead> 
                            <tbody>
                            <c:forEach items="${terminal.rows }" var="term">
                            	<tr>
                                	<th>
                                    	<input type="checkbox" value="${term.id }" name="ckBox" id="ckBox">
                                    </th>
                                    <th>${term.id }</th>
                                    <th>
                                    	<a title="${term.name }" href="<%=path%>/terminalInfo/terminal_info.do?terminalId=${term.id}&action=search">${term.name }</a>	
                                    </th>
                                    <c:if test="${term.status == 1 }">
		                            	<th>在线</th>
		                            </c:if>
		                            <c:if test="${term.status == 0 }">
		                            	<th>离线</th>
		                            </c:if>
                                    <th>${term.ip }</th>
                                    <th>
                                    	<a title="${term.mechanismName }" href="javascript:;">${term.mechanismName }</a>
                                    </th>
                                    <th>
                                    	<a title="${term.packetName }" href="javascript:;">${term.packetName }</a>
                                    </th>
                                    <th>${term.reolution }</th>
                                    <th>${term.version }</th>
                                    <th><fmt:formatDate value="${term.modifyDate }" pattern="yyyy-MM-dd HH:mm"/></th>
                                </tr>
                            </c:forEach>
                            </tbody>            
                        </table>
                    </div>
                </div>
            </div>
            <div class="pagebox">
            	<div class="pageleft">
            		<c:if test="${terminal.pageNumber != 1}">
						<a href="javascript:void(0)" onclick="searchByPage('${terminal.pageNumber -1}','${terminal.pageSize}')">上一页</a>
					</c:if>
            		<c:forEach begin="1" end="${pageTotal}" step="1" var="pageIndex">
						<c:choose>
							<c:when test="${pageIndex > 10}">
								<span class="disabled">...</span>
							</c:when>
							<c:otherwise>
								<c:if test="${pageIndex == terminal.pageNumber}">
									<span class="cpb">${pageIndex}</span>
								</c:if>
								<c:if test="${pageIndex != terminal.pageNumber}">
									<a href="javascript:void(0)" onclick="searchByPage('${pageIndex}','${terminal.pageSize}')">${pageIndex}</a>
								</c:if>
							</c:otherwise>
						</c:choose>
					</c:forEach>
            		
					<c:if test="${terminal.pageNumber != pageTotal}">
						<a href="javascript:void(0)" onclick="searchByPage('${terminal.pageNumber+1}','${terminal.pageSize}')">下一页</a>
					</c:if>
            		
                </div>
                <div class="pageright">
                	<p>每页</p>
                	<c:choose>
						<c:when test="${terminal.pageSize eq 5}">
							<a href="javascript:void(0)" onclick="searchByPage(1,30)">30</a>
		                    <a href="javascript:void(0)" onclick="searchByPage(1,10)">10</a>
		                    <span>5</span>
						</c:when>
						<c:when test="${terminal.pageSize eq 10}">
							<a href="javascript:void(0)" onclick="searchByPage(1,30)">30</a>
							<span>10</span>
		                    <a href="javascript:void(0)" onclick="searchByPage(1,5)">5</a>
						</c:when>
						<c:otherwise>
							<span>30</span>
							<a href="javascript:void(0)" onclick="searchByPage(1,10)">10</a>
		                    <a href="javascript:void(0)" onclick="searchByPage(1,5)">5</a>
						</c:otherwise>
					</c:choose>
                </div>
            </div>
        </form>
    </div>

<div class="layer_promote" style="display:none;">
	<div class="form_item">
    	<div class="form_title">文件：</div>
        <div class="form_input">
        	<input type="text" readonly id="file_name">
            <input type="button" value="浏览" class="btn-01">
            <input type="button" value="上传" class="btn-01">
        </div>
    </div>
	<div class="form_item">
    	<div class="form_title">版本：</div>
        <div class="form_input">
        	<input type="text" id="file_version">
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
			<input type="text" name="" value="新终端_1345" id="name">
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


</BODY>
</HTML>


	<SCRIPT type="text/javascript">
 
		<!--
		var setting = {
		    treeNodeKey : "id",
		    treeNodeParentKey : "pId",
		    async : true, 
		
			view: {
				selectedMulti: false
			},
			edit: {
				enable: true,
				showRemoveBtn: false,
				showRenameBtn: false
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
				beforeRemove: beforeRemove,
				beforeRename: beforeRename,
				onClick: zTreeOnClick
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
		        url: "<%=path%>/packet/queryPacketList.do",//请求的action路径  
		        error: function () {//请求失败处理函数  
		            alert('请求失败');  
		        },  
		        success:function(data){ //请求成功后处理函数。   
		            zNodes = eval(data.packets);   //把后台封装好的简单Json格式赋给treeNodes  
		        }  
		    });
		});  

        //点击组查询终端
		function zTreeOnClick(event, treeId, treeNode) {
		    
		
			$(function(){  
			    $.ajax({
			    	enable: true,
			        async : false,  
			        cache:false,  
			        type: 'POST',  
			        dataType : "json", 
			        data:{"terminal.mechanism":treeNode.id}, 
			        url: "<%=path%>/newsStream/terminal_list.do",//请求的action路径  
			        error: function () {//请求失败处理函数  
			            alert('请求失败');  
			        },  
			        success:function(data){ //请求成功后处理函数。   
			            alert(data);  
			        }  
			    });
			});  
		};
   
		 function beforeRemove(treeId, treeNode) {
			var zTree = $.fn.zTree.getZTreeObj("treeDemo");
            zTree.selectNode(treeNode);
            
            if (confirm("确认删除" + treeNode.name + "组吗？")) {
                var treeInfo = treeNode.id;
			    $.ajax({
			    	enable: true,
			        async : false,  
			        cache:false,  
			        type: 'POST',  
			        dataType : "json",
			        data:{id:treeNode.id},
			        url: "<%=path%>/packet/deleteLeaf.do",
			        error: function () {//请求失败处理函数  
			            alert('请求失败');  
			        },  
			        success:function(data){ //请求成功后处理函数。   
			            //alert("修改后： "+data.packets);
			            zNodes = eval(data.packets);   //把后台封装好的简单Json格式赋给treeNodes  
			            var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
			            treeObj.refresh();
			            
			            window.location.reload();
			        }  
			    });
            }
            
            return true;
		}
 
		function beforeRename(treeId, treeNode, newName) {
			if (newName.length == 0) {
				alert("节点名称不能为空.");
				var zTree = $.fn.zTree.getZTreeObj("treeDemo");
				setTimeout(function(){zTree.editName(treeNode)}, 10);
				return false;
			}
			
		    $.ajax({
		    	enable: true,
		        async : false,  
		        cache:false,  
		        type: 'POST',  
		        dataType : "json",
		        data:{id:treeNode.id, pId:treeNode.pId, name:newName},
		        url: "<%=path%>/packet/addLeaf.do",
		        error: function () {//请求失败处理函数  
		            alert('请求失败');  
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

		var newCount = 1;
		function add(e) {
			var zTree = $.fn.zTree.getZTreeObj("treeDemo"),
			isParent = e.data.isParent,

			nodes = zTree.getSelectedNodes(),
			treeNode = nodes[0];

			if (treeNode) {
			    alert("pid: "+treeNode.id+ " isParent: "+isParent);
			
			    var newNode = {id:null, pId:treeNode.id, isParent:isParent, name:"new node" + (newCount++)};
			    newNode = zTree.addNodes(treeNode, newNode, true);

				if (newNode) {
					zTree.editName(newNode[0]);
				} else {
					alert("叶子节点被锁定，无法增加子节点");
					return (false);
				}
			} else {
			    alert("不能增加顶级节点，请选择父节点");
			    return (false);
			}
		};
		function edit() {
			var zTree = $.fn.zTree.getZTreeObj("treeDemo"),
			nodes = zTree.getSelectedNodes(),
			treeNode = nodes[0];
			if (nodes.length == 0) {
				alert("请先选择一个节点");
				return;
			}
			zTree.editName(treeNode);
		};

		function remove(e) {
			var zTree = $.fn.zTree.getZTreeObj("treeDemo"),
			nodes = zTree.getSelectedNodes(),
			treeNode = nodes[0];
			alert("treeNode.pId: "+treeNode.pId);
			
			if(treeNode.pId == 0 || treeNode.pId == null){
			    alert("你选择的是系统缺省分组,不能删除.");
			    return;
			}
			if (nodes.length == 0) {
				alert("请先选择一个节点");
				return;
			}
			//表示需要回调
			var callbackFlag = true;
			zTree.removeNode(treeNode, callbackFlag);
		};

		$(document).ready(function(){
		$("#v_index").removeClass("visiting");
 $("#v_program").removeClass("visiting");
$("#v_terminal").addClass("visiting");
$("#v_sys").removeClass("visiting");
$("#v_mater").removeClass("visiting");
			$.fn.zTree.init($("#treeDemo"), setting, zNodes);
			$("#addLeaf").bind("click", {isParent:false}, add);
			$("#edit").bind("click", edit);
			$("#remove").bind("click", remove);
		});
		//-->
	</SCRIPT>