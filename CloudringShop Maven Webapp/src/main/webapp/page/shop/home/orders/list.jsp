<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="/WEB-INF/tlds/c.tld" prefix="c"%>
<%@ taglib uri="/WEB-INF/tlds/fmt.tld" prefix="fmt"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title></title>
    <link href="<%=path%>/css/shop/common.css" rel="stylesheet" type="text/css" />
	<link href="<%=path%>/css/shop/member.css" rel="stylesheet" type="text/css" /> 
	<script type="text/javascript" src="<%=path%>/js/jquery.min.js"></script>
	<script type="text/javascript" src="<%=path%>/js/shop/common.js"></script>
	<script type="text/javascript" src="<%=path%>/js/shop/jquery.lSelect.js"></script>
	<script type="text/javascript" src="<%=path%>/js/shop/jquery.validate.js"></script> 

  </head>
  
  <body>
     <div class="container member">
  <div class="row"> 
    <div class="span10">
				<div class="list">
					<div class="title">我的订单</div>
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
									<span title=""><fmt:formatDate value="${it.creatDate}" pattern="yyyy-MM-dd"/></span>
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

  </body>
</html>
