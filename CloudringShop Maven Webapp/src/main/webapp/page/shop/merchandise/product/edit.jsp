<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="/WEB-INF/tlds/c.tld" prefix="c"%>
<%	
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"+ request.getServerName() + ":" + request.getServerPort()+ path + "/";
%>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
	<link rel="stylesheet" type="text/css" href="../../css/easyui.css">
	<link rel="stylesheet" type="text/css" href="../../css/icon.css">
	<link rel="stylesheet" type="text/css" href="../../css/demo.css">	
	   <link  type="text/css" rel="stylesheet" href="../../css/201202/manage.css"/>
    <link  type="text/css" rel="stylesheet" href="../../css/201202/all_icon.css"/>
	<script type="text/javascript" src="../../js/jquery.min.js"></script>
	<script type="text/javascript" src="../../js/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="<%=path%>/js/jquery.validate.js"></script>
<script type="text/javascript" src="<%=path%>/ckeditor/ckeditor.js"></script>
	<link href="../../css/main.css" rel="stylesheet" type="text/css" />
	
	<style type="text/css">
    html{overflow-x:hidden; width:100%;}
</style>
	
</head>


<body> 
<div class="listinfo">
<form id="frm" name="frm" method="post" enctype="multipart/form-data"  action="<%=path %>/admin/product/updateMerchandiseProduct.do" target="_parent">
<input type="hidden" name="id" value="${merch.id}">
<table width="100%" border="0" cellpadding="0" cellspacing="1" class="yanshi_newu2" style="background: green;">

<tr>
    <td align="center" width="80px" style="font-weight:bold">商品名称</td>
	<td class="shurukang_abv" width="310px">
		<div class="geinputleft3">
		<div class="geinputright">
		<div class="geinputmid3">
		    <input type="text" name="name" value="${merch.name} " id="name" /> 
		</div>
		</div>
		</div>
	</td>
	<td>&nbsp;<span class="required" style="color: red;">*</span></td>
</tr>
<tr>
    <td align="center" width="80px" style="font-weight:bold">市场价格</td>
	<td class="shurukang_abv" width="310px">
		<div class="geinputleft3">
		<div class="geinputright">
		<div class="geinputmid3">
		    <input type="text" name="marketPrice" value="${merch.marketPrice} "  id="marketPrice"  onkeyup="if(isNaN(value))execCommand('undo')" onafterpaste="if(isNaN(value))execCommand('undo')" /> 
		</div>
		</div>
		</div>
	</td>
	<td>&nbsp;<span class="required" style="color: red;">*</span></td>
</tr>
<tr>
    <td align="center" width="80px" style="font-weight:bold">商品价格</td>
	<td class="shurukang_abv" width="310px">
		<div class="geinputleft3">
		<div class="geinputright">
		<div class="geinputmid3">
		    <input type="text" name="price" value="${merch.price} "  id="price" onkeyup="if(isNaN(value))execCommand('undo')" onafterpaste="if(isNaN(value))execCommand('undo')" /> 
		</div>
		</div>
		</div>
	</td>
	<td>&nbsp;<span class="required" style="color: red;">*</span></td>
</tr>
<tr>
    <td align="center" width="80px" style="font-weight:bold">商品推广标题</td>
	<td class="shurukang_abv" width="310px">
		<div class="geinputleft3">
		<div class="geinputright">
		<div class="geinputmid3">
		    <input type="text" name="title" value="${merch.title} " id="title" /> 
		</div>
		</div>
		</div>
	</td>
	<td>&nbsp;<span class="required" style="color: red;">*</span></td>
</tr>
<tr>
    <td align="center" width="80px" style="font-weight:bold">商品栏目介绍标题</td>
	<td class="shurukang_abv" width="310px">
		<div class="geinputleft3">
		<div class="geinputright">
		<div class="geinputmid3">
		    <input type="text" name="chtitle" value="${merch.chtitle} " id="chtitle" /> 
		</div>
		</div>
		</div>
	</td>
	<td>&nbsp;<span class="required" style="color: red;">*</span></td>
</tr>
<tr>
    <td align="center" width="80px" style="font-weight:bold">商品品牌</td>
	<td class="shurukang_abv" width="310px">
		<div class="geinputleft3">
		<div class="geinputright">
		<div class="geinputmid3">
					<select name="brand_id" id="brand_id">
						<option value="">请选择商品品牌</option>
						<c:forEach items="${brandMap}" var="m">
							<option value="${m.key}" <c:if test="${merch.brand_id == m.key}">selected</c:if> >${m.value}</option>
						</c:forEach>
					</select>
				</div>
		</div>
		</div>
	</td>
	<td>&nbsp;<span class="required" style="color: red;">*</span></td>
