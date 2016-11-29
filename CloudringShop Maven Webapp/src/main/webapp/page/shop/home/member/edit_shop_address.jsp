<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="/WEB-INF/tlds/c.tld" prefix="c"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title></title>
    <link href="<%=path%>/css/shop/common.css" rel="stylesheet" type="text/css" />
	<link href="<%=path%>/css/shop/member.css" rel="stylesheet" type="text/css" /> 
	<script type="text/javascript" src="<%=path%>/js/jquery.min.js"></script>
	<script type="text/javascript" src="<%=path%>/js/shop/common.js"></script>
	<script type="text/javascript" src="<%=path%>/js/shop/jquery.lSelect.js"></script>
	<script type="text/javascript" src="<%=path%>/js/shop/jquery.validate.js"></script> 
	<style>
body {
    overflow-x:hidden;overflow-y:hidden;
}
</style>
<script type="text/javascript">
var contextPath = "${pageContext.request.contextPath}";
$().ready(function() {

	var $inputForm = $("#inputForm");
    select1();
    
	// 表单验证
	$inputForm.validate({
		rules: {
			contacts: "required",
			/* areaId: "required", */
			address: "required",
			province_id: "required",
			city_id: "required",
			district_id: "required",
			zipcode: {
				required: true,
				pattern: /^\d{6}$/
			},
			mobile: {
				required: true,
				pattern: /^\d{3,4}-?\d{7,9}$/
			}
		}
	});

});

function select1() {
 $("#S1").html("");
            $.ajax(
            {
                type: "post",
                url: contextPath+"/region/getAreaData.do",
                data: { "parentId": null },
                success: function (msg) {   
                var data=eval(msg);                      
                    for (var i = 0; i < data.length; i++) {                          
                        $("#S1").append("<option value=" + data[i].id + ">" + data[i].name + "</option>");
                    }
                }
            });
        };
 function select2() {
    $("#S2").html("");
    $.ajax(
    {
        type: "post",
        url: contextPath+"/region/getAreaClidrenData.do",
        data: {"parentId":$('#S1').val()},
        success: function (msg) {
         var data=eval(msg);
             for (var i = 0; i < data.length; i++) {            
                   $("#S2").append("<option value=" + data[i].id + ">" + data[i].name + "</option>");
              }
              select3();
        }
    });
};

function select3() {
            $("#S3").html("");
            $.ajax(
            {
                type: "post",
                url: contextPath+"/region/getAreaClidrenData.do",
                data: {"parentId":$('#S2').val()},
                success: function (msg) {
                   var data=eval(msg);
                    for (var i = 0; i < data.length; i++) {                       
                        $("#S3").append("<option value=" + data[i].id + ">" + data[i].name + "</option>");
                    }
                }
            });
        };
</script>
  </head>
  
  <body>
   <div class="container member">
  <div class="row">
   <div class="span10">
				<div class="input">
					<div class="title">编辑收货地址</div>
					<form id="inputForm" action="<%=path%>/shipAddress/update.do" method="post">
						<input type="hidden" name="id" value="${address.id}" />
						<table class="input">
						
							<tr>
								<th>
									收货人:
								</th>
								<td>
									<input type="text" name="contacts" class="text" value="${address.contacts}" maxlength="200" />
								</td>
							</tr>
							 <tr>
								<th>
									地区:
								</th>
								<td>
							
									<span class="fieldSet">
										<!--
										<input type="hidden" id="areaId" name="areaId" value="20" treePath=",18," />
										-->
										
										<select id="S1" name="province_id" onchange="select2();">
										  <option value="${province.id}">${province.name}</option>
									     </select>
									     <select id="S2" name="city_id" onchange="select3();">
									      <option value="${city.id}">${city.name}</option>
									     </select>
									    <select id="S3" name="district_id" >
									     <option value="${district.id}">${district.name}</option>
									    </select>
									</span>
									
									 
								</td>
							</tr> 
							<tr>
								<th>
									地址:
								</th>
								<td>
									<input type="text" name="address" class="text" value="${address.address}" maxlength="200" />
								</td>
							</tr>
							<tr>
								<th>
									邮编:
								</th>
								<td>
									<input type="text" name="zipcode" class="text" value="${address.zipcode}" maxlength="200" />
								</td>
							</tr>
							<tr>
								<th>
									电话:
								</th>
								<td>
									<input type="text" name="mobile" class="text" value="${address.mobile}" maxlength="200" />
								</td>
							</tr>
							<tr>
								<th>
									是否默认:
								</th>
								<td>
								   <c:choose>
								     <c:when test="${address.isdefault==1}">
								     	<input type="checkbox" name="isdefault" value="1" checked="checked" />
										<input type="hidden" name="_isdefault" value="0" />
								     </c:when>
								     <c:otherwise>
								     	<input type="checkbox" name="isDefault" value="1"/>
										<input type="hidden" name="_isDefault" value="0" />
								     </c:otherwise>
								   </c:choose>
									
								</td>
							</tr>
							<tr>
								<th>
									&nbsp;
								</th>
								<td>
									<input type="submit" class="button" value="提 交" />
									<input type="button" class="button" value="返 回" onclick="history.back(); return false;" />
								</td>
							</tr>
						</table>
					</form>
				</div>
			</div>
</div>
</div>
  </body>
</html>
