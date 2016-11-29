<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="/WEB-INF/tlds/c.tld" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<html>
<head>
<meta charset="UTF-8">
<title>用户详情</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta content="" name="description">
<meta content="" name="keywords">
<meta content="Cloudring" name="author">
<meta content="Cloudring" name="copyright">
<link rel="shortcut icon" href="<%=request.getContextPath()%>/images/icon/icon.png">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/common.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/main.css">
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common.js"></script>
<script type="text/javascript"  src="<%=path%>/layer/layer.js"></script>
<style type="text/css">
html,body{
	height:100%;
	width:100%;
	overflow:auto;
}
</style>
<script type="text/javascript">
	function save(){
		var form = $("#searchForm");
		
		var reg = /^(\w)+(\.\w+)*@(\w)+((\.\w+)+)$/;//邮件正则表达式
		var kgReg = /^[^\s]*$/;//空格
		var patrn=/([a-z]|[A-Z]|[0-9])$/;
		
		if($("[name='userCode']").val()==""||!kgReg.test($("[name='userCode']").val())){
			layerAlter("提示","用户代码不能为空！");
			return false;
		}
		if($("[name='userName']").val()==""){
			layerAlter("提示","用户名不能为空！");
			return false;
		}
		if(!patrn.test($("[name='userName']").val())){
			layerAlter("提示","用户名只能输入数字或字母组合！");
			return false;
		}
		if(!patrn.test($("[name='userCode']").val())){
			layerAlter("提示","用户代码只能输入数字或字母组合！");
			return false;
		}
		if($("[name='email']").val()!=""){
			if (!reg.test($("[name='email']").val())) {
				layerAlter("提示","邮件格式不正确！");
	    		return false;
	    	}
		}
		if($("[name='remark']").val().length>500){
	 		layerAlter("提示","备注长度不能大于500位！");
	 		return false;
	 	}
		if($("#province_no").val()!=""){
			$("#province").val($("#province_no").find("option:selected").text());
		}
		if($("#city_no").val()!=""){
			$("#city").val($("#city_no").find("option:selected").text());
		}
		if($("#district_no").val()!=""){
			$("#district").val($("#district_no").find("option:selected").text());
		}
		
		var checkIds = document.getElementsByName("roleIds");
		var selectedArr = new Array();
		var notSelectArr = new Array();
		for(var n=0;n<checkIds.length;n++){
			if (checkIds[n].checked){
				selectedArr.push(checkIds[n].value);
			}else{
				notSelectArr.push(checkIds[n].value);
			}
		}
		
		$("[name='selectedArr']").val(selectedArr);
		$("[name='notSelectArr']").val(notSelectArr);
		//form.submit();
		
		var id = $("#id").val();
		var userCode = $("[name='userCode']").val();
		
		$.ajax({
			url : "<%=request.getContextPath()%>/admin/user/queryName.do?id="+id+"&name="+userCode,
			type: "POST",
			cache:false,
			async:true,
			dataType: "json",
			success:function(data) {
				if(data=="true"){
					layerAlter("提示","用户代码已存在！");
				}else{
					$.ajax({
						url : "<%=request.getContextPath()%>/admin/department/addUserInfo.do",
						type: "POST",
						cache:false,
						async:true,
						dataType: "json",
						data:$("#searchForm").serialize(),
						success:function(data) {
							if(data[0].isValid==true){
								layerAlter("提示","保存成功！");
								window.close();
							}else{
								layerAlter("提示","保存失败！");
							}
				        },
						error:function(XMLHttpRequest, textStatus, errorThrown) {
				            layerAlter("提示","操作出现异常！");
				        }
				    });
				}
	        },
			error:function(XMLHttpRequest, textStatus, errorThrown) {
	            layerAlter("提示","操作出现异常！");
	        }
	    });
		
	}
	
	//初始化
	$(document).ready(function(){
		provinceInfo();
		cityInfo();
		districtInfo();
	});
	
	//初始化省
	function provinceInfo(){
		var prov = parseInt($("#province").val());
		var listHtml = [];
		listHtml.push('<option value="">省份</option>');
		$.ajax({
			url: "<%=path%>/admin/user/queryProvince.do?t=" + Math.random(),
			type: "POST",
			cache:false,
			async:true,
			dataType: "json",
			success:function(data) {
				for (var i = 0; i < data.length; i++) {
		             var province = data[i];
		             var selected = province.provinceId==prov?"selected":"";
		             listHtml.push('<option value="'+province.provinceId+'" '+selected+'>'+province.provinceName+'</option>');
		        }
		        $('#province_no').html(listHtml.join(''));
			},
			error:function(){
	            layerAlter("提示","获取数据出现异常！");
	        }
		});
	};

	//初始化市
	function cityInfo(){
		var provinceid = $("#province").val();//省编号
		var cityid = parseInt($("#city").val());//市编号
		var listHtml = [];
		listHtml.push('<option value="">城市</option>');
		$.ajax({
			url: "<%=path%>/admin/user/queryCity.do?t=" + Math.random(),
			type: "POST",
			cache:false,
			async:true,
			dataType: "json",
	        data: 'provinceId='+provinceid,
	        success: function(data){
	            for (var i = 0; i < data.length; i++) {
	                var city = data[i];
	                var selected = city.cityId==cityid?"selected":"";
	                listHtml.push('<option value="'+city.cityId+'" '+selected+' >'+city.cityName+'</option>');
	            }
	            $('#city_no').html(listHtml.join(''));
	        },
			error:function(){
	            layerAlter("提示","获取数据出现异常！");
	        }
		});
	};

	//初始化区
	function districtInfo(){
		var cityid = $("#city").val();//市编号
		var districtid = parseInt($("#district").val());//区编号
		var listHtml = [];
		listHtml.push('<option value="">地区</option>');
		$.ajax({
			url: "<%=path%>/admin/user/queryDistrict.do?t=" + Math.random(),
			type: "POST",
			cache:false,
			async:true,
			dataType: "json",
	        data: 'cityId='+cityid,
	        success: function(data){
	            for (var i = 0; i < data.length; i++) {
	                var district = data[i];
	                var selected = district.districtId==districtid?"selected":"";
	                listHtml.push('<option value="'+district.districtId+'" '+selected+'>'+district.districtName+'</option>');
	            }
	            $('#district_no').html(listHtml.join(''));
	        },
			error:function(){
	            layerAlter("提示","获取数据出现异常！");
	        }
		});
	};

	//选择省，填充市信息
	$("[name='province_no']").live("change",function(){
		var provinceid=$("[name='province_no']").val();// 省
		
		if(provinceid==""){//等于省份
			$('#city_no').empty().html('<option value="">城市</option>');
			$('#district_no').empty().html('<option value="">地区</option>');
		}else{
			var listHtml = [];
			listHtml.push('<option value="">城市</option>');
			$.ajax({
				url: "<%=path%>/admin/user/queryCity.do?t=" + Math.random(),
				type: "POST",
				cache:false,
				async:true,
				dataType: "json",
		        data: 'provinceId='+provinceid,
		        success: function(data){
	                for (var i = 0; i < data.length; i++) {
	                    var city = data[i];
	                    listHtml.push('<option value="'+city.cityId+'">'+city.cityName+'</option>');
	                }
	                $('#city_no').empty().html(listHtml.join(''));
	                $('#district_no').empty().html('<option value="">地区</option>');
		        },
				error:function(){
		            layerAlter("提示","获取数据出现异常！");
		        }
			});
		}
		
	});

	//选择市，填充区信息
	$("[name='city_no']").live("change",function(){
		var cityid = $("[name='city_no']").val();//市编号
		var listHtml = [];
		listHtml.push('<option value="">地区</option>');
		$.ajax({
			url: "<%=path%>/admin/user/queryDistrict.do?t=" + Math.random(),
			type: "POST",
			cache:false,
			async:true,
			dataType: "json",
	        data: 'cityId='+cityid,
	        success: function(data){
	             for (var i = 0; i < data.length; i++) {
	                 var district = data[i];
	                 listHtml.push('<option value="'+district.districtId+'">'+district.districtName+'</option>');
	             }
	             $('#district_no').empty().html(listHtml.join(''));
	        },
			error:function(){
	            layerAlter("提示","获取数据出现异常！");
	        }
		});
	});
	
