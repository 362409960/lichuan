<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title></title>
    <link href="../css/shop/common.css" rel="stylesheet" type="text/css" />
	<link href="../css/shop/member.css" rel="stylesheet" type="text/css" /> 
<style>
body {
    overflow-x:hidden;overflow-y:hidden;
}
</style>
  </head>
  
  <body>
   <div class="container member">
  <div class="row"> 
         <div class="span10">
				<div class="index">
					<div class="top clearfix">
						<div>
							<ul>
								<li>
									会员等级: 普通会员
								</li>
								<li>
									账户余额:
									<strong>￥0.00元</strong>
								</li>
								<li>
									消费金额:
									<strong>￥0.00元</strong>
								</li>
								<li>
									可用积分:
									<em>0</em>
									<a href="" class="silver">积分兑换</a>
								</li>
							</ul>
							<ul>
								<li>
									<a href="<%=path %>/orders/list.do">等待付款(<em>${total}</em>)</a>
									<a href="">等待发货(<em>0</em>)</a>
								</li>
								<li>
									<a href="">未读消息(<em>0</em>)</a>
									<a href="">可用优惠券(<em>0</em>)</a>
								</li>
								<li>
									<a href="">商品收藏(<em>0</em>)</a>
									<a href="">到货通知(<em>0</em>)</a>
								</li>
								<li>
									<a href="">商品评论(<em>0</em>)</a>
									<a href="">商品咨询(<em>0</em>)</a>
								</li>
							</ul>
						</div>
					</div>
					<div class="list">
						<div class="title">最新订单</div>
						<table class="list">
							<tr>
								<th>
									编号
								</th>
								<th>
									商品
								</th>
								<th>
									收货人
								</th>
								<th>
									订单金额
								</th>
								<th>
									状态
								</th>
								<th>
									创建日期
								</th>
								<th>
									操作
								</th>
							</tr>
						<c:choose>
						       <c:when test="${isTrue=='true'}">
						          <c:forEach items="${ordersVOList}" var="it" varStatus="st">
						              <c:choose>
						                  <c:when test="${st.last}"><tr class="last"></c:when>
						                  <c:otherwise><tr></c:otherwise>
						              </c:choose>
						              <td>
									${it.oid}
								</td>
								<td>
								      <c:forEach items="${it.ordlist}" var="list">
										<img src="${list.goods_url}" class="thumbnail" alt="${list.name}" />										
										</c:forEach>
								</td>
								<td>
									${it.receiver}
								</td>
								<td>
									￥${it.amount}
								</td>
								<td>
										${it.status}
								</td>
								<td>
									<span title="2015-10-14 09:28:22"><fmt:formatDate value="${it.creatDate}" pattern="yyyy-MM-dd"/></span>
								</td>
								<td>
									<a href="<%=path %>/orders/view.do?sn=${it.oid}">[查看]</a>
								</td>
						          </c:forEach>
						       </c:when>
						       <c:otherwise></c:otherwise>
						     </c:choose>
							
					</table>
					<c:choose>
				       <c:when test="${isTrue=='false'}"><p>暂无信息</p></c:when>
				       <c:otherwise></c:otherwise>
				     </c:choose>
					</div>
				</div>
			</div>
			 </div>
			</div> 
  </body>
</html>
