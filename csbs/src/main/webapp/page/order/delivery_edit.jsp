<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="/WEB-INF/tlds/c.tld" prefix="c"%>
<% 
    String path = request.getContextPath();
%>
<html>
<head>
<meta charset="utf-8">
<title>管理中心——Cloudring Shop</title>
<meta content="Cloudring" name="author">
<meta content="Cloudring" name="copyright">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/common.css">
</head>

<body>
<div class="breadcrumb"><a href="index.html">首页</a>&raquo;编辑发货点<span>(共0条记录)</span></div>
<form id="inputForm" method="post" action="##">
  <table class="input">
    <tr>
      <th> <span class="requiredField">*</span>名称: </th>
      <td><input type="text" name="name" class="text" value="北京配送中心" maxlength="200" /></td>
    </tr>
    <tr>
      <th> <span class="requiredField">*</span>联系人: </th>
      <td><input type="text" name="contact" class="text" value="北京配送中心" maxlength="200" /></td>
    </tr>
    <tr>
      <th> <span class="requiredField">*</span>地区: </th>
      <td><span class="fieldSet">
        <input type="hidden" id="areaId" name="areaId" value="2"/>
        </span></td>
    </tr>
    <tr>
      <th> <span class="requiredField">*</span>地址: </th>
      <td><input type="text" name="address" class="text" value="安德路888号" maxlength="200" /></td>
    </tr>
    <tr>
      <th> 邮编: </th>
      <td><input type="text" name="zipCode" class="text" value="100000" maxlength="200" /></td>
    </tr>
    <tr>
      <th> 电话: </th>
      <td><input type="text" name="phone" class="text" value="010-88888888" maxlength="200" /></td>
    </tr>
    <tr>
      <th> 手机: </th>
      <td><input type="text" name="mobile" class="text" value="13888888888" maxlength="200" /></td>
    </tr>
    <tr>
      <th> 是否默认: </th>
      <td><input type="checkbox" name="isDefault" checked="checked" />
        <input type="hidden" name="_isDefault" value="false" /></td>
    </tr>
    <tr>
      <th> 备注 </th>
      <td><input type="text" name="memo" class="text" value="" maxlength="200" /></td>
    </tr>
    <tr>
      <th>&nbsp; </th>
      <td><input type="submit" class="button" value="确 定" />
        <input type="button" class="button" value="返 回" onclick="history.back(); return false;" /></td>
    </tr>
  </table>
</form>
</body>
</html>