</tr>
<tr>
    <td align="center" width="80px" style="font-weight:bold">商品分类</td>
	<td class="shurukang_abv" width="310px">
		<div class="geinputleft3">
		<div class="geinputright">
		<div class="geinputmid3">
					
					<select id="productcategory_id"  name="productcategory_id" style="width:156px;"/>  
				</div>
		</div>
		</div>
	</td>
	<td>&nbsp;<span class="required" style="color: red;">*</span></td>
</tr>
<tr>
    <td align="center" width="80px" style="font-weight:bold">商品类型</td>
	<td class="shurukang_abv" width="310px">
		<div class="geinputleft3">
		<div class="geinputright">
		<div class="geinputmid3">
					<select name="productType_id" id="productType_id">
						<option value="">请选择商品类型</option>
						<c:forEach items="${typeMap}" var="m">
							<option value="${m.key}" <c:if test="${merch.productType_id == m.key}">selected</c:if> >${m.value}</option>
						</c:forEach>
					</select>
				</div>
		</div>
		</div>
	</td>
	<td>&nbsp;<span class="required" style="color: red;">*</span></td>
</tr>
<tr>
    <td align="center" width="80px" style="font-weight:bold">精品商品</td>
	<td class="shurukang_abv" width="310px">
			     	   
		    <input type="radio" name="isBest" value="0" id="isBest1"/>是 
		    <input type="radio" name="isBest" value="1" id="isBest2"/>不是
		
	</td>
	<td>&nbsp;<span class="required" style="color: red;">*</span></td>
</tr>
<tr>
    <td align="center" width="80px" style="font-weight:bold">热销商品</td>
	<td class="shurukang_abv" width="310px">
				    	   
		    <input type="radio" name="isHost" value="0" id="isHost1"/>是 
		    <input type="radio" name="isHost" value="1" id="isHost2"/>不是
		
	</td>
	<td>&nbsp;<span class="required" style="color: red;">*</span></td>
</tr>
<tr>
    <td align="center" width="80px" style="font-weight:bold">新品商品</td>
	<td class="shurukang_abv" width="310px">
				    	   
		    <input type="radio" name="isNew" value="0" id="isNew1"/>是 
		    <input type="radio" name="isNew" value="1" id="isNew2"/>不是
		
	</td>
	<td>&nbsp;<span class="required" style="color: red;">*</span></td>
</tr>
<tr>
    <td align="center" width="80px" style="font-weight:bold">上架情况</td>
	<td class="shurukang_abv" width="310px">
			    	   
		    <input type="radio" name="isMarketable" value="0" id="isMarketable1"/>是 
		    <input type="radio" name="isMarketable" value="1" id="isMarketable2"/>不是
		
	</td>
	<td>&nbsp;<span class="required" style="color: red;">*</span></td>
</tr>
<tr>
    <td align="center" width="80px" style="font-weight:bold">商品型号</td>
	<td class="shurukang_abv" width="310px">
		<div class="geinputleft3">
		<div class="geinputright">
		<div class="geinputmid3">
		    <input type="text" name="productSn" value="${merch.productSn} " id="productSn" /> 
		</div>
		</div>
		</div>
	</td>
	<td>&nbsp;<span class="required" style="color: red;">*</span></td>
</tr>

<tr>
    <td align="center" width="80px" style="font-weight:bold">商品图片</td>
	<td class="shurukang_abv" width="310px">
		
		 <img  src="${merch.productImageListStore}" id="productImageListStore" style="display: block;width: 100px;height: 100px;">
		    <input type="file" name="productImageListStoreFile" accept="image/*" id="productImageListStoreFile" size="30" onchange="showproductImageListStore()"/>
		
	</td>
	<td>&nbsp;<span class="required" style="color: red;">*</span></td>
</tr>
<tr>
    <td align="center" width="80px" style="font-weight:bold">商品整体图片</td>
	<td class="shurukang_abv" width="310px">
		<!-- <div class="geinputleft3">
		<div class="geinputright">
		<div class="geinputmid3"> -->
		 <img  src="${merch.productEntiretyImageListStore}" id="productEntiretyImageListStore" style="display: block;width: 100px;height: 100px;">
		    <input type="file" name="productEntiretyImageListStoreFile" accept="image/*" id="productEntiretyImageListStoreFile" size="30" onchange="showproductEntiretyImageListStore()"/>
		<!-- </div>
		</div>
		</div> -->
	</td>
	<td>&nbsp;<span class="required" style="color: red;">*</span></td>
