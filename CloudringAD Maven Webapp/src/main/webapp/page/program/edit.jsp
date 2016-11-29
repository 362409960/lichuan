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
<title>节目编辑</title>
<!-- <meta http-equiv="X-UA-Compatible" content="IE=edge"> -->
<meta http-equiv="X-UA-Compatible" content="IE=5;IE=9;IE=10">
<meta content="" name="description">
<meta content="" name="keywords">
<meta content="Cloudring" name="author">
<meta content="Cloudring" name="copyright">
<link rel="shortcut icon" href="<%=path%>/images/sys/icon/icon.png">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/sys/common.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/sys/main.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/sys/editor.css">
<link rel="stylesheet" href="<%=path%>/css/sys/jquery-ui.css">
<link rel="stylesheet" href="<%=path%>/css/sys/default.css">
<link rel="stylesheet" href="<%=path%>/css/sys/jquery.cxcolor.css">
<link rel="stylesheet" href="<%=path%>/css/sys/jquery.contextmenu.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/zTreeStyle/zTreeStyle.css"/>
<style>
html, body {
	width:100%;
	height:100%;
	overflow:auto;
}
.focusin{
	border-color:#179ff9;
}

.hover{
	border:dashed 1px #179ff9;
}
body{
	background:none;
}
.pictureImg > img{
	width:100%;
	height:100%; 
}
.row_w500{
  overflow:hidden;
  text-overflow:ellipsis;
  white-space: nowrap;
  width:500px;
}
</style>
 <script type="text/javascript">
var contextPath = "${pageContext.request.contextPath}";
</script>
</head>

<body>
<form id="frm" name="frm" method="post"  action="<%=path%>/program/save.do">
<input type="hidden" name="context" id="context"/>
<input type="hidden" name="context_video" id="context_video" /><!--视频的的地址需要保存2个  -->
<input type="hidden" name="id" id="id"  value="${program.id}"/>
<input type="hidden" name="sonId" id="sonId" value="${programDetails.id}"/>
<input type="hidden" name="video_url" id="video_url" value="${programDetails.video_url}"/>
<input type="hidden" name="imgae_url" id="imgae_url" value="${programDetails.imgae_url}"/>
<input type="hidden" name="pdf_url" id="pdf_url" value="${programDetails.pdf_url}"/>
<input type="hidden" name="stream_left" id="stream_left" />
<input type="hidden" name="stream_top" id="stream_top" />
<input type="hidden" name="stream_width" id="stream_width" />
<input type="hidden" name="stream_height" id="stream_height" />
<input type="hidden" name="video_stream" id="video_stream" />
<input type="hidden" name="videoPlace_url" id="videoPlace_url" value="${programDetails.videoPlace_url}" />
<input type="hidden" id="background_picture" name="background_picture" value="${programDetails.background_picture}"/>
<div id="EditDiv">
  <div class="Toolbar" style="padding:2px 4px 0;">
    <div id="div3" class="css_normal left">
      <input id="backToMg" class="btnYellowPale" type="button"  value="返回" onclick="back();">
      <input id="btnInvokeTemp" class="btnYellowPale" type="button" value="选择模板">
      <input id="btnSave" class="btnYellow" type="button" value="保存"  >
      <input id="btnPreview" class="btnYellowPale" type="button" title="预览" value="预览" onclick="preview();">
      <img src="<%=path%>/images/sys/icon/tb_dock.gif" alt="|"> <span> <span>节目名称：</span> <span id="programName">
      <input id="program_name" type="text" value="${program.program_name}" name="program_name" maxlength="25">
      </span> <span>分辨率：</span> <span id="screenRate">
      <select id="sel_screenRate" onChange="setScreenRate(this)"  name="resolution">
          <option value="1024*768"  <c:if test="${program.resolution=='1024*768'}">selected</c:if>>1024*768</option>
        <option value="1280*720" <c:if test="${program.resolution=='1280*720'}">selected</c:if>>1280*720</option>
        <option value="1366*768" <c:if test="${program.resolution=='1366*768'}">selected</c:if>>1366*768</option>
        <option value="1920*1080" <c:if test="${program.resolution=='1920*1080'}">selected</c:if>>1920*1080</option>
      </select>
      </span> <span>节目类型：</span>
      <select id="program_type" name="program_type">
        <option value="普通节目" <c:if test="${program.program_type=='普通节目'}">selected</c:if>>普通节目</option>
        <option value="互动节目" <c:if test="${program.program_type=='互动节目'}">selected</c:if>>互动节目</option>
      </select>
      <%-- <span id="interactTime"> <span>展示时长：</span>
      <input id="view_time" type="text" name="view_time" value="${program.view_time}">
      <span>秒</span> </span> --%> <span>背景音乐：</span> <span id="bgMusic">
      <select id="bagrmusic" onChange="setbgMusic()" name="bagrmusic"> 
        <c:choose>
           <c:when test="${is=='0'}"><option value="" selected="selected">请选择背景音乐</option></c:when>
           <c:otherwise><option value="" >请选择背景音乐</option>    </c:otherwise>
        </c:choose>
          <c:forEach items="${mMusicList}" var="type" varStatus="st"> 
           	   <c:choose>
                    <c:when test="${type.id==program.bagrmusic}"> <option value="${type.id}" selected="selected">${it.name}</option></c:when>
                    <c:otherwise><option value="${type.id}">${it.name}</option></c:otherwise>
                  </c:choose>
           </c:forEach> 
      </select>
      </span> <img src="<%=path%>/images/sys/icon/tb_dock.gif" alt="|"> </span> </div>
  </div>
  <div class="Toolbar">
    <div id="toolbar"></div>
  </div>
</div>
<div id="tool" class="tool">
  <div class="group"> 
    <span id="place" class="item place" title="视频监控：视频监控区域。"></span>
  	<span id="text" class="item text" title="文本：插入文字。"></span> 
    <span id="marquee" class="item marquee" title="滚动文本：插入滚动文字。"></span> 
    <span id="date" class="item date" title="日期：插入日期和时间。"></span> 
  </div>
  <div class="group"> 
  	<span id="weather" class="item weather" title="天气：插入天气预报。"></span> 
    <span id="picture" class="item picture" title="图片：插入单张图片或轮播图片。"></span> 
    <span id="video" class="item video" title="视频：插入视频，支持格式：.mp4 .flv .mpg .wmv .avi。"></span> 
    <span id="webpage" class="item webpage" title="网络页面：插入网页，可插入外部网页和内部场景。"></span> 
  </div>
  <div class="group"> 
  	<!--  <span class="item interact" title="互动组件：制作互动节目时常用组件。"></span>  -->
   <!--  <span id="tblink" class="item tblink" title="插入链接：插入按钮，或者为其它组件元素添加超链接。"></span>  -->
    <!-- <span class="item tbunlink" title="删除链接：删除组件中超链接"></span -->
    <span id="livevideo" class="item livevideo" title="视频直播：插入一些常见的视频频道，例如：CCTV-1,CCTV-2等。"></span> 
    <span id="doc" class="item doc" title="插入文档：插入word、excel、ppt、pdf文档。"></span> 
  </div>
   <div class="group" id="pattern" style="width:220px; height:52px;"> 
  	<span class="spanSmall gtop" title="顶对齐：居顶或多个组件顶对齐。"></span> 
    <span class="spanSmall gbottom" title="底对齐：居底或多个组件底对齐。"></span> 
    <span class="spanSmall gleft" title="左对齐：居左或多个组件左对齐。"></span> 
    <span class="spanSmall gright" title="右对齐：居右或多个组件右对齐。"></span> 
    <span class="spanSmall gcenter" title="水平居中对齐"></span> 
    <span class="spanSmall vcenter" title="垂直居中对齐：垂直居中或多个组件垂直居中对齐。"></span> 
    <span class="spanSmall reduce" title="缩小：缩小编辑区域。"></span> 
    <span class="spanSmall enlarge" title="放大：放大编辑区域。"></span> 
    <span id="bgColor" class="itemDrop"> <span class="spanSmall bgtext" title="文本背景：添加文本背景颜色。"></span> 
    <span class="drop"></span> </span> 
    <span id="textColor" class="itemDrop"> 
    <span class="spanSmall ctext" title="字体颜色：设置文字颜色。"></span> 
    <span class="drop"></span> </span> <span class="spanSmall bold" title="粗体：将所选文字加粗。"></span> 
    <span class="spanSmall underline" title="下划线：给所选文字加下划线。"></span> 
    <span class="spanSmall italic" title="斜体：将所选文字设为倾斜。"></span> 
    <span class="itemDrop"> 
        <span class="spanSmall fontSize" title="字号：更改字号"></span> 
        <span class="drop"></span> 
    </span> 
  </div>
  <div class="group" style="display:none;"> <span class="item more" title="更多：点击查看更多组件。"></span> </div>
