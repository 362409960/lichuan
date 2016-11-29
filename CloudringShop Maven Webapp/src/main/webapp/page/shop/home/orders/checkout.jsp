<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="/WEB-INF/tlds/c.tld" prefix="c"%>
<%@page import="cloud.shop.common.Constants" %>
<%@page import="cloud.shop.goods.entity.Customer" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>订单结算 </title>
<meta name="author" content="Team" />
<meta name="copyright" content="" />
<link href="../css/shop/common.css" rel="stylesheet" type="text/css" />
<link href="../css/shop/order.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="../js/jquery.min.js"></script>
<script type="text/javascript" src="../js/shop/jquery.lSelect.js"></script>
<script type="text/javascript" src="../js/shop/jquery.validate.js"></script>
<script type="text/javascript" src="../js/shop/common.js"></script>
<script type="text/javascript">
var contextPath = "${pageContext.request.contextPath}";
$().ready(function() {

	var $dialogOverlay = $("#dialogOverlay");
	var $receiverForm = $("#receiverForm");
	var $receiverItem = $("#receiver ul");
	var $otherReceiverButton = $("#otherReceiverButton");
	var $newReceiverButton = $("#newReceiverButton");
	var $newReceiver = $("#newReceiver");
	
	var $newReceiverSubmit = $("#newReceiverSubmit");
	var $newReceiverCancelButton = $("#newReceiverCancelButton");
	var $orderForm = $("#orderForm");
	var $receiverId = $("#receiverId");
	
	var $paymentMethodId = $("#paymentMethod input:radio");
	var $shippingMethodId = $("#shippingMethod input:radio");
	var $isInvoice = $("#isInvoice");
	var $invoiceTitle = $("#invoiceTitle");

	var $submit = $("#submit");
	var amountPayable="${total}";
	var paymentMethodIds = {};
     paymentMethodIds["1"] = [ "1", "2" ];
     paymentMethodIds["2"] = [ "1", "2", "3" ];	
     
     
     var isTrue="${isTrue}"; 
     select4();   
     if(isTrue==false)
     {
       $dialogOverlay.show();
     }
		// 收货地址
		$receiverItem.on("click", "li", function() {
			var $this = $(this);
			$receiverId.val($this.attr("receiverId"));
			$this.addClass("selected").siblings().removeClass("selected");
			//calculate();
		});
		
		// 其它收货地址
		$otherReceiverButton.click(function() {
			$receiverItem.height("auto");
			$otherReceiverButton.hide();
			$newReceiverButton.removeClass("hidden");
		});
		
		// 新收货地址
		$newReceiverButton.click(function() {
		     select1();
			$receiverItem.height("auto");
			$receiverForm.find("input:text").val("");
			$dialogOverlay.show();
			$newReceiver.show();
		});
		
		// 新收货地址取消
		$newReceiverCancelButton.click(function() {
			if ($receiverId.val() == "") {
				$.message("warn", "必须新增一个收货地址");
				return false;
			}
			$dialogOverlay.hide();
			$newReceiver.hide();
		});
	
	
	// 支付方式
	$paymentMethodId.click(function() {
		var $this = $(this);
		if ($this.prop("disabled")) {
			return false;
		}
		$this.closest("dd").addClass("selected").siblings().removeClass("selected");
		var paymentMethodId = $this.val();
		$shippingMethodId.each(function() {
			var $this = $(this);
			if ($.inArray(paymentMethodId, paymentMethodIds[$this.val()]) >= 0) {
				$this.prop("disabled", false);
			} else {
				$this.prop("disabled", true).prop("checked", false).closest("dd").removeClass("selected");
			}
		});
		//calculate();
	});
	
		// 配送方式
		$shippingMethodId.click(function() {
			var $this = $(this);
			if ($this.prop("disabled")) {
				return false;
			}
			$this.closest("dd").addClass("selected").siblings().removeClass("selected");
			var shippingMethodId = $this.val();
			$paymentMethodId.each(function() {
				var $this = $(this);
				if ($.inArray($this.val(), paymentMethodIds[shippingMethodId]) >= 0) {
					$this.prop("disabled", false);
				} else {
					$this.prop("disabled", true).prop("checked", false).closest("dd").removeClass("selected");
				}
			});
			//calculate();
		});
	

	// 订单提交
	$submit.click(function() {
		if (amountPayable > 0) {
			if ($paymentMethodId.filter(":checked").size() <= 0) {
				$.message("warn", "请选择支付方式");
				return false;
			}
		} else {
			$paymentMethodId.prop("disabled", true);
		}
			if ($shippingMethodId.filter(":checked").size() <= 0) {
				$.message("warn", "请选择配送方式");
				return false;
			}
			if ($isInvoice.prop("checked") && $.trim($invoiceTitle.val()) == "") {
				$.message("warn", "请填写发票抬头");
				return false;
			}
			var url=contextPath+"/orders/payment.do";
			var rurl=contextPath+"/orders/view.do";
		$.ajax({
			url: contextPath+"/orders/save.do",
			type: "POST",
			data: $orderForm.serialize(),
			dataType: "json",
			cache: false,
			beforeSend: function() {
				$submit.prop("disabled", true);
			},
			success: function(msg) {
			      var data=eval(msg);			     
				if (data[2]== true) {
					location.href = amountPayable > 0 ? url+"?sn=" + data[1] : rurl+"?sn=" + data[1];
				} else {
					 alert("订单提交失败。");
					setTimeout(function() {
						location.reload(true);
					}, 3000);
				}
			},
			complete: function() {
				$submit.prop("disabled", false);
			}
		});
	});
	
		// 收货地址表单验证
		$receiverForm.validate({
			rules: {
				contacts: "required",
				province_id: "required",
				city_id: "required",
				district_id: "required",
				address: "required",
				zipcode: {
					required: true,
					pattern: /^\d{6}$/
				},
				mobile: {
					required: true,
					pattern: /^\d{3,4}-?\d{7,9}$/
				}
			},
			submitHandler: function(form) {
				$.ajax({
					url: contextPath+"/shipAddress/saveJson.do",
					type: "POST",
					data: $receiverForm.serialize(),
					dataType: "json",
					cache: false,
					beforeSend: function() {
						$newReceiverSubmit.prop("disabled", true);
					},
					success: function(msg) {
					    var data=eval(msg); 
						if (data != null) {							  			
							$receiverId.val(data[0].id);														
							$receiverItem.show();
							$('<li class="selected" receiverId="' + data[0].id + '"> <span> <strong>' + escapeHtml(data[0].contacts) + '<\/strong> 收 <\/span> <span>' + escapeHtml(data[0].province_id+data[0].city_id+data[0].district_id + data[0].address) + '<\/span> <span>' + escapeHtml(data[0].mobile) + '<\/span> <\/li>'	).appendTo($receiverItem).siblings().removeClass("selected");
							$dialogOverlay.hide();
							$newReceiver.hide();
							//calculate();
						} else {
							alert("出现不可预料的错误");
						}
					},
					complete: function() {
						$newReceiverSubmit.prop("disabled", false);
					}
				});
			}
		});

});
function select4() {
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
                    select2();
                }
            });
        };
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
                    select2();
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
<%
    Customer sysUserVO = null;
	String userName = "";
    Object obj = session.getAttribute(Constants.SESSION_LOGIN_USER_GOODS);
    if(obj != null){
    	sysUserVO = (Customer)obj;
    	userName = sysUserVO.getName();    	
    }