</script>
</head>

<body style="overflow:scroll;overflow-x:hidden">
    <div class="blank9"></div>
    <div class="container">
    	<form id="searchForm" name="searchForm" method="post" action="<%=path %>/admin/department/addUserInfo.do">
    		<!-- 隐藏域 -->
    		<input id="id" name="id" type="hidden" value="${user.id }" />
			<input name="selectedArr" type="hidden" />
			<input name="notSelectArr" type="hidden" />
			<input type="hidden" name="province" id="province" value="${user.province_no}"> 
			<input type="hidden" name="city" id="city" value="${user.city_no}"> 
			<input type="hidden" name="district" id="district" value="${user.district_no}">
			
        	<div class="main_nav">增加用户信息</div>
            <table class="detailTable">
            	<colgroup>
                	<col width="15%">
                    <col width="35%">
                    <col width="15%">
                    <col width="35%">
                </colgroup>
                <tr class="detailRow1">
                	<td>用户代码(用户登录)：<span class="cRed">*</span></td>
                    <td><input type="text" maxlength="32" name="userCode"></td>
                    <td>密码：<span class="cRed">*</span></td>
                    <td>
                    	${password }
                    </td>
                </tr>
                <tr>
                    <td>用户名：<span class="cRed">*</span></td>
                    <td><input name="userName" type="text" maxlength="64"></td>
                	<td>电子邮件：</td>
                    <td><input type="text" maxlength="32" name="email"></td>
                </tr>
                <tr class="detailRow1">
                	<td>地址：</td>
                    <td colspan="3">
                    	<select id="province_no" name="province_no"></select>&nbsp;&nbsp;
						<select id="city_no" name="city_no"></select>&nbsp;&nbsp; 
						<select id="district_no" name="district_no"></select>
                    </td>
                </tr>
                <tr>
                	<td>邮编：</td>
                    <td><input type="text" maxlength="4" name="postcode"></td>
                    <td>号码：</td>
                    <td><input type="text" maxlength="11" name="phone"></td>
                </tr>
                <tr class="detailRow1">
                    <td>QQ：</td>
                    <td>
                    	<input type="text" maxlength="11" name="qq">
                    </td>
                    <td colspan="2"></td>
                </tr>
                <tr>
                	<td valign="top" style="height:50px;">备注：</td>
                    <td style="vertical-align:top;" colspan="3">
                    	<textarea cols="20" rows="3" name="remark"></textarea>
                    </td>
                </tr>
            </table>
            <div class="main_nav">
            	权限信息
            </div>
            <table class="detailTable">
            	<colgroup>
                	<col width="15%">
                    <col width="35%">
                    <col width="50%">
                </colgroup>
                <tr class="detailRow1">
                	<td>所属机构: </td>
                    <td>
                    	<input type="hidden" id="departmentid" name="departmentid" value="${department.id }">
                    	<input type="hidden" id="departmentname" name="departmentname" value="${department.name }">
                    	${department.name }
                    </td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                	<td>拥有角色: </td>
                    <td colspan="2">
                    	<c:forEach items="${allRoles}" var="role">
							<div class="imageholder">
								<input type="checkbox" id ="roleIds" name="roleIds" value="${role.id}" ${role.is_checked eq "true"?"checked=\"checked\"":"" }/>
								<span title="${role.role_name}">${role.role_name}</span><br/>&nbsp;&nbsp;
							</div>
	           			</c:forEach>
                    </td>
                </tr>
            </table>
            <div class="detailbutton">
                <input type="button" value="保存" class="btn-01" onclick="save();"/>&nbsp;&nbsp;
				<input type="button" value="返回" class="btn-01" onclick="window.close();">
            </div>
        </form>
    </div>
</body>
</html>
