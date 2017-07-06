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
<script type="text/javascript" src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js"></script>
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

$(function(){
	$.post("${pageContext.request.contextPath}/member/getMyPeriod.action",{mid:$("#mid").val()},function(data){
		drawTable(data);
	},"json");
	function drawTable(data){
		var line="";
		line=line + "<thead>";
		line=line + "<tr class='text-c'>";
		line=line + "<th>序号</th>";
		line=line + "<th>交费日期</th>";
		line=line + "<th>交费金额</th>";	
		line=line + "<th>剩余交费金额</th>";
		line=line + "</tr>";
		line=line + "</thead>";
		var account = 0;
		line=line + "<tbody>";
		for(i=0;i<data.length;i++){
			line=line + "<tr class='text-c'>";			
			line=line + "<td>" + (i+1) + "</td>";
			
			var d=	new Date();
			d.setTime(data[i].duetime);
			var s=d.format('yyyy-MM-dd');
			
			line=line + "<td>" + s + "</td>";
			line=line + "<td>" + data[i].amount + "</td>";
			line=line + "<td>" + data[i].restAmount + "</td>";
			line=line + "</tr>";	
			account += data[i].amount;
		}
		line=line + "</tbody>";
		$("#period1").append(line);
		$("#account1").html($("#account1").html()+account);
	}
});

$(function(){
	$.post("${pageContext.request.contextPath}/member/getMyInterest.action",{mid:$("#mid").val()},function(data){
		drawTable(data);
	},"json");
	function drawTable(data){
		var line="";
		line=line + "<tr>";
		line=line + "<td>序号</td>";
		line=line + "<td>分期日期</td>";
		line=line + "<td>分期金额</td>";	
		line=line + "<td>缴费日期</td>";
		line=line + "<td>本次交费</td>";	
		line=line + "<td>本期冲抵</td>";
		line=line + "<td>利息金额</td>";
		line=line + "</tr>";
		var account = 0;
		for(i=0;i<data.length;i++){
			line=line + "<tr>";			
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
		$("#period2").append(line);
		$("#account2").html($("#account2").html()+account.toFixed(2));
	}
});	

</script>
 <style type="text/css">
	#account{margin-left:20px;display:inline;font-weight:bold;margin-right:20px}
	#account1{margin-left:20px;display:inline;font-weight:bold;margin-right:20px}
	#account2{margin-left:20px;display:inline;font-weight:bold}
	#sidebar-tab{border:1px solid #ccf;overflow:hidden; margin-right:80px}
	#tab-content ul{padding-bottom:500px;}
 	#tab-content ul li{padding-left:30px;padding-right:30px;} 
</style>  
</head>
<body>
<div id="sidebar-tab" align="center">
<div id="tab-title">
<ul id="myTab" class="nav nav-tabs">
   <li class="active">
      <a href="#ap1" data-toggle="tab">
         合计缴费
      </a>
   </li>
   <li><a href="#ap2" data-toggle="tab">合计费用</a></li>
   <li><a href="#ap3" data-toggle="tab">合计利息</a></li>
</ul>

<!-- 显示信息 -->
<div id="myTabContent" class="tab-content" align="center">
   <div class="tab-pane fade in active" id="ap1">
      <ul><li><br/>
<div id="account" style="font-size:16px" >合计缴费：</div>
		<table id="period" style="height:2500px;" class="table table-border table-bordered table-bg table-hover table-sort" align="center">
		</table>
</li></ul>
   </div>
   
   <div class="tab-pane fade" id="ap2" align="center">
<ul ><li><br/>
<div id="account1" style="font-size:16px">合计费用：</div>
		<table id="period1" class="table table-border table-bordered table-bg table-hover table-sort" align="center">
		</table>
</li></ul>
   </div>
   <div class="tab-pane fade" id="ap3" align="center">
<ul ><li>
<br/>
	<div id="account2" style="font-size:16px">合计利息：</div>
		<table id="period2" class="table table-border table-bordered table-bg table-hover table-sort">
		</table>
	</li></ul>
	</div>
   </div>
</div>
<!-- 修改 -->
	<input type="hidden" value="${myuser.member.id}" id="mid">
</div>
</body>
</html>