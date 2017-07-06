<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset=UTF-8>
<title>利息明细</title>
<link rel="shortcut icon"
	href="${pageContext.request.contextPath}/resources/images/Icon.ico" />
<link
	href="${pageContext.request.contextPath}/resources/H-ui_v3.0/css/H-ui.min.css"
	rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath}/resources/css/page.css"
	rel="stylesheet" type="text/css" />
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/jslib/jquery-1.11.1.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/jslib/currency.js"></script>
<script type="text/javascript">
$(function(){
	//第一次点击进来的默认值
	var page2=1;
	getData(page2);
	function getData(page2){
		$.ajaxSetup({async:false});
		$.post("${pageContext.request.contextPath}/thanksgiving/getInfoByPage.action",{page2:page2,type:5},function(data){
			//alert(data);
			var dataObj = eval("("+data+")");
			var navbar=dataObj.returnMap.navbar;
			var list=dataObj.returnMap.list;
			$(".page-nav").html(navbar);
			btnclick();
			drawTable(list);
			clickRows();
			showDell();
		})
		
	}	
	//分页按钮点击事件
	function btnclick(){
		$(".nav-btn").click(function(){
			page2=this.lang;
			getData(page2);
		})
	}
	//判断是否显示利息交易
	function showDell(){
		$.post("${pageContext.request.contextPath}/thanksgiving/canDell.action",function(data){
			if(data=="1"){
				$("#nav").append("&nbsp;|&nbsp;<a href='${pageContext.request.contextPath}/thanksgiving/pay.jsp'>利息交易</a>");
			}
			
		})
	}
	function drawTable(data){
		var line ="";
		for(i = 0; i < data.length ;i++){
			line += "<tr class='rows'>";
			line += "<td>" + (i + 1) + "</td>";
			line += "<td>" + data[i].name + "</td>";
			line += "<td>" + data[i].member.name + "</td>";
			line += "<td><a target='_blank' href='http://wpa.qq.com/msgrd?v=1&uin="
				+ data[i].userInfo.qqNo
				+ "&site=qq&menu=yes'>"
				+ data[i].userInfo.qqNo + "</a></td>";
			line += "<td>" + data[i].member.mobile + "</td>";
			line += "<td>" + data[i].member.restInterest + "</td>";
			line += "</tr>";
		};
		$("#tbody").html(line);
	}
})
</script>
</head>
<body>
	<h1 class="text-c">VIP会员利息交易</h1>
	<div class="panel panel-secondary">
		<div class="panel-header">
			<div class="btn-group">
				<a href="${pageContext.request.contextPath}/thanksgiving/restinfo.jsp" class="btn btn-primary radius"  target="_blank">利息明细</aa>
				<a href="${pageContext.request.contextPath}/thanksgiving/payinfo.jsp" class="btn btn-primary radius" target="_blank">交易明细</a>
			</div>
		</div>
		<div class="panel-primary">
			<table class="table table-border table-bg table-bordered radius">
				<thead class='text-c'>
					<tr>
						<th>序号</th>
						<th>会员号</th>
						<th>姓名</th>
						<th>QQ</th>
						<th>电话</th>
						<th>利息余额</th>
					</tr>
				</thead>
				<tbody id="tbody" class='text-c'></tbody>
			</table>
		</div>
	</div>
	<div class='page-nav' style="float: right; margin-top: 10px;"></div>
</body>
</html>