</div>
<div id="div_editor" class="editor">
  <div id="lefttool" class="lefttool">
    <div class="headerTop">属性</div>
     <div class="tab">
      <ul class="clearfix">
        <li>源</li>
        <li>历史</li>
        <li class="current">组件</li>
      </ul>
      <div class="tabContent source"></div>
      <div id="history" class="tabContent history">
      </div>
      <div id="comp" class="tabContent comp"  style="display:block">
      </div>
    </div>
  </div>
  <div id="panel" class="panel">
    <div class="rule-top">
      <div class="rule-top-l"></div>
      <div class="rule-top-r"></div>
    </div>
    <div class="rule-left"></div>
    <div class="panel-main" >
<div class="wrapAll" id="wrapAll">
      <!-- <div id="main" class="main"> -->${programDetails.context_video} <!-- </div> -->
</div>
    </div>
  </div>
  <div id="righttool" class="righttool">
    <div class="headerTop">场景选择</div>
    <div class="scene">
      <div class="createScene" id="createScene" title="新建场景">
        <%-- <input id="input_createScene" type="image" src="<%=path%>/images/sys/icon/createscene.png" title="新建场景" name=""> --%>
      </div>
      <div> <span>当前: </span>
        <input id="scenes" class="inp-60" type="text" value="${programDetails.scenes}" name="scenes">
        <br>
        <div style="height:3px"></div>
        <span>播放时间: </span>
        <input id="play_time" class="inp-25" type="text" value="${programDetails.play_time}" name="play_time">
        秒 </div>
      <hr class="hr-w150">
      <div class="playMusic"> <span>
        <input id="setBgMusic" type="checkbox" checked name="">
        </span> <span>播放背景音乐</span> </div>
      <hr class="hr-w150">
      <div class="toggleScene">
        <select id="switchScene" style="width:145px;" onChange="setScene(this)">
            <option value="切换场景" selected>切换场景</option>
            <c:forEach items="${programDetailList}" var="p" varStatus="st">
                   <option value="${p.id}" >${p.scenes}</option>
            </c:forEach>
        </select>
      </div>
    </div>
  </div>
</div>
</form>
<div id="statusbar" class="footerbar">
  <span>当前对象为：</span><span>左：</span><span>右：</span><span>宽：</span><span>高：</span>
  <div class="statusposition"> <img id="zoomout" onClick="javascirpt:zoomout();" title="缩小" src="<%=path%>/images/sys/editor/zoomoutbak.png" alt=""> <span>100%</span> <img id="zoomin" onClick="javascirpt:zoomin();" title="放大" src="images/editor/zoominbak.png" alt=""> <a title="更改缩放级别"> <img id="dropdown" src="<%=path%>/images/sys/icon/dropdown.gif" alt=""> </a> </div>
</div>

<!--保存弹出区域-->
<div class="layer-btnSave" style="display:none" id="layer-btnSave">
	<table class="table-btnSave">
    <!-- 	<tr>
        	<th colspan="4">节目名称: 最新节目-1... 播放时间: 15 秒</th>
        </tr>
        <tr>
        	<td>场景1</td>
            <td>名称:场景1</td>
            <td>场景时长:15秒</td>
            <td>背景音乐:无</td>
        </tr> -->
    </table>	
</div>

<!--选择模板弹出区域-->
<div class="layer-model" style="display:none">
	<ul id="templateListContainer">
	 <c:forEach items="${templateList}" var="temp" varStatus="st">
		<li>          
           <span id="${temp.id}">${temp.name}</span> 
        </li>  
       </c:forEach> 
          
      </ul>
</div>

<!--文字弹出区域-->
<div class="layer-text" style="display:none">
	<div class="tabs">
      <ul>
        <li><a href="#tabs-1">内容</a></li>
        <li><a href="#tabs-2">样式</a></li>
      </ul>
      <div id="tabs-1">
        <textarea id="layer-content" style="height:180px; width:100%;">请输入文字</textarea>
      </div>
      <div id="tabs-2">
      	<div style="height:180px;">
			<table class="tabs-table">
            	<tr>
                	<td style="width:30px;">左：</td>
                    <td style="width:120px;">
                    	<input type="text" id="left" name="" value="0" class="inp-60">&nbsp;px
                    </td>
                    <td style="width:40px;">上:</td>
                    <td style="width:120px;">
                    	<input type="text" id="top"  value="1" name="" class="inp-60">&nbsp;px
                    </td>
                    <td style="width:40px;">宽:</td>
                    <td style="width:120px;">
                        <input type="text" id="width" class="inp-60">&nbsp;px
                    </td>
                    <td style="width:40px;">高:</td>      
                    <td style="width:120px;">
        				<input type="text" id="height" class="inp-60">&nbsp;px
                    </td>              
                </tr>
                <tr>
                	<td>样式:</td>
                    <td colspan="3">
                      <input type="checkbox" value="bold" class="checkbox" id="font-weight">
                      <label for="font-weight">粗体</label>
                      <input type="checkbox" value="underline" class="checkbox" id="text-decoration">
                      <label for="text-decoration">下划</label>
                      <input type="checkbox" class="checkbox" value="italic" id="font-style">
                      <label for="font-style">斜体</label>
                    </td>
                    <td>对齐:</td>
                    <td colspan="3">
                      <select style="width:90px;" id="text-align">
                      	<option value="0"></option>
                        <option value="left">左对齐</option>
                        <option value="center" selected>居中对齐</option>
                        <option value="right">右对齐</option>
                        <option value="justify">两端对齐</option>
                      </select>
                   </td>
                </tr>
                <tr>
                	<td>字号:</td>
                    <td>
                    	<select id="font-size">
                            <option value="0" selected>默认</option>
                            <option value="9px">9px</option>
                            <option value="10px">10px</option>
                            <option value="12px">12px</option>
                            <option value="14px">14px</option>
                            <option value="16px">16px</option>
                            <option value="18px">18px</option>
                            <option value="24px">24px</option>
                            <option value="32px">32px</option>
                            <option value="48px">48px</option>
                         </select>
                    </td>
                    <td>字体:</td>
                    <td colspan="5">
      					<select style="width:90px;" id="font-family">
                        	<option value="0">默认字体</option>
                        </select>
                    </td>
                </tr>
                <tr>
                	<td>颜色:</td>
                    <td>
      					<input type="text" id="color" class="input_cxcolor cxColor" readonly>
   					</td>
                    <td>背景:</td>
                    <td colspan="5">
      					<input type="text" id="background-color" class="input_cxcolor">
    				</td>
                </tr>
                <tr>
                	<td colspan="2">边框:</td>
                    <td colspan="6">
      					<span>宽</span>
      					<input type="text" id="border-width" class="inp-60">px
      					<span>样式</span>
     					<select style="width:90px;" id="border-style">
      						<option value="0"></option>
                            <option value="solid">实线</option>
                            <option value="dotted">点状</option>
                            <option value="dashed">虚线</option>
                            <option value="double">双钱</option>
                            <option value="groove">3D凹槽边框</option>
                            <option value="ridge">3D垄状边框</option>
                            <option value="outset">3D outset边框</option>
                            <option value="inherit">继承父类</option>
                        </select>
      				 	<span>颜色</span>
     				 	<input type="text" id="border-color" class="input_cxcolor cxColor">
    				</td>
                </tr>
                <tr>
                	<td colspan="2">边距:</td>
                    <td colspan="6">
                      <span>上</span>
                      <input type="text" id="padding-top" class="inp-60">px
                      <span>右</span>
                      <input type="text" id="padding-right" class="inp-60">px
                      <span>下</span>
                      <input type="text" id="padding-bottom" class="inp-60">px
                      <span>左</span>
                      <input type="text" id="padding-left" class="inp-60">px
                    </td>
                </tr>
            </table>
         </div>
      </div>
    </div>
