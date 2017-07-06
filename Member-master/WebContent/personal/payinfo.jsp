<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>利息明细</title>
<link rel="shortcut icon" href="${pageContext.request.contextPath}/images/favicon.ico" />
<link href="${pageContext.request.contextPath}/tableTemplet/css/H-ui.css" rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath}/tableTemplet/lib/Hui-iconfont/1.0.1/iconfont.css" rel="stylesheet" type="text/css" /> 	

<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/jquery-1.11.1.js"></script>
<script type="text/javascript">
$(function(){
	//第一次点击进来的默认值
	var page2=1;
	getData(page2);
	function getData(page2){
		$.ajaxSetup({async:false});
		$.post("${pageContext.request.contextPath}/thanksgiving/getThanksgivingByPage.action",{page2:page2},function(data){
			//alert(data);
			var dataObj = eval("("+data+")");
			var navbar=dataObj.returnMap.navbar;
			var list=dataObj.returnMap.list;
			$(".page-nav").html(navbar);
			btnclick();
			showDell();
			if(list.length>0){
				drawTable(list);
			}
			else{
				$("#title").html("*暂无数据...");
			}
			
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
				$("#nav").append("&nbsp;|&nbsp;<a href='${pageContext.request.contextPath}/personal/pay.jsp'>利息交易</a>");
			}
			
		})
	}
	function drawTable(data){
		var table ="<table id='period' class='table table-border table-bordered table-bg table-hover table-sort'>";
		table=table + "<thead>";
		table +="<tr><th>序号</th><th>赠予方编号</th><th>赠予方姓名</th><th>接受方编号</th><th>接受方姓名</th><th>金额</th><th>时间</th></tr>";
		table=table + "</thead>";
		table=table + "<tbody>";
		for(var i=0;i<data.length;i++){
			table +="<tr ><td>";
			table +=i+1;
			table +="</td><td>";
			table +=data[i].mgid;
			table +="</td><td>";
			table +=data[i].gname;
			table +="</td><td>";
			table +=data[i].mrid;
			table +="</td><td>";
			table +=data[i].rname;
			table +="</td><td>";
			table +=data[i].money+".00元";
			table +="</td><td>";
			table +=data[i].time;
			table +="</td></tr>";
		};
		table=table + "</tbody>";
		table+="</table>";
		$("#list").html(table);
	}
})
</script>
</head>
<body>
<div class="wrap" style="padding-left:50px;margin-top:30px">
	<nav id="nav">
    	<a href="${pageContext.request.contextPath}/personal/restinfo.jsp">利息明细</a>&nbsp;|&nbsp;
		<a href="${pageContext.request.contextPath}/personal/payinfo.jsp">交易明细</a>
	</nav>
	<div class="cl pd-5 bg-1 bk-gray mt-20" id="title">
		<span style="color:#F5FAFE">1</span> 
	</div>
	<div class="mt-20">
		<table id="list" class="table table-border table-bordered table-bg table-hover table-sort">
 		</table>
 		<br/>
 	</div>
	<br/>
	<div class='page-nav' style="padding-right:120px"></div>
</div>
</body>
</html>