%>
<body>
	<div id="dialogOverlay" class="dialogOverlay"></div>
<script type="text/javascript">
$().ready(function() {

	var $headerName = $("#headerName");
	var $headerLogin = $("#headerLogin");
	var $headerRegister = $("#headerRegister");
	var $headerLogout = $("#headerLogout");
	var $goodsSearchForm = $("#goodsSearchForm");
	var $keyword = $("#goodsSearchForm input");
	var defaultKeyword = "商品搜索";
	
	var username = '<%=userName%>';	
	var nickname = getCookie("nickname");
	if ($.trim(nickname) != "") {
		$headerName.text(nickname).show();
		$headerLogout.show();
	} else if ($.trim(username) != "") {
		$headerName.text(username).show();
		$headerLogout.show();
	} else {
		$headerLogin.show();
		$headerRegister.show();
	}
	
	$keyword.focus(function() {
		if ($.trim($keyword.val()) == defaultKeyword) {
			$keyword.val("");
		}
	});
	
	$keyword.blur(function() {
		if ($.trim($keyword.val()) == "") {
			$keyword.val(defaultKeyword);
		}
	});
	
	$goodsSearchForm.submit(function() {
		if ($.trim($keyword.val()) == "" || $keyword.val() == defaultKeyword) {
			return false;
		}
	});

});
</script>
<div class="header">
	<div class="top">
		<div class="topNav">
			<ul class="left">
				<li>
					<span>您好，欢迎来到Cloudring商城</span>
					<span id="headerName" class="headerName">&nbsp;</span>
				</li>
				<li id="headerLogin" class="headerLogin">
					<a href="<%=path %>/home/tologin.do">登录</a>|
				</li>
				<li id="headerRegister" class="headerRegister">
					<a href="<%=path %>/register/showShopRegister.do">注册</a>
				</li>
				<li id="headerLogout" class="headerLogout">
					<a href="<%=path %>/login/loginout.do">[退出]</a>
				</li>
			</ul>
			<ul class="right">
						<li>
						    <% if("".equals(userName))
						    {%>
						    <a href="<%=path %>/home/tologin.do">会员中心</a>|
						   <% }else{%>
						     <a href="<%=path %>/member/showCentre.do">会员中心</a>|
						  <% }%>
						</li>
						<li>
							<a href="">帮助中心</a>|
						</li>
				<li id="headerCart" class="headerCart">
					<a href="<%=path %>/cart/showShopCart.do">购物车</a>
					(<em></em>)
				</li>
			</ul>
		</div>
	</div>
	<div class="container">
		<div class="row">
			<div class="span3">
				<a href="http://www.cloudring.net">
					<img src="<%=path %>/images/logo_shop.png" alt="Cloudring" />
				</a>
			</div>
			<div class="span6">
				<div class="search" >
					<form id="goodsSearchForm" action="<%=path %>/home/showShopInquiry.do" method="get">
						<input name="keyword" class="keyword" value="商品搜索" autocomplete="off" x-webkit-speech="x-webkit-speech" x-webkit-grammar="builtin:search" maxlength="30" />
						<button type="submit">&nbsp;</button>
					</form>
				</div>
				<div class="hotSearch">
						<!-- 热门搜索:
							<a href="#">苹果</a>
							<a href="#">三星</a>	 -->						
				</div>
			</div>
			<div class="span3">
				<div class="phone">
					<em>服务电话</em>
					800-8888888
				</div>
			</div>
		</div>
		<div class="row">
			<div class="span12">
				<dl class="mainNav">
					<dt>
						<a href="<%=path%>/home/showShopProductcategory.do">所有商品分类</a>
					</dt>
							<dd>
								<a href="<%=path %>/home/showShopIndex.do">首页</a>
							</dd>
							<c:forEach items="${menu}" var="menu">
							<dd>
								<a href="<%=path %>/home/showShopHomeSecurity.do?type=1&skipName=${menu.key}">${menu.value}</a>
							</dd>
							</c:forEach>
				</dl>
			</div>
		</div>
	</div>