</div>

<!--滚动文字弹出区域-->
<div class="layer-marquee" style="display:none;">
	<div style="padding:10px;">
    	<form id="form1" action="" method="post">
        	<!-- <table class="tabs-table">
            	<tr>
                	<td align="left" style="width:65%;">
                    	<span>名称：</span>
                        <input type="text" class="inp-120">
                        <span>分类：</span>
                        <select class="sel-120">
                        	<option value="文本" selected>文本</option>
                        </select>
                    </td>
                    <td align="right">
                    	<input type="button"  value="搜索" class="btn-01">
                        <input type="button" value="上传文件" class="btn-01">
                    </td>
                </tr>
            </table> -->
           <%--  <div class="layer-tree clearfix">
            	<div class="treeView">
                	<ul class="ztree">
                    	<li>
                        	<a href="##">
                            	<span>文本</span>
                            </a>
                        </li>
                    </ul>
                </div>
                <div class="treeRight">
                	<table class="tbList">
                    	<colgroup>
                        	<col width="80">
                            <col width="160">
                            <col width="120">
                            <col width="310">
                        </colgroup>
                        <tr>
                        	<td>
                            	<input type="checkbox" name="">
                            </td>
                            <td>名称</td>
                            <td>分类</td>
                            <td>文件路径</td>
                        </tr>
                    </table>
                </div>
            </div> --%>
            <div class="tree-marquee">
            	<div class="fieldset-marquee">
                	<div class="fieldset">
                    	<h2 class="legend">文字输入</h2>
                        <textarea id="marqueeText" class="texta-marquee" ></textarea>
                    </div>
                    <div class="fieldset">
                    	<h2 class="legend">字体属性</h2>
                        <table class="table-list">
                        	<tr>
                                <td>字体</td>
                                <td>
                                	<select id="marquee-font-family" class="marqueeStyle">
                                        <option value="inherit">默认字体</option>
                                     </select>
                                </td>
                                <td align="right">字号</td>
                                <td>
                                	<select id="marquee-font-size" class="marqueeStyle">
                                        <option value="12">12px</option>
                                        <option value="14">14px</option>
                                        <option value="16">16px</option>
                                        <option value="18">18px</option>
                                        <option value="20">20px</option>
                                        <option value="22">22px</option>
                                        <option value="24">24px</option>
                                        <option value="26">26px</option>
                                        <option value="28">28px</option>
                                     </select>
                                </td>
                                <td>字体颜色&nbsp;&nbsp;<input type="text" id="marquee-color" class="input_cxcolor marqueeStyle" readonly></td>
                                <td>&nbsp;&nbsp;<label for="marquee-font-weight">是否加粗</label>&nbsp;<input type="checkbox" id="marquee-font-weight" class="marqueeStyle"></td>
                            </tr>
                        </table>
                    </div>
                    <div class="fieldset">
                    	<h2 class="legend">滚动设置</h2>
                        <table cellpadding="5" class="tabs-table">
                        	<tr>
                            	<td>
                                	<span>滚动方向</span>
                                    <select id="marquee-direction" class="marqueeStyle">
                                    	<option value="left"> 向左滚动</option>
                                        <option value="right"> 向右滚动</option>
                                        <option value="up"> 向上滚动</option>
                                        <option value="down"> 向下滚动</option>
                                    </select>
                                </td>
                                <td>
                                	<span>滚动方式</span>
                                    <select id="marquee-behavior" class="marqueeStyle">
                                    	<option value="scroll">环绕滚动</option>
										<option value="slide">滚动一次</option>
                                        <option value="alternate">交替滚动</option>
                                    </select>
                                </td>
                                <td colspan="2">
                                	<span>滚动速度</span>
                                    <select id="marquee-scrollamount" class="marqueeStyle">
                                    	<option value="1">1</option>
                                        <option value="2">2</option>
                                        <option value="3">3</option>
                                        <option value="4">4</option>
                                        <option value="5">5</option>
                                        <option value="6">6</option>
                                        <option value="7">7</option>
                                        <option value="8">8</option>
                                        <option value="9">9</option>
                                    </select>
                                    <b>(数字越大速度越快)</b>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                	<span>滚动循环:</span>
                                    <select id="marquee-loop" class="marqueeStyle">
                                    	<option value="-1">是</option>
                                        <option value="1">否</option>
                                    </select>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
                <div class="fieldset-view">
                	<div class="fieldset">
                    	<h2 class="legend">效果预览</h2>
                        <div id="preview" class="preview"></div>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>


<!--天气弹出区域-->
<div class="layer-weather" style="display:none">
	<form id="form1" action="" method="post" name="form1">
		<div class="fieldset">
        	<h2 class="legend">样式显示属性</h2>
               <div class="pad8">
            	<span>字号：</span>
                <select style="width:60px;" id="weather-font-size">
                	<option value="12">12px</option>
                    <option value="14">14px</option>
                    <option value="16">16px</option>
                    <option value="18">18px</option>
                    <option value="20">20px</option>
                    <option value="22">22px</option>
                    <option value="24">24px</option>
                    <option value="30">30px</option>
                    <option value="36">36px</option>
                    <option value="42">42px</option>
                    <option value="48">48px</option>
                </select>
            	<span>字体颜色：</span>
                <input type="text"  value="#000000" class="inp-60 cxColor input_cxcolor" id="weather-color" readonly>
                &nbsp;&nbsp;&nbsp;&nbsp;
                <span>是否加粗：</span>
                <input type="checkbox" name="" id="weather-font-weight">
            </div>
        </div>        
        <div class="fieldset" id="fil_weather">        	
        </div>
    </form>
</div>

