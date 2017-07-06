<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <script type="text/javascript" src="${pageContext.request.contextPath}/assets/js/jquery.js"></script>
  <script type="text/javascript" src="${pageContext.request.contextPath}/layer/layer-v2.0/layer/layer.js"></script>
<script type="text/javascript">
$(function(){
	$.ajaxSetup({
		  async: false
	});
		$(".forDetail").click(function(){
			var index=layer.open({
			    type: 2,
			    title:'解决情况',
			    area: ['700px', '500px'],
			    skin: 'layui-layer-rim',
			    shift:5,
			    maxmin: true,
			    content: '${pageContext.request.contextPath}/ondutylog/getSRById.action?id=' + this.lang
			});	
		})
});
</script>
<title>Insert title here</title>
</head>
<body>
<table class="table table-bordered" id="logs">
<caption>值班日志审核</caption>
	<tr><th>序号</th><th>值班开始时间</th><th>被帮助者的姓名</th><th>被帮助者的QQ</th><th>被帮助者的个人情况</th><th>问题描述</th><th>解决情况</th><th>修改</th></tr>
<c:forEach var="log" items="${LIST}" varStatus="status">
<tr>
<td><c:out value="${status.index+1}"></c:out></td>
<td><c:out value="${log.formatStart}"></c:out></td>
<td><c:out value="${log.beHelpedName}"></c:out></td>
<td><c:out value="${log.beHelpedQQ}"></c:out></td>
<td><c:out value="${log.beHelpedInfo}"></c:out></td>
<td><c:out value="${log.qustionDescription}"></c:out></td>
<td><a href='javascript:void(0)' class='forDetail' lang="${log.id}">查看详情</a></td>
<td><a href='${pageContext.request.contextPath}/ondutylog/modifyThis.action?id=${log.id}'>修改</a></td>
</tr>
</c:forEach>
</table>
<input type="hidden" id="page" value="${PAGE}"> 
${NAVBAR}
</body>
</html>