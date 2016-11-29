<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>系统首页</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta content="" name="description">
<meta content="" name="keywords">
<meta content="Cloudring" name="author">
<meta content="Cloudring" name="copyright">
<script type="text/javascript">
	//修改密码
	function updateUserPwd(){
		var id='<%=session.getAttribute("userId")%>';
		var url = "<%=request.getContextPath()%>/admin/user/toPwd.do?id="+id;
        var winOption = "height="+260+",width="+400+",top=400,left=700,toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,fullscreen=0";
        navigator.userAgent.indexOf("Chrome") >0 ? window.open(url,window, winOption) : window.showModalDialog(url, "", "dialogHeight:260px;dialogWidth:400px;dialogTop:400;dialogLeft:700;center:yes;status:no");
	}
	
	function quitUser(){
		layer.confirm('确认要退出当前账号？',{icon: 3, title:'提示'},function(index){
				window.location.href = "<%=request.getContextPath()%>/admin/user/quitUser.do";
    		}
    	);
		
	}
</script>
  </head>
  
  <body>
   	<div id="header" class="header">
    	<div id="logo" class="logo">
        	<div class="lotipbox">
            	<a class="ali01" href="javascript:;">
                	<span id="azh"></span>
                </a>
                <div id="tanzh" class="lotoptan">
                	<div class="lotoptnr">
                    	<a id="modifyPwd" class="cWhite underLine" href="javascript:;" onclick="updateUserPwd()">修改密码</a>
                        <a id="exitlogin" class="cWhite" href="javascript:;" onclick="quitUser()">退出</a>
                    </div>
                </div>
            </div>
        	<div class="welcome-info">
            	<span>欢迎您：</span><a id="loginName" href="javascript:;"><%=session.getAttribute("userCode")%></a>
            </div>
        </div>
        <div class="clearfix"></div>
        <div class="container_bg">
        	<div class="menuleft">
            	<div class="menuright">
                	<ul id="menu">
                    	<li class="visiting" id="v_index">
                        	<a class="menuNormal" href="<%=path%>/hs/index.do">系统首页</a>
                        </li>
                        <li id="v_program">
                        	<a class="menuNormal" href="javascript:;">节目管理</a>
                            <span>
                            	<a href="<%=path%>/program/toMake.do">制作</a>
                                |
                                <a href="<%=path%>/program/toProject.do">管理</a>
                                |
                                <a href="<%=path%>/publish/toPublish.do">发布</a>
                                |
                                 <a href="<%=path%>/programDownloadManager/toPublishList.do">下载管理</a>
                                | 
                                <a href="<%=path%>/removeTerminalProgram/toList.do">删除终端节目</a>
                                |
                                <a href="<%=path%>/programBackup/list.do">节目备份</a>
                               <!--  |
                                <a href="javascript:;">一键发布</a>
                                | -->
                            </span>
                        </li>
                        <li id="v_terminal">
                        	<a class="menuNormal" href="javascript:;">终端管理</a>
                            <span>
                            	<a href="<%=path%>/newsStream/terminal_list.do">插播消息</a>
                                |
                                <a href="<%=path%>/terminalMonitor/terminal_list.do">终端监控</a>
                                |
                                <a href="<%=path%>/terminalInfo/terminal_list.do">终端信息</a>
                                |
                                <a href="<%=path%>/terminalProgram/program_list.do">节目统计</a>
                                
                                <!--  此功能屏蔽     
                                |
                                <a href="javascript:;">终端带宽管理</a>
                                |
                                <a href="javascript:;">终端升级</a>
                                |
                            -->
                                
                            </span>
                        </li>
                        <li id="v_sys">
                        	<a class="menuNormal" href="javascript:;">系统设置</a>
                            <span>
                            	<a href="<%=request.getContextPath()%>/admin/user/listSysUser.do">用户管理</a>
                                |
                                <a href="<%=request.getContextPath()%>/admin/role/listRole.do">角色管理</a>
                                |
                                <a href="<%=request.getContextPath()%>/admin/department/listDepartment.do">机构管理</a>
                                
                                <!-- | <a href="javascript:;">参数设置</a>
                                |
                                <a href="javascript:;">数据采集服务</a>
                                | -->
                            </span>
                        </li>
                        
                        
                        <!-- 暂时屏蔽 
                        <li>
                        	<a class="menuNormal" href="javascript:;">系统日志</a>
                            <span>
                            	<a href="javascript:;">用户操作日志</a>
                                |
                                <a href="javascript:;">素材统计表</a>
                                |
                            </span>
                        </li>
                         -->
                        
                        <li id="v_mater">
                        	<a class="menuNormal" href="javascript:;">素材管理</a>
                            <span>
                            	<a href="<%=path%>/material/toList.do">素材管理</a>
                                |
                                <a href="<%=path%>/template/toList.do">模板管理</a>
                                
                               <!-- | <a href="javascript:;">模板商城</a>
                                |
                                <a href="javascript:;">应用管理</a>
                                | -->
                            </span>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <div class="blank9"></div>
  </body>
</html>