<!--日期弹出区域-->
<div class="layer-date" style="display:none">
	<div class="tabs">
      <ul>
        <li><a href="#tabs-1">样式</a></li>
        <li><a href="#tabs-2">日期</a></li>
      </ul>
      <div id="tabs-1">
			<table class="tabs-table">
            	<tr>
                	<td style="width:30px;">左：</td>
                    <td style="width:120px;">
                    	<input type="text" id="date-left" name="" value="0" class="inp-60">&nbsp;px
                    </td>
                    <td style="width:40px;">上:</td>
                    <td style="width:120px;">
                    	<input type="text" id="date-top"  value="" name="" class="inp-60">&nbsp;px
                    </td>
                    <td style="width:40px;">宽:</td>
                    <td style="width:120px;">
                        <input type="text" id="date-width" class="inp-60">&nbsp;px
                    </td>
                    <td style="width:40px;">高:</td>      
                    <td style="width:120px;">
        				<input type="text" id="date-height" class="inp-60">&nbsp;px
                    </td>              
                </tr>
                <tr>
                	<td>样式:</td>
                    <td colspan="3">
                      <input type="checkbox" value="bold" class="checkbox" id="date-font-weight">
                      <label for="font-weight">粗体</label>
                      <input type="checkbox" value="underline" class="checkbox" id="date-text-decoration">
                      <label for="text-decoration">下划</label>
                      <input type="checkbox" class="checkbox" value="italic" id="date-font-style">
                      <label for="date-font-style">斜体</label>
                    </td>
                    <td>对齐:</td>
                    <td colspan="3">
                      <select style="width:90px;" id="date-text-align">
                      	<option value="0"></option>
                        <option value="left">左对齐</option>
                        <option value="center" selected>居中对齐</option>
                        <option value="right">右对齐</option>
                        <option value="justify">两端对齐</option>
                      </select>
                   </td>
                </tr>
                <tr>
                	<td>字号:</td>
                    <td>
                    	<select id="date-font-size">
                            <option value="0" selected>默认</option>
                            <option value="9px">9px</option>
                            <option value="10px">10px</option>
                            <option value="12px">12px</option>
                            <option value="14px">14px</option>
                            <option value="16px">16px</option>
                            <option value="18px">18px</option>
                            <option value="24px">24px</option>
                            <option value="32px">32px</option>
                            <option value="48px">48px</option>
                         </select>
                    </td>
                    <td>字体:</td>
                    <td colspan="5">
      					<select style="width:90px;" id="date-font-family">
                        	<option value="0">默认字体</option>
                        </select>
                    </td>
                </tr>
                <tr>
                	<td>颜色:</td>
                    <td>
      					<input type="text" id="date-color" class="input_cxcolor cxColor" readonly>
   					</td>
                    <td>背景:</td>
                    <td colspan="5">
      					<input type="text" id="date-background-color" class="input_cxcolor">
    				</td>
                </tr>
                <tr>
                	<td colspan="2">边框:</td>
                    <td colspan="6">
      					<span>宽</span>
      					<input type="text" id="date-border-width" class="inp-60">px
      					<span>样式</span>
     					<select style="width:90px;" id="date-border-style">
      						<option value="0"></option>
                            <option value="solid">实线</option>
                            <option value="dotted">点状</option>
                            <option value="dashed">虚线</option>
                            <option value="double">双钱</option>
                            <option value="groove">3D凹槽边框</option>
                            <option value="ridge">3D垄状边框</option>
                            <option value="outset">3D outset边框</option>
                            <option value="inherit">继承父类</option>
                        </select>
      				 	<span>颜色</span>
     				 	<input type="text" id="date-border-color" class="input_cxcolor cxColor">
    				</td>
                </tr>
                <tr>
                	<td colspan="2">边距:</td>
                    <td colspan="6">
                      <span>上</span>
                      <input type="text" id="date-padding-top" class="inp-60">px
                      <span>右</span>
                      <input type="text" id="date-padding-right" class="inp-60">px
                      <span>下</span>
                      <input type="text" id="date-padding-bottom" class="inp-60">px
                      <span>左</span>
                      <input type="text" id="date-padding-left" class="inp-60">px
                    </td>
                </tr>
            </table>
      </div>
      <div id="tabs-2">
        <p>
        	<div>
                <div style="margin-top:10px;">
                  <span>日期:</span>
                  <input type="text" disabled="disabled" style=" width:120px;" id="dymd" class="hasDatepicker">
                </div>
                <div style="margin-top:10px;">
                  <span>格式:</span>
                  <select id="dateformat">
                     <option value=0>yyyy年MM月dd日</option>
                     <option value=1>yy-mm-dd</option>
                     <option value=2 selected>yy/mm/dd</option>
                     <option value=3>mm/dd/yy</option>
                   </select>
                </div>
                <div style="margin-top:10px;">
                  <span id="comp_text_weekformat">星期:</span>
                  <span id="comp_text_week"> 星期四</span>
                  <input type="checkbox" id="comp_check_week">
                </div>
                <div style="margin-top:10px;">
                  <span id="comp_text_timeformat">时间:</span>
                  <span id="comp_text_time"></span>
                </div>
                 <div style="margin-top:10px;">
                 	<span>选择样式:</span>
                	 <select id="datestyle">
                 		<option value=0>文字</option>
                     	<option value=1>图片</option>
                     </select>
                </div>
          	</div>
        </p>
      </div>
    </div>
</div>

<!--图片弹出区域-->
<div class="layer-picture" style="display:none;">
	<div style="padding:10px;">
    	<form id="form1" action="<%=path%>/material/search.do" method="post">
        	<table class="tabs-table">
            	<tr>
                	<td align="left" style="width:65%;">
                    	<span>名称：</span>
                        <input type="text" class="inp-120" name="name" id="image_name">
                        <span>分类：</span>
                        <select class="sel-120" name="material_type" id="image_material_type">
                             <option value="请选择" selected>请选择</option>
                        	 <c:forEach items="${matIamgelist}" var="type">
	                    		<option value="${type.id}">${type.name}</option>
	                    	</c:forEach>
                        </select>                        
                    </td>
                    <td align="right">
                    	<input type="button"  value="搜索" class="btn-01" onclick="searchImgae();">
                       <!--  <input type="button" value="上传文件" class="btn-01">  -->
                    </td>
                </tr>
            </table>
            <div class="layer-tree clearfix">
            	<!-- <div class="treeView">
                	<ul class="ztree">
                    	<li>
                        	<a href="##">
                            	<span>图片</span>
                            </a>
                        </li>
                    </ul>
                </div> -->
                <div class="treeView">
			            		<div class="box">          
					            	<div class="box_body">
					                  	<div class="box_content">
					                  		<div class="content_warp">
					                  			<div class="tree left">
					                  				<div id="menuTreeImage" class="ztree"></div>
					                  			</div>
					                  		</div>
					                  	</div>
					            	</div>
			            		</div>			            	
			            	</div>
                <div class="treeRight" id="image">
                	<table class="tbList"  id="unpoading_list" style="table-layout:fixed;word-break:break-all;background:#f2f2f2;">
                    	<colgroup>
                        	<col width="40">
                            <col width="180">
                            <col width="90">
                            <col width="200">
                           <col width="85"> 
                            <col width="75">
                        </colgroup>
                        <tr>
                        	<td>
                            	<input type="checkbox" name="ckAllImage" id="unpoading_all">
                            </td>
                            <td>图片名称</td>
                            <td>分类</td>
                            <td>图片路径</td>
                           <td>尺寸(像素)</td> 
                            <td>大小</td>
                        </tr>
                        <c:forEach items="${mImageList}" var="pI" varStatus="st">
                        <tr>
                        	<td>
                            	<input type="checkbox" name="imageId" value="${pI.id}"  class="pic_checkbox">
                            </td>
                            <td>${pI.name}</td>
                            <td>图片</td>
                            <td><p style="width: 190px;" class="maxLength">${pI.file_path}</p> </td>
                             <td> ${pI.pixels}</td> 
                            <td>${pI.file_size}</td>
                        </tr>
                        </c:forEach>
                    </table>
                </div>
            </div>
            <div style="width:100%;">
            	<table class="detailbutton">
                	<colgroup>
                    	<col width="20%">
                        <col width="*">
                    </colgroup>
                	<tr>
                    	<td align="left"><strong>已选择素材列表</strong></td>
                        <td>
                        	<input type="button" value="添加" class="btn-01" id="picAdd">
                            <input type="button" value="删除" class="btn-01" id="pidDel">
                        </td>
                    </tr>
                </table>
            </div>
            <div class="imglist maxH230">
            	<table class="tbList" id="unpoaded_list" style="table-layout:fixed;word-break:break-all;background:#f2f2f2;">
                	<tr>
                    	<td><input type="checkbox" name="ckAllImage" id="uploaded_all"></td>
                        <td>图片名称</td>
                        <td>分类</td>
                        <td>图片路径</td>
                        <td>尺寸(像素)</td>
                        <td>大小</td>
                    </tr>
                </table>
            </div>
            <div class="detailbutton" id="imgDiv">
            	<div class="trSubmit">
            	<span>
                    	图片轮播形式:
                        <select id="swiperType">
                        	 <option value="TweenMax">打碎玻璃</option>
                             <option value="scrollLeft">向左滑动</option>
                             <option value="curtainX">滑动渐显</option>
                             <option value="fadeZoom">渐隐覆盖</option>
                       	</select>
                    </span>
                	<!-- <span>滤镜效果时间:<input type="text" class="inp-40" value="0">秒</span> -->
                    <span>宽度:<input type="text" class="inp-40" id="imgWidth" name="imgWidth" value="800"></span>
                    <span>高度:<input type="text" class="inp-40" id="imgHeight" name="imgHeight" value="480"></span>
                  <!--   <span><input type="checkbox" name="">全屏</span> -->
                </div>
            </div>
        </form>
    </div>
</div>