</tr>
<tr>
    <td align="center" width="80px" style="font-weight:bold">商品细节图片</td>
	<td class="shurukang_abv" width="310px">
		
		 <img  src="${merch.productDetailImageListStore}" id="productDetailImageListStore" style="display: block;width: 100px;height: 100px;">
		    <input type="file" name="productDetailImageListStoreFile" accept="image/*" id="productDetailImageListStoreFile" size="30" onchange="showproductDetailImageListStore()"/>
		
	</td>
	<td>&nbsp;<span class="required" style="color: red;">*</span></td>
</tr>
<tr>
    <td align="center" width="80px" style="font-weight:bold">商品配件图片</td>
	<td class="shurukang_abv" width="310px">
		
		 <img  src="${merch.productAssemblyImageListStore}" id="productAssemblyImageListStore" style="display: block;width: 100px;height: 100px;">
		    <input type="file" name="productAssemblyImageListStoreFile" accept="image/*" id="productAssemblyImageListStoreFile" size="30" onchange="showproductAssemblyImageListStore()"/>
		
	</td>
	<td>&nbsp;<span class="required" style="color: red;">*</span></td>
</tr>
<tr>
    <td><span class="Horizontallist" style="font-weight:bold">商品详细描述</span></td>
    <td >
    	<table width="100%" border="0" cellspacing="0" cellpadding="0">
        	<tr>
        	
        		<td>
						<textarea  name="description" id="editor3" rows="10" cols="5">
				           ${merch.description}
				        </textarea>
				        <script>
				            // Replace the <textarea id="editor1"> with a CKEditor
				            // instance, using default configuration.
				           	CKEDITOR.replace( 'editor3' );
				        </script>
					</td>
        	</tr>
        </table>
    </td>
    <td>&nbsp;<span class="required" style="color: red;">*</span></td>
</tr>
<tr>
    <td><span class="Horizontallist" style="font-weight:bold">商品参数</span></td>
    <td >
    	<table width="100%" border="0" cellspacing="0" cellpadding="0">
        	<tr>
        	
        		<td>
						<textarea  name="product_parameters" id="editor4" rows="10" cols="5">
				           ${merch.product_parameters}
				        </textarea>
				        <script>
				            // Replace the <textarea id="editor1"> with a CKEditor
				            // instance, using default configuration.
				           	CKEDITOR.replace( 'editor4' );
				        </script>
					</td>
        	</tr>
        </table>
    </td>
    <td>&nbsp;<span class="required" style="color: red;">*</span></td>
</tr>
<tr>
    <td><span class="Horizontallist" style="font-weight:bold">页面简单描述</span></td>
    <td colspan="2">
    	<table width="100%" border="0" cellspacing="0" cellpadding="0">
        	<tr>
        		
        		<td>
						<textarea  name="metaDescription" id="editor2" rows="10" cols="5">
				           ${merch.metaDescription}
				        </textarea>
				        <script>
				            // Replace the <textarea id="editor1"> with a CKEditor
				            // instance, using default configuration.
				           	CKEDITOR.replace( 'editor2' );
				        </script>
					</td>
        	</tr>
        </table>
    </td>
    <td></td>
</tr>
<tr>
    <td><span class="Horizontallist" style="font-weight:bold">页面关键词</span></td>
    <td >
    	<table width="100%" border="0" cellspacing="0" cellpadding="0">
        	<tr>
        	
        		<td>
						<textarea  name="metaKeywords" id="editor1" rows="10" cols="5">
				           ${merch.metaKeywords}
				        </textarea>
				        <script>
				            // Replace the <textarea id="editor1"> with a CKEditor
				            // instance, using default configuration.
				           	CKEDITOR.replace( 'editor1' );
				        </script>
					</td>
        	</tr>
        </table>
    </td>
    <td></td>
</tr>

 
</table>

<br />
<table width="100%" border="0" cellpadding="0" cellspacing="0" >
     <tr>
    	<td align="center" ><div class="generalbtt"><a id="generaltse"; href="javascript:save()" >保存</a></div></td>
    	<td align="center" ><div class="generalbtt"><a id="generaltse"; href="javascript:closeDialog();" >关闭</a></div></td>
    </tr>
