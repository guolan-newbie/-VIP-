<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>交费信息-Java互助学习VIP群业务运行系统</title>
	<link rel="shortcut icon" href="${pageContext.request.contextPath}/images/favicon.ico">

<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/jquery-1.11.1.min.js"></script>	
<link href="${pageContext.request.contextPath}/tableTemplet/css/H-ui.css" rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath}/tableTemplet/lib/Hui-iconfont/1.0.1/iconfont.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="${pageContext.request.contextPath}/layer/layer-v2.0/layer/layer.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/myfile.js"></script>

    
<script type="text/javascript">


$(function(){
	$.post("${pageContext.request.contextPath}/member/getMyAccount.action",{id:$("#mid").val()},function(data){
		drawTable(data);
	},"json");
	function drawTable(data){
		var line="";
		line=line + "<thead>";
		line=line + "<tr class='text-c'>";
		line=line + "<th width='60'>序号</th>";
		line=line + "<th width='120'>交费日期</th>";
		line=line + "<th width='60'>交费金额</th>";	
		line=line + "<th width='60'>状态</th>";
		line=line + "</tr>";
		line=line + "</thead>";
		var account = 0;
		line=line + "<tbody>";
		for(i=0;i<data.length;i++){
			if(data[i].flag){
				line=line + "<tr class='text-c'>";	
			}
			else{
				line=line + "<tr class='text-c'>";
			}
			line=line + "<td>" + (i+1) + "</td>";
			
			var d=	new Date();
			d.setTime(data[i].date);
			var s=d.format('yyyy-MM-dd');
			line=line + "<td>" + s + "</td>";
			line=line + "<td>" + data[i].amount + "</td>";
			
			if(data[i].flag){
				line=line + "<td class='td-status'> <span class='label label-success radius'>" + "已审核" + "</span> </td>";
			}
			else{
				line=line + "<td class='td-status'> <span class='label label-danger radius'>" + "未审核" + "</span> </td>";
			}
			line=line + "</tr>";	
			account += data[i].amount;
		}
		line=line + "</tbody>";
		$("#account").html($("#account").html()+account);
		$("#period").append(line);
	}
});
</script>

</head>
<body>



<br/>
<br/>
	<div id="title"  class="cl pd-5 bg-1 bk-gray mt-20" >
	<input type="hidden" value="${myuser.member.id}" id="mid">
	<c:if test="${myuser.member.flag}">  
	姓名：${myuser.member.name}  &nbsp;&nbsp;类型：<c:if test="${myuser.member.student=='true'}">学生</c:if><c:if test="${myuser.member.student=='false'}">在职</c:if>
	<div id="account">合计缴费：</div>
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