<!--视频弹出区域-->
<div class="layer-video" style="display:none;">
	<div style="padding:10px;">
    	<form id="form1" action="<%=path%>/material/search.do" method="post">
        	<table class="tabs-table">
            	<tr>
                	<td align="left" style="width:65%;">
                    	<span>名称：</span>
                        <input type="text" class="inp-120" name="name" id="video_name">
                        <span>分类：</span>
                        <select class="sel-120" name="material_type" id="video_material_type">
                        	<option value="请选择" selected>请选择</option>
                            <c:forEach items="${matVideolist}" var="type">
	                    	<option value="${type.id}">${type.name}</option>
                        </c:forEach>   
                        </select>
                    </td>
                    <td align="right">
                    	<input type="button"  value="搜索" class="btn-01" onclick="searchVideo();">
                       <!--  <input type="button"  value="大文件上传" class="btn-01"> -->
                      <!--   <input type="button" value="上传文件" class="btn-01"> -->
                    </td>
                </tr>
            </table>
            <div class="layer-tree clearfix">
            	<!-- <div class="treeView"> -->
                	<!-- <ul class="ztree">
                    	<li> -->
                        	 <div class="treeView">
			            		<div class="box">          
					            	<div class="box_body">
					                  	<div class="box_content">
					                  		<div class="content_warp">
					                  			<div class="tree left">
					                  				<div id="menuTreeVideo" class="ztree"></div>
					                  			</div>
					                  		</div>
					                  	</div>
					            	</div>
			            		</div>			            	
			            	</div>
                      <!--   </li>
                    </ul> -->
              <!--   </div> -->
                <div class="treeRight">
                	<table class="tbList" id="unpoading_video" style="table-layout:fixed;word-break:break-all;background:#f2f2f2;">
                    	<colgroup>
                        	<col width="40">
                            <col width="180">
                            <col width="90">
                            <col width="200">
                            <col width="85">
                            <col width="75">
                        </colgroup>
                        <tr>
                        	<td>
                            	<input type="checkbox" name="video_ckAll" id="videoing_all">
                            </td>
                            <td>视频名称[秒]</td>
                            <td>分类</td>
                            <td>视频路径</td>
                            <td>尺寸(像素)</td>
                            <td>大小</td>
                        </tr>
                         <c:forEach items="${mVideoList}" var="video" varStatus="st">
                        <tr>                        
                        	<td>
                            	<input type="checkbox" name="videoId" value="${video.id}" class="video_checkbox">
                            </td>
                            <td>${video.name}[${video.video_play_time}]</td>
                            <td>视频</td>
                            <td><p style="width: 190px;" class="maxLength">${video.file_path}</p></td>
                            <td>${video.pixels}</td>
                            <td>${video.file_size}</td>
                        </tr>
                        </c:forEach>
                    </table>
                </div>
            </div>
            <div style="width:100%;">
            	<table class="detailbutton">
                	<colgroup>
                    	<col width="20%">
                        <col width="*">
                    </colgroup>
                	<tr>
                    	<td align="left"><strong>已选择素材列表</strong></td>
                        <td>
                        	<input type="button" value="添加" class="btn-01" id="videoAdd">
                            <input type="button" value="删除" class="btn-01" id="videoDel">
                        </td>
                    </tr>
                </table>
            </div>
            <div class="imglist maxH230">
            	<table class="tbList" id="unpoaded_video" style="table-layout:fixed;word-break:break-all;background:#f2f2f2;">
                	<tr>
                    	<td><input type="checkbox" id="videoed_all"></td>
                        <td>视频名称</td>
                        <td>分类</td>
                        <td>视频路径</td>
                        <td>尺寸(像素)</td>
                        <td>大小</td>
                    </tr>
                </table>
            </div>
            <div class="detailbutton">
            	<div class="trSubmit">
                    <span>宽度:<input type="text" class="inp-40" id="viedoWidth" name="viedoWidth" value="800"></span>
                    <span>高度:<input type="text" class="inp-40" id="videoHeight" name="videoHeight" value="480"></span>
                    <!-- <span><input type="checkbox" name="">全屏</span> -->
                </div>            
            </div>
        </form>
    </div>
</div>

<!--插入页面弹出区域-->
<div class="layer-webpage" style="display:none">
	<div class="tabs">
      <ul>
        <li><a href="#tabs-1">外部链接</a></li>
        <li><a href="#tabs-2">内部场景</a></li>
      </ul>
       <div id="tabs-1">
       	  <div class="webpage-height">
            <table class="tabs-table01">
                <tr>
                    <th>URL:</th>
                    <td colspan="3"><input type="text" value="http://www.baidu.com" name="webpageurl" id="webpageurl" class="inp-01" style="width:80%"></td>
                </tr>
                <tr>
                	<th>&nbsp;</th>
                    <td colspan="3"><input type="checkbox" checked="checked">预览</td>
                </tr>
                <tr>
                    <th>宽度:</th>
                    <td><input type="text" name="" class="inp-01" style="width:60px"></td>
                    <td><span>高度:</span><input type="text" name="" class="inp-01" style="width:60px"></td>
                    <td>
                    	<span>刷新间隔:</span>
                        <select>
                        	<option>不刷新</option>
                            <option>10秒钟</option>
                            <option>15秒钟</option>
                            <option>自定义</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <th>舞台名称:</th>
                    <td colspan="3">
                    	<input type="text" name="" class="inp-01">
                    </td>
                </tr>
                <tr>
                    <th>绑定:</th>
                    <td colspan="3">
                    	<input type="checkbox">终端ID
                        <input type="checkbox">终端名称
                    </td>
                </tr>
                <tr>
                    <th>404 URL:</th>
                    <td colspan="3">
                    	<input type="text" class="inp-01" style="width:80%">
                    </td>
                </tr>
                <tr>
                    <th>刷新间隔:</th>
                    <td colspan="3">
                        <select>
                        	<option>不刷新</option>
                            <option>10秒钟</option>
                            <option>15秒钟</option>
                            <option>自定义</option>
                        </select>
                    </td>
                </tr>
                <tr>
                	<th>默认图片:</th>
                    <td colspan="3">
                    	<span class="picture">
                        	<img src="<%=path%>/images/sys/webpage.jpg" alt="" class="coverImage">
                        </span>
                        <input type="button" value="更换" class="btn-01">
                    </td>
                </tr>
            </table>
           </div>
        </div>
        <div id="tabs-2">
          <div class="webpage-height">
            <table class="tabs-table01">
            	 <tr>
                    <th>场景选择:</th>
                    <td colspan="3"><input type="text" value="切换场景" name=""sc class="inp-01"></td>
                </tr>
                <tr>
                	<th>&nbsp;</th>
                    <td colspan="3"><input type="checkbox" checked="checked">预览</td>
                </tr>
                <tr>
                	<th>宽度:</th>
                    <td><input type="text" name="" class="inp-01" style="width:60px"></td>
                    <td><span>高度:</span><input type="text" name="" class="inp-01" style="width:60px"></td>
                    <td>
                    	<span>刷新间隔:</span>
                        <select>
                        	<option>不刷新</option>
                            <option>10秒钟</option>
                            <option>15秒钟</option>
                            <option>自定义</option>
                        </select>
                    </td>
                </tr>
                <tr>
                	<th>舞台名称:</th>
                    <td colspan="3">
                    	<input type="text" class="inp-01">
                    </td>
                </tr>
            </table>
          </div>
        </div>
    </div>
    
</div>

