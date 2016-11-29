<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>管理中心——Cloudring Shop</title>
<meta content="Cloudring" name="author">
<meta content="Cloudring" name="copyright">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/deafult/common.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/deafult/main.css">
<script type="text/javascript" src="<%=path%>/js/jquery.min.js"></script>
<script type="text/javascript" src="<%=path%>/js/browser.js"></script>
<script type="text/javascript" src="<%=path%>/js/jquery.validate.js"></script>
<script type="text/javascript" src="<%=path%>/js/jquery.autocomplete.js"></script>
<script>var contextPath = "${pageContext.request.contextPath}";</script>
<script type="text/javascript">
$().ready(function() {

	var $inputForm = $("#inputForm");
	var $productId = $("#productId");	
	var $sn = $("#product_no");
	var $name = $("#product_name");
	var $stock = $("#stock");
	var $allocatedStock = $("#lock_stock");
	var $quantity = $("#outQuantity");
	var stock = null;
	
	var product=contextPath+"/admin/invManag/search.do";
	// 商品选择
	$("#productSelect").autocomplete(product, {	  
		dataType: "json",		
		max: 20,
		extraParams:{name:function(){return $('#productSelect').val();},type:"0"},
		width: 218,
		scrollHeight: 300,
		parse: function(data) {
			return $.map(data, function(item) {
				return {
					data: item,
					value: item.product_name
				}
			});
		},
		formatItem: function(item) {
			return '<span title="' + escapeHtml(item.product_name) + '">' + escapeHtml(abbreviate(item.product_name, 50, "...")) + '<\/span>' ;
		}
	}).result(function(event, item, formatted) {	       
		$productId.val(item.productId);
		$("#sn").val(item.product_no);
		$("#name").val(item.product_name);
		$("#stock1").val(item.stock);
		$("#lock_stock1").val(item.lock_stock);
		$sn.text(item.product_no).closest("tr").show();
		$name.text(item.product_name).closest("tr").show();		
		$stock.text(item.stock).closest("tr").show();
		$allocatedStock.text(item.lock_stock).closest("tr").show();  
	});
		
	// 表单验证
	$inputForm.validate({
		rules: {
			quantity: {
				required: true,
				integer: true,
				min: 1
			}
		},
		submitHandler: function(form) {
			if ($productId.val() == "") {
			
				alert("请选择商品");
				return false;
			}
			var quantity = parseInt($quantity.val());
			if (stock != null && stock - quantity < 0) {
				
				alert("当前库存不足");
				return false;
			}
			$(form).find("input:submit").prop("disabled", true);
			form.submit();
		}
	});


});
function escapeHtml(str) {
	return str.replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;').replace(/"/g, '&quot;');
}
function abbreviate(str, width, ellipsis) {
	if ($.trim(str) == "" || width == null) {
		return str;
	}
	var i = 0;
	for (var strWidth = 0; i < str.length; i++) {
		strWidth = /^[\u4e00-\u9fa5\ufe30-\uffa0]$/.test(str.charAt(i)) ? strWidth + 2 : strWidth + 1;
		if (strWidth >= width) {
			break;
		}
	}
	return ellipsis != null && i < str.length - 1 ? str.substring(0, i) + ellipsis : str.substring(0, i);
}
</script>
</head>
<body>
	<div class="breadcrumb">
		<a href="<%=path%>/index.jsp">首页</a> &raquo; 出库
	</div>
	<form id="inputForm" action="<%=path%>/admin/invManag/save_out.do" method="post">
		<input type="hidden" id="productId" name="productId" value="" />
		<input type="hidden" id="sn" name="product_no" value="" />
		<input type="hidden" id="name" name="product_name" value="" />
		<input type="hidden" id="stock1" name="stock" value="" />
		<input type="hidden" id="lock_stock1" name="lock_stock" value="" />
		<table class="input">
			<tr>
				<th>
					商品选择:
				</th>
				<td>
					<input type="text" id="productSelect" name="productSelect" class="text" maxlength="200" title="请输入名称查找商品" />
				</td>
			</tr>
			<tr class="hidden">
				<th>
					编号:
				</th>
				<td id="product_no">
					
				</td>
			</tr>
			<tr class="hidden">
				<th>
					名称:
				</th>
				<td id="product_name">
					
				</td>
			</tr>
			<tr class="hidden">
				<th>
					库存:
				</th>
				<td id="stock">
					
				</td>
			</tr>
			<tr class="hidden">
				<th>
					已分配库存:
				</th>
				<td id="lock_stock">
					
				</td>
			</tr>
			<tr>
				<th>
					<span class="requiredField">*</span>数量:
				</th>
				<td>
					<input type="text" id="outQuantity" name="outQuantity" class="text" maxlength="16" />
				</td>
			</tr>
			<tr>
				<th>
					备注:
				</th>
				<td>
					<input type="text" name="remark" class="text" maxlength="200" />
				</td>
			</tr>
			<tr>
				<th>
					&nbsp;
				</th>
				<td>
					<input type="submit" class="button" value="确 定" />
					<input type="button" class="button" value="返 回" onclick="history.back(); return false;" />
				</td>
			</tr>
		</table>
	</form>
</body>
</html>


