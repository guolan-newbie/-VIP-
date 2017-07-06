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
		$(".checkThis").click(function(){
			$.post("${pageContext.request.contextPath}/ondutylog/checkLogById.action?id="+this.lang,function(data){
				location.href="${pageContext.request.contextPath}/ondutylog/toCheck.action?page=" + $("#page").val();				
				})
			})
	function drawTable(data){
		var table="";
		var line="";
		line=line+"<caption>值班日志审核</caption>";
		line=line + "<tr>";
		line=line + "<th>序号</th>";
		line=line + "<th>会员姓名</th>";
		line=line + "<th>被帮助者的姓名</th>";
		line=line + "<th>被帮助者的QQ</th>";
		line=line + "<th>被帮助者的个人情况</th>";
		line=line + "<th>问题描述</th>";
		line=line + "<th>解决情况</th>";
		line=line + "<th>审核</th>";
		line=line + "</tr>";
		table=table+line;
		for(i=0;i<data.length;i++){
			line="<tr>";
			line=line+"<td>"+(i+1)+"</td>";
			line=line+"<td>"+data[i].member.name+"</td>";
			line=line+"<td>"+data[i].beHelpedName+"</td>";
			line=line+"<td>"+data[i].beHelpedQQ+"</td>";
			line=line+"<td>"+data[i].beHelpedInfo+"</td>";
			line=line+"<td>"+data[i].qustionDescription+"</td>";
			line=line+"<td>"+"<a href='javascript:void(0)' class='forDetail' lang="+data[i].id+">查看详情</a>"+"</td>";
			line=line+"<td>"+"<a href='javascript:void(0)'class='checkThis' lang="+data[i].id+">审核</a>"+"</td>";
			line=line+"</tr>";
			table=table+line;	
		}
		$("#logs").append(table);
	}	
});
</script>
<title>Insert title here</title>
</head>
<body>
<br/>
<jsp:include page="/admin/navbar.jsp"></jsp:include>
<table class="table table-border table-bg table-bordered radius" id="logs">
<caption>值班日志审核</caption>
	<tr><th>序号</th><th>会员姓名</th><th>被帮助者的姓名</th><th>被帮助者的QQ</th><th>被帮助者的个人情况</th><th>问题描述</th><th>解决情况</th><th>审核</th></tr>
<c:forEach var="log" items="${LIST}" varStatus="status">
<tr>
<td><c:out value="${status.index+1}"></c:out></td>
<td><c:out value="${log.member.name}"></c:out></td>
<td><c:out value="${log.beHelpedName}"></c:out></td>
<td><c:out value="${log.beHelpedQQ}"></c:out></td>
<td><c:out value="${log.beHelpedInfo}"></c:out></td>
<td><c:out value="${log.qustionDescription}"></c:out></td>
<td><a href='javascript:void(0)' class='forDetail' lang="${log.id}">查看详情</a></td>
<td><a href='javascript:void(0)'class='checkThis' lang="${log.id}">审核</a></td>
</tr>
</c:forEach>
</table>
<input type="hidden" id="page" value="${PAGE}"> 
${NAVBAR}
</body>
</html>