<!--插入链接弹出区域-->
<div class="layer-tblink" style="display:none;">
	<div class="fieldset">
    	<h2 class="legend">显示模式</h2>
        <div>
        	<input type="checkbox" name="">按钮
            <input type="checkbox" name="">超链接
        </div>
    </div>
    <div class="link_button">
    	<div class="link_style">
        	<div class="fieldset">
            	<h2 class="legend">按钮显示样式</h2>
                <div id="select_link">
                	<table style="width:100%">
                    	<tr>
                        	<td>默认</td>
                            <td>选中</td>
                            <td>点击</td>
                        </tr>
                        <tr>
                        	<td><img src="<%=path%>/images/sys/icon/button1.png" alt="" class="button_example"></td>
                            <td><img src="<%=path%>/images/sys/icon/button1_click.png" alt="" class="button_example"></td>
                            <td><img src="<%=path%>/images/sys/icon/button1_hover.png" alt="" class="button_example"></td>
                        </tr>
                    </table>
                </div>
                <div>
                	<span>按钮标题:</span>
                    <input type="text" value="button1" class="inp-01">
                    <input type="checkbox" checked>
                    <label for="">边框样式</label>
                </div>
            </div>
        </div>
        <div class="link_view">
        	<div class="fieldset">
            	<h2 class="legend">预览</h2>
                <div>
                	
                </div>
            </div>
        </div>
    </div>
    <div class="fieldset">
    	<h2 class="legend">链接设置</h2>
       	<div class="tabs">
          <ul>
            <li><a href="#tabs-1">内部场景</a></li>
            <li><a href="#tabs-2">外部链接</a></li>
            <li><a href="#tabs-3">第三方程序</a></li>
          </ul>
          <div id="tabs-1">
            <div class="form_item">
                <div class="form_title">场景选择:</div>
                <div class="form_input">
                    <select style="width:129px;"></select>
                </div>
            </div>
            <div class="form_item">
                <div class="form_title">舞台:</div>
                <div class="form_input">
                    <span>
                    	<select style="width:129px;"></select>
                    </span>
                    <span>
                    	<select style="width:129px;">
                        	<option value="_top">_top</option>
                            <option value="_parent">_parent</option>
                            <option value="_self">_self</option>
                            <option value="_blank">_blank</option>
                        </select>
                    </span>
                </div>
            </div>
          </div>
          <div id="tabs-2">
            <div class="form_item">
                <div class="form_title">输入网址:</div>
                <div class="form_input">
                    <input type="text" style="width:129px;" value="http://">
                </div>
            </div>
            <div class="form_item">
                <div class="form_title">舞台:</div>
                <div class="form_input">
                    <span>
                    	<select style="width:129px;"></select>
                    </span>
                    <span>
                    	<select style="width:129px;">
                        	<option value="_top">_top</option>
                            <option value="_parent">_parent</option>
                            <option value="_self">_self</option>
                            <option value="_blank">_blank</option>
                        </select>
                    </span>
                </div>
            </div>
          </div>
          <div id="tabs-3">
             <div class="form_item">
                <div class="form_title">包名:</div>
                <div class="form_input">
                    <input type="text" style="width:129px;">
                </div>
            </div>
            <div class="form_item">
                <div class="form_title">参数:</div>
                <div class="form_input">
                    <input type="text" style="width:129px;">
                </div>
            </div>
          </div>
        </div>
    </div>
   
</div>




<!--视频直播弹出区域-->
<div class="layer-livevideo" style="display:none;">
	<form action="" name="">
    	<table>
        	<tr>
            	<th>宽度:</th>
                <td><input type="text" name="v-width" value="1024" class="inp-01">px</td>
            </tr>
            <tr>
            	<th>高度:</th>
                <td><input type="text" name="v-height" value="768" class="inp-01">px</td>
            </tr>
            <tr>
            	<th>URL:</th>
                <td>
                	<select name="v-src" class="sel-01">
                    	<option value="" selected="selected"></option>
                        <option value="rtsp://rlive.tv189.cn/live/172">CCTV-1 综合</option>
                        <option value="rtsp://rlive.tv189.cn/live/292">CCTV-2 财经</option>
                    </select>
                    <input type="button" value="更新数据" name="v-update" class="btn-01">
                </td>
            </tr>
        </table>
    </form>
</div>


<!--视频监控弹出区域-->
<div class="layer-monitor" style="display:none;">
	<form action="" name="">
    	<table>
        	<tr>
            	<th>左：</th>
                <td><input type="text"  name="left" value="" class="monitor-inp inp-01" readonly></td>
            </tr>
            <tr>
            	<th>上：</th>
                <td><input type="text" name="top" value="" class="monitor-inp inp-01" readonly></td>
            </tr>
            <tr>
            	<th>宽度：</th>
                <td><input type="text" name="width" value="" class="monitor-inp inp-01" readonly></td>
            </tr>
            <tr>
            	<th>高度：</th>
                <td><input type="text" name="height" value="" class="monitor-inp inp-01" readonly></td>
            </tr>
            <tr>
            	<th>分组：</th>
                <td>                
                    <select name="monitor-ip" class="monitor-inp" id="stream">                    
                    	<c:forEach items="${listSu}" var="it">                    	    
                    	      <option value="${it}">${it}</option>
                    	</c:forEach>
                    </select>
                </td>
            </tr>
        </table>
    </form>
</div>



<!--插入文档弹出区域-->
<div class="layer-doc" style="display:none;">
	<div style="padding:10px;">
    	<form id="form1" action="" method="post">
        	<table class="tabs-table">
            	<tr>
                	<td align="left" style="width:65%;">
                    	<span>名称：</span>
                        <input type="text" class="inp-120" name="name" id="doc_name">
                        <span>分类：</span>
                        <select class="sel-120" name="material_type" id="doc_material_type">
                        	<option value="请选择" selected>请选择</option>
                            <c:forEach items="${matDoclist}" var="type">
	                    	<option value="${type.id}">${type.name}</option>
                        </c:forEach> 
                        </select>
                        <!-- <span>宽度：</span>
                        <input type="text" class="inp-60">
                        <span>高度：</span>
                        <input type="text" class="inp-60"> -->
                    </td>
                    <td align="right">
                    	<input type="button"  value="搜索" class="btn-01" onclick="searchDoc();">
                       <!--  <input type="button" value="上传文件" class="btn-01"> -->
                    </td>
                </tr>
            </table>
            <div class="layer-tree clearfix">
            	<!-- <div class="treeView">
                	<ul class="ztree">
                    	<li>
                        	<a href="##">
                            	<span>文本</span>
                            </a>
                        </li>
                    </ul>
                </div> -->
                 <div class="treeView">
			            		<div class="box">          
					            	<div class="box_body">
					                  	<div class="box_content">
					                  		<div class="content_warp">
					                  			<div class="tree left">
					                  				<div id="menuTreeDoc" class="ztree"></div>
					                  			</div>
					                  		</div>
					                  	</div>
					            	</div>
			            		</div>			            	
			            	</div>
                <div class="treeRight">
                	<table class="tbList" id="doc_tblist" style="table-layout:fixed;word-break:break-all;background:#f2f2f2;">
                    	<colgroup>
                            <col width="180">
                            <col width="120">
                            <col width="200">
                            <col width="95">
                            <col width="75">
                        </colgroup>
      					<tbody>
                        <tr>
                            <td>文本名称 </td>
                            <td>分类</td>
                            <td>文本路径</td>
                            <td>文本大小</td>
                            <td>大小</td>
                        </tr>
                          <c:forEach items="${mDocList}" var="doc" varStatus="st">
                        <tr>  
                            <td>${doc.name}</td>
                            <td>文本</td>
                            <td><p style="width: 190px;" class="maxLength">${doc.file_path}</p></td>
                            <td>${doc.pixels}</td>
                            <td>${doc.file_size}</td>
                        </tr>
                        </c:forEach>
						</tbody>
                    </table>
                </div>
            </div>
            <div style="width:100%;">
            	<table class="detailbutton">
                	<tr>
                    	<td align="left" id="docText"><strong>请选择</strong></td>
                    </tr>
                </table>
            </div>
            <div class="detailbutton">
            	<div class="trSubmit">
                    <span>宽度:<input type="text" class="inp-40" value="800"></span>
                    <span>高度:<input type="text" class="inp-40" value="480"></span>
                  <!--   <span>切换时间:<input type="text" class="inp-40" value="0">秒</span> -->
                  <!--   <span><input type="checkbox" name="">全屏</span> -->
                </div>
            </div>
        </form>
    </div>
</div>

<div class="layer-rate" style="display:none;">
	<form action="" name="">
    	<table>
        	<tr>
            	<th>宽度:</th>
                <td><input type="text" name="rate-width" class="inp-01">px</td>
            </tr>
            <tr>
            	<th>高度:</th>
                <td><input type="text" name="rate-height" class="inp-01">px</td>
            </tr>
        </table>
    </form>
</div>

