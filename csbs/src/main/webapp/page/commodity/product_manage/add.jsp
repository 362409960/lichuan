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
<title>管理中心——Cloudring Shop</title>
<meta content="Cloudring" name="author">
<meta content="Cloudring" name="copyright">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/deafult/common.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/deafult/main.css">
<script type="text/javascript" src="<%=path%>/js/jquery.min.js"></script>
<script type="text/javascript" src="<%=path%>/js/jquery-tab.js"></script>
<script type="text/javascript" src="<%=path%>/js/jquery.validate.js"></script>
<script type="text/javascript" src="<%=path%>/ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="<%=path%>/js/dialog.js"></script>
<script type="text/javascript">
$().ready(function() {

	var $inputForm = $("#inputForm");
	var $isDefault = $("#isDefault");
	var $productCategoryId = $("#productcategory_id");
	var $price = $("#price");
	var $cost = $("#cost");
	var $marketPrice = $("#marketPrice");	
	var $rewardPoint = $("#rewardPoint");
	var $exchangePoint = $("#exchangePoint");
	var $stock = $("#stock");	
	var $productImageTable = $("#productImageTable");
	var $addProductImage = $("#addProductImage");
	var $parameterTable = $("#parameterTable");
	var $addParameter = $("#addParameter");
	var $resetParameter = $("#resetParameter");
	var $attributeTable = $("#attributeTable");
	var $specificationTable = $("#specificationTable");
	var $resetSpecification = $("#resetSpecification");
	var $productTable = $("#productTable");	
	var productImageIndex = 0;
	var parameterIndex = 0;
	var specificationItemEntryId = 0;
	var hasSpecification = false;

	
	
	loadSpecification();
	
	
	// 商品分类
	$productCategoryId.change(function() {
		if ($attributeTable.find("select[value!='']").size() > 0) {
			if ($parameterTable.find("input.parameterEntryValue[value!='']").size() == 0) {
						loadParameter();
					}
					loadAttribute();
					if ($productTable.find("input:text[value!='']").size() == 0) {
						loadSpecification();
					}
					previousProductCategoryId = $productCategoryId.val();
		} else {
			if ($parameterTable.find("input.parameterEntryValue[value!='']").size() == 0) {
				loadParameter();
			}
			loadAttribute();
			if ($productTable.find("input:text[value!='']").size() == 0) {
				loadSpecification();
			}
			previousProductCategoryId = $productCategoryId.val();
		}
	});
	
	// 修改视图
	function changeView() {
		if (hasSpecification) {
			$isDefault.prop("disabled", true);
			$price.add($cost).add($marketPrice).add($rewardPoint).add($exchangePoint).add($stock).prop("disabled", true).closest("tr").hide();
		} else {
			$isDefault.prop("disabled", false);
			$price.add($cost).add($marketPrice).add($rewardPoint).add($exchangePoint).add($stock).prop("disabled", false).closest("tr").show();
		}
	}
	
	$addProductImage.click(function() {
		$productImageTable.append(
		'<tr> <td> <input type="file" name="productImages[' + productImageIndex + '].file" class="productImageFile" \/> <\/td> <td> <input type="text" name="productImages[' + productImageIndex + '].file_name" class="text" maxlength="200" \/> <\/td> <td> <input type="text" name="productImages[' + productImageIndex + '].order_value" class="text productImageOrder" maxlength="9" style="width: 50px;" \/> <\/td> <td> <a href="javascript:;" class="remove">[删除]<\/a> <\/td> <\/tr>'		);
		productImageIndex ++;
	});

	
	// 删除商品图片
	$productImageTable.on("click", "a.remove", function() {
		$(this).closest("tr").remove();
	});
	
	// 增加参数
	$addParameter.click(function() {
		$(
		'<tr> <td colspan="2"> <table> <tr> <th> 参数组: <\/th> <td> <input type="text" name="parameterValues[' + parameterIndex + '].group" class="text parameterGroup" maxlength="200" \/> <\/td> <td> <a href="javascript:;" class="remove group">[删除]<\/a> <a href="javascript:;" class="add">[添加]<\/a> <\/td> <\/tr> <tr> <th> <input type="text" name="parameterValues[' + parameterIndex + '].entries[0].name" class="text parameterEntryName" maxlength="200" style="width: 50px;" \/> <\/th> <td> <input type="text" name="parameterValues[' + parameterIndex + '].entries[0].value" class="text parameterEntryValue" maxlength="200" \/> <\/td> <td> <a href="javascript:;" class="remove">[删除]<\/a> <\/td> <\/tr> <\/table> <\/td> <\/tr>'		).appendTo($parameterTable).find("table").data("parameterIndex", parameterIndex).data("parameterEntryIndex", 1);
		parameterIndex ++;
	});
	
	// 重置参数
	$resetParameter.click(function() {
		loadParameter();
	});
	
	// 删除参数
	$parameterTable.on("click", "a.remove", function() {
		var $this = $(this);
		if ($this.hasClass("group")) {
			$this.closest("table").closest("tr").remove();
		} else {
			if ($this.closest("table").find("tr").size() <= 2) {
				//$.message("warn", "删除失败，必须至少保留一项");
				alert("删除失败，必须至少保留一项");
				return false;
			}
			$this.closest("tr").remove();
		}
	});
	
	// 增加参数
	$parameterTable.on("click", "a.add", function() {
		var $table = $(this).closest("table");
		var parameterIndex = $table.data("parameterIndex");
		var parameterEntryIndex = $table.data("parameterEntryIndex");
		$table.append(
'<tr> <th> <input type="text" name="parameterValues[' + parameterIndex + '].entries[' + parameterEntryIndex + '].name" class="text parameterEntryName" maxlength="200" style="width: 50px;" \/> <\/th> <td> <input type="text" name="parameterValues[' + parameterIndex + '].entries[' + parameterEntryIndex + '].value" class="text parameterEntryValue" maxlength="200" \/> <\/td> <td> <a href="javascript:;" class="remove">[删除]<\/a> <\/td> <\/tr>'		);
		$table.data("parameterEntryIndex", parameterEntryIndex + 1);
	});
	
	// 加载参数
	function loadParameter() {
		$.ajax({
			url: "parameters.jhtml",
			type: "GET",
			data: {productCategoryId: $productCategoryId.val()},
			dataType: "json",
			success: function(data) {
				parameterIndex = 0;
				$parameterTable.find("tr:gt(0)").remove();
				$.each(data, function(i, parameter) {
					var $parameterGroupTable = $(
'<tr> <td colspan="2"> <table> <tr> <th> 参数组: <\/th> <td> <input type="text" name="parameterValues[' + parameterIndex + '].group" class="text parameterGroup" value="' + escapeHtml(parameter.group) + '" maxlength="200" \/> <\/td> <td> <a href="javascript:;" class="remove group">[删除]<\/a> <a href="javascript:;" class="add">[添加]<\/a> <\/td> <\/tr> <\/table> <\/td> <\/tr>'					).appendTo($parameterTable).find("table").data("parameterIndex", parameterIndex);
					
					var parameterEntryIndex = 0;
					$.each(parameter.names, function(i, name) {
						$parameterGroupTable.append(
'<tr> <th> <input type="text" name="parameterValues[' + parameterIndex + '].entries[' + parameterEntryIndex + '].name" class="text parameterEntryName" value="' + escapeHtml(name) + '" maxlength="200" style="width: 50px;" \/> <\/th> <td> <input type="text" name="parameterValues[' + parameterIndex + '].entries[' + parameterEntryIndex + '].value" class="text parameterEntryValue" maxlength="200" \/> <\/td> <td> <a href="javascript:;" class="remove">[删除]<\/a> <\/td> <\/tr>'						);
						parameterEntryIndex ++;
					});
					$parameterGroupTable.data("parameterEntryIndex", parameterEntryIndex);
					parameterIndex ++;
				});
			}
		});
	}
	
	// 加载属性
	function loadAttribute() {
		$.ajax({
			url: "attributes.jhtml",
			type: "GET",
			data: {productCategoryId: $productCategoryId.val()},
			dataType: "json",
			success: function(data) {
				$attributeTable.empty();
				$.each(data, function(i, attribute) {
					var $select = $(
'<tr> <th>' + escapeHtml(attribute.name) + ':<\/th> <td> <select name="attribute_' + attribute.id + '"> <option value="">请选择...<\/option> <\/select> <\/td> <\/tr>'					).appendTo($attributeTable).find("select");
					$.each(attribute.options, function(j, option) {
						$select.append('<option value="' + escapeHtml(option) + '">' + escapeHtml(option) + '<\/option>');
					});
				});
			}
		});
	}
	
	// 重置规格
	$resetSpecification.click(function() {
	      hasSpecification = false;
				changeView();
				loadSpecification();
	});
	
	// 选择规格
	$specificationTable.on("change", "input:checkbox", function() {
		if ($specificationTable.find("input:checkbox:checked").size() > 0) {
			hasSpecification = true;
		} else {
			hasSpecification = false;
		}
		changeView();
		buildProductTable();
	});
	
	// 规格
	$specificationTable.on("change", "input:text", function() {
		var $this = $(this);
		var value = $.trim($this.val());
		if (value == "") {
			$this.val($this.data("value"));
			return false;
		}
		if ($this.hasClass("specificationItemEntryValue")) {
			var values = $this.closest("tr").find("input.specificationItemEntryValue").not($this).map(function() {
				return $.trim($(this).val());
			}).get();
			if ($.inArray(value, values) >= 0) {
				$.message("warn", "规格值不允许重复");
				$this.val($this.data("value"));
				return false;
			}
		}
		$this.data("value", value);
		buildProductTable();
	});
	
	// 是否默认
	$productTable.on("change", "input.isDefault", function() {
		var $this = $(this);
		if ($this.prop("checked")) {
			$productTable.find("input.isDefault").not($this).prop("checked", false);
		} else {
			$this.prop("checked", true);
		}
	});
	
	// 是否启用
	$productTable.on("change", "input.isEnabled", function() {
		var $this = $(this);
		if ($this.prop("checked")) {
			$this.closest("tr").find("input:not(.isEnabled)").prop("disabled", false);
		} else {
			$this.closest("tr").find("input:not(.isEnabled)").prop("disabled", true).end().find("input.isDefault").prop("checked", false);
		}
		if ($productTable.find("input.isDefault:not(:disabled):checked").size() == 0) {
			$productTable.find("input.isDefault:not(:disabled):first").prop("checked", true);
		}
	});
	
	// 生成商品表
	function buildProductTable() {
		var type = $type.val();
		var productValues = {};
		var specificationItems = [];
		if (!hasSpecification) {
			$productTable.empty()
			return false;
		}
		$specificationTable.find("tr:gt(0)").each(function() {
			var $this = $(this);
			var $checked = $this.find("input:checkbox:checked");
			if ($checked.size() > 0) {
				var specificationItem = {};
				specificationItem.name = $this.find("input.specificationItemName").val();
				specificationItem.entries = $checked.map(function() {
					return {
						id: $(this).siblings("input.specificationItemEntryId").val(),
						value: $(this).siblings("input.specificationItemEntryValue").val()
					};
				}).get();
				specificationItems.push(specificationItem);
			}
		});
		var products = cartesianProductOf($.map(specificationItems, function(specificationItem) {
			return [specificationItem.entries];
		}));
		$productTable.find("tr:gt(0)").each(function() {
			var $this = $(this);
			productValues[$this.data("ids")] = {
				price: $this.find("input.price").val(),
				cost: $this.find("input.cost").val(),
				marketPrice: $this.find("input.marketPrice").val(),
				rewardPoint: $this.find("input.rewardPoint").val(),
				exchangePoint: $this.find("input.exchangePoint").val(),
				stock: $this.find("input.stock").val(),
				isDefault: $this.find("input.isDefault").prop("checked"),
				isEnabled: $this.find("input.isEnabled").prop("checked")
			};
		});
		$titleTr = $('<tr><\/tr>').appendTo($productTable.empty());
		$.each(specificationItems, function(i, specificationItem) {
			$titleTr.append('<th>' + escapeHtml(specificationItem.name) + '<\/th>');
		});
		$titleTr.append(
(type == "general" ? '<th>销售价<\/th>' : '') + ' <th> 成本价 <\/th> <th> 市场价 <\/th> ' + (type == "general" ? '<th>赠送积分<\/th>' : '') + (type == "exchange" ? '<th>兑换积分<\/th>' : '') + ' <th> 库存 <\/th> <th> 是否默认 <\/th> <th> 是否启用 <\/th>'		);
		$.each(products, function(i, entries) {
			var ids = [];
			$productTr = $('<tr><\/tr>').appendTo($productTable);
			$.each(entries, function(j, entry) {
				$productTr.append(
'<td> ' + escapeHtml(entry.value) + ' <input type="hidden" name="productList[' + i + '].specificationValues[' + j + '].id" value="' + entry.id + '" \/> <input type="hidden" name="productList[' + i + '].specificationValues[' + j + '].value" value="' + escapeHtml(entry.value) + '" \/> <\/td>'				);
				ids.push(entry.id);
			});
			var productValue = productValues[ids.join(",")];
			var price = productValue != null && productValue.price != null ? productValue.price : "";
			var cost = productValue != null && productValue.cost != null ? productValue.cost : "";
			var marketPrice = productValue != null && productValue.marketPrice != null ? productValue.marketPrice : "";
			var rewardPoint = productValue != null && productValue.rewardPoint != null ? productValue.rewardPoint : "";
			var exchangePoint = productValue != null && productValue.exchangePoint != null ? productValue.exchangePoint : "";
			var stock = productValue != null && productValue.stock != null ? productValue.stock : "";
			var isDefault = productValue != null && productValue.isDefault != null ? productValue.isDefault : false;
			var isEnabled = productValue != null && productValue.isEnabled != null ? productValue.isEnabled : false;
			$productTr.append(
(type == "general" ? '<td><input type="text" name="productList[' + i + '].price" class="text price" value="' + price + '" maxlength="16" style="width: 50px;" \/><\/td>' : '') + ' <td> <input type="text" name="productList[' + i + '].cost" class="text cost" value="' + cost + '" maxlength="16" style="width: 50px;" \/> <\/td> <td> <input type="text" name="productList[' + i + '].marketPrice" class="text marketPrice" value="' + marketPrice + '" maxlength="16" style="width: 50px;" \/> <\/td> ' + (type == "general" ? '<td><input type="text" name="productList[' + i + '].rewardPoint" class="text rewardPoint" value="' + rewardPoint + '" maxlength="9" style="width: 50px;" \/><\/td>' : '') + (type == "exchange" ? '<td><input type="text" name="productList[' + i + '].exchangePoint" class="text exchangePoint" value="' + exchangePoint + '" maxlength="9" style="width: 50px;" \/><\/td>' : '') + ' <td> <input type="text" name="productList[' + i + '].stock" class="text stock" value="' + stock + '" maxlength="9" style="width: 50px;" \/> <\/td> <td> <input type="checkbox" name="productList[' + i + '].isDefault" class="isDefault" value="true"' + (isDefault ? ' checked="checked"' : '') + ' \/> <input type="hidden" name="_productList[' + i + '].isDefault" value="false" \/> <\/td> <td> <input type="checkbox" name="isEnabled" class="isEnabled" value="true"' + (isEnabled ? ' checked="checked"' : '') + ' \/> <\/td>'			).data("ids", ids.join(","));
			if (!isEnabled) {
				$productTr.find(":input:not(.isEnabled)").prop("disabled", true);
			}
		});
		if ($productTable.find("input.isDefault:not(:disabled):checked").size() == 0) {
			$productTable.find("input.isDefault:not(:disabled):first").prop("checked", true);
		}
	}
	
	// 笛卡尔积
	function cartesianProductOf(array) {
		function addTo(current, args) {
			var i, copy;
			var rest = args.slice(1);
			var isLast = !rest.length;
			var result = [];
			for (i = 0; i < args[0].length; i++) {
				copy = current.slice();
				copy.push(args[0][i]);
				if (isLast) {
					result.push(copy);
				} else {
					result = result.concat(addTo(copy, rest));
				}
			}
			return result;
		}
		return addTo([], array);
	}
	
	// 加载规格
	function loadSpecification() {
		$.ajax({
			url: "specifications.jhtml",
			type: "GET",
			data: {productCategoryId: $productCategoryId.val()},
			dataType: "json",
			success: function(data) {
				$specificationTable.find("tr:gt(0)").remove();
				$productTable.empty();
				$.each(data, function(i, specification) {
					var $td = $(
'<tr> <th> <input type="text" name="specificationItems[' + i + '].name" class="text specificationItemName" value="' + escapeHtml(specification.name) + '" style="width: 50px;" \/> <\/th> <td><\/td> <\/tr>'					).appendTo($specificationTable).find("input").data("value", specification.name).end().find("td");
					$.each(specification.options, function(j, option) {
						$(
'<span> <input type="checkbox" name="specificationItems[' + i + '].entries[' + j + '].isSelected" value="true" \/> <input type="hidden" name="_specificationItems[' + i + '].entries[' + j + '].isSelected" value="false" \/> <input type="hidden" name="specificationItems[' + i + '].entries[' + j + '].id" class="text specificationItemEntryId" value="' + specificationItemEntryId + '" \/> <input type="text" name="specificationItems[' + i + '].entries[' + j + '].value" class="text specificationItemEntryValue" value="' + escapeHtml(option) + '" style="width: 50px;" \/> <\/span>'						).appendTo($td).find("input.specificationItemEntryValue").data("value", option);
						specificationItemEntryId ++;
					});
				});
			}
		});
	}
	
	$.validator.addClassRules({
		productImageFile: {
			required: function(element) {
				return $(element).siblings("input:hidden").size() == 0;
			},
			extension: "jpg,jpeg,bmp,gif,png"
		},
		productImageOrder: {
			digits: true
		},
		parameterGroup: {
			required: true
		},
		price: {
			required: true,
			min: 0,
			decimal: {
				integer: 12,
				fraction: 2
			}
		},
		cost: {
			min: 0,
			decimal: {
				integer: 12,
				fraction: 2
			}
		},
		marketPrice: {
			min: 0,
			decimal: {
				integer: 12,
				fraction: 2
			}
		},
		rewardPoint: {
			digits: true
		},
		exchangePoint: {
			required: true,
			digits: true
		},
		stock: {
			required: true,
			digits: true
		}
	});
	
	// 表单验证
	$inputForm.validate({
		rules: {
			productCategoryId: "required",
			name: "required",
			sale_price: {
				required: true,
				min: 0,
				decimal: {
					integer: 12,
					fraction: 2
				}
			},
			cost: {
				min: 0,
				decimal: {
					integer: 12,
					fraction: 2
				}
			},
			price: {
				min: 0,
				decimal: {
					integer: 12,
					fraction: 2
				}
			},
			image: {
				pattern: /^(http:\/\/|https:\/\/|\/).*$/i
			},		
			points_swarded: "digits",
			redeem_point: {
				digits: true				
			},
			stock: {
				required: true,
				digits: true
			}
		},
		messages: {
			sn: {
				pattern: "非法字符",
				remote: "已存在"
			}
		},
		submitHandler: function(form) {
			if (hasSpecification && $productTable.find("input.isEnabled:checked").size() == 0) {			
				alert("请设置规格商品");
				return false;
			}			
			$(form).find("input:submit").prop("disabled", true);
			form.submit();
		}
	});

});
</script>

