<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>访问记录-Java互助学习VIP群业务运行系统</title>
	<link rel="shortcut icon" href="${pageContext.request.contextPath}/images/favicon.ico" type="image/x-icon"/>
	

	
<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/jquery-1.11.1.min.js"></script>	
<link href="${pageContext.request.contextPath}/tableTemplet/css/H-ui.css" rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath}/tableTemplet/lib/Hui-iconfont/1.0.1/iconfont.css" rel="stylesheet" type="text/css" />


<script type="text/javascript" src="${pageContext.request.contextPath}/layer/layer-v2.0/layer/layer.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/myfile.js"></script>


</head>
<body>
<br/>



<br/>
	<h1 align="center">我的来访记录</h1>
	<div id="title"  class="cl pd-5 bg-1 bk-gray mt-20" >
		<span style="color:#F5FAFE">1</span> 
	</div>
<br/>
	<div class="mt-20">
	<table class="table table-border table-bg table-bordered radius" id="period">
	  <thead>
	  <tr class="text-c">
	    <th>序号</th>
	    <th>ip地址</th>
	    <th>来访时间</th>
	    <th>离开时间</th>
	    <th>来自的网页</th>
	  </tr>
	  </thead>
	  <tbody>
	  <c:forEach var="key" items="${online}" varStatus="status">
	  <tr class="text-c">
	    <td>${status.index+1}</td>
	    <td>${key.value.ip}</td>
	    <td><fmt:formatDate type="both" pattern="yyyy-MM-dd HH:mm:ss " value="${key.value.visitTime}"/></td>
	    <td><fmt:formatDate type="both" pattern="yyyy-MM-dd HH:mm:ss " value="${key.value.leftTime}"/></td>
	    <td>${key.value.comfrom}</td>
	  </tr>
	   </c:forEach>
	   </tbody>
	</table>
	</div>


			<!-- 正文 结束-->

</body>
</html>