<script type="text/javascript" src="<%=path%>/js/sys/jquery.js"></script>
<script type="text/javascript" src="<%=path%>/js/sys/jquery-ui.js"></script>
<script type="text/javascript" src="<%=path%>/js/sys/jquery.cxcolor.js"></script>
<script type="text/javascript"  src="<%=path%>/layer/layer.js"></script>
<script type="text/javascript"  src="<%=path%>/js/sys/jquery.contextmenu.js"></script>
<script type="text/javascript" src="<%=path%>/js/sys/event.js"></script>
<script type="text/javascript" src="<%=path%>/js/sys/insert.js"></script>
<script type="text/javascript" src="<%=path%>/js/sys/history.js"></script>
<script type="text/javascript" src="<%=path%>/js/sys/checkbox.js"></script>
<script type="text/javascript" src="<%=path%>/js/zTree/jquery.ztree.all.js"></script>
<script>
var selectIndex=0;
function setScreenRate(obj){
	var screenRate=obj.value;
	var main=document.getElementById('main');
	var $width=$(window).width()-340;
	var $height=$(window).height()-130;
	var ntop=0;
	var nleft=0;
	if(screenRate!=-1){
		var arrRate=screenRate.split('*');
		var nWidth=parseInt(arrRate[0]);
		var nHeight=parseInt(arrRate[1]);
		var $bWidth=$width-nWidth;
		var $bHeight=$height-nHeight;	
		if($width<nWidth){
			nleft=0;
		}else{
			nleft=$bWidth/2;
		}
		if($height<nHeight){
			ntop=0;
		}else{
			ntop=$bHeight/2;
		}
		main.style.width=nWidth+'px';
		main.style.height=nHeight+'px';
		main.style.top=ntop+'px';
		main.style.left=nleft+'px';
		selectIndex=obj.selectedIndex;
	}else{
		var oScreenRate=document.getElementById('sel_screenRate');
		var index=layer.open({
			type:1,
			btn:['确定','取消'],
			title:['分辨率','font-size:14px;font-weight:bold'],
			shadeClose: true,
			area:['300px','auto'],
			shade: 0.8,
			content:$('.layer-rate'),
			btn2:function(){
				oScreenRate.selectedIndex=selectIndex;
				layer.closeAll();
			},
			btn1:function(){
				var layerX=parseInt($('input[name="rate-width"]').val());
				var layerY=parseInt($('input[name="rate-height"]').val());
	
				if(isNaN(layerX)||isNaN(layerY)||!layerX||!layerY){
					oScreenRate.selectedIndex=selectIndex;
				}else{
					var selValue=layerX+'*'+layerY;
					$(oScreenRate).find('option').each(function(index, element) {
                        if($(this).val()==selValue){
							$(this).remove();
						}
                    });
					
					var lastOption=oScreenRate.options[oScreenRate.length-1];
					var option=document.createElement('option');
					option.text=selValue;
					option.value=selValue;
					oScreenRate.insertBefore(option,lastOption);
					oScreenRate.options[oScreenRate.length-2].selected=true;
					setScreenRate(oScreenRate);
					
				}
				layer.closeAll();
			},
			end:function(){
				oScreenRate.selectedIndex=selectIndex;
				layer.closeAll();
			}
		});
	}
}

$(function(){
	var $docList=$('#doc_tblist');
	$docList.delegate('tr','mouseover',function(){
		var $index=$(this).index();
		if($index){
			$(this).addClass('docHover');	
		}
	});
	$docList.delegate('tr','mouseout',function(){
		var $index=$(this).index();
		if($index){
			$(this).removeClass('docHover');	
		}
	});
	$docList.delegate('tr','click',function(){
		var $this=$(this);
		var $index=$this.index();
		if($index){
			$this.addClass('docActive').siblings('tr').removeClass('docActive');
			$('#docText').find('strong').html('已选择文本:'+$this.find('td:eq(0)').html());
			var $pdfUrl=$this.find('td:eq(2)').find('p').html();
			$("#pdf_url").val($pdfUrl);
		}
	});
	var $reduce=$('.reduce');
	var $enlarge=$('.enlarge');
	var $speed=1;
	$reduce.bind('click',function(){
		var $main=document.getElementById('main');
		if($speed<=0.2){
			$speed=0.2;
		}
		$speed-=0.1;
		$main.style.transform='scale('+$speed+')';
	});
	$enlarge.bind('click',function(){
		var $main=document.getElementById('main');
		if($speed>=3){
			$speed=3;
		}
		$speed+=0.1;
		$main.style.transform='scale('+$speed+')';
	});
	setScreenRate(document.getElementById('sel_screenRate'));
	
	var $tabLi=$('.tab').find('li');
	var $tabContent=$('.tabContent');
	$tabLi.bind('click',function(){
		var $this=$(this);
		$tabLi.removeClass('current');
		$this.addClass('current');
		$tabContent.hide();
		$tabContent.eq($this.index()).show();
	});
});

;(function(){
	var createScene=document.getElementById('createScene');
	var oMain=document.getElementById('main');
	createScene.onclick=function(){
		oMain.innerHTML='';
		var sonId=$("#sonId").val();
		var scenes=$("#scenes").val();
		if(sonId!="" && sonId!=null){
		   var count=scenes.substring(scenes.length-1,scenes.length);
		   var s=count*1+1*1;
		   $("#scenes").val("场景"+s);
		   	$("#play_time").val("15");
		  	$("#video_url").val("");
			$("#imgae_url").val("");
			$("#video_stream").val("");
			$("#stream_left").val("");
			$("#stream_top").val("");
			$("#stream_width").val("");
			$("#stream_height").val("");
			$("#videoPlace_url").val("");
			$("#sonId").val("");
	
		}		
		return false;
	};
})(); 

function newScene(){
	var oMain=document.getElementById('main');
	var oWrap=document.getElementById('wrapAll');
	var newMain=oMain.cloneNode(false);
	oWrap.removeChild(oMain);
	oWrap.appendChild(newMain);
}

$(window).resize(function(){
	setScreenRate(document.getElementById('sel_screenRate'));
});
document.onclick=document.onmouseup=document.keyup=function(){
	var $focusTarget=$('.focusin');
	var $footerbar=$('.footerbar').find('span');
	var reg=/\d/;
	if($focusTarget.length){
		$footerbar.show();
		var $id=$focusTarget.attr('id').replace(reg,'');
		$id=$id.charAt(0).toUpperCase()+$id.substring(1);
		var $left=$focusTarget.css('left');
		var $top=$focusTarget.css('top');
		var $width=$focusTarget.css('width');
		var $height=$focusTarget.css('height');
		$footerbar.eq(0).html('当前对象:'+$id+',&nbsp;');
		$footerbar.eq(1).html('左:'+$left+',&nbsp;');
		$footerbar.eq(2).html('上:'+$top+',&nbsp;');
		$footerbar.eq(3).html('宽:'+$width+',&nbsp;');
		$footerbar.eq(4).html('高:'+$height);
	}else{
		$footerbar.hide();
	}
	
}