</head>

<body>
<div class="breadcrumb"><a href="<%=path%>/index.jsp">首页</a>&raquo;&nbsp;编辑商品</div>
	<form id="inputForm" action="<%=path %>/admin/product/save.do" method="post" enctype="multipart/form-data">
		<input type="hidden" id="isDefault" name="product.isDefault" value="true" />
		<ul id="tab" class="tab">
			<li class="current">
				<input type="button" value="基本信息" />
			</li>
			<li>
				<input type="button" value="商品介绍" />
			</li>
			<li>
				<input type="button" value="商品图片" />
			</li>
			<li>
				<input type="button" value="商品参数" />
			</li>
			<li>
				<input type="button" value="商品属性" />
			</li>
			<li>
				<input type="button" value="商品规格" />
			</li>
		</ul>
		<table class="input tabContent" style="display: block;">
			<tr>
				<th>
					商品分类:
				</th>
				<td>
					<select id="productcategory_id" name="productcategory_id">
							<c:forEach items="${category}" var="it" varStatus="st">
                	  			<option value="${it.id}">${it.category_name}</option>
                			</c:forEach>
					</select>
				</td>
			</tr>
			<!-- <tr>
				<th>
					类型:
				</th>
				<td>
					<select id="type" name="type">
							<option value="general">普通商品</option>
							<option value="exchange">兑换商品</option>
							<option value="gift">赠品</option>
					</select>
				</td>
			</tr> -->
			<tr>
				<th>
					编号:
				</th>
				<td>
					<input type="text" name="product_no" class="text" maxlength="100" title="若留空则由系统自动生成" />
				</td>
			</tr>
			<tr>
				<th>
					<span class="requiredField">*</span>名称:
				</th>
				<td>
					<input type="text" name="product_name" class="text" maxlength="200" />
				</td>
			</tr>
			<tr>
				<th>
					副标题:
				</th>
				<td>
					<input type="text" name="chtitle" class="text" maxlength="200" />
				</td>
			</tr>
			<tr>
				<th>
					<span class="requiredField">*</span>销售价:
				</th>
				<td>
					<input type="text" id="price" name="sale_price" class="text" maxlength="16" />
				</td>
			</tr>
			<tr>
				<th>
					成本价:
				</th>
				<td>
					<input type="text" id="cost" name="cost" class="text" maxlength="16" title="前台不会显示，仅供后台使用" />
				</td>
			</tr>
			<tr>
				<th>
					市场价:
				</th>
				<td>
					<input type="text" id="marketPrice" name="price" class="text" maxlength="16" title="若留空则由系统自动计算" />
				</td>
			</tr>
			<tr>
				<th>
					展示图片:
				</th>
				<td>
					<span class="fieldSet">
						<!-- <input type="text" name="image" class="text" maxlength="200" title="应用于首页、宣传页，留空则由系统自动生成" />
						<a href="javascript:;" id="filePicker" class="button">选择文件</a> -->
						<input type="file" name=file accept="image/*" id="file" size="30" />
					</span>
				</td>
			</tr>			
		 <tr>
				<th>
					赠送积分:
				</th>
				<td>
					<input type="text" id="rewardPoint" name="points_swarded" class="text" maxlength="9" title="若留空则由系统自动计算" />
				</td>
			</tr>
				<!--<tr class="hidden">
				<th>
					兑换积分:
				</th>
				<td>
					<input type="text" id="exchangePoint" name="redeem_point" class="text" maxlength="9" disabled="disabled" />
				</td>
			</tr> -->
			<tr>
				<th>
					<span class="requiredField">*</span>库存:
				</th>
				<td>
					<input type="text" id="stock" name="stock" class="text" value="1" maxlength="9" />
				</td>
			</tr>
			<tr>
				<th>
					品牌:
				</th>
				<td>
					<select name="brand_id">
					     <option value="">请选择</option>
						<c:forEach items="${brand}" var="it" varStatus="st">
                	  		<option value="${it.id}">${it.brand_name}</option>
                		</c:forEach>
                	</select>
				</td>
			</tr>
				<!-- <tr>
					<th>
						促销:
					</th>
					<td>
							<label title="iPhone促销专场">
								<input type="checkbox" name="promotionIds" value="1" />满减促销
							</label>
							<label title="联想笔记本促销专场">
								<input type="checkbox" name="promotionIds" value="2" />折扣促销
							</label>
							<label title="平板电视促销专场">
								<input type="checkbox" name="promotionIds" value="3" />返券促销
							</label>
					</td>
				</tr> -->
				<tr>
					<th>
						标签:
					</th>
					<td>
							<label>
								<input type="checkbox" name="isHost" value="1" />热销
							</label>
							<label>
								<input type="checkbox" name="isNew" value="1" />最新
							</label>
							<label>
								<input type="checkbox" name="isBest" value="1" />精品
							</label>							
					</td>
				</tr>
			<tr>
				<th>
					设置:
				</th>
				<td>
					<label>
						<input type="checkbox" name="isMarketable" value="1"  />是否上架					
					</label>
					<label>
						<input type="checkbox" name="isLogistics" value="1"  />是否需要物流						
					</label>
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
					搜索关键词:
				</th>
				<td>
					<input type="text" name="searchKeyword" class="text" maxlength="200" title="应用于前台商品搜索，多个关键字以(,)分隔" />
				</td>
			</tr>
			<tr>
				<th>
					页面标题:
				</th>
				<td>
					<input type="text" name="pageTitle" class="text" maxlength="200" />
				</td>
			</tr>
			<tr>
				<th>
					页面关键词:
				</th>
				<td>
					<input type="text" name="metaKeywords" class="text" maxlength="200" />
				</td>
			</tr>
			<tr>
				<th>
					页面描述:
				</th>
				<td>
					<input type="text" name="metaDescription" class="text" maxlength="200" />
				</td>
			</tr>
		</table>
		<table class="input tabContent">
			<tr>
				<td>					
					<textarea id="description" name="description" class="editor"></textarea>            
				 <script>
				     CKEDITOR.replace( 'description' );
				  </script>
				</td>
			</tr>
		</table>
		<table id="productImageTable" class="item tabContent">
			<tr>
				<td colspan="4">
					<a href="javascript:;" id="addProductImage" class="button">增加图片</a>
				</td>
			</tr>
			<tr>
				<th>
					文件
				</th>
				<th>
					标题
				</th>
				<th>
					排序
				</th>
				<th>
					操作
				</th>
			</tr>
		</table>
		<table id="parameterTable" class="parameterTable input tabContent">
			<tr>
				<th>
					&nbsp;
				</th>
				<td>
					<a href="javascript:;" id="addParameter" class="button">增加参数</a>
					<a href="javascript:;" id="resetParameter" class="button">重置参数</a>
				</td>
			</tr>
		</table>
		<table id="attributeTable" class="input tabContent"></table>
		<div class="tabContent">
			<table id="specificationTable" class="specificationTable input">
				<tr>
					<th>
						&nbsp;
					</th>
					<td>
						<a href="javascript:;" id="resetSpecification" class="button">重置规格</a>
					</td>
				</tr>
			</table>
			<table id="productTable" class="productTable item"></table>
		</div>
		<table class="input">
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
<script>
$(function(){
	$('.tab').tab();
});
</script>
</body>
</html>
