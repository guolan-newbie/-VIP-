<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>利息信息-Java互助学习VIP群业务运行系统</title>
	<link rel="shortcut icon" href="${pageContext.request.contextPath}/images/favicon.ico">
	

	
<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/jquery-1.11.1.min.js"></script>	
<link href="${pageContext.request.contextPath}/tableTemplet/css/H-ui.css" rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath}/tableTemplet/lib/Hui-iconfont/1.0.1/iconfont.css" rel="stylesheet" type="text/css" />


<script type="text/javascript" src="${pageContext.request.contextPath}/layer/layer-v2.0/layer/layer.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/myfile.js"></script>
 
   
<script type="text/javascript">

$(function(){
	$.post("${pageContext.request.contextPath}/member/getMyInterest.action",{mid:$("#mid").val()},function(data){
		drawTable(data);
	},"json");
	function drawTable(data){
		var line="";
		line=line + "<thead>";
		line=line + "<tr class='text-c'>";
		line=line + "<th>序号</th>";
		line=line + "<th>分期日期</th>";
		line=line + "<th>分期金额</th>";	
		line=line + "<th>缴费日期</th>";
		line=line + "<th>本次交费</th>";	
		line=line + "<th>本期冲抵</th>";
		line=line + "<th>利息金额</th>";
		line=line + "</tr>";
		line=line + "</thead>";
		var account = 0;
		line=line + "<tbody>";
		for(i=0;i<data.length;i++){
			line=line + "<tr class='text-c'>";			
			line=line + "<td>" + (i+1) + "</td>";
			
			var d1=	new Date();
			d1.setTime(data[i].p_duetime);
			var s1=d1.format('yyyy-MM-dd');
			
			line=line + "<td>" + s1 + "</td>";
			line=line + "<td>" + data[i].p_amount + "</td>";
			
			var d2=	new Date();
			d2.setTime(data[i].a_date);
			var s2=d2.format('yyyy-MM-dd');
			
			line=line + "<td>" + s2 + "</td>";
			line=line + "<td>" + data[i].a_amount + "</td>";
			line=line + "<td>" + data[i].i_money + "</td>";
			line=line + "<td>" + data[i].i_amount + "</td>";
			line=line + "</tr>";	
			account += data[i].i_amount;
		}
		line=line + "</tbody>";
		$("#period").append(line);
		$("#account").html($("#account").html()+account.toFixed(2));
	}
});	

</script>

</head>
<body>


	<div id="title" class="cl pd-5 bg-1 bk-gray mt-20">
	<input type="hidden" value="${myuser.member.id}" id="mid">
	<c:if test="${myuser.member.flag}">  
	姓名：${myuser.member.name}  &nbsp;&nbsp;类型：<c:if test="${myuser.member.student=='true'}">学生</c:if><c:if test="${myuser.member.student=='false'}">在职</c:if>
	<div id="account">合计利息：</div>
	</c:if>
	<br/>
	</div>
	<br/>
	<div class="mt-20">
	<table id="period" class="table table-border table-bordered table-bg table-hover table-sort">
	</table>
	</div>


</body>
</html>