var zTreeVideo;
var zTreeImage;
var zTreeDoc;
var setting1 = {
	check: {
		enable: true//复选框显示
	},
	data: {
		simpleData: {
			enable: true
		}
	},
	callback:{	
		onCheck: onCheck1,
		onClick:clickNode1//点击节点触发的事件
	}
};
var setting2 = {
	check: {
		enable: true//复选框显示
	},
	data: {
		simpleData: {
			enable: true
		}
	},
	callback:{	
		onCheck: onCheck2,
		onClick:clickNode2//点击节点触发的事件
	}
};	
var setting3 = {
	check: {
		enable: false//复选框显示
	},
	data: {
		simpleData: {
			enable: true
		}
	},
	callback:{	
		onClick:clickNode3//点击节点触发的事件
	}
};
//树的数据初始化
var zNodesVideo;  
var zNodesImage;  
var zNodesDoc;  
$(function(){ 
    $.ajax({  
    	enable: true,
        async : false,  
        cache:false,  
        type: 'POST',  
        dataType : "json",  
        url: "<%=path%>/material/searchTree.do",
        error: function () {//请求失败处理函数  
            alert('请求失败');  
        },  
        success:function(data){ //请求成功后处理函数。    
        	zNodesVideo = data[0].video; 
        	zNodesImage = data[0].image; 
        	zNodesDoc = data[0].doc;    	
        	zTreeVideo = $.fn.zTree.init($("#menuTreeVideo"), setting1, zNodesVideo);
        	zTreeImage = $.fn.zTree.init($("#menuTreeImage"), setting2, zNodesImage);
        	zTreeDoc = $.fn.zTree.init($("#menuTreeDoc"), setting3, zNodesDoc);
        	zTreeVideo.expandAll(true);//节点展开
        	zTreeImage.expandAll(true);//节点展开
        	zTreeDoc.expandAll(true);//节点展开
        }  
    });  
}); 
function onCheck1(e, treeId, treeNode) { 
	var $unpoading_video=$('#unpoading_video');
    var $videoingBox=$unpoading_video.find('.video_checkbox'); 	    
	$videoingBox.attr('checked',treeNode.checked);
	$("#videoing_all").attr('checked',treeNode.checked);
} 
function onCheck2(e, treeId, treeNode) {
    var $unpoading_list=$('#unpoading_list');
	var $unpoadingBox=$unpoading_list.find('.pic_checkbox');	
    $unpoadingBox.attr('checked',treeNode.checked);
    $("#unpoading_all").attr('checked',treeNode.checked);
}
function clickNode1(e,treeId,treeNode){
       var nodes = zTreeVideo.getSelectedNodes();
		var treeNode = nodes[0];
		var treeId=treeNode.id+",";
		if(treeNode.children !=undefined){
			for(var i=0;i<treeNode.children.length;i++) {
			    var childNode = treeNode.children[i];
			    	treeId+=childNode.id+",";   
			}
		}
		treeId=treeId.substring(0,treeId.length-1);
		var video=$("#unpoading_video");
		$.ajax({
		type : "post",
		url : contextPath + "/material/treeSearch.do",
		data : {
			type : treeId
		},
		dataType : "json",
		success : function(data) {
		   var jsonObj=data;
		    video.html("");
		   var html="<colgroup><col width=\"40\"><col width=\"180\"><col width=\"90\"><col width=\"200\"><col width=\"85\"><col width=\"75\"></colgroup>";
		    html+="<tr><td><input type=\"checkbox\" name=\"video_ckAll\" id=\"videoing_all\"></td><td>视频名称[秒]</td><td>分类</td><td>视频路径</td><td>尺寸(像素)</td><td>大小</td></tr>";
		     $.each(jsonObj, function (i, item) {
		         html+="<tr><td><input type=\"checkbox\" name=\"videoId\" value=\""+item.id+"\" class=\"video_checkbox\"></td><td>"+item.name+"["+item.video_play_time+"]</td><td>视频</td> <td><p style=\"width: 190px;\" class=\"maxLength\">"+item.file_path+"</p></td>";
		         html+="<td> "+item.pixels+"</td><td>"+item.file_size+"</td></tr>";
		     });		   
			video.html(html);
			
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			alert(errorThrown);
			return false;
		}
	});
	}
function clickNode2(e,treeId,treeNode){
       var nodes = zTreeImage.getSelectedNodes();
		var treeNode = nodes[0];
		var treeId=treeNode.id+",";
		if(treeNode.children !=undefined){
			for(var i=0;i<treeNode.children.length;i++) {
			    var childNode = treeNode.children[i];
			    	treeId+=childNode.id+",";   
			}
		}
		treeId=treeId.substring(0,treeId.length-1);
		var image=$("#unpoading_list");
		$.ajax({
		type : "post",
		url : contextPath + "/material/treeSearch.do",
		data : {
			type : treeId
		
		},
		dataType : "json",
		success : function(data) {
		   var jsonObj=data;
		    image.html("");
		   var html="<colgroup><col width=\"40\"><col width=\"180\"><col width=\"90\"><col width=\"200\"><col width=\"85\"><col width=\"75\"></colgroup>";
		    html+="<tr><td><input type=\"checkbox\" name=\"ckAllImage\" id=\"unpoading_all\"></td><td>图片名称</td> <td>分类</td> <td>图片路径</td>  <td>尺寸(像素)</td> <td>大小</td></tr>";
		     $.each(jsonObj, function (i, item) {
		         html+="<tr><td><input type=\"checkbox\" name=\"imageId\" value=\""+item.id+"\" class=\"pic_checkbox\"> </td> <td>"+item.name+"</td><td>图片</td><td><p style=\"width: 190px\; class=\"maxLength\">"+item.file_path+"</p></td>";
		         html+="<td> "+item.pixels+"</td><td>"+item.file_size+"</td></tr>";
		     });		   
			image.html(html);
			
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			alert(errorThrown);
			return false;
		}
	});
}
function clickNode3(e,treeId,treeNode){
       var nodes = zTreeDoc.getSelectedNodes();
		var treeNode = nodes[0];
		var treeId=treeNode.id+",";
		if(treeNode.children !=undefined){
			for(var i=0;i<treeNode.children.length;i++) {
			    var childNode = treeNode.children[i];
			    	treeId+=childNode.id+",";   
			}
		}
		treeId=treeId.substring(0,treeId.length-1);
		var doc=$("#doc_tblist");
		$.ajax({
		type : "post",
		url : contextPath + "/material/treeSearch.do",
		data : {
			type : treeId			
		},
		dataType : "json",
		success : function(data) {
		   var jsonObj=data;
		    doc.html("");
		   var html="<colgroup><col width=\"180\"> <col width=\"120\"><col width=\"200\"><col width=\"95\"> <col width=\"75\"></colgroup><tbody>";
		    html+="<tr><td>文本名称 </td> <td>分类</td><td>文本路径</td><td>文本大小</td><td>大小</td></tr>";
		     $.each(jsonObj, function (i, item) {
		         html+="<tr><td>"+item.name+"</td><td>文本</td> <td><p style=\"width: 190px;\" class=\"maxLength\">"+item.file_path+"</p></td>";
		         html+="<td> "+item.pixels+"</td><td>"+item.file_size+"</td></tr>";
		     });	
		     html+="</tbody>";	   
			doc.html(html);
			
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			alert(errorThrown);
			return false;
		}
	});
}
	
</script>
</body>
</html>
<script type="text/javascript">

//查询文本
function searchDoc(){
	var type = $("#doc_material_type").val();
	var name = $("#doc_name").val();
	var doc=$("#doc_tblist");
	if("请选择"==type){
	  type="doc";
	}
	$.ajax({
		type : "post",
		url : contextPath + "/material/search.do",
		data : {
			type : type,
			name : name
		},
		dataType : "json",
		success : function(data) {
		   var jsonObj=data;
		    doc.html("");
		   var html="<colgroup><col width=\"180\"> <col width=\"120\"><col width=\"200\"><col width=\"95\"> <col width=\"75\"></colgroup><tbody>";
		    html+="<tr><td>文本名称 </td> <td>分类</td><td>文本路径</td><td>文本大小</td><td>大小</td></tr>";
		     $.each(jsonObj, function (i, item) {
		         html+="<tr><td>"+item.name+"</td><td>文本</td> <td><p style=\"width: 190px;\" class=\"maxLength\">"+item.file_path+"</p></td>";
		         html+="<td> "+item.pixels+"</td><td>"+item.file_size+"</td></tr>";
		     });	
		     html+="</tbody>";	   
			doc.html(html);
			
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			alert(errorThrown);
			return false;
		}
	});
}
//切换场景
function setScene(obj){  
var id=$("#switchScene").val();
  $.ajax({
		type : "post",
		url : contextPath + "/program/showProgramDetailsJson.do",
		data : {
			id : id
		},
		dataType : "json",
		success : function(data) {	
		   var p=data[0].programDetails; 		  
		    $("#scenes").val(p.scenes);
		   	$("#play_time").val(p.play_time);
		  	$("#video_url").val(p.video_url);
			$("#imgae_url").val(p.imgae_url);			
			$("#videoPlace_url").val(p.videoPlace_url);
			$("#pdf_url").val(p.pdf_url);
			$("#sonId").val(p.id);
			$("#wrapAll").html("");
			$("#wrapAll").html(p.context_video);	
			var scens=data[0].list;	
			$("#switchScene").html("");
			$("#switchScene").append("<option value=\"切换场景\" selected>切换场景</option>");    
			$.each(scens, function(key, value){
				$("#switchScene").append("<option value="+value.id+">"+value.scenes+"</option>");                                    
			});	
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			alert(errorThrown);
			return false;
		}
	});
   
}
</script>