</div>
	<div class="container checkout">
		<div class="row">
			<div class="span12">
				<div class="step">
					<ul>
						<li>查看购物车</li>
						<li class="current">订单结算</li>
						<li>订单完成</li>
					</ul>
				</div>
					<form id="receiverForm" action="<%=path %>/shipAddress/saveJson.do" method="post">
						<div id="receiver" class="receiver">
							<div class="title">收货地址</div>
							<c:choose>
						  <c:when test="${isTrue=='false'}"><ul class="clearfix hidden"></ul></c:when>
						  <c:otherwise> 
						  <ul class="clearfix">	
							       <c:forEach items="${aList}" var="it" varStatus="st">
								        <c:choose>
								             <c:when test="${st.first}">
								             	<li class="selected" receiverId="${it.id}">
								             </c:when>
								             <c:otherwise><li  receiverId="${it.id}"></c:otherwise>
								          </c:choose>
											<span>
												<strong>${it.contacts}</strong>
												收
											</span>
											<span>${it.province_id}${it.city_id}${it.district_id}${it.address}</span>
											<span>${it.mobile}</span> 
										</li>
								</c:forEach>
							</ul>
						  </c:otherwise>
						</c:choose>
						<div>
							<a href="javascript:;" id="newReceiverButton" class="button">使用新地址</a>
						</div>
						</div>
						<c:choose>
						  <c:when test="${isTrue=='false'}"><div id="newReceiver" class="newReceiver"></c:when>
						  <c:otherwise> <div id="newReceiver" class="newReceiver hidden"></c:otherwise>
						</c:choose>
				
							<table>
								<tr>
									<th width="100">
										<span class="requiredField">*</span>收货人:
									</th>
									<td>
										<input type="text" id="contacts" name="contacts" class="text" maxlength="200" />
									</td>
								</tr>
								<tr>
									<th>
										<span class="requiredField">*</span>地区:
									</th>
									<td>
										<span class="fieldSet">
											 <select id="S1" name="province_id" onchange="select2();">
										  <option value="">请选择</option>
									     </select>
									     <select id="S2" name="city_id" onchange="select3();">
									      <option value="">请选择</option>
									     </select>
									    <select id="S3" name="district_id" >
									    <option value="">请选择</option> 
									    </select>
										</span>
									</td>
								</tr>
								<tr>
									<th>
										<span class="requiredField">*</span>地址:
									</th>
									<td>
										<input type="text" id="address" name="address" class="text" maxlength="200" />
									</td>
								</tr>
								<tr>
									<th>
										<span class="requiredField">*</span>邮编:
									</th>
									<td>
										<input type="text" id="zipcode" name="zipcode" class="text" maxlength="200" />
									</td>
								</tr>
								<tr>
									<th>
										<span class="requiredField">*</span>电话:
									</th>
									<td>
										<input type="text" id="mobile" name="mobile" class="text" maxlength="200" />
									</td>
								</tr>
								<tr>
									<th>
										是否默认:
									</th>
									<td>
										<input type="checkbox" name="isdefault" value="1" />
										<input type="hidden" name="_isdefault" value="0" />
									</td>
								</tr>
								<tr>
									<th>
										&nbsp;
									</th>
									<td>
										<input type="submit" id="newReceiverSubmit" class="button" value="确 定" />
										<input type="button" id="newReceiverCancelButton" class="button" value="取 消" />
									</td>
								</tr>
							</table>
						</div>
					</form>
				</div>
			</div>
		<form id="orderForm" action="<%=path %>/orders/save.do" method="post">
			<div class="row">
				<div class="span12">
				   <c:choose>
					  <c:when test="${isTrue=='true'}"><input type="hidden" id="receiverId" name="receiver_id" value="${ress.id}"/></c:when>
					  <c:otherwise> <input type="hidden" id="receiverId" name="receiver_id" /></c:otherwise>
					</c:choose>
					
					<dl id="paymentMethod" class="select">
						<dt>支付方式</dt>
							<dd>
								<label for="paymentMethod_1">
									<input type="radio" id="paymentMethod_1" name="pay_by" value="1" />
									<span>
											<em style="border-right: none; background: url(../images/icon/alipay.gif) center no-repeat;">&nbsp;</em>
										<strong>网上支付</strong>
									</span>
									<span>支持支付宝、财付通、快钱以及大多数网上银行支付</span>
								</label>
							</dd>
							<!-- <dd>
								<label for="paymentMethod_2">
									<input type="radio" id="paymentMethod_2" name="pay_by" value="2" />
									<span>
											<em style="border-right: none; background: url(../images/icon/bank.gif) center no-repeat;">&nbsp;</em>
										<strong>银行汇款</strong>
									</span>
									<span>支持工商银行、建设银行、农业银行汇款支付，收款时间一般为汇款后的1-2个工作日</span>
								</label>
							</dd>
							<dd>
								<label for="paymentMethod_3">
									<input type="radio" id="paymentMethod_3" name="pay_by" value="3" />
									<span>
											<em style="border-right: none; background: url(../images/icon/transfer.gif) center no-repeat;">&nbsp;</em>
										<strong>货到付款</strong>
									</span>
									<span>由快递公司送货上门，您签收后直接将货款交付给快递员</span>
								</label>
							</dd> -->
					</dl>
						<dl id="shippingMethod" class="select">
							<dt>配送方式</dt>
								<dd>
									<label for="shippingMethod_1">
										<input type="radio" id="shippingMethod_1" name="delivery_method" value="1" />
										<span>
												<em style="border-right: none; background: url(../images/icon/general.gif) center no-repeat;">&nbsp;</em>
											<strong>普通快递</strong>
										</span>
										<span>系统将根据您的收货地址自动匹配快递公司进行配送，享受免运费服务</span>
									</label>
								</dd>
								<!-- <dd>
									<label for="shippingMethod_2">
										<input type="radio" id="shippingMethod_2" name="delivery_method" value="2" />
										<span>
												<em style="border-right: none; background: url(../images/icon/shunf.gif) center no-repeat;">&nbsp;</em>
											<strong>顺丰速运</strong>
										</span>
										<span>支持货到付款，不享受免运费服务</span>
									</label>
								</dd> -->
						</dl>
						
					<table class="product">
						<tr>
							<th width="60">图片</th>
							<th>商品</th>
							<th>价格</th>
							<th>数量</th>
							<th>小计</th>
						</tr>
						  <c:forEach items="${cartList}" var="list"> 
							<tr>
								<td>
									<img src="${list.goods_url}" alt="${list.picture}" />
								</td>
								<td>
									${list.picture}
								</td>
								<td>
										￥${list.price}
								</td>
								<td>
									${list.quantity}
								</td>
								<td>
										￥${list.subtotal}
								</td>
							</tr>
							</c:forEach>
					</table>
				</div>
			</div>
			<div class="row">
				<div class="span6">
					<dl class="memo">
						<dt>附言:</dt>
						<dd>
							<input type="text" name="memo" maxlength="200" />
						</dd>
					</dl>
						
				</div>
				<div class="span6">
					<ul class="statistic">
					
						<li>
							<span>
								订单金额: <strong id="amounts_payable">￥${total}元</strong>
								<input type="hidden" id="amounts_payable" name="amounts_payable" value="${total}"/>
							</span>
						</li>
					</ul>
				</div>
			</div>
			<div class="row">
				<div class="span12">
					<div class="bottom">
						<a href="<%=path %>/cart/showShopCart.do" class="back">返回购物车</a>
						<a href="javascript:;" id="submit" class="submit">提交订单</a>
					</div>
				</div>
			</div>
		</form>
	</div>

<jsp:include page="/page/shop/home/foot.jsp" />
</body>
</html>