</table>

</form>
</div>
</body>
</html>

<script type="text/javascript">
 var me='${me.id}';
 $(function () {
        $('#productcategory_id').combotree
            ({ url: '<%=path %>/admin/product/getJsonData.do',
                valueField: 'id',
                textField: 'text',
                required: false,
                editable: false,                         
                onLoadSuccess: function () {
                 $("#productcategory_id").combotree("setValue", me);                
                }
        });

  });
       var isBest="${merch.isBest}";
        if("0"== isBest)
        {
           $("#isBest1").attr("checked","checked");
        }
        else
        {
           $("#isBest2").attr("checked","checked");
        }
        var isHost="${merch.isHost}";
        if("0"== isHost)
        {
           $("#isHost1").attr("checked","checked");
        }
        else
        {
           $("#isHost2").attr("checked","checked");
        }
        var isNew="${merch.isNew}";
        if("0"== isNew)
        {
           $("#isNew1").attr("checked","checked");
        }
        else
        {
           $("#isNew2").attr("checked","checked");
        }
        var isMarketable="${merch.isMarketable}";
        if("0"== isMarketable)
        {
           $("#isMarketable1").attr("checked","checked");
        }
        else
        {
           $("#isMarketable2").attr("checked","checked");
        }
var contextPath = "${pageContext.request.contextPath}";
    function save(){ 
   var name = $("#name").val();
	if(name == null || name == ''){
		alert("请输入商品名称");
		$("#name").focus();
		return;
	}
	var marketPrice = $("#marketPrice").val();
    if(marketPrice == null || marketPrice == ''){
    	alert("请输入市场价格");
    	$("#marketPrice").focus();
    	return;
    }
    var price = $("#price").val();
    if(price == null || price == ''){
    	alert("请输入商品价格");
    	$("#price").focus();
    	return;
    }
    var title = $("#title").val();
    if(title == null || title == ''){
    	alert("请输入商品推广标题");
    	$("#title").focus();
    	return;
    }
    var chtitle = $("#chtitle").val();
    if(chtitle == null || chtitle == ''){
    	alert("请输入商品栏目介绍标题");
    	$("#chtitle").focus();
    	return;
    }
     var productSn = $("#productSn").val();
    if(productSn == null || productSn == ''){
    	alert("请输入货号");
    	$("#productSn").focus();
    	return;
    }
    var brand_id = $("#brand_id").val();
    if(brand_id == null || brand_id == ''){
    	alert("请选择商品品牌");
    	$("#brand_id").focus();
    	return;
    }
   
    var productType_id = $("#productType_id").val();
    if(productType_id == null || productType_id == ''){
    	alert("请选择商品类型");
    	$("#productType_id").focus();
    	return;
    }
   
	 $('#frm').form('submit',{
                url: contextPath+"/admin/product/updateMerchandiseProduct.do",
               	onSubmit: function(){
                    return $(this).form('validate');
               	},              
                success: function(result){ 
                   alert("保存成功！");	                        
                   closeDialog();
               	} ,
               	error:function(){
			         alert("保存时出现异常！");
			     }              	
            }); 
	
}

function showproductImageListStore()
{ 
  var img = $('#productImageListStore');
  img.hide();
}
function showproductEntiretyImageListStore()
{ 
  var img = $('#productEntiretyImageListStore');
  img.hide();
}
function showproductDetailImageListStore()
{ 
  var img = $('#productDetailImageListStore');
  img.hide();
}
function showproductAssemblyImageListStore()
{ 
  var img = $('#productAssemblyImageListStore');
  img.hide();
}
    
    // 关闭窗口
  function closeDialog() 
  {
      var url="<%=path%>/admin/product/list.do";
      location.href=url;
       
  }

	function isEmpty( str ){
		if ( str == "" ) return true;
		var regu = /^[ ]+$/;
		var re = new RegExp(regu);
		return re.test(str);
	}
	
	function form2Json(id) {
        	var arr = $("#" + id).serializeArray()
        	var jsonStr = "";
        	jsonStr += '{';
        	for (var i = 0; i < arr.length; i++) {
            	jsonStr += '"' + arr[i].name + '":"' + arr[i].value + '",'
        	}
        	jsonStr = jsonStr.substring(0, (jsonStr.length - 1));
        	jsonStr += '}'
        	var json = JSON.parse(jsonStr)
        	return json
    	}
